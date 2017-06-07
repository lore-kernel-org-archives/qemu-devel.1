Received: from eggs.gnu.org ([2001:4830:134:3::10]:34786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoI-0002gX-7f
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoG-0000hz-PZ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:18 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dIjoG-0000hu-Ks
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:16 -0400
Received: by mail-yw0-x244.google.com with SMTP id h82so1308775ywb.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 15:52:16 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed,  7 Jun 2017 18:52:12 -0400
Message-Id: <20170607225212.23714-4-bobby.prani@gmail.com>
In-Reply-To: <20170607225212.23714-1-bobby.prani@gmail.com>
References: <20170607225212.23714-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 3/3] tcg/aarch64: Remove code buffer size
 limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

This enables indirect jump on aarch64 hosts. Tested by booting an x86 guest on aarch64 host.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/exec/exec-all.h      |  6 +-----
 tcg/aarch64/tcg-target.inc.c | 25 ++++++-------------------
 translate-all.c              |  2 --
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 724ec73dce..a6bd3c7d1e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -301,9 +301,8 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
-#if defined(_ARCH_PPC) \
+#if defined(_ARCH_PPC) || defined(__sparc__)    \
     || defined(__x86_64__) || defined(__i386__) \
-    || defined(__sparc__) || defined(__aarch64__) \
     || defined(__s390x__) || defined(__mips__) \
     || defined(CONFIG_TCG_INTERPRETER)
 /* NOTE: Direct jump patching must be atomic to be thread-safe. */
@@ -398,9 +397,6 @@ static inline void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr)
     atomic_set((int32_t *)jmp_addr, disp / 2);
     /* no need to flush icache explicitly */
 }
-#elif defined(__aarch64__)
-void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr);
-#define tb_set_jmp_target1 aarch64_tb_set_jmp_target
 #elif defined(__sparc__) || defined(__mips__)
 void tb_set_jmp_target1(uintptr_t jmp_addr, uintptr_t addr);
 #else
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e488aacadb..cc81a0d5ff 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -865,15 +865,6 @@ static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
     }
 }
 
-void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
-{
-    tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
-    tcg_insn_unit *target = (tcg_insn_unit *)addr;
-
-    reloc_pc26_atomic(code_ptr, target);
-    flush_icache_range(jmp_addr, jmp_addr + 4);
-}
-
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 {
     if (!l->has_value) {
@@ -1385,16 +1376,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_goto_tb:
-#ifndef USE_DIRECT_JUMP
-#error "USE_DIRECT_JUMP required for aarch64"
-#endif
-        /* consistency for USE_DIRECT_JUMP */
-        tcg_debug_assert(s->tb_jmp_insn_offset != NULL);
-        s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
-        /* actual branch destination will be patched by
-           aarch64_tb_set_jmp_target later, beware retranslation. */
-        tcg_out_goto_noaddr(s);
-        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
+        {
+            intptr_t offset = tcg_pcrel_diff(s, (s->tb_jmp_target_addr + a0)) >> 2;
+            tcg_out_insn(s, 3305, LDR, offset, TCG_REG_TMP);
+            tcg_out_callr(s, TCG_REG_TMP);
+            s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
+        }
         break;
 
     case INDEX_op_goto_ptr:
diff --git a/translate-all.c b/translate-all.c
index 966747ad60..e4cd849931 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -521,8 +521,6 @@ static inline PageDesc *page_find(tb_page_addr_t index)
 # define MAX_CODE_GEN_BUFFER_SIZE  (2ul * 1024 * 1024 * 1024)
 #elif defined(__powerpc__)
 # define MAX_CODE_GEN_BUFFER_SIZE  (32u * 1024 * 1024)
-#elif defined(__aarch64__)
-# define MAX_CODE_GEN_BUFFER_SIZE  (128ul * 1024 * 1024)
 #elif defined(__s390x__)
   /* We have a +- 4GB range on the branches; leave some slop.  */
 # define MAX_CODE_GEN_BUFFER_SIZE  (3ul * 1024 * 1024 * 1024)
-- 
2.13.0
