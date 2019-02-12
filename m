Received: from eggs.gnu.org ([209.51.188.92]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtMhX-0000uj-VR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gtMhJ-0006FG-QQ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35268
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gtMhA-00065d-Hy
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:17:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1C18rPj129333
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:17:05 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qkk532f15-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:17:05 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 12 Feb 2019 01:17:04 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 11 Feb 2019 20:16:56 -0500
In-Reply-To: <20190212011657.18324-1-walling@linux.ibm.com>
References: <20190212011657.18324-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190212011657.18324-2-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/3] s390x/cpumodel: default enable mepoch
 for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

Latest systems and host kernels support mepoch, which is a
feature that was meant to be supported for z14 GA1 from the
get-go. Let's copy it to the z14 GA1 default CPU model.

Machines s390-ccw-virtio-3.1 and older will retain the old CPU
models and will not provide this bit nor the extended PTFF
functions in the default model.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
@Christian, @David: I elected to not add your r-b's to this
patch since I've added some code to disable feature groups.
I'd like to know what you both think :)
---
 hw/s390x/s390-virtio-ccw.c  |  2 ++
 target/s390x/cpu_models.c   | 24 ++++++++++++++++++++++++
 target/s390x/cpu_models.h   |  2 ++
 target/s390x/gen-features.c |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fd9d0b0542..643265f0b4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -757,6 +757,8 @@ DEFINE_CCW_MACHINE(4_0, "4.0", true);
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
     ccw_machine_4_0_instance_options(machine);
+    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
+    s390_cpudef_group_featoff_greater(14, 1, S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF);
 }
 
 static void ccw_machine_3_1_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index b42b5fd327..d75a20e49d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -117,6 +117,30 @@ void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat)
     }
 }
 
+void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
+                                       S390FeatGroup group)
+{
+    const S390FeatGroupDef *group_def = s390_feat_group_def(group);
+    S390FeatBitmap group_def_off;
+    int i;
+
+    bitmap_complement(group_def_off, group_def->feat, S390_FEAT_MAX);
+
+    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
+        const S390CPUDef *cpu_def = &s390_cpu_defs[i];
+
+        if (cpu_def->gen < gen) {
+            continue;
+        }
+        if (cpu_def->gen == gen && cpu_def->ec_ga < ec_ga) {
+            continue;
+        }
+
+        bitmap_and((unsigned long *)&cpu_def->default_feat,
+                   cpu_def->default_feat, group_def_off, S390_FEAT_MAX);
+    }
+}
+
 uint32_t s390_get_hmfai(void)
 {
     static S390CPU *cpu;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 11cf5386fb..174a99e561 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -75,6 +75,8 @@ struct S390CPUModel {
 
 void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
 void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat);
+void s390_cpudef_group_featoff_greater(uint8_t gen, uint8_t ec_ga,
+                                       S390FeatGroup group);
 uint32_t s390_get_hmfai(void);
 uint8_t s390_get_mha_pow(void);
 uint32_t s390_get_ibc_val(void);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015eaaf5..4770f00105 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -550,6 +550,8 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_6,
     S390_FEAT_GROUP_MSA_EXT_7,
     S390_FEAT_GROUP_MSA_EXT_8,
+    S390_FEAT_MULTIPLE_EPOCH,
+    S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
 };
 
 /* QEMU (CPU model) features */
-- 
2.20.1
