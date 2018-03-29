Received: from eggs.gnu.org ([2001:4830:134:3::10]:37082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Vo7-0007jw-QA
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f1Vo7-0003lH-0h
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:33:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 29 Mar 2018 13:33:20 +0200
Message-Id: <20180329113320.8053-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13] s390x: introduce 2.13 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
Yes, it's that time again :)
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 864145a7c6..122f316f6a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -668,6 +668,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_12 \
+        HW_COMPAT_2_12
+
 #define CCW_COMPAT_2_11 \
         HW_COMPAT_2_11 \
         {\
@@ -753,14 +756,26 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_2_13_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_13_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_13, "2.13", true);
+
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
+    ccw_machine_2_13_instance_options(machine);
 }
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
+    ccw_machine_2_13_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
 }
-DEFINE_CCW_MACHINE(2_12, "2.12", true);
+DEFINE_CCW_MACHINE(2_12, "2.12", false);
 
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index bc9e3a6627..6e91491b77 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_12 \
+    /* empty */
+
 #define HW_COMPAT_2_11 \
     {\
         .driver   = "hpet",\
-- 
2.14.3
