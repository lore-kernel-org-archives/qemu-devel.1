Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhabc-0001TQ-3f
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhabX-0003sZ-Vf
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:10:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 23 Jul 2018 15:10:16 +0200
Message-Id: <20180723131016.4161-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1] s390x: introduce 3.1 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7983185d04..d366909474 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -673,6 +673,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_3_0 \
+        HW_COMPAT_3_0
+
 #define CCW_COMPAT_2_12 \
         HW_COMPAT_2_12
 
@@ -761,14 +764,26 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_3_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_3_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(3_1, "3.1", true);
+
 static void ccw_machine_3_0_instance_options(MachineState *machine)
 {
+    ccw_machine_3_1_instance_options(machine);
 }
 
 static void ccw_machine_3_0_class_options(MachineClass *mc)
 {
+    ccw_machine_3_1_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_0);
 }
-DEFINE_CCW_MACHINE(3_0, "3.0", true);
+DEFINE_CCW_MACHINE(3_0, "3.0", false);
 
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index c08f4040bb..6f4d5fc647 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_3_0 \
+    /* empty */
+
 #define HW_COMPAT_2_12 \
     {\
         .driver   = "migration",\
-- 
2.14.4
