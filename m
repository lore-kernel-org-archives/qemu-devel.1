Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyK-0003le-BX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyI-0002Ms-Rh
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:32 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:47837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyI-0002MR-Jl
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:30 -0400
Received: by mail-wm0-x243.google.com with SMTP id t69so10986970wmt.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:18 +0200
Message-Id: <1508343141-31835-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 26/29] qdev: store DeviceState's canonical path
 to use when unparenting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>

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
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20171016222315.407-2-mdroth@linux.vnet.ibm.com>
[Clear dev->canonical_path at the post_realize_fail label, which is
 cleaner.  Suggested by David Gibson. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 17 ++++++++++++++---
 include/hw/qdev-core.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53..0019a49 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -928,6 +928,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             goto post_realize_fail;
         }
 
+        /*
+         * always free/re-initialize here since the value cannot be cleaned up
+         * in device_unrealize due to its usage later on in the unplug path
+         */
+        g_free(dev->canonical_path);
+        dev->canonical_path = object_get_canonical_path(OBJECT(dev));
+
         if (qdev_get_vmsd(dev)) {
             if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
                                                dev->instance_id_alias,
@@ -984,6 +991,8 @@ child_realize_fail:
     }
 
 post_realize_fail:
+    g_free(dev->canonical_path);
+    dev->canonical_path = NULL;
     if (dc->unrealize) {
         dc->unrealize(dev, NULL);
     }
@@ -1102,10 +1111,12 @@ static void device_unparent(Object *obj)
 
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
index 0891461..0a71bf8 100644
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
1.8.3.1
