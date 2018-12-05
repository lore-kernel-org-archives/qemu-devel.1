Received: from eggs.gnu.org ([2001:4830:134:3::10]:51536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSc-0007aR-Qz
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXSb-0004nV-A6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:43:30 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:15 +0000
Message-ID: <20181205134243.4791-3-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 02/14] target/arm: Reorganize PMCCNTR
 accesses
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

pmccntr_read and pmccntr_write contained duplicate code that was already
being handled by pmccntr_sync. Consolidate the duplicated code into two
functions: pmccntr_op_start and pmccntr_op_finish. Add a companion to
c15_ccnt in CPUARMState so that we can simultaneously save both the
architectural register value and the last underlying cycle count - this
ensures time isn't lost and will also allow us to access the 'old'
architectural register value in order to detect overflows in later
patches.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  37 ++++++++++----
 target/arm/helper.c | 114 +++++++++++++++++++++++++++-----------------
 2 files changed, 98 insertions(+), 53 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a73fed9a0..61ac458627 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -468,10 +468,20 @@ typedef struct CPUARMState {
         uint64_t oslsr_el1; /* OS Lock Status */
         uint64_t mdcr_el2;
         uint64_t mdcr_el3;
-        /* If the counter is enabled, this stores the last time the counte=
r
-         * was reset. Otherwise it stores the counter value
+        /* Stores the architectural value of the counter *the last time it=
 was
+         * updated* by pmccntr_op_start. Accesses should always be surroun=
ded
+         * by pmccntr_op_start/pmccntr_op_finish to guarantee the latest
+         * architecturally-correct value is being read/set.
          */
         uint64_t c15_ccnt;
+        /* Stores the delta between the architectural value and the underl=
ying
+         * cycle count during normal operation. It is used to update c15_c=
cnt
+         * to be the correct architectural value before accesses. During
+         * accesses, c15_ccnt_delta contains the underlying count being us=
ed
+         * for the access, after which it reverts to the delta value in
+         * pmccntr_op_finish.
+         */
+        uint64_t c15_ccnt_delta;
         uint64_t pmccfiltr_el0; /* Performance Monitor Filter Register */
         uint64_t vpidr_el2; /* Virtualization Processor ID Register */
         uint64_t vmpidr_el2; /* Virtualization Multiprocessor ID Register =
*/
@@ -956,15 +966,26 @@ int cpu_arm_signal_handler(int host_signum, void *pin=
fo,
                            void *puc);
=20
 /**
- * pmccntr_sync
+ * pmccntr_op_start/finish
+ * @env: CPUARMState
+ *
+ * Convert the counter in the PMCCNTR between its delta form (the typical =
mode
+ * when it's enabled) and the guest-visible value. These two calls must al=
ways
+ * surround any action which might affect the counter.
+ */
+void pmccntr_op_start(CPUARMState *env);
+void pmccntr_op_finish(CPUARMState *env);
+
+/**
+ * pmu_op_start/finish
  * @env: CPUARMState
  *
- * Synchronises the counter in the PMCCNTR. This must always be called twi=
ce,
- * once before any action that might affect the timer and again afterwards=
.
- * The function is used to swap the state of the register if required.
- * This only happens when not in user mode (!CONFIG_USER_ONLY)
+ * Convert all PMU counters between their delta form (the typical mode whe=
n
+ * they are enabled) and the guest-visible values. These two calls must
+ * surround any action which might affect the counters.
  */
-void pmccntr_sync(CPUARMState *env);
+void pmu_op_start(CPUARMState *env);
+void pmu_op_finish(CPUARMState *env);
=20
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0da1424f72..497907fc79 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1085,28 +1085,63 @@ static inline bool arm_ccnt_enabled(CPUARMState *en=
v)
=20
     return true;
 }
-
-void pmccntr_sync(CPUARMState *env)
+/*
+ * Ensure c15_ccnt is the guest-visible count so that operations such as
+ * enabling/disabling the counter or filtering, modifying the count itself=
,
+ * etc. can be done logically. This is essentially a no-op if the counter =
is
+ * not enabled at the time of the call.
+ */
+void pmccntr_op_start(CPUARMState *env)
 {
-    uint64_t temp_ticks;
-
-    temp_ticks =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+    uint64_t cycles =3D 0;
+    cycles =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
=20
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        temp_ticks /=3D 64;
+    if (arm_ccnt_enabled(env)) {
+        uint64_t eff_cycles =3D cycles;
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            eff_cycles /=3D 64;
+        }
+
+        env->cp15.c15_ccnt =3D eff_cycles - env->cp15.c15_ccnt_delta;
     }
