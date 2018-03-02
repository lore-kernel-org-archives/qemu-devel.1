Received: from eggs.gnu.org ([2001:4830:134:3::10]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWa-0002sB-5N
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWZ-0004sc-40
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:52 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWY-0004qW-Sv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:51 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWX-0001LJ-Oi
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:49 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:13 +0000
Message-Id: <20180302110640.28004-13-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/39] target/arm: Add Cortex-M33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a Cortex-M33 definition. The M33 is an M profile CPU
which implements the ARM v8M architecture, including the
M profile Security Extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-9-peter.maydell@linaro.org
---
 target/arm/cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 27d9e90308..e08b1e7943 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1206,6 +1206,35 @@ static void cortex_m4_initfn(Object *obj)
     cpu->id_isar5 = 0x00000000;
 }
 
+static void cortex_m33_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x410fd213; /* r0p3 */
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    cpu->id_pfr0 = 0x00000030;
+    cpu->id_pfr1 = 0x00000210;
+    cpu->id_dfr0 = 0x00200000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->id_mmfr0 = 0x00101F40;
+    cpu->id_mmfr1 = 0x00000000;
+    cpu->id_mmfr2 = 0x01000000;
+    cpu->id_mmfr3 = 0x00000000;
+    cpu->id_isar0 = 0x01101110;
+    cpu->id_isar1 = 0x02212000;
+    cpu->id_isar2 = 0x20232232;
+    cpu->id_isar3 = 0x01111131;
+    cpu->id_isar4 = 0x01310132;
+    cpu->id_isar5 = 0x00000000;
+    cpu->clidr = 0x00000000;
+    cpu->ctr = 0x8000c000;
+}
+
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
@@ -1697,6 +1726,8 @@ static const ARMCPUInfo arm_cpus[] = {
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
+                             .class_init = arm_v7m_class_init },
     { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
     { .name = "cortex-a7",   .initfn = cortex_a7_initfn },
     { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
-- 
2.16.2
