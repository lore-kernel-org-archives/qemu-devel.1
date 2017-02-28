Received: from eggs.gnu.org ([2001:4830:134:3::10]:43347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilO0-0001jo-Tq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNz-00036v-SW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:28 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilNz-00036d-Ll
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:27 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNy-0003V9-Sk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:16:11 +0000
Message-Id: <1488302176-19463-17-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/21] target-arm: Add GICv3CPUState in
 CPUARMState struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Add gicv3state void pointer to CPUARMState struct
to store GICv3CPUState.

In case of usecase like CPU reset, we need to reset
GICv3CPUState of the CPU. In such scenario, this pointer
becomes handy.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1487850673-26455-5-git-send-email-vijay.kilari@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gicv3_internal.h   | 2 ++
 target/arm/cpu.h           | 2 ++
 hw/intc/arm_gicv3_common.c | 2 ++
 hw/intc/arm_gicv3_cpuif.c  | 8 ++++++++
 4 files changed, 14 insertions(+)

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
index 9e7b2df..25ceaab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -521,6 +521,8 @@ typedef struct CPUARMState {
 
     void *nvic;
     const struct arm_boot_info *boot_info;
+    /* Store GICv3CPUState to access from this struct */
+    void *gicv3state;
 } CPUARMState;
 
 /**
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 5b0e456..c6493d6 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -252,6 +252,8 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
 
         s->cpu[i].cpu = cpu;
         s->cpu[i].gic = s;
+        /* Store GICv3CPUState in CPUARMState gicv3state pointer */
+        gicv3_set_gicv3state(cpu, &s->cpu[i]);
 
         /* Pre-construct the GICR_TYPER:
          * For our implementation:
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index f775aba..0b20856 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -19,6 +19,14 @@
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
-- 
2.7.4
