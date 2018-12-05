Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXTG-0008Ca-Jw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXTF-0005gS-An
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:10 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:26 +0000
Message-ID: <20181205134243.4791-12-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 11/14] target/arm: PMU: Add instruction and
 cycle events
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

The instruction event is only enabled when icount is used, cycles are
always supported. Always defining get_cycle_count (but altering its
behavior depending on CONFIG_USER_ONLY) allows us to remove some
CONFIG_USER_ONLY #defines throughout the rest of the code.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 90 ++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c51031d262..a45ab5d9da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -15,6 +15,7 @@
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "exec/semihost.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
@@ -1021,7 +1022,48 @@ typedef struct pm_event {
     uint64_t (*get_count)(CPUARMState *);
 } pm_event;
=20
+static bool event_always_supported(CPUARMState *env)
+{
+    return true;
+}
+
+/*
+ * Return the underlying cycle count for the PMU cycle counters. If we're =
in
+ * usermode, simply return 0.
+ */
+static uint64_t cycles_get_count(CPUARMState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+#else
+    return cpu_get_host_ticks();
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
+static bool instructions_supported(CPUARMState *env)
+{
+    return use_icount =3D=3D 1 /* Precise instruction counting */;
+}
+
+static uint64_t instructions_get_count(CPUARMState *env)
+{
+    return (uint64_t)cpu_get_icount_raw();
+}
+#endif
+
 static const pm_event pm_events[] =3D {
+#ifndef CONFIG_USER_ONLY
+    { .number =3D 0x008, /* INST_RETIRED, Instruction architecturally exec=
uted */
+      .supported =3D instructions_supported,
+      .get_count =3D instructions_get_count,
+    },
+    { .number =3D 0x011, /* CPU_CYCLES, Cycle */
+      .supported =3D event_always_supported,
+      .get_count =3D cycles_get_count,
+    }
+#endif
 };
=20
 /*
@@ -1030,7 +1072,7 @@ static const pm_event pm_events[] =3D {
  * should first be updated to something sparse instead of the current
  * supported_event_map[] array.
  */
-#define MAX_EVENT_ID 0x0
+#define MAX_EVENT_ID 0x11
 #define UNSUPPORTED_EVENT UINT16_MAX
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
=20
@@ -1131,8 +1173,6 @@ static CPAccessResult pmreg_access_swinc(CPUARMState =
*env,
     return pmreg_access(env, ri, isread);
 }
=20
-#ifndef CONFIG_USER_ONLY
-
 static CPAccessResult pmreg_access_selr(CPUARMState *env,
                                         const ARMCPRegInfo *ri,
                                         bool isread)
@@ -1243,9 +1283,7 @@ static bool pmu_counter_enabled(CPUARMState *env, uin=
t8_t counter)
  */
 void pmccntr_op_start(CPUARMState *env)
 {
-    uint64_t cycles =3D 0;
-    cycles =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                          ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
+    uint64_t cycles =3D cycles_get_count(env);
=20
     if (pmu_counter_enabled(env, 31)) {
         uint64_t eff_cycles =3D cycles;
@@ -1391,42 +1429,6 @@ static void pmccntr_write32(CPUARMState *env, const =
ARMCPRegInfo *ri,
     pmccntr_write(env, ri, deposit64(cur_val, 0, 32, value));
 }
=20
-#else /* CONFIG_USER_ONLY */
-
-void pmccntr_op_start(CPUARMState *env)
-{
-}
-
-void pmccntr_op_finish(CPUARMState *env)
-{
-}
-
-void pmevcntr_op_start(CPUARMState *env, uint8_t i)
-{
-}
-
-void pmevcntr_op_finish(CPUARMState *env, uint8_t i)
-{
-}
-
-void pmu_op_start(CPUARMState *env)
-{
-}
-
-void pmu_op_finish(CPUARMState *env)
-{
-}
-
-void pmu_pre_el_change(ARMCPU *cpu, void *ignored)
-{
-}
-
-void pmu_post_el_change(ARMCPU *cpu, void *ignored)
-{
-}
-
-#endif
-
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1814,7 +1816,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
     /* Unimplemented so WI. */
     { .name =3D "PMSWINC", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D =
0, .opc2 =3D 4,
       .access =3D PL0_W, .accessfn =3D pmreg_access_swinc, .type =3D ARM_C=
P_NOP },
-#ifndef CONFIG_USER_ONLY
     { .name =3D "PMSELR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =3D 0=
, .opc2 =3D 5,
       .access =3D PL0_RW, .type =3D ARM_CP_ALIAS,
       .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmselr),
@@ -1836,7 +1837,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .fieldoffset =3D offsetof(CPUARMState, cp15.c15_ccnt),
       .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
       .raw_readfn =3D raw_read, .raw_writefn =3D raw_write, },
-#endif
     { .name =3D "PMCCFILTR", .cp =3D 15, .opc1 =3D 0, .crn =3D 14, .crm =
=3D 15, .opc2 =3D 7,
       .writefn =3D pmccfiltr_write_a32, .readfn =3D pmccfiltr_read_a32,
       .access =3D PL0_RW, .accessfn =3D pmreg_access,
@@ -5506,7 +5506,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * count register.
          */
         unsigned int i, pmcrn =3D 0;
-#ifndef CONFIG_USER_ONLY
         ARMCPRegInfo pmcr =3D {
             .name =3D "PMCR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =
=3D 0, .opc2 =3D 0,
             .access =3D PL0_RW,
@@ -5563,7 +5562,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             g_free(pmevtyper_name);
             g_free(pmevtyper_el0_name);
         }
-#endif
         ARMCPRegInfo clidr =3D {
             .name =3D "CLIDR", .state =3D ARM_CP_STATE_BOTH,
             .opc0 =3D 3, .crn =3D 0, .crm =3D 0, .opc1 =3D 1, .opc2 =3D 1,
--=20
2.19.1
