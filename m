Received: from eggs.gnu.org ([2001:4830:134:3::10]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5IFh-0007gs-HP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5IFg-0008B9-G5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:17 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:52671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5IFg-0008AB-8E
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:16 -0400
Received: by mail-pf0-x243.google.com with SMTP id e64so7813874pfk.9
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:21:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 14:21:09 -0700
Message-Id: <20171019212109.11341-3-richard.henderson@linaro.org>
In-Reply-To: <20171019212109.11341-1-richard.henderson@linaro.org>
References: <20171019212109.11341-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Don't set INSN_ARM_BE32 for
 CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This matches translator behaviour in arm_lduw_code.

Fixes: https://bugs.launchpad.net/qemu/+bug/1724485
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bc9d70df04..a0ed11c9a5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -478,6 +478,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
     CPUARMState *env = &ac->env;
+    bool sctlr_b;
 
     if (is_a64(env)) {
         /* We might not be compiled with the A64 disassembler
@@ -506,7 +507,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->cap_arch = CS_ARCH_ARM;
         info->cap_mode = cap_mode;
     }
-    if (bswap_code(arm_sctlr_b(env))) {
+
+    sctlr_b = arm_sctlr_b(env);
+    if (bswap_code(sctlr_b)) {
 #ifdef TARGET_WORDS_BIGENDIAN
         info->endian = BFD_ENDIAN_LITTLE;
 #else
@@ -514,9 +517,11 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
     }
     info->flags &= ~INSN_ARM_BE32;
-    if (arm_sctlr_b(env)) {
+#ifndef CONFIG_USER_ONLY
+    if (sctlr_b) {
         info->flags |= INSN_ARM_BE32;
     }
+#endif
 }
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
-- 
2.13.6
