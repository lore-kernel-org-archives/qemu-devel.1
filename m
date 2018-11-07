Received: from eggs.gnu.org ([2001:4830:134:3::10]:45058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gKSsm-0000Dh-J3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bijan.mottahedeh@oracle.com>) id 1gKSsi-0000A7-8h
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bijan.mottahedeh@oracle.com>)
	id 1gKSsh-00008O-UF
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:48:48 -0500
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Date: Wed,  7 Nov 2018 10:48:23 -0800
Message-Id: <1541616504-68526-2-git-send-email-bijan.mottahedeh@oracle.com>
In-Reply-To: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
References: <1541616504-68526-1-git-send-email-bijan.mottahedeh@oracle.com>
Subject: [Qemu-devel] [RFC QEMU 1/2] arm/virt: Initialize generic timer
 scale factor dynamically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvmarm@lists.cs.columbia.edu

Initialize the generic timer scale factor based on the counter frequency
register cntfrq_el0, and default to the current static value if necessary.

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 hw/arm/virt.c          | 15 +++++++++++++++
 target/arm/helper.c    | 19 ++++++++++++++++---
 target/arm/internals.h |  8 ++++++--
 target/arm/kvm64.c     |  1 +
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcd..200a601 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -59,6 +59,7 @@
 #include "qapi/visitor.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "target/arm/internals.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1710,6 +1711,19 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void set_system_clock_scale(void)
+{
+    unsigned long cntfrq_el0;
+
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(cntfrq_el0));
+
+    if (cntfrq_el0 == 0) {
+        cntfrq_el0 = GTIMER_SCALE_DEF;
+    }
+
+    system_clock_scale = NANOSECONDS_PER_SECOND / (int)cntfrq_el0;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1736,6 +1750,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
+    set_system_clock_scale();
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66afb08..6330586 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -18,6 +18,7 @@
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
+#include "hw/arm/arm.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -1614,6 +1615,18 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static void gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    assert(GTIMER_SCALE);
+    assert(ri->fieldoffset);
+
+    if (cpreg_field_is_64bit(ri)) {
+        CPREG_FIELD64(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
+    } else {
+        CPREG_FIELD32(env, ri) = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
+    }
+}
+
 static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
                                         bool isread)
 {
@@ -1709,7 +1722,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     }
 }
 
-static uint64_t gt_get_countervalue(CPUARMState *env)
+uint64_t gt_get_countervalue(CPUARMState *env)
 {
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
 }
@@ -1996,7 +2009,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
-      .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
+      .resetfn = gt_cntfrq_reset,
     },
     /* overall control: mostly access permissions */
     { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
@@ -2187,7 +2200,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .type = ARM_CP_CONST, .access = PL0_R /* no PL1_RW in linux-user */,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
-      .resetvalue = NANOSECONDS_PER_SECOND / GTIMER_SCALE,
+      .resetfn = gt_cntfrq_reset,
     },
     { .name = "CNTVCT_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 2,
diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc93577..b66a1fa 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -52,9 +52,13 @@ static inline bool excp_is_internal(int excp)
 }
 
 /* Scale factor for generic timers, ie number of ns per tick.
- * This gives a 62.5MHz timer.
+ * Calculated dynamically based on CNTFRQ with a default value
+ * that gives a 62.5MHZ timer.
  */
-#define GTIMER_SCALE 16
+#define GTIMER_SCALE        system_clock_scale
+#define GTIMER_SCALE_DEF    16
+
+uint64_t gt_get_countervalue(CPUARMState *);
 
 /* Bit definitions for the v7M CONTROL register */
 FIELD(V7M_CONTROL, NPRIV, 0, 1)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index e0b8246..5d1c394 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -485,6 +485,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
+    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     ahcf->features = features;
 
-- 
1.8.3.1
