Received: from eggs.gnu.org ([2001:4830:134:3::10]:43345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4q-0007E1-AR
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQg4n-0000zJ-44
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQg4m-0000xL-Qn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:30:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 29 Jun 2017 16:28:24 -0400
Message-Id: <1498768109-4092-3-git-send-email-cota@braap.org>
In-Reply-To: <1498768109-4092-1-git-send-email-cota@braap.org>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 2/7] translate-all: add out_size field to
 TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This paves the way for upcoming work: we need tb->out_size for
tb_find_pc to work with a binary search tree.

Note that due to the cacheline padding we are using, for
hosts with 64-byte cache lines this will not waste any
additional memory. Using a s16 would be ideal, since that
would plug an existing hole in the struct, but I see no
guarantee that a TB won't overflow it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   |  1 +
 accel/tcg/translate-all.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 35a75f1..df12338 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -363,6 +363,7 @@ struct TranslationBlock {
      */
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_list_first;
+    int32_t out_size; /* size of host code for this block */
 };
 
 void tb_free(TranslationBlock *tb);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b..da91482 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1260,7 +1260,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_page_addr_t phys_pc, phys_page2;
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
-    int gen_code_size, search_size;
+    int search_size;
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
@@ -1327,11 +1327,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
        the tcg optimization currently hidden inside tcg_gen_code.  All
        that should be required is to flush the TBs, allocate a new TB,
        re-initialize it per above, and re-do the actual code generation.  */
-    gen_code_size = tcg_gen_code(&tcg_ctx, tb);
-    if (unlikely(gen_code_size < 0)) {
+    tb->out_size = tcg_gen_code(&tcg_ctx, tb);
+    if (unlikely(tb->out_size < 0)) {
         goto buffer_overflow;
     }
-    search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
+    search_size = encode_search(tb, (void *)gen_code_buf + tb->out_size);
     if (unlikely(search_size < 0)) {
         goto buffer_overflow;
     }
@@ -1339,7 +1339,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #ifdef CONFIG_PROFILER
     tcg_ctx.code_time += profile_getclock();
     tcg_ctx.code_in_len += tb->size;
-    tcg_ctx.code_out_len += gen_code_size;
+    tcg_ctx.code_out_len += tb->out_size;
     tcg_ctx.search_out_len += search_size;
 #endif
 
@@ -1347,8 +1347,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
         qemu_log_lock();
-        qemu_log("OUT: [size=%d]\n", gen_code_size);
-        log_disas(tb->tc_ptr, gen_code_size);
+        qemu_log("OUT: [size=%d]\n", tb->out_size);
+        log_disas(tb->tc_ptr, tb->out_size);
         qemu_log("\n");
         qemu_log_flush();
         qemu_log_unlock();
@@ -1356,7 +1356,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 #endif
 
     tcg_ctx.code_gen_ptr = (void *)
-        ROUND_UP((uintptr_t)gen_code_buf + gen_code_size + search_size,
+        ROUND_UP((uintptr_t)gen_code_buf + tb->out_size + search_size,
                  CODE_GEN_ALIGN);
 
     /* init jump list */
-- 
2.7.4
