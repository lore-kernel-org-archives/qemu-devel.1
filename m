Received: from eggs.gnu.org ([2001:4830:134:3::10]:57506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjqB-0004El-9q
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjq9-0001ed-7c
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:55 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 15:20:41 +0000
Message-ID: <20181211151945.29137-11-aaron@os.amperecomputing.com>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 10/14] target/arm: Finish implementation of
 PM[X]EVCNTR and PM[X]EVTYPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <alindsay@codeaurora.org>

Add arrays to hold the registers, the definitions themselves, access
functions, and logic to reset counters when PMCR.P is set. Update
filtering code to support counters other than PMCCNTR. Support migration
with raw read/write functions.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |   3 +
 target/arm/helper.c | 296 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 282 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b15d0383b2..a479625790 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -482,6 +482,9 @@ typedef struct CPUARMState {
          * pmccntr_op_finish.
          */
         uint64_t c15_ccnt_delta;
+        uint64_t c14_pmevcntr[31];
+        uint64_t c14_pmevcntr_delta[31];
+        uint64_t c14_pmevtyper[31];
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register =
*/
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fd2923f033..1b851d1689 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -979,6 +979,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
+#define PMCRP   0x2
 #define PMCRE   0x1
=20
 #define PMXEVTYPER_P          0x80000000
@@ -1066,6 +1067,17 @@ uint64_t get_pmceid(CPUARMState *env, unsigned which=
)
     return pmceid;
 }
=20
+/*
+ * Check at runtime whether a PMU event is supported for the current machi=
ne
+ */
+static bool event_supported(uint16_t number)
+{
+    if (number > MAX_EVENT_ID) {
+        return false;
+    }
+    return supported_event_map[number] !=3D UNSUPPORTED_EVENT;
+}
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *r=
i,
                                    bool isread)
 {
@@ -1185,9 +1197,11 @@ static bool pmu_counter_enabled(CPUARMState *env, ui=
nt8_t counter)
         prohibited =3D env->cp15.c9_pmcr & PMCRDP;
     }
=20
-    /* TODO Remove assert, set filter to correct PMEVTYPER */
-    assert(counter =3D=3D 31);
-    filter =3D env->cp15.pmccfiltr_el0;
+    if (counter =3D=3D 31) {
+        filter =3D env->cp15.pmccfiltr_el0;
+    } else {
+        filter =3D env->cp15.c14_pmevtyper[counter];
+    }
=20
     p   =3D filter & PMXEVTYPER_P;
     u   =3D filter & PMXEVTYPER_U;
@@ -1207,6 +1221,17 @@ static bool pmu_counter_enabled(CPUARMState *env, ui=
nt8_t counter)
         filtered =3D m !=3D p;
     }
=20
+    if (counter !=3D 31) {
+        /*
+         * If not checking PMCCNTR, ensure the counter is setup to an even=
t we
+         * support
+         */
+        uint16_t event =3D filter & PMXEVTYPER_EVTCOUNT;
+        if (!event_supported(event)) {
+            return false;
+        }
+    }
+
     return enabled && !prohibited && !filtered;
 }
=20
@@ -1253,14 +1278,47 @@ void pmccntr_op_finish(CPUARMState *env)
     }
 }
=20
+static void pmevcntr_op_start(CPUARMState *env, uint8_t counter)
+{
+
+    uint16_t event =3D env->cp15.c14_pmevtyper[counter] & PMXEVTYPER_EVTCO=
UNT;
+    uint64_t count =3D 0;
+    if (event_supported(event)) {
+        uint16_t event_idx =3D supported_event_map[event];
+        count =3D pm_events[event_idx].get_count(env);
+    }
+
+    if (pmu_counter_enabled(env, counter)) {
+        env->cp15.c14_pmevcntr[counter] =3D
+            count - env->cp15.c14_pmevcntr_delta[counter];
+    }
+    env->cp15.c14_pmevcntr_delta[counter] =3D count;
+}
+
+static void pmevcntr_op_finish(CPUARMState *env, uint8_t counter)
+{
+    if (pmu_counter_enabled(env, counter)) {
+        env->cp15.c14_pmevcntr_delta[counter] -=3D
+            env->cp15.c14_pmevcntr[counter];
+    }
+}
+
 void pmu_op_start(CPUARMState *env)
 {
+    unsigned int i;
     pmccntr_op_start(env);
+    for (i =3D 0; i < pmu_num_counters(env); i++) {
+        pmevcntr_op_start(env, i);
+    }
 }
