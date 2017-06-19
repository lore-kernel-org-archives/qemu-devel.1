Received: from eggs.gnu.org ([2001:4830:134:3::10]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GD-0008MH-OR
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GC-0002E8-QI
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:49 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GC-0002DC-Kg
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:48 -0400
Received: by mail-pf0-x241.google.com with SMTP id d5so18589017pfe.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:32 -0700
Message-Id: <20170619181839.25249-6-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 05/12] tcg/arm: Use indirect branch for goto_tb
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/exec-all.h  |  5 +----
 tcg/arm/tcg-target.inc.c | 17 ++---------------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 87ae10b..724ec73 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -301,7 +301,7 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
-#if defined(__arm__) || defined(_ARCH_PPC) \
+#if defined(_ARCH_PPC) \
     || defined(__x86_64__) || defined(__i386__) \
     || defined(__sparc__) || defined(__aarch64__) \
     || defined(__s390x__) || defined(__mips__) \
@@ -401,9 +401,6 @@ static inline void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
 #elif defined(__aarch64__)
 void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr);
 #define tb_set_jmp_target1 aarch64_tb_set_jmp_target
-#elif defined(__arm__)
-void arm_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr);
-#define tb_set_jmp_target1 arm_tb_set_jmp_target
 #elif defined(__sparc__) || defined(__mips__)
 void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr);
 #else
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 9f5cb66..fce382f 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1026,16 +1026,6 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
     }
 }
 
-void arm_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
-{
-    tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
-    tcg_insn_unit *target = (tcg_insn_unit *)addr;
-
-    /* we could use a ldr pc, [pc, #-4] kind of branch and avoid the flush */
-    reloc_pc24_atomic(code_ptr, target);
-    flush_icache_range(jmp_addr, jmp_addr + 4);
-}
-
 static inline void tcg_out_goto_label(TCGContext *s, int cond, TCGLabel *l)
 {
     if (l->has_value) {
@@ -1665,11 +1655,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_goto_tb:
-        if (s->tb_jmp_insn_offset) {
-            /* Direct jump method */
-            s->tb_jmp_insn_offset[args[0]] = tcg_current_code_size(s);
-            tcg_out_b_noaddr(s, COND_AL);
-        } else {
+        tcg_debug_assert(s->tb_jmp_insn_offset == 0);
+        {
             /* Indirect jump method */
             intptr_t ptr = (intptr_t)(s->tb_jmp_target_addr + args[0]);
             tcg_out_movi32(s, COND_AL, TCG_REG_R0, ptr & ~0xfff);
-- 
2.9.4
