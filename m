Received: from eggs.gnu.org ([2001:4830:134:3::10]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyL-0003nD-UN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyK-0002OL-Qe
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:33 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:47837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyK-0002Nj-Jp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:32 -0400
Received: by mail-wm0-x244.google.com with SMTP id t69so10987129wmt.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:20 +0200
Message-Id: <1508343141-31835-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] qdev: defer DEVICE_DEL event until
 instance_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

DEVICE_DEL is currently emitted when a Device is unparented, as
opposed to when it is finalized. The main design motivation for this
seems to be that after unparent()/unrealize(), the Device is no
longer visible to the guest, and thus the operation is complete
from the perspective of management.

However, there are cases where remaining host-side cleanup is also
pertinent to management. The is generally handled by treating these
resources as aspects of the "backend", which can be managed via
separate interfaces/events, such as blockdev_add/del, netdev_add/del,
object_add/del, etc, but some devices do not have this level of
compartmentalization, namely vfio-pci, and possibly to lend themselves
well to it.

In the case of vfio-pci, the "backend" cleanup happens as part of
the finalization of the vfio-pci device itself, in particular the
cleanup of the VFIO group FD. Failing to wait for this cleanup can
result in tools like libvirt attempting to rebind the device to
the host while it's still being used by VFIO, which can result in
host crashes or other misbehavior depending on the host driver.

Deferring DEVICE_DEL still affords us the ability to manage backends
explicitly, while also addressing cases like vfio-pci's, so we
implement that approach here.

An alternative proposal involving having VFIO emit a separate event
to denote completion of host-side cleanup was discussed, but the
prevailing opinion seems to be that it is not worth the added
complexity, and leaves the issue open for other Device implementations
to solve in the future.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20171016222315.407-4-mdroth@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 418cdac..1111295 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1069,7 +1069,6 @@ static void device_finalize(Object *obj)
     NamedGPIOList *ngl, *next;
 
     DeviceState *dev = DEVICE(obj);
-    qemu_opts_del(dev->opts);
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
@@ -1080,6 +1079,18 @@ static void device_finalize(Object *obj)
          * here
          */
     }
+
+    /* Only send event if the device had been completely realized */
+    if (dev->pending_deleted_event) {
+        g_assert(dev->canonical_path);
+
+        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
+                                       &error_abort);
+        g_free(dev->canonical_path);
+        dev->canonical_path = NULL;
+    }
+
+    qemu_opts_del(dev->opts);
 }
 
 static void device_class_base_init(ObjectClass *class, void *data)
@@ -1109,16 +1120,6 @@ static void device_unparent(Object *obj)
         object_unref(OBJECT(dev->parent_bus));
         dev->parent_bus = NULL;
     }
-
-    /* Only send event if the device had been completely realized */
-    if (dev->pending_deleted_event) {
-        g_assert(dev->canonical_path);
-
-        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
-                                       &error_abort);
-        g_free(dev->canonical_path);
-        dev->canonical_path = NULL;
-    }
 }
 
 static void device_class_init(ObjectClass *class, void *data)
-- 
1.8.3.1