=20
 void pmu_op_finish(CPUARMState *env)
 {
+    unsigned int i;
     pmccntr_op_finish(env);
+    for (i =3D 0; i < pmu_num_counters(env); i++) {
+        pmevcntr_op_finish(env, i);
+    }
 }
=20
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
@@ -1283,6 +1341,13 @@ static void pmcr_write(CPUARMState *env, const ARMCP=
RegInfo *ri,
         env->cp15.c15_ccnt =3D 0;
     }
=20
+    if (value & PMCRP) {
+        unsigned int i;
+        for (i =3D 0; i < pmu_num_counters(env); i++) {
+            env->cp15.c14_pmevcntr[i] =3D 0;
+        }
+    }
+
     /* only the DP, X, D and E bits are writable */
     env->cp15.c9_pmcr &=3D ~0x39;
     env->cp15.c9_pmcr |=3D (value & 0x39);
@@ -1336,6 +1401,14 @@ void pmccntr_op_finish(CPUARMState *env)
 {
 }
=20
+void pmevcntr_op_start(CPUARMState *env, uint8_t i)
+{
+}
+
+void pmevcntr_op_finish(CPUARMState *env, uint8_t i)
+{
+}
+
 void pmu_op_start(CPUARMState *env)
 {
 }
@@ -1406,30 +1479,174 @@ static void pmovsset_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
     env->cp15.c9_pmovsr |=3D value;
 }
=20
-static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t value)
+static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value, const uint8_t counter)
 {
+    if (counter =3D=3D 31) {
+        pmccfiltr_write(env, ri, value);
+    } else if (counter < pmu_num_counters(env)) {
+        pmevcntr_op_start(env, counter);
+
+        /*
+         * If this counter's event type is changing, store the current
+         * underlying count for the new type in c14_pmevcntr_delta[counter=
] so
+         * pmevcntr_op_finish has the correct baseline when it converts ba=
ck to
+         * a delta.
+         */
+        uint16_t old_event =3D env->cp15.c14_pmevtyper[counter] &
+            PMXEVTYPER_EVTCOUNT;
+        uint16_t new_event =3D value & PMXEVTYPER_EVTCOUNT;
+        if (old_event !=3D new_event) {
+            uint64_t count =3D 0;
+            if (event_supported(new_event)) {
+                uint16_t event_idx =3D supported_event_map[new_event];
+                count =3D pm_events[event_idx].get_count(env);
+            }
+            env->cp15.c14_pmevcntr_delta[counter] =3D count;
+        }
+
+        env->cp15.c14_pmevtyper[counter] =3D value & PMXEVTYPER_MASK;
+        pmevcntr_op_finish(env, counter);
+    }
     /* Attempts to access PMXEVTYPER are CONSTRAINED UNPREDICTABLE when
      * PMSELR value is equal to or greater than the number of implemented
      * counters, but not equal to 0x1f. We opt to behave as a RAZ/WI.
      */
-    if (env->cp15.c9_pmselr =3D=3D 0x1f) {
-        pmccfiltr_write(env, ri, value);
+}
+
+static uint64_t pmevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri,
+                               const uint8_t counter)
+{
+    if (counter =3D=3D 31) {
+        return env->cp15.pmccfiltr_el0;
+    } else if (counter < pmu_num_counters(env)) {
+        return env->cp15.c14_pmevtyper[counter];
+    } else {
+      /*
+       * We opt to behave as a RAZ/WI when attempts to access PMXEVTYPER
+       * are CONSTRAINED UNPREDICTABLE. See comments in pmevtyper_write().
+       */
+        return 0;
     }
 }
