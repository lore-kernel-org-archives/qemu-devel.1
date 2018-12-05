Received: from eggs.gnu.org ([2001:4830:134:3::10]:51804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXTB-00086o-LX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXT6-0005SM-Al
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:05 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:23 +0000
Message-ID: <20181205134243.4791-10-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 09/14] target/arm: Add array for supported
 PMU events, generate PMCEID[01]_EL0
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

This commit doesn't add any supported events, but provides the framework
for adding them. We store the pm_event structs in a simple array, and
provide the mapping from the event numbers to array indexes in the
supported_event_map array. Because the value of PMCEID[01] depends upon
which events are supported at runtime, generate it dynamically.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c    | 19 +++++++++------
 target/arm/cpu.h    | 10 ++++++++
 target/arm/cpu64.c  |  4 ----
 target/arm/helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f7bad04f60..208a08e867 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1019,10 +1019,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
=20
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
+    }
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        cpu->pmceid0 =3D get_pmceid(&cpu->env, 0);
+        cpu->pmceid1 =3D get_pmceid(&cpu->env, 1);
+
+        if (!kvm_enabled()) {
+            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+        }
+    } else {
         cpu->id_aa64dfr0 &=3D ~0xf00;
-    } else if (!kvm_enabled()) {
-        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
-        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+        cpu->pmceid0 =3D 0;
+        cpu->pmceid1 =3D 0;
     }
=20
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
@@ -1665,8 +1674,6 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_pfr0 =3D 0x00001131;
     cpu->id_pfr1 =3D 0x00011011;
     cpu->id_dfr0 =3D 0x02010555;
-    cpu->pmceid0 =3D 0x00000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->id_afr0 =3D 0x00000000;
     cpu->id_mmfr0 =3D 0x10101105;
     cpu->id_mmfr1 =3D 0x40000000;
@@ -1712,8 +1719,6 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_pfr0 =3D 0x00001131;
     cpu->id_pfr1 =3D 0x00011011;
     cpu->id_dfr0 =3D 0x02010555;
-    cpu->pmceid0 =3D 0x0000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->id_afr0 =3D 0x00000000;
     cpu->id_mmfr0 =3D 0x10201105;
     cpu->id_mmfr1 =3D 0x20000000;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4216fe22db..0255f68bd7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -993,6 +993,16 @@ void pmu_op_finish(CPUARMState *env);
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
 void pmu_post_el_change(ARMCPU *cpu, void *ignored);
=20
+/*
+ * get_pmceid
+ * @env: CPUARMState
+ * @which: which PMCEID register to return (0 or 1)
+ *
+ * Return the PMCEID[01]_EL0 register values corresponding to the counters
+ * which are supported given the current configuration
+ */
+uint64_t get_pmceid(CPUARMState *env, unsigned which);
+
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
  * for both old and new bit meanings. Code which tests against those
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 873f059bf2..a1aad772fa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -138,8 +138,6 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.id_isar6 =3D 0;
     cpu->isar.id_aa64pfr0 =3D 0x00002222;
     cpu->id_aa64dfr0 =3D 0x10305106;
-    cpu->pmceid0 =3D 0x00000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->isar.id_aa64isar0 =3D 0x00011120;
     cpu->id_aa64mmfr0 =3D 0x00001124;
     cpu->dbgdidr =3D 0x3516d000;
@@ -246,8 +244,6 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.id_isar5 =3D 0x00011121;
     cpu->isar.id_aa64pfr0 =3D 0x00002222;
     cpu->id_aa64dfr0 =3D 0x10305106;
-    cpu->pmceid0 =3D 0x00000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->isar.id_aa64isar0 =3D 0x00011120;
     cpu->id_aa64mmfr0 =3D 0x00001124;
     cpu->dbgdidr =3D 0x3516d000;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fb6939e99c..b7a1f4c108 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1009,6 +1009,63 @@ static inline uint64_t pmu_counter_mask(CPUARMState =
*env)
   return (1 << 31) | ((1 << pmu_num_counters(env)) - 1);
 }
=20
+typedef struct pm_event {
+    uint16_t number; /* PMEVTYPER.evtCount is 16 bits wide */
+    /* If the event is supported on this CPU (used to generate PMCEID[01])=
 */
+    bool (*supported)(CPUARMState *);
+    /*
+     * Retrieve the current count of the underlying event. The programmed
+     * counters hold a difference from the return value from this function
+     */
+    uint64_t (*get_count)(CPUARMState *);
+} pm_event;
+
+static const pm_event pm_events[] =3D {
+};
+
+/*
+ * Note: Before increasing MAX_EVENT_ID beyond 0x3f into the 0x40xx range =
of
+ * events (i.e. the statistical profiling extension), this implementation
+ * should first be updated to something sparse instead of the current
+ * supported_event_map[] array.
+ */
+#define MAX_EVENT_ID 0x0
+#define UNSUPPORTED_EVENT UINT16_MAX
+static uint16_t supported_event_map[MAX_EVENT_ID + 1];
+
+/*
+ * Called upon initialization to build PMCEID0_EL0 or PMCEID1_EL0 (indicat=
ed by
+ * 'which'). We also use it to build a map of ARM event numbers to indices=
 in
+ * our pm_events array.
+ *
+ * Note: Events in the 0x40XX range are not currently supported.
+ */
+uint64_t get_pmceid(CPUARMState *env, unsigned which)
+{
+    uint64_t pmceid =3D 0;
+    unsigned int i;
+
+    assert(which <=3D 1);
+
+    for (i =3D 0; i < ARRAY_SIZE(supported_event_map); i++) {
+        supported_event_map[i] =3D UNSUPPORTED_EVENT;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(pm_events); i++) {
+        const pm_event *cnt =3D &pm_events[i];
+        assert(cnt->number <=3D MAX_EVENT_ID);
+        /* We do not currently support events in the 0x40xx range */
+        assert(cnt->number <=3D 0x3f);
+
+        if ((cnt->number & 0x20) =3D=3D (which << 6) &&
+                cnt->supported(env)) {
+            pmceid |=3D (1 << (cnt->number & 0x1f));
+            supported_event_map[cnt->number] =3D i;
+        }
+    }
+    return pmceid;
+}
+
 static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *r=
i,
                                    bool isread)
 {
--=20
2.19.1
