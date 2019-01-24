Received: from eggs.gnu.org ([209.51.188.92]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmho7-0003kn-11
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmho3-0005m6-7t
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:46 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Thu, 24 Jan 2019 16:24:14 +0000
Message-ID: <20190124162401.5111-2-aaron@os.amperecomputing.com>
References: <20190124162401.5111-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190124162401.5111-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v12 1/2] target/arm: Send interrupts on PMU
 counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay OS <aaron@os.amperecomputing.com>

Whenever we notice that a counter overflow has occurred, send an
interrupt. This is made more reliable with the addition of a timer in a
follow-on commit.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 61 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 31273fb8de..fc33c45441 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -977,6 +977,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
 /* Definitions for the PMU registers */
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
+#define PMCRLC  0x40
 #define PMCRDP  0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
@@ -1293,6 +1294,13 @@ static bool pmu_counter_enabled(CPUARMState *env, ui=
nt8_t counter)
     return enabled && !prohibited && !filtered;
 }
=20
+static void pmu_update_irq(CPUARMState *env)
+{
+    ARMCPU *cpu =3D arm_env_get_cpu(env);
+    qemu_set_irq(cpu->pmu_interrupt, (env->cp15.c9_pmcr & PMCRE) &&
+            (env->cp15.c9_pminten & env->cp15.c9_pmovsr));
+}
+
 /*
  * Ensure c15_ccnt is the guest-visible count so that operations such as
  * enabling/disabling the counter or filtering, modifying the count itself=
,
@@ -1310,7 +1318,16 @@ void pmccntr_op_start(CPUARMState *env)
             eff_cycles /=3D 64;
         }
=20
-        env->cp15.c15_ccnt =3D eff_cycles - env->cp15.c15_ccnt_delta;
+        uint64_t new_pmccntr =3D eff_cycles - env->cp15.c15_ccnt_delta;
+
+        uint64_t overflow_mask =3D env->cp15.c9_pmcr & PMCRLC ? \
+                                 1ull << 63 : 1ull << 31;
+        if (env->cp15.c15_ccnt & ~new_pmccntr & overflow_mask) {
+            env->cp15.c9_pmovsr |=3D (1 << 31);
+            pmu_update_irq(env);
+        }
+
+        env->cp15.c15_ccnt =3D new_pmccntr;
     }
     env->cp15.c15_ccnt_delta =3D cycles;
 }
@@ -1345,8 +1362,13 @@ static void pmevcntr_op_start(CPUARMState *env, uint=
8_t counter)
     }
=20
     if (pmu_counter_enabled(env, counter)) {
-        env->cp15.c14_pmevcntr[counter] =3D
-            count - env->cp15.c14_pmevcntr_delta[counter];
+        uint32_t new_pmevcntr =3D count - env->cp15.c14_pmevcntr_delta[cou=
nter];
+
+        if (env->cp15.c14_pmevcntr[counter] & ~new_pmevcntr & INT32_MIN) {
+            env->cp15.c9_pmovsr |=3D (1 << counter);
+            pmu_update_irq(env);
+        }
+        env->cp15.c14_pmevcntr[counter] =3D new_pmevcntr;
     }
     env->cp15.c14_pmevcntr_delta[counter] =3D count;
 }
@@ -1423,7 +1445,20 @@ static void pmswinc_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
                 /* counter is SW_INCR */
                 (env->cp15.c14_pmevtyper[i] & PMXEVTYPER_EVTCOUNT) =3D=3D =
0x0) {
             pmevcntr_op_start(env, i);
-            env->cp15.c14_pmevcntr[i]++;
+
+            /*
+             * Detect if this write causes an overflow since we can't pred=
ict
+             * PMSWINC overflows like we can for other events
+             */
+            uint32_t new_pmswinc =3D env->cp15.c14_pmevcntr[i] + 1;
+
+            if (env->cp15.c14_pmevcntr[i] & ~new_pmswinc & INT32_MIN) {
+                env->cp15.c9_pmovsr |=3D (1 << i);
+                pmu_update_irq(env);
+            }
+
+            env->cp15.c14_pmevcntr[i] =3D new_pmswinc;
+
             pmevcntr_op_finish(env, i);
         }
     }
@@ -1508,6 +1543,7 @@ static void pmovsr_write(CPUARMState *env, const ARMC=
PRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmovsr &=3D ~value;
+    pmu_update_irq(env);
 }
=20
 static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1515,6 +1551,7 @@ static void pmovsset_write(CPUARMState *env, const AR=
MCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pmovsr |=3D value;
+    pmu_update_irq(env);
 }
=20
 static void pmevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1701,6 +1738,7 @@ static void pmintenset_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
     /* We have no event counters so only the C bit can be changed */
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pminten |=3D value;
+    pmu_update_irq(env);
 }
=20
 static void pmintenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1708,6 +1746,7 @@ static void pmintenclr_write(CPUARMState *env, const =
ARMCPRegInfo *ri,
 {
     value &=3D pmu_counter_mask(env);
     env->cp15.c9_pminten &=3D ~value;
+    pmu_update_irq(env);
 }
=20
 static void vbar_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1846,7 +1885,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcnten),
       .writefn =3D pmcntenclr_write },
     { .name =3D "PMOVSR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D 0=
, .opc2 =3D 3,
-      .access =3D PL0_RW,
+      .access =3D PL0_RW, .type =3D ARM_CP_IO,
       .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmovsr),
       .accessfn =3D pmreg_access,
       .writefn =3D pmovsr_write,
@@ -1854,16 +1893,18 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
     { .name =3D "PMOVSCLR_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D 3,
       .access =3D PL0_RW, .accessfn =3D pmreg_access,
-      .type =3D ARM_CP_ALIAS,
+      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn =3D pmovsr_write,
       .raw_writefn =3D raw_write },
     { .name =3D "PMSWINC", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D =
0, .opc2 =3D 4,
-      .access =3D PL0_W, .accessfn =3D pmreg_access_swinc, .type =3D ARM_C=
P_NO_RAW,
+      .access =3D PL0_W, .accessfn =3D pmreg_access_swinc,
+      .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
       .writefn =3D pmswinc_write },
     { .name =3D "PMSWINC_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D 4,
-      .access =3D PL0_W, .accessfn =3D pmreg_access_swinc, .type =3D ARM_C=
P_NO_RAW,
+      .access =3D PL0_W, .accessfn =3D pmreg_access_swinc,
+      .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
       .writefn =3D pmswinc_write },
     { .name =3D "PMSELR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D 0=
, .opc2 =3D 5,
       .access =3D PL0_RW, .type =3D ARM_CP_ALIAS,
@@ -2050,14 +2091,14 @@ static const ARMCPRegInfo pmovsset_cp_reginfo[] =3D=
 {
     /* PMOVSSET is not implemented in v7 before v7ve */
     { .name =3D "PMOVSSET", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D =
14, .opc2 =3D 3,
       .access =3D PL0_RW, .accessfn =3D pmreg_access,
-      .type =3D ARM_CP_ALIAS,
+      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmovsr),
       .writefn =3D pmovsset_write,
       .raw_writefn =3D raw_write },
     { .name =3D "PMOVSSET_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 14, .opc2 =3D 3,
       .access =3D PL0_RW, .accessfn =3D pmreg_access,
-      .type =3D ARM_CP_ALIAS,
+      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmovsr),
       .writefn =3D pmovsset_write,
       .raw_writefn =3D raw_write },
--=20
2.20.1
