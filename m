Received: from eggs.gnu.org ([209.51.188.92]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmOje-0007Dd-DI
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmOgd-0004Ui-Jl
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:59:48 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Wed, 23 Jan 2019 19:59:36 +0000
Message-ID: <20190123195814.29253-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] target/arm: Don't clear supported PMU events
 when initializing PMCEID1
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

A bug was introduced during a respin of:

	commit 57a4a11b2b281bb548b419ca81bfafb214e4c77a
	target/arm: Add array for supported PMU events, generate PMCEID[01]_EL0

This patch introduced two calls to get_pmceid() during CPU
initialization - one each for PMCEID0 and PMCEID1. In addition to
building the register values, get_pmceid() clears an internal array
mapping event numbers to their implementations (supported_event_map)
before rebuilding it. This is an optimization since much of the logic is
shared. However, since it was called twice, the contents of
supported_event_map reflect only the events in PMCEID1 (the second call
to get_pmceid()).

Fix this bug by moving the initialization of PMCEID0 and PMCEID1 back
into a single function call, and name it more appropriately since it is
doing more than simply generating the contents of the PMCEID[01]
registers.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/cpu.c    |  3 +--
 target/arm/cpu.h    | 11 +++++------
 target/arm/helper.c | 27 ++++++++++++++++-----------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e1f3dd637..d6da3f4fed 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1039,8 +1039,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error=
 **errp)
         unset_feature(env, ARM_FEATURE_PMU);
     }
     if (arm_feature(env, ARM_FEATURE_PMU)) {
-        cpu->pmceid0 =3D get_pmceid(&cpu->env, 0);
-        cpu->pmceid1 =3D get_pmceid(&cpu->env, 1);
+        pmu_init(cpu);
=20
         if (!kvm_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ff81db420d..b8161cb6d7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1012,14 +1012,13 @@ void pmu_pre_el_change(ARMCPU *cpu, void *ignored);
 void pmu_post_el_change(ARMCPU *cpu, void *ignored);
=20
 /*
- * get_pmceid
- * @env: CPUARMState
- * @which: which PMCEID register to return (0 or 1)
+ * pmu_init
+ * @cpu: ARMCPU
  *
- * Return the PMCEID[01]_EL0 register values corresponding to the counters
- * which are supported given the current configuration
+ * Initialize the CPU's PMCEID[01]_EL0 registers and associated internal s=
tate
+ * for the current configuration
  */
-uint64_t get_pmceid(CPUARMState *env, unsigned which);
+void pmu_init(ARMCPU *cpu);
=20
 /* SCTLR bit meanings. Several bits have been reused in newer
  * versions of the architecture; in that case we define constants
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92666e5208..31273fb8de 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1090,22 +1090,24 @@ static const pm_event pm_events[] =3D {
 static uint16_t supported_event_map[MAX_EVENT_ID + 1];
=20
 /*
- * Called upon initialization to build PMCEID0_EL0 or PMCEID1_EL0 (indicat=
ed by
- * 'which'). We also use it to build a map of ARM event numbers to indices=
 in
- * our pm_events array.
+ * Called upon CPU initialization to initialize PMCEID[01]_EL0 and build a=
 map
+ * of ARM event numbers to indices in our pm_events array.
  *
  * Note: Events in the 0x40XX range are not currently supported.
  */
-uint64_t get_pmceid(CPUARMState *env, unsigned which)
+void pmu_init(ARMCPU *cpu)
 {
-    uint64_t pmceid =3D 0;
     unsigned int i;
=20
-    assert(which <=3D 1);
-
+    /*
+     * Empty supported_event_map and cpu->pmceid[01] before adding support=
ed
+     * events to them
+     */
     for (i =3D 0; i < ARRAY_SIZE(supported_event_map); i++) {
         supported_event_map[i] =3D UNSUPPORTED_EVENT;
     }
+    cpu->pmceid0 =3D 0;
+    cpu->pmceid1 =3D 0;
=20
     for (i =3D 0; i < ARRAY_SIZE(pm_events); i++) {
         const pm_event *cnt =3D &pm_events[i];
@@ -1113,13 +1115,16 @@ uint64_t get_pmceid(CPUARMState *env, unsigned whic=
h)
         /* We do not currently support events in the 0x40xx range */
         assert(cnt->number <=3D 0x3f);
=20
-        if ((cnt->number & 0x20) =3D=3D (which << 6) &&
-                cnt->supported(env)) {
-            pmceid |=3D (1 << (cnt->number & 0x1f));
+        if (cnt->supported(&cpu->env)) {
             supported_event_map[cnt->number] =3D i;
+            uint64_t event_mask =3D 1 << (cnt->number & 0x1f);
+            if (cnt->number & 0x20) {
+                cpu->pmceid1 |=3D event_mask;
+            } else {
+                cpu->pmceid0 |=3D event_mask;
+            }
         }
     }
-    return pmceid;
 }
=20
 /*
--=20
2.20.1
