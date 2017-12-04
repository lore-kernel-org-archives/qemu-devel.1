Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLrKQ-0001UD-Qt
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLrKP-00079b-4f
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:02:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Dec 2017 15:01:50 +0100
Message-Id: <20171204140150.20483-10-david@redhat.com>
In-Reply-To: <20171204140150.20483-1-david@redhat.com>
References: <20171204140150.20483-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 9/9] s390x: change the QEMU cpu
 model to a stripped down z12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

We are good enough to boot upstream Linux kernels / Fedora 26/27. That
should be suficient for now.

As the QEMU CPU model is migration safe, let's add compatibility code.
Generate the feature list to reduce the trouble of messing things up in the
future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  |   6 +++
 target/s390x/cpu.h          |   3 ++
 target/s390x/cpu_models.c   | 100 ++++++++++++++++++--------------------------
 target/s390x/cpu_models.h   |   1 +
 target/s390x/gen-features.c |  87 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 59 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a23b8aec9f..edd18b7fac 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -721,6 +721,9 @@ bool css_migration_enabled(void)
 
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
+    const S390FeatBitmap qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };
+
+    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
 }
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
@@ -730,7 +733,10 @@ DEFINE_CCW_MACHINE(2_12, "2.12", true);
 
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
+    const S390FeatBitmap qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_11 };
     ccw_machine_2_12_instance_options(machine);
+
+    s390_set_qemu_cpu_model(0x2064, 7, 1, qemu_cpu_feat);
 }
 
 static void ccw_machine_2_11_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4d3e7920f5..969598b211 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -719,6 +719,9 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 /* cpu_models.c */
 void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 #define cpu_list s390_cpu_list
+void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
+                             const S390FeatBitmap features);
+
 
 /* helper.c */
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index edac7fdecf..f0577f8155 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -15,7 +15,6 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
-#include "gen-features.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
@@ -81,6 +80,11 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
 };
 
+#define QEMU_MAX_CPU_TYPE 0x2827
+#define QEMU_MAX_CPU_GEN 12
+#define QEMU_MAX_CPU_EC_GA 2
+static const S390FeatBitmap qemu_max_cpu_feat = { S390_FEAT_LIST_QEMU_MAX };
+
 /* features part of a base model but not relevant for finding a base model */
 S390FeatBitmap ignored_base_feat;
 
@@ -812,51 +816,6 @@ static void check_compatibility(const S390CPUModel *max_model,
                   "available in the configuration: ");
 }
 
-/**
- * The base TCG CPU model "qemu" is based on the z900. However, we already
- * can also emulate some additional features of later CPU generations, so
- * we add these additional feature bits here.
- */
-static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
-{
-    static const int feats[] = {
-        S390_FEAT_DAT_ENH,
-        S390_FEAT_IDTE_SEGMENT,
-        S390_FEAT_STFLE,
-        S390_FEAT_SENSE_RUNNING_STATUS,
-        S390_FEAT_EXTENDED_TRANSLATION_2,
-        S390_FEAT_MSA,
-        S390_FEAT_LONG_DISPLACEMENT,
-        S390_FEAT_LONG_DISPLACEMENT_FAST,
-        S390_FEAT_EXTENDED_IMMEDIATE,
-        S390_FEAT_EXTENDED_TRANSLATION_3,
-        S390_FEAT_ETF2_ENH,
-        S390_FEAT_STORE_CLOCK_FAST,
-        S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
-        S390_FEAT_ETF3_ENH,
-        S390_FEAT_EXTRACT_CPU_TIME,
-        S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
-        S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
-        S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
-        S390_FEAT_EXECUTE_EXT,
-        S390_FEAT_SET_PROGRAM_PARAMETERS,
-        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
-        S390_FEAT_STFLE_45,
-        S390_FEAT_STFLE_49,
-        S390_FEAT_LOCAL_TLB_CLEARING,
-        S390_FEAT_INTERLOCKED_ACCESS_2,
-        S390_FEAT_STFLE_53,
-        S390_FEAT_MSA_EXT_5,
-        S390_FEAT_MSA_EXT_3,
-        S390_FEAT_MSA_EXT_4,
-    };
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(feats); i++) {
-        set_bit(feats[i], fbm);
-    }
-}
-
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
     static S390CPUModel max_model;
