Received: from eggs.gnu.org ([2001:4830:134:3::10]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1bW2-000192-1K
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1bVw-0002Cu-Vz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e1bVw-0002C5-N9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99H4fbH144894
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 13:06:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgaucquk1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 13:06:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 13:06:42 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 12:06:07 -0500
In-Reply-To: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
References: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171009170607.4155-4-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qdev: defer DEVICE_DEL event until
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
Cc: david@gibson.dropbear.id.au, groug@kaod.org, peter.maydell@linaro.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

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
solve in the future.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/core/qdev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f7c66d9bd0..8b7b8c3280 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1068,7 +1068,6 @@ static void device_finalize(Object *obj)
     NamedGPIOList *ngl, *next;
 
     DeviceState *dev = DEVICE(obj);
-    qemu_opts_del(dev->opts);
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
@@ -1079,6 +1078,18 @@ static void device_finalize(Object *obj)
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
@@ -1108,16 +1119,6 @@ static void device_unparent(Object *obj)
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
2.11.0
