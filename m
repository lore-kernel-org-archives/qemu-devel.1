Received: from eggs.gnu.org ([209.51.188.92]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtUOm-00031U-9g
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtUOk-0005pc-Ba
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:30:40 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 10:30:23 +0100
Message-Id: <20190212093023.32466-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x: add zPCI feature to "qemu" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

As we now always have PCI support, let's add it to the "qemu" CPU model,
taking care of backwards compatibility.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 3 +++
 target/s390x/gen-features.c | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3fb5c88af9..7f0d394fbe 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -657,7 +657,10 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
 
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
+    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V3_1 };
     ccw_machine_4_0_instance_options(machine);
+
+    s390_set_qemu_cpu_model(0x2064, 7, 1, qemu_cpu_feat);
 }
 
 static void ccw_machine_3_1_class_options(MachineClass *mc)
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index b0e9b271e2..19bb8ac7f8 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -560,7 +560,7 @@ static uint16_t qemu_V2_11[] = {
     S390_FEAT_ZARCH,
 };
 
-static uint16_t qemu_LATEST[] = {
+static uint16_t qemu_V3_1[] = {
     S390_FEAT_DAT_ENH,
     S390_FEAT_IDTE_SEGMENT,
     S390_FEAT_STFLE,
@@ -592,13 +592,16 @@ static uint16_t qemu_LATEST[] = {
     S390_FEAT_MSA_EXT_4,
 };
 
+static uint16_t qemu_LATEST[] = {
+    S390_FEAT_ZPCI,
+};
+
 /* add all new definitions before this point */
 static uint16_t qemu_MAX[] = {
     /* z13+ features */
     S390_FEAT_STFLE_53,
     /* generates a dependency warning, leave it out for now */
     S390_FEAT_MSA_EXT_5,
-    S390_FEAT_ZPCI,
 };
 
 /****** END FEATURE DEFS ******/
@@ -708,6 +711,7 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
     QEMU_FEAT_INITIALIZER(V2_11),
+    QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(LATEST),
     QEMU_FEAT_INITIALIZER(MAX),
 };
-- 
2.17.2
