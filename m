Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1k-0007hd-5B
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX1j-0006F1-8S
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:10:32 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:22 +0100
Message-Id: <20171214171004.25058-5-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/46] s390x: introduce 2.12 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 6a57f94197..a23b8aec9f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -639,6 +639,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_11 \
+        HW_COMPAT_2_11
+
 #define CCW_COMPAT_2_10 \
         HW_COMPAT_2_10
 
@@ -716,14 +719,26 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_2_12_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_12_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_12, "2.12", true);
+
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
+    ccw_machine_2_12_instance_options(machine);
 }
 
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
+    ccw_machine_2_12_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_11);
 }
-DEFINE_CCW_MACHINE(2_11, "2.11", true);
+DEFINE_CCW_MACHINE(2_11, "2.11", false);
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index cf389b4e85..263de973a7 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_11 \
+    /* empty */
+
 #define HW_COMPAT_2_10 \
     {\
         .driver   = "virtio-mouse-device",\
-- 
2.13.6
