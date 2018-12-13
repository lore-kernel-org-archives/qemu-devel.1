Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXPaB-0007dV-TW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXPa8-00008H-6B
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:11 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXPa7-00007N-6q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:55:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id g67so2091756wmd.2
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:55:07 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 13 Dec 2018 11:55:03 +0000
Message-Id: <20181213115503.24188-3-alex.bennee@linaro.org>
In-Reply-To: <20181213115503.24188-1-alex.bennee@linaro.org>
References: <20181213115503.24188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/2] target/arm: defer setting up of aarch64
 gdb until arm_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Omair Javaid <omair.javaid@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

If we setup earlier we miss the parsing of the aarch64 state of the
CPU. If the user has booted up with:

  qemu-system-aarch64 -cpu host,aarch64=off -enable-kvm

we end up presenting an aarch64 view of the world via the gdbstub and
hilarity ensues.

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Omair Javaid <omair.javaid@linaro.org>
---
 include/hw/arm/arm.h |  2 ++
 target/arm/cpu.c     |  4 ++++
 target/arm/cpu64.c   | 20 +++++++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ffed39252d..f9a7a6e2fb 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -171,4 +171,6 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
    ticks.  */
 extern int system_clock_scale;
 
+void arm_cpu_enable_aarch64_gdbstub(CPUClass *cc);
+
 #endif /* HW_ARM_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..100a72ff81 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -890,9 +890,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
      * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
      */
+#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        CPUClass *cc = CPU_GET_CLASS(cs);
         no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
+        arm_cpu_enable_aarch64_gdbstub(cc);
     }
+#endif
 
     if (arm_feature(env, ARM_FEATURE_V7VE)) {
         /* v7 Virtualization Extensions. In real hardware this implies
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 873f059bf2..53cde60557 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -434,12 +434,14 @@ static gchar *aarch64_gdb_arch_name(CPUState *cs)
     return g_strdup("aarch64");
 }
 
-static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
-{
-    CPUClass *cc = CPU_CLASS(oc);
+/*
+ * We can only setup aarch64 gdb support once we realize the CPU
+ * object and know what mode it has been booted in. This is called
+ * from arm_cpu_realize.
+ */
 
-    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
-    cc->set_pc = aarch64_cpu_set_pc;
+void arm_cpu_enable_aarch64_gdbstub(CPUClass *cc)
+{
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 34;
@@ -447,6 +449,14 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = aarch64_gdb_arch_name;
 }
 
+static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
+{
+    CPUClass *cc = CPU_CLASS(oc);
+
+    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
+    cc->set_pc = aarch64_cpu_set_pc;
+}
+
 static void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info = {
-- 
2.17.1
