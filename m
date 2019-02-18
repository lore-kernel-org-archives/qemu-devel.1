Received: from eggs.gnu.org ([209.51.188.92]:52421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqS-00074v-Dx
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqR-0006qz-GB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:20 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:50 +0100
Message-Id: <20190218111153.22681-8-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/10] s390x/cpumodel: default enable mepoch for
 z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Collin Walling <walling@linux.ibm.com>

Latest systems and host kernels support mepoch, which is a
feature that was meant to be supported for z14 GA1 from the
get-go. Let's copy it to the z14 GA1 default CPU model.

Machines s390-ccw-virtio-3.1 and older will retain the old CPU
models and will not provide this bit nor the extended PTFF
functions in the default model.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Message-Id: <20190212011657.18324-2-walling@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  |  3 ++-
 target/s390x/cpu_models.c   | 24 ++++++++++++++++++++++++
 target/s390x/cpu_models.h   |  2 ++
 target/s390x/gen-features.c |  2 ++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1a3414b64280..d11069b860b4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -659,7 +659,8 @@ static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
     static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V3_1 };
     ccw_machine_4_0_instance_options(machine);
-
+    s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
+    s390_cpudef_group_featoff_greater(14, 1, S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF);
     s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
 }
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8002412f9af1..4e7e8cab0198 100644
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
index 11cf5386fbcf..174a99e56149 100644
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
index 19bb8ac7f890..dd6e8458ef00 100644
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
2.17.2
