Received: from eggs.gnu.org ([2001:4830:134:3::10]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSc-0007aJ-Ki
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSb-0004nE-7F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:30 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:18 +0000
Message-ID: <20181205134243.4791-5-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 04/14] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <alindsay@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

Rename arm_ccnt_enabled to pmu_counter_enabled, and add logic to only
return 'true' if the specified counter is enabled and neither prohibited
or filtered.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c    |  3 ++
 target/arm/cpu.h    | 10 ++++-
 target/arm/helper.c | 96 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..f7bad04f60 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1020,6 +1020,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
         cpu->id_aa64dfr0 &=3D ~0xf00;
+    } else if (!kvm_enabled()) {
+        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
     }
=20
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 61ac458627..627e5c1995 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -987,6 +987,12 @@ void pmccntr_op_finish(CPUARMState *env);
 void pmu_op_start(CPUARMState *env);
 void pmu_op_finish(CPUARMState *env);
=20
+/**
+ * Functions to register as EL change hooks for PMU mode filtering
+ */
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
+void pmu_post_el_change(ARMCPU *cpu, void *ignored);
+
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
  * for both old and new bit meanings. Code which tests against those
@@ -1048,7 +1054,8 @@ void pmu_op_finish(CPUARMState *env);
=20
 #define MDCR_EPMAD    (1U << 21)
 #define MDCR_EDAD     (1U << 20)
-#define MDCR_SPME     (1U << 17)
+#define MDCR_SPME     (1U << 17)  /* MDCR_EL3 */
+#define MDCR_HPMD     (1U << 17)  /* MDCR_EL2 */
 #define MDCR_SDD      (1U << 16)
 #define MDCR_SPD      (3U << 14)
 #define MDCR_TDRA     (1U << 11)
@@ -1058,6 +1065,7 @@ void pmu_op_finish(CPUARMState *env);
 #define MDCR_HPME     (1U << 7)
 #define MDCR_TPM      (1U << 6)
 #define MDCR_TPMCR    (1U << 5)
+#define MDCR_HPMN     (0x1fU)
=20
 /* Not all of the MDCR_EL3 bits are present in the 32-bit SDCR */
 #define SDCR_VALID_MASK (MDCR_EPMAD | MDCR_EDAD | MDCR_SPME | MDCR_SPD)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71a5c71e0a..ddb47813d2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -976,10 +976,24 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
 #define PMCRE   0x1
