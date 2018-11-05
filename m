Received: from eggs.gnu.org ([2001:4830:134:3::10]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjzI-00055q-Dr
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjz3-0000rH-G5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:52:32 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Mon, 5 Nov 2018 18:51:57 +0000
Message-ID: <20181105185046.2802-8-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181105185046.2802-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v7 07/12] target/arm: Add array for supported
 PMU events, generate PMCEID[01]
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
---
 target/arm/cpu.c    | 20 +++++++++++++-------
 target/arm/cpu.h    | 10 ++++++++++
 target/arm/cpu64.c  |  4 ----
 target/arm/helper.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9e54c56379..d1c766d180 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -957,9 +957,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error =
**errp)
     if (!cpu->has_pmu) {
         unset_feature(env, ARM_FEATURE_PMU);
         cpu->id_aa64dfr0 &=3D ~0xf00;
-    } else if (!kvm_enabled()) {
-        arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
-        arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+    }
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        uint64_t pmceid =3D get_pmceid(&cpu->env);
+        cpu->pmceid0 =3D extract64(pmceid, 0, 32);
+        cpu->pmceid1 =3D extract64(pmceid, 32, 32);
+
+        if (!kvm_enabled()) {
+            arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
+            arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
+        }
+    } else {
+        cpu->pmceid0 =3D 0x00000000;
+        cpu->pmceid1 =3D 0x00000000;
     }
=20
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
@@ -1601,8 +1611,6 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_pfr0 =3D 0x00001131;
     cpu->id_pfr1 =3D 0x00011011;
     cpu->id_dfr0 =3D 0x02010555;
-    cpu->pmceid0 =3D 0x00000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->id_afr0 =3D 0x00000000;
     cpu->id_mmfr0 =3D 0x10101105;
     cpu->id_mmfr1 =3D 0x40000000;
@@ -1647,8 +1655,6 @@ static void cortex_a15_initfn(Object *obj)
     cpu->id_pfr0 =3D 0x00001131;
     cpu->id_pfr1 =3D 0x00011011;
     cpu->id_dfr0 =3D 0x02010555;
-    cpu->pmceid0 =3D 0x0000000;
-    cpu->pmceid1 =3D 0x00000000;
     cpu->id_afr0 =3D 0x00000000;
     cpu->id_mmfr0 =3D 0x10201105;
     cpu->id_mmfr1 =3D 0x20000000;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 92282cd976..f991ff370e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -991,6 +991,16 @@ void pmu_op_finish(CPUARMState *env);
 void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
 void pmu_post_el_change(ARMCPU *cpu, void *ignored);
=20
+/*
+ * get_pmceid
+ * @env: CPUARMState
+ *
+ * Return the PMCEID[01] register values corresponding to the counters whi=
ch
+ * are supported given the current configuration (0 is low 32, 1 is high 3=
2
+ * bits)
+ */
+uint64_t get_pmceid(CPUARMState *env);
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
index 6724d97346..b9d8441497 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1009,6 +1009,48 @@ static inline uint64_t pmu_counter_mask(CPUARMState =
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
+#define MAX_EVENT_ID 0x0
+#define UNSUPPORTED_EVENT UINT16_MAX
+static uint16_t supported_event_map[MAX_EVENT_ID + 1];
+
+/*
+ * Called upon initialization to build PMCEID0 (low 32 bits) and PMCEID1 (=
high
+ * 32). We also use it to build a map of ARM event numbers to indices in
+ * our pm_events array.
+ */
+uint64_t get_pmceid(CPUARMState *env)
+{
+    uint64_t pmceid =3D 0;
+    unsigned int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(supported_event_map); i++) {
+        supported_event_map[i] =3D UNSUPPORTED_EVENT;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(pm_events); i++) {
+        const pm_event *cnt =3D &pm_events[i];
+        assert(cnt->number <=3D MAX_EVENT_ID);
+        if (cnt->supported(env)) {
+            pmceid |=3D (1 << cnt->number);
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
