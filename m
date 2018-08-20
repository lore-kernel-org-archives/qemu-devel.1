Received: from eggs.gnu.org ([2001:4830:134:3::10]:45911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjgv-00074q-Rt
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjgv-0005sT-0E
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:53:53 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Aug 2018 14:53:35 +0200
Message-Id: <20180820125341.5882-2-cohuck@redhat.com>
In-Reply-To: <20180820125341.5882-1-cohuck@redhat.com>
References: <20180820125341.5882-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] s390x: introduce 3.1 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>
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