=20
+#define PMXEVTYPER_P          0x80000000
+#define PMXEVTYPER_U          0x40000000
+#define PMXEVTYPER_NSK        0x20000000
+#define PMXEVTYPER_NSU        0x10000000
+#define PMXEVTYPER_NSH        0x08000000
+#define PMXEVTYPER_M          0x04000000
+#define PMXEVTYPER_MT         0x02000000
+#define PMXEVTYPER_EVTCOUNT   0x0000ffff
+#define PMXEVTYPER_MASK       (PMXEVTYPER_P | PMXEVTYPER_U | PMXEVTYPER_NS=
K | \
+                               PMXEVTYPER_NSU | PMXEVTYPER_NSH | \
+                               PMXEVTYPER_M | PMXEVTYPER_MT | \
+                               PMXEVTYPER_EVTCOUNT)
+
 static inline uint32_t pmu_num_counters(CPUARMState *env)
 {
   return (env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT;
@@ -1075,16 +1089,66 @@ static CPAccessResult pmreg_access_ccntr(CPUARMStat=
e *env,
     return pmreg_access(env, ri, isread);
 }
=20
-static inline bool arm_ccnt_enabled(CPUARMState *env)
+/* Returns true if the counter (pass 31 for PMCCNTR) should count events u=
sing
+ * the current EL, security state, and register configuration.
+ */
+static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
 {
-    /* This does not support checking PMCCFILTR_EL0 register */
+    uint64_t filter;
+    bool e, p, u, nsk, nsu, nsh, m;
+    bool enabled, prohibited, filtered;
+    bool secure =3D arm_is_secure(env);
+    int el =3D arm_current_el(env);
+    uint8_t hpmn =3D env->cp15.mdcr_el2 & MDCR_HPMN;
=20
-    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31)=
)) {
-        return false;
+    if (!arm_feature(env, ARM_FEATURE_EL2) ||
+            (counter < hpmn || counter =3D=3D 31)) {
+        e =3D env->cp15.c9_pmcr & PMCRE;
+    } else {
+        e =3D env->cp15.mdcr_el2 & MDCR_HPME;
     }
+    enabled =3D e && (env->cp15.c9_pmcnten & (1 << counter));
=20
-    return true;
+    if (!secure) {
+        if (el =3D=3D 2 && (counter < hpmn || counter =3D=3D 31)) {
+            prohibited =3D env->cp15.mdcr_el2 & MDCR_HPMD;
+        } else {
+            prohibited =3D false;
+        }
+    } else {
+        prohibited =3D arm_feature(env, ARM_FEATURE_EL3) &&
+           (env->cp15.mdcr_el3 & MDCR_SPME);
+    }
+
+    if (prohibited && counter =3D=3D 31) {
+        prohibited =3D env->cp15.c9_pmcr & PMCRDP;
+    }
+
+    /* TODO Remove assert, set filter to correct PMEVTYPER */
+    assert(counter =3D=3D 31);
+    filter =3D env->cp15.pmccfiltr_el0;
+
+    p   =3D filter & PMXEVTYPER_P;
+    u   =3D filter & PMXEVTYPER_U;
+    nsk =3D arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSK)=
;
+    nsu =3D arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_NSU)=
;
+    nsh =3D arm_feature(env, ARM_FEATURE_EL2) && (filter & PMXEVTYPER_NSH)=
;
+    m   =3D arm_el_is_aa64(env, 1) &&
+              arm_feature(env, ARM_FEATURE_EL3) && (filter & PMXEVTYPER_M)=
;
+
+    if (el =3D=3D 0) {
+        filtered =3D secure ? u : u !=3D nsu;
+    } else if (el =3D=3D 1) {
+        filtered =3D secure ? p : p !=3D nsk;
+    } else if (el =3D=3D 2) {
+        filtered =3D !nsh;
+    } else { /* EL3 */
+        filtered =3D m !=3D p;
+    }
+
+    return enabled && !prohibited && !filtered;
 }
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself=
,
@@ -1097,7 +1161,7 @@ void pmccntr_op_start(CPUARMState *env)
     cycles =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
=20
-    if (arm_ccnt_enabled(env)) {
+    if (pmu_counter_enabled(env, 31)) {
         uint64_t eff_cycles =3D cycles;
         if (env->cp15.c9_pmcr & PMCRD) {
             /* Increment once every 64 processor clock cycles */
@@ -1116,7 +1180,7 @@ void pmccntr_op_start(CPUARMState *env)
  */
 void pmccntr_op_finish(CPUARMState *env)
 {
-    if (arm_ccnt_enabled(env)) {
+    if (pmu_counter_enabled(env, 31)) {
         uint64_t prev_cycles =3D env->cp15.c15_ccnt_delta;
=20
         if (env->cp15.c9_pmcr & PMCRD) {
@@ -1138,6 +1202,16 @@ void pmu_op_finish(CPUARMState *env)
     pmccntr_op_finish(env);
 }
=20
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
+{
+    pmu_op_start(&cpu->env);
+}
+
+void pmu_post_el_change(ARMCPU *cpu, void *ignored)
+{
+    pmu_op_finish(&cpu->env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
@@ -1209,6 +1283,14 @@ void pmu_op_finish(CPUARMState *env)
 {
 }
=20
+void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
+{
+}
+
+void pmu_post_el_change(ARMCPU *cpu, void *ignored)
+{
+}
+
 #endif
=20
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
--=20
2.19.1
