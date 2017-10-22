Received: from eggs.gnu.org ([2001:4830:134:3::10]:37290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PR-0002CY-5I
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e64PQ-0008GC-6Z
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:33 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:54106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e64PQ-0008FF-0P
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 20:46:32 -0400
Received: by mail-pf0-x242.google.com with SMTP id t188so14596378pfd.10
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 17:46:31 -0700 (PDT)
Received: from cloudburst.twiddle.net (174-21-9-158.tukw.qwest.net.
	[174.21.9.158]) by smtp.gmail.com with ESMTPSA id
	j12sm5766728pgs.35.2017.10.21.17.46.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 21 Oct 2017 17:46:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 21 Oct 2017 17:46:14 -0700
Message-Id: <20171022004621.28372-5-richard.henderson@linaro.org>
In-Reply-To: <20171022004621.28372-1-richard.henderson@linaro.org>
References: <20171022004621.28372-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 04/11] target/arm: Don't set INSN_ARM_BE32
 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
