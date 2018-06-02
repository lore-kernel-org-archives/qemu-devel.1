Received: from eggs.gnu.org ([2001:4830:134:3::10]:42866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J6-0001H5-65
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J5-0007Du-Ap
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  2 Jun 2018 15:14:45 +0100
Message-Id: <20180602141446.29982-2-stefanha@redhat.com>
In-Reply-To: <20180602141446.29982-1-stefanha@redhat.com>
References: <20180602141446.29982-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 1/2] target/arm: add "cortex-m0" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, mail@steffen-goertz.de, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, joel@jms.id.au, Stefan Hajnoczi <stefanha@redhat.com>

Define a "cortex-m0" ARMv6-M CPU model.

Most of the register reset values set by other CPU models are not
relevant for the cut-down ARMv6-M architecture.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 target/arm/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d60893a07..aac224d809 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1215,6 +1215,16 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->reset_auxcr = 1;
 }
 
+static void cortex_m0_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+
+    /* TODO ARMv6-M doesn't support coprocessors, so how is this value accessed? */
+    cpu->midr = 0x410cc200;
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1796,6 +1806,8 @@ static const ARMCPUInfo arm_cpus[] = {
     { .name = "arm1136",     .initfn = arm1136_initfn },
     { .name = "arm1176",     .initfn = arm1176_initfn },
     { .name = "arm11mpcore", .initfn = arm11mpcore_initfn },
+    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
+                             .class_init = arm_v7m_class_init /* TODO rename? */ },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-- 
2.17.0
