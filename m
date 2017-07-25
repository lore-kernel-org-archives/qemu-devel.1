Received: from eggs.gnu.org ([2001:4830:134:3::10]:57148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48h-0002am-Th
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1da48e-0002En-O4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:01:00 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1da48e-0002Di-Ib
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:00:56 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 247AE116609
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:00:55 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 25 Jul 2017 20:00:47 +0200
Message-ID: <150100564746.27487.5195312465666688402.stgit@bahia>
In-Reply-To: <150100547373.27487.3154210751350595400.stgit@bahia>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.11 PATCH 13/26] qdev: store DeviceState's
 canonical path to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

device_unparent(dev, ...) is called when a device is unparented,
either directly, or as a result of a parent device being
finalized, and handles some final cleanup for the device. Part
of this includes emiting a DEVICE_DELETED QMP event to notify
management, which includes the device's path in the composition
tree as provided by object_get_canonical_path().

object_get_canonical_path() assumes the device is still connected
to the machine/root container, and will assert otherwise, but
in some situations this isn't the case:

If the parent is finalized as a result of object_unparent(), it
will still be attached to the composition tree at the time any
children are unparented as a result of that same call to
object_unparent(). However, in some cases, object_unparent()
will complete without finalizing the parent device, due to
lingering references that won't be released till some time later.
One such example is if the parent has MemoryRegion children (which
take a ref on their parent), who in turn have AddressSpace's (which
take a ref on their regions), since those AddressSpaces get cleaned
up asynchronously by the RCU thread.

In this case qdev:device_unparent() may be called for a child Device
that no longer has a path to the root/machine container, causing
object_get_canonical_path() to assert.

Fix this by storing the canonical path during realize() so the
information will still be available for device_unparent() in such
cases.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
Changes since RFC:
- rebased against ppc-for-2.10
---
 hw/core/qdev.c         |   15 ++++++++++++---
 include/hw/qdev-core.h |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53c42cd..a64b35c16251 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -928,6 +928,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             goto post_realize_fail;
         }
 
+        /* always re-initialize since we clean up in device_unparent() instead
+         * of unrealize()
+         */
+        g_free(dev->canonical_path);
+        dev->canonical_path = object_get_canonical_path(OBJECT(dev));
+
         if (qdev_get_vmsd(dev)) {
             if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
@@ -984,6 +990,7 @@ child_realize_fail:
     }
 
 post_realize_fail:
+    g_free(dev->canonical_path);
     if (dc->unrealize) {
         dc->unrealize(dev, NULL);
     }
@@ -1102,10 +1109,12 @@ static void device_unparent(Object *obj)
 
     /* Only send event if the device had been completely realized */
     if (dev->pending_deleted_event) {
-        gchar *path = object_get_canonical_path(OBJECT(dev));
+        g_assert(dev->canonical_path);
 
-        qapi_event_send_device_deleted(!!dev->id, dev->id, path, &error_abort);
-        g_free(path);
+        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
+                                       &error_abort);
+        g_free(dev->canonical_path);
+        dev->canonical_path = NULL;
     }
 
     qemu_opts_del(dev->opts);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ae317286a480..9237b6849ff3 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -153,6 +153,7 @@ struct DeviceState {
     /*< public >*/
 
     const char *id;
+    char *canonical_path;
     bool realized;
     bool pending_deleted_event;
     QemuOpts *opts;
