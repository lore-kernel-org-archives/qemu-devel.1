Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kpz-0007Vm-9M
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kpy-00081K-5e
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:11 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kpx-00080x-VK
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:10 -0400
Received: by mail-wr0-x243.google.com with SMTP id w105so14534876wrc.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:49 +0200
Message-Id: <20171025123056.3165-5-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/11] target/arm: Don't set INSN_ARM_BE32 for
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
index 82dad0b721..a92d86faa0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -477,6 +477,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
     CPUARMState *env = &ac->env;
+    bool sctlr_b;
 
     if (is_a64(env)) {
         /* We might not be compiled with the A64 disassembler
@@ -491,7 +492,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
     } else {
         info->print_insn = print_insn_arm;
     }
-    if (bswap_code(arm_sctlr_b(env))) {
+
+    sctlr_b = arm_sctlr_b(env);
+    if (bswap_code(sctlr_b)) {
 #ifdef TARGET_WORDS_BIGENDIAN
         info->endian = BFD_ENDIAN_LITTLE;
 #else
@@ -499,9 +502,11 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
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
