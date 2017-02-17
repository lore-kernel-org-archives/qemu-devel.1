Received: from eggs.gnu.org ([2001:4830:134:3::10]:44218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cec5s-0001Il-TA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cec5s-0005kF-2H
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:32:36 -0500
From: vijay.kilari@gmail.com
Date: Fri, 17 Feb 2017 12:01:54 +0530
Message-Id: <1487313115-9510-5-git-send-email-vijay.kilari@gmail.com>
In-Reply-To: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
References: <1487313115-9510-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v8 4/5] target-arm: Add GICv3CPUState in
 CPUARMState struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org, eric.auger@redhat.com
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Add gicv3state void pointer to CPUARMState struct
to store GICv3CPUState.

In case of usecase like CPU reset, we need to reset
GICv3CPUState of the CPU. In such scenario, this pointer
becomes handy.

This patch take care of only GICv3.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 hw/intc/arm_gicv3_common.c | 2 ++
 hw/intc/arm_gicv3_cpuif.c  | 8 ++++++++
 hw/intc/gicv3_internal.h   | 2 ++
 target/arm/cpu.h           | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e62480e..79a5bd9 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -248,6 +248,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
 
         s->cpu[i].cpu = cpu;
         s->cpu[i].gic = s;
+        /* Store GICv3CPUState in CPUARMState gicv3state pointer */
+        gicv3_set_gicv3state(cpu, &s->cpu[i]);
 
         /* Pre-construct the GICR_TYPER:
          * For our implementation:
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index c25ee03..7849783 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -18,6 +18,14 @@
 #include "gicv3_internal.h"
 #include "cpu.h"
 
+void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    env->gicv3state = (void *)s;
+};
+
 static GICv3CPUState *icc_cs_from_env(CPUARMState *env)
 {
     /* Given the CPU, find the right GICv3CPUState struct.
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 457118e..05303a5 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -408,4 +408,6 @@ static inline void gicv3_cache_all_target_cpustates(GICv3State *s)
     }
 }
 
+void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s);
+
 #endif /* QEMU_ARM_GICV3_INTERNAL_H */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0956a54..d2eb7bf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -517,6 +517,8 @@ typedef struct CPUARMState {
 
     void *nvic;
     const struct arm_boot_info *boot_info;
+    /* Store GICv3CPUState to access from this struct */
+    void *gicv3state;
 } CPUARMState;
 
 /**
-- 
1.9.1
