Received: from eggs.gnu.org ([2001:4830:134:3::10]:50873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXeh-0002sm-Oz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXec-00087d-RJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:31:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40872
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1daXec-000870-Lp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:31:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6R1Sh45049041
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:53 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bxyxvgmjb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:53 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 19:31:52 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 20:30:53 -0500
In-Reply-To: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1501119055-4060-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/3] qdev: store DeviceState's
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, groug@kaod.org, armbru@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>

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
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/qdev.c         | 15 ++++++++++++---
 include/hw/qdev-core.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53..a64b35c 100644
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
index ae31728..9237b684 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -153,6 +153,7 @@ struct DeviceState {
     /*< public >*/
 
     const char *id;
+    char *canonical_path;
     bool realized;
     bool pending_deleted_event;
     QemuOpts *opts;
-- 
2.7.4