+    env->cp15.c15_ccnt_delta =3D cycles;
+}
=20
+/*
+ * If PMCCNTR is enabled, recalculate the delta between the clock and the
+ * guest-visible count. A call to pmccntr_op_finish should follow every ca=
ll to
+ * pmccntr_op_start.
+ */
+void pmccntr_op_finish(CPUARMState *env)
+{
     if (arm_ccnt_enabled(env)) {
-        env->cp15.c15_ccnt =3D temp_ticks - env->cp15.c15_ccnt;
+        uint64_t prev_cycles =3D env->cp15.c15_ccnt_delta;
+
+        if (env->cp15.c9_pmcr & PMCRD) {
+            /* Increment once every 64 processor clock cycles */
+            prev_cycles /=3D 64;
+        }
+
+        env->cp15.c15_ccnt_delta =3D prev_cycles - env->cp15.c15_ccnt;
     }
 }
=20
+void pmu_op_start(CPUARMState *env)
+{
+    pmccntr_op_start(env);
+}
+
+void pmu_op_finish(CPUARMState *env)
+{
+    pmccntr_op_finish(env);
+}
+
 static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                        uint64_t value)
 {
-    pmccntr_sync(env);
+    pmu_op_start(env);
=20
     if (value & PMCRC) {
         /* The counter has been reset */
@@ -1117,26 +1152,16 @@ static void pmcr_write(CPUARMState *env, const ARMC=
PRegInfo *ri,
     env->cp15.c9_pmcr &=3D ~0x39;
     env->cp15.c9_pmcr |=3D (value & 0x39);
=20
-    pmccntr_sync(env);
+    pmu_op_finish(env);
 }
=20
 static uint64_t pmccntr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    uint64_t total_ticks;
-
-    if (!arm_ccnt_enabled(env)) {
-        /* Counter is disabled, do not change value */
-        return env->cp15.c15_ccnt;
-    }
-
-    total_ticks =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
-
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        total_ticks /=3D 64;
-    }
-    return total_ticks - env->cp15.c15_ccnt;
+    uint64_t ret;
+    pmccntr_op_start(env);
+    ret =3D env->cp15.c15_ccnt;
+    pmccntr_op_finish(env);
+    return ret;
 }
=20
 static void pmselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1153,22 +1178,9 @@ static void pmselr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
 static void pmccntr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    uint64_t total_ticks;
-
-    if (!arm_ccnt_enabled(env)) {
-        /* Counter is disabled, set the absolute value */
-        env->cp15.c15_ccnt =3D value;
-        return;
-    }
-
-    total_ticks =3D muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
-
-    if (env->cp15.c9_pmcr & PMCRD) {
-        /* Increment once every 64 processor clock cycles */
-        total_ticks /=3D 64;
-    }
-    env->cp15.c15_ccnt =3D total_ticks - value;
+    pmccntr_op_start(env);
+    env->cp15.c15_ccnt =3D value;
+    pmccntr_op_finish(env);
 }
=20
 static void pmccntr_write32(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1181,7 +1193,19 @@ static void pmccntr_write32(CPUARMState *env, const =
ARMCPRegInfo *ri,
=20
 #else /* CONFIG_USER_ONLY */
=20
-void pmccntr_sync(CPUARMState *env)
+void pmccntr_op_start(CPUARMState *env)
+{
+}
+
+void pmccntr_op_finish(CPUARMState *env)
+{
+}
+
+void pmu_op_start(CPUARMState *env)
+{
+}
+
+void pmu_op_finish(CPUARMState *env)
 {
 }
=20
@@ -1190,9 +1214,9 @@ void pmccntr_sync(CPUARMState *env)
 static void pmccfiltr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
-    pmccntr_sync(env);
+    pmccntr_op_start(env);
     env->cp15.pmccfiltr_el0 =3D value & 0xfc000000;
-    pmccntr_sync(env);
+    pmccntr_op_finish(env);
 }
=20
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
--=20
2.19.1