=20
+static void pmevtyper_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    pmevtyper_write(env, ri, value, counter);
+}
+
+static void pmevtyper_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    env->cp15.c14_pmevtyper[counter] =3D value;
+
+    /*
+     * pmevtyper_rawwrite is called between a pair of pmu_op_start and
+     * pmu_op_finish calls when loading saved state for a migration. Becau=
se
+     * we're potentially updating the type of event here, the value writte=
n to
+     * c14_pmevcntr_delta by the preceeding pmu_op_start call may be for a
+     * different counter type. Therefore, we need to set this value to the
+     * current count for the counter type we're writing so that pmu_op_fin=
ish
+     * has the correct count for its calculation.
+     */
+    uint16_t event =3D value & PMXEVTYPER_EVTCOUNT;
+    if (event_supported(event)) {
+        uint16_t event_idx =3D supported_event_map[event];
+        env->cp15.c14_pmevcntr_delta[counter] =3D
+            pm_events[event_idx].get_count(env);
+    }
+}
+
+static uint64_t pmevtyper_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    return pmevtyper_read(env, ri, counter);
+}
+
+static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    pmevtyper_write(env, ri, value, env->cp15.c9_pmselr & 31);
+}
+
 static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    /* We opt to behave as a RAZ/WI when attempts to access PMXEVTYPER
-     * are CONSTRAINED UNPREDICTABLE. See comments in pmxevtyper_write().
+    return pmevtyper_read(env, ri, env->cp15.c9_pmselr & 31);
+}
+
+static void pmevcntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value, uint8_t counter)
+{
+    if (counter < pmu_num_counters(env)) {
+        pmevcntr_op_start(env, counter);
+        env->cp15.c14_pmevcntr[counter] =3D value;
+        pmevcntr_op_finish(env, counter);
+    }
+    /*
+     * We opt to behave as a RAZ/WI when attempts to access PM[X]EVCNTR
+     * are CONSTRAINED UNPREDICTABLE.
      */
-    if (env->cp15.c9_pmselr =3D=3D 0x1f) {
-        return env->cp15.pmccfiltr_el0;
+}
+
+static uint64_t pmevcntr_read(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint8_t counter)
+{
+    if (counter < pmu_num_counters(env)) {
+        uint64_t ret;
+        pmevcntr_op_start(env, counter);
+        ret =3D env->cp15.c14_pmevcntr[counter];
+        pmevcntr_op_finish(env, counter);
+        return ret;
     } else {
+      /* We opt to behave as a RAZ/WI when attempts to access PM[X]EVCNTR
+       * are CONSTRAINED UNPREDICTABLE. */
         return 0;
     }
 }
=20
+static void pmevcntr_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    pmevcntr_write(env, ri, value, counter);
+}
+
+static uint64_t pmevcntr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    return pmevcntr_read(env, ri, counter);
+}
+
+static void pmevcntr_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    assert(counter < pmu_num_counters(env));
+    env->cp15.c14_pmevcntr[counter] =3D value;
+    pmevcntr_write(env, ri, value, counter);
+}
+
+static uint64_t pmevcntr_rawread(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint8_t counter =3D ((ri->crm & 3) << 3) | (ri->opc2 & 7);
+    assert(counter < pmu_num_counters(env));
+    return env->cp15.c14_pmevcntr[counter];
+}
+
+static void pmxevcntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    pmevcntr_write(env, ri, value, env->cp15.c9_pmselr & 31);
+}
+
+static uint64_t pmxevcntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    return pmevcntr_read(env, ri, env->cp15.c9_pmselr & 31);
+}
+
 static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1633,16 +1850,23 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .fieldoffset =3D offsetof(CPUARMState, cp15.pmccfiltr_el0),
       .resetvalue =3D 0, },
     { .name =3D "PMXEVTYPER", .cp =3D 15, .crn =3D 9, .crm =3D 13, .opc1 =
=3D 0, .opc2 =3D 1,
-      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW, .accessfn =3D pmreg_acc=
ess,
+      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn =3D pmreg_access,
       .writefn =3D pmxevtyper_write, .readfn =3D pmxevtyper_read },
     { .name =3D "PMXEVTYPER_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 13, .opc2 =3D 1,
-      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW, .accessfn =3D pmreg_acc=
ess,
+      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn =3D pmreg_access,
       .writefn =3D pmxevtyper_write, .readfn =3D pmxevtyper_read },