@@ -869,12 +828,10 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
     if (kvm_enabled()) {
         kvm_s390_get_host_cpu_model(&max_model, errp);
     } else {
-        /* TCG emulates a z900 (with some optional additional features) */
-        max_model.def = &s390_cpu_defs[0];
-        bitmap_copy(max_model.features, max_model.def->default_feat,
-                    S390_FEAT_MAX);
-        add_qemu_cpu_model_features(max_model.features);
-    }
+        max_model.def = s390_find_cpu_def(QEMU_MAX_CPU_TYPE, QEMU_MAX_CPU_GEN,
+                                          QEMU_MAX_CPU_EC_GA, NULL);
+        bitmap_copy(max_model.features, qemu_max_cpu_feat, S390_FEAT_MAX);
+   }
     if (!*errp) {
         cached = true;
         return &max_model;
@@ -1130,18 +1087,43 @@ static void s390_host_cpu_model_initfn(Object *obj)
 }
 #endif
 
+static S390CPUDef s390_qemu_cpu_def;
+static S390CPUModel s390_qemu_cpu_model;
+
+/* Set the qemu CPU model (on machine initialization). Must not be called
+ * once CPUs have been created.
+ */
+void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
+                             const S390FeatBitmap features)
+{
+    const S390CPUDef *def = s390_find_cpu_def(type, gen, ec_ga, NULL);
+
+    g_assert(def);
+    g_assert(QTAILQ_EMPTY(&cpus));
+
+    /* TCG emulates some features that can usually not be enabled with
+     * the emulated machine generation. Make sure they can be enabled
+     * when using the QEMU model by adding them to full_feat. We have
+     * to copy the definition to do that.
+     */
+    memcpy(&s390_qemu_cpu_def, def, sizeof(s390_qemu_cpu_def));
+    bitmap_or(s390_qemu_cpu_def.full_feat, s390_qemu_cpu_def.full_feat,
+              qemu_max_cpu_feat, S390_FEAT_MAX);
+
+    /* build the CPU model */
+    s390_qemu_cpu_model.def = &s390_qemu_cpu_def;
+    bitmap_copy(s390_qemu_cpu_model.features, features, S390_FEAT_MAX);
+}
+
 static void s390_qemu_cpu_model_initfn(Object *obj)
 {
-    static S390CPUDef s390_qemu_cpu_defs;
     S390CPU *cpu = S390_CPU(obj);
 
     cpu->model = g_malloc0(sizeof(*cpu->model));
-    /* TCG emulates a z900 (with some optional additional features) */
-    memcpy(&s390_qemu_cpu_defs, &s390_cpu_defs[0], sizeof(s390_qemu_cpu_defs));
-    add_qemu_cpu_model_features(s390_qemu_cpu_defs.full_feat);
-    cpu->model->def = &s390_qemu_cpu_defs;
-    bitmap_copy(cpu->model->features, cpu->model->def->default_feat,
-                S390_FEAT_MAX);
+    /* has to be initialized by now via s390_set_qemu_cpu_model() */
+    g_assert(s390_qemu_cpu_model.def);
+    /* copy the CPU model so we can modify it */
+    memcpy(cpu->model, &s390_qemu_cpu_model, sizeof(*cpu->model));
 }
 
 static void s390_cpu_model_finalize(Object *obj)
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 4c6dee1871..11cf5386fb 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -14,6 +14,7 @@
 #define TARGET_S390X_CPU_MODELS_H
 
 #include "cpu_features.h"
+#include "gen-features.h"
 #include "qom/cpu.h"
 
 /* static CPU definition */
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 68e6c31b4b..983f2dcd52 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -536,6 +536,51 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MSA_EXT_8,
 };
 