-    /* Unimplemented, RAZ/WI. */
     { .name =3D "PMXEVCNTR", .cp =3D 15, .crn =3D 9, .crm =3D 13, .opc1 =
=3D 0, .opc2 =3D 2,
-      .access =3D PL0_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0,
-      .accessfn =3D pmreg_access_xevcntr },
+      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn =3D pmreg_access_xevcntr,
+      .writefn =3D pmxevcntr_write, .readfn =3D pmxevcntr_read },
+    { .name =3D "PMXEVCNTR_EL0", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 13, .opc2 =3D 2,
+      .access =3D PL0_RW, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
+      .accessfn =3D pmreg_access_xevcntr,
+      .writefn =3D pmxevcntr_write, .readfn =3D pmxevcntr_read },
     { .name =3D "PMUSERENR", .cp =3D 15, .crn =3D 9, .crm =3D 14, .opc1 =
=3D 0, .opc2 =3D 0,
       .access =3D PL0_R | PL1_RW, .accessfn =3D access_tpm,
       .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmuserenr),
@@ -4429,7 +4653,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
 #endif
     /* The only field of MDCR_EL2 that has a defined architectural reset v=
alue
      * is MDCR_EL2.HPMN which should reset to the value of PMCR_EL0.N; but=
 we
-     * don't impelment any PMU event counters, so using zero as a reset
+     * don't implement any PMU event counters, so using zero as a reset
      * value for MDCR_EL2 is okay
      */
     { .name =3D "MDCR_EL2", .state =3D ARM_CP_STATE_BOTH,
@@ -5281,6 +5505,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * field as main ID register, and we implement only the cycle
          * count register.
          */
+        unsigned int i, pmcrn =3D 0;
 #ifndef CONFIG_USER_ONLY
         ARMCPRegInfo pmcr =3D {
             .name =3D "PMCR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =
=3D 0, .opc2 =3D 0,
@@ -5301,6 +5526,43 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         };
         define_one_arm_cp_reg(cpu, &pmcr);
         define_one_arm_cp_reg(cpu, &pmcr64);
+        for (i =3D 0; i < pmcrn; i++) {
+            char *pmevcntr_name =3D g_strdup_printf("PMEVCNTR%d", i);
+            char *pmevcntr_el0_name =3D g_strdup_printf("PMEVCNTR%d_EL0", =
i);
+            char *pmevtyper_name =3D g_strdup_printf("PMEVTYPER%d", i);
+            char *pmevtyper_el0_name =3D g_strdup_printf("PMEVTYPER%d_EL0"=
, i);
+            ARMCPRegInfo pmev_regs[] =3D {
+                { .name =3D pmevcntr_name, .cp =3D 15, .crn =3D 15,
+                  .crm =3D 8 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i & =
7,
+                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
+                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_write=
fn,
+                  .accessfn =3D pmreg_access },
+                { .name =3D pmevcntr_el0_name, .state =3D ARM_CP_STATE_AA6=
4,
+                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 8 | (3 &=
 (i >> 3)),
+                  .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg=
_access,
+                  .type =3D ARM_CP_IO,
+                  .readfn =3D pmevcntr_readfn, .writefn =3D pmevcntr_write=
fn,
+                  .raw_readfn =3D pmevcntr_rawread,
+                  .raw_writefn =3D pmevcntr_rawwrite },
+                { .name =3D pmevtyper_name, .cp =3D 15, .crn =3D 15,
+                  .crm =3D 12 | (3 & (i >> 3)), .opc1 =3D 0, .opc2 =3D i &=
 7,
+                  .access =3D PL0_RW, .type =3D ARM_CP_IO | ARM_CP_ALIAS,
+                  .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_wri=
tefn,
+                  .accessfn =3D pmreg_access },
+                { .name =3D pmevtyper_el0_name, .state =3D ARM_CP_STATE_AA=
64,
+                  .opc0 =3D 3, .opc1 =3D 3, .crn =3D 15, .crm =3D 12 | (3 =
& (i >> 3)),
+                  .opc2 =3D i & 7, .access =3D PL0_RW, .accessfn =3D pmreg=
_access,
+                  .type =3D ARM_CP_IO,
+                  .readfn =3D pmevtyper_readfn, .writefn =3D pmevtyper_wri=
tefn,
+                  .raw_writefn =3D pmevtyper_rawwrite },
+                REGINFO_SENTINEL
+            };
+            define_arm_cp_regs(cpu, pmev_regs);
+            g_free(pmevcntr_name);
+            g_free(pmevcntr_el0_name);
+            g_free(pmevtyper_name);
+            g_free(pmevtyper_el0_name);
+        }
 #endif
         ARMCPRegInfo clidr =3D {
             .name =3D "CLIDR", .state =3D ARM_CP_STATE_BOTH,
--=20
2.19.2