+/* QEMU (CPU model) features */
+
+static uint16_t qemu_V2_11[] = {
+    S390_FEAT_GROUP_PLO,
+    S390_FEAT_ESAN3,
+    S390_FEAT_ZARCH,
+};
+
+static uint16_t qemu_V2_12[] = {
+    S390_FEAT_DAT_ENH,
+    S390_FEAT_IDTE_SEGMENT,
+    S390_FEAT_STFLE,
+    S390_FEAT_SENSE_RUNNING_STATUS,
+    S390_FEAT_EXTENDED_TRANSLATION_2,
+    S390_FEAT_MSA,
+    S390_FEAT_LONG_DISPLACEMENT,
+    S390_FEAT_LONG_DISPLACEMENT_FAST,
+    S390_FEAT_EXTENDED_IMMEDIATE,
+    S390_FEAT_EXTENDED_TRANSLATION_3,
+    S390_FEAT_ETF2_ENH,
+    S390_FEAT_STORE_CLOCK_FAST,
+    S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
+    S390_FEAT_ETF3_ENH,
+    S390_FEAT_EXTRACT_CPU_TIME,
+    S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
+    S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
+    S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
+    S390_FEAT_EXECUTE_EXT,
+    S390_FEAT_SET_PROGRAM_PARAMETERS,
+    S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
+    S390_FEAT_STFLE_45,
+    S390_FEAT_STFLE_49,
+    S390_FEAT_LOCAL_TLB_CLEARING,
+    S390_FEAT_INTERLOCKED_ACCESS_2,
+    S390_FEAT_STFLE_53,
+    S390_FEAT_MSA_EXT_4,
+    S390_FEAT_MSA_EXT_3,
+};
+
+/* add all new definitions before this point */
+static uint16_t qemu_MAX[] = {
+    /* generates a dependency warning, leave it out for now */
+    S390_FEAT_MSA_EXT_5,
+};
+
 /****** END FEATURE DEFS ******/
 
 #define _YEARS  "2016"
@@ -627,6 +672,24 @@ static FeatGroupDefSpec FeatGroupDef[] = {
     FEAT_GROUP_INITIALIZER(MSA_EXT_8),
 };
 
+#define QEMU_FEAT_INITIALIZER(_name)                   \
+    {                                                  \
+        .name = "S390_FEAT_LIST_QEMU_" #_name,         \
+        .bits =                                        \
+            { .data = qemu_##_name,                    \
+              .len = ARRAY_SIZE(qemu_##_name) },       \
+    }
+
+/*******************************
+ * QEMU (CPU model) features
+ *******************************/
+static FeatGroupDefSpec QemuFeatDef[] = {
+    QEMU_FEAT_INITIALIZER(V2_11),
+    QEMU_FEAT_INITIALIZER(V2_12),
+    QEMU_FEAT_INITIALIZER(MAX),
+};
+
+
 static void set_bits(uint64_t list[], BitSpec bits)
 {
     uint32_t i;
@@ -684,6 +747,29 @@ static void print_feature_defs(void)
     }
 }
 
+static void print_qemu_feature_defs(void)
+{
+    uint64_t feat[S390_FEAT_MAX / 64 + 1] = {};
+    int i, j;
+
+    printf("\n/* QEMU (CPU model) feature list data */\n");
+
+    /* for now we assume that we only add new features */
+    for (i = 0; i < ARRAY_SIZE(QemuFeatDef); i++) {
+        set_bits(feat, QemuFeatDef[i].bits);
+
+        printf("#define %s\t", QemuFeatDef[i].name);
+        for (j = 0; j < ARRAY_SIZE(feat); j++) {
+            printf("0x%016"PRIx64"ULL", feat[j]);
+            if (j < ARRAY_SIZE(feat) - 1) {
+                printf(",");
+            } else {
+                printf("\n");
+            }
+        }
+    }
+}
+
 static void print_feature_group_defs(void)
 {
     int i, j;
@@ -721,6 +807,7 @@ int main(int argc, char *argv[])
            "#ifndef %s\n#define %s\n", __FILE__, _YEARS, _NAME_H, _NAME_H);
     print_feature_defs();
     print_feature_group_defs();
+    print_qemu_feature_defs();
     printf("\n#endif\n");
     return 0;
 }
-- 
2.14.3
