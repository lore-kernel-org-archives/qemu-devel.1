Received: from eggs.gnu.org ([2001:4830:134:3::10]:60552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqQ-0002Oj-C7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqO-0004Wv-2C
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:25 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:57221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqN-0004Wd-Po
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:23 -0400
Received: by mail-pf0-x22f.google.com with SMTP id b85so4312949pfj.13
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:52 -0700
Message-Id: <20171010005600.28735-16-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/23] exec-all: extract tb->tc_* into a
 separate struct tc_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

In preparation for adding tc.size to be able to keep track of
TB's using the binary search tree implementation from glib.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 12 ++++++++++--
 accel/tcg/cpu-exec.c      | 14 +++++++-------
 accel/tcg/tcg-runtime.c   |  4 ++--
 accel/tcg/translate-all.c | 24 ++++++++++++------------
 tcg/tcg.c                 |  4 ++--
 5 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 79f8041811..53f1835c43 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -303,6 +303,14 @@ static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
 #define CODE_GEN_AVG_BLOCK_SIZE 150
 #endif
 
+/*
+ * Translation Cache-related fields of a TB.
+ */
+struct tb_tc {
+    void *ptr;    /* pointer to the translated code */
+    uint8_t *search;  /* pointer to search data */
+};
+
 struct TranslationBlock {
     target_ulong pc;   /* simulated PC corresponding to this block (EIP + CS base) */
     target_ulong cs_base; /* CS base for this block */
@@ -321,8 +329,8 @@ struct TranslationBlock {
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
 
-    void *tc_ptr;    /* pointer to the translated code */
-    uint8_t *tc_search;  /* pointer to search data */
+    struct tb_tc tc;
+
     /* original tb when cflags has CF_NOCACHE */
     struct TranslationBlock *orig_tb;
     /* first and second physical page containing code. The lower bit
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9cd809d607..363dfa208a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -143,11 +143,11 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
     uintptr_t ret;
     TranslationBlock *last_tb;
     int tb_exit;
-    uint8_t *tb_ptr = itb->tc_ptr;
+    uint8_t *tb_ptr = itb->tc.ptr;
 
     qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
                            "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
-                           itb->tc_ptr, cpu->cpu_index, itb->pc,
+                           itb->tc.ptr, cpu->cpu_index, itb->pc,
                            lookup_symbol(itb->pc));
 
 #if defined(DEBUG_DISAS)
@@ -179,7 +179,7 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
         qemu_log_mask_and_addr(CPU_LOG_EXEC, last_tb->pc,
                                "Stopped execution of TB chain before %p ["
                                TARGET_FMT_lx "] %s\n",
-                               last_tb->tc_ptr, last_tb->pc,
+                               last_tb->tc.ptr, last_tb->pc,
                                lookup_symbol(last_tb->pc));
         if (cc->synchronize_from_tb) {
             cc->synchronize_from_tb(cpu, last_tb);
@@ -334,7 +334,7 @@ void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
 {
     if (TCG_TARGET_HAS_direct_jump) {
         uintptr_t offset = tb->jmp_target_arg[n];
-        uintptr_t tc_ptr = (uintptr_t)tb->tc_ptr;
+        uintptr_t tc_ptr = (uintptr_t)tb->tc.ptr;
         tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr);
     } else {
         tb->jmp_target_arg[n] = addr;
@@ -354,11 +354,11 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
     qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
                            "Linking TBs %p [" TARGET_FMT_lx
                            "] index %d -> %p [" TARGET_FMT_lx "]\n",
-                           tb->tc_ptr, tb->pc, n,
-                           tb_next->tc_ptr, tb_next->pc);
+                           tb->tc.ptr, tb->pc, n,
+                           tb_next->tc.ptr, tb_next->pc);
 
     /* patch the native jump address */
-    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc_ptr);
+    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc.ptr);
 
     /* add in TB jmp circular list */
     tb->jmp_list_next[n] = tb_next->jmp_list_first;
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index d0edd944b0..54d89100d9 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -157,9 +157,9 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     }
     qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
-                           tb->tc_ptr, cpu->cpu_index, pc,
+                           tb->tc.ptr, cpu->cpu_index, pc,
                            lookup_symbol(pc));
-    return tb->tc_ptr;
+    return tb->tc.ptr;
 }
 
 void HELPER(exit_atomic)(CPUArchState *env)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 26efad302d..c5ce99d549 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -260,7 +260,7 @@ static target_long decode_sleb128(uint8_t **pp)
    which comes from the host pc of the end of the code implementing the insn.
 
    Each line of the table is encoded as sleb128 deltas from the previous
-   line.  The seed for the first line is { tb->pc, 0..., tb->tc_ptr }.
+   line.  The seed for the first line is { tb->pc, 0..., tb->tc.ptr }.
    That is, the first column is seeded with the guest pc, the last column
    with the host pc, and the middle columns with zeros.  */
 
@@ -270,7 +270,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     uint8_t *p = block;
     int i, j, n;
 
-    tb->tc_search = block;
+    tb->tc.search = block;
 
     for (i = 0, n = tb->icount; i < n; ++i) {
         target_ulong prev;
@@ -305,9 +305,9 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                      uintptr_t searched_pc)
 {
     target_ulong data[TARGET_INSN_START_WORDS] = { tb->pc };
-    uintptr_t host_pc = (uintptr_t)tb->tc_ptr;
+    uintptr_t host_pc = (uintptr_t)tb->tc.ptr;
     CPUArchState *env = cpu->env_ptr;
-    uint8_t *p = tb->tc_search;
+    uint8_t *p = tb->tc.search;
     int i, j, num_insns = tb->icount;
 #ifdef CONFIG_PROFILER
     int64_t ti = profile_getclock();
@@ -858,7 +858,7 @@ void tb_free(TranslationBlock *tb)
             tb == tcg_ctx.tb_ctx.tbs[tcg_ctx.tb_ctx.nb_tbs - 1]) {
         size_t struct_size = ROUND_UP(sizeof(*tb), qemu_icache_linesize);
 
-        tcg_ctx.code_gen_ptr = tb->tc_ptr - struct_size;
+        tcg_ctx.code_gen_ptr = tb->tc.ptr - struct_size;
         tcg_ctx.tb_ctx.nb_tbs--;
     }
 }
@@ -1059,7 +1059,7 @@ static inline void tb_remove_from_jmp_list(TranslationBlock *tb, int n)
    another TB */
 static inline void tb_reset_jump(TranslationBlock *tb, int n)
 {
-    uintptr_t addr = (uintptr_t)(tb->tc_ptr + tb->jmp_reset_offset[n]);
+    uintptr_t addr = (uintptr_t)(tb->tc.ptr + tb->jmp_reset_offset[n]);
     tb_set_jmp_target(tb, n, addr);
 }
 
@@ -1288,7 +1288,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
     gen_code_buf = tcg_ctx.code_gen_ptr;
-    tb->tc_ptr = gen_code_buf;
+    tb->tc.ptr = gen_code_buf;
     tb->pc = pc;
     tb->cs_base = cs_base;
     tb->flags = flags;
@@ -1307,7 +1307,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     gen_intermediate_code(cpu, tb);
     tcg_ctx.cpu = NULL;
 
-    trace_translate_block(tb, tb->pc, tb->tc_ptr);
+    trace_translate_block(tb, tb->pc, tb->tc.ptr);
 
     /* generate machine code */
     tb->jmp_reset_offset[0] = TB_JMP_RESET_OFFSET_INVALID;
@@ -1354,11 +1354,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         qemu_log_lock();
         qemu_log("OUT: [size=%d]\n", gen_code_size);
         if (tcg_ctx.data_gen_ptr) {
-            size_t code_size = tcg_ctx.data_gen_ptr - tb->tc_ptr;
+            size_t code_size = tcg_ctx.data_gen_ptr - tb->tc.ptr;
             size_t data_size = gen_code_size - code_size;
             size_t i;
 
-            log_disas(tb->tc_ptr, code_size);
+            log_disas(tb->tc.ptr, code_size);
 
             for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
                 if (sizeof(tcg_target_ulong) == 8) {
@@ -1372,7 +1372,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 }
             }
         } else {
-            log_disas(tb->tc_ptr, gen_code_size);
+            log_disas(tb->tc.ptr, gen_code_size);
         }
         qemu_log("\n");
         qemu_log_flush();
@@ -1699,7 +1699,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr)
     while (m_min <= m_max) {
         m = (m_min + m_max) >> 1;
         tb = tcg_ctx.tb_ctx.tbs[m];
-        v = (uintptr_t)tb->tc_ptr;
+        v = (uintptr_t)tb->tc.ptr;
         if (v == tc_ptr) {
             return tb;
         } else if (tc_ptr < v) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dff9999bc6..a874bdd41f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2836,8 +2836,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
 
     tcg_reg_alloc_start(s);
 
-    s->code_buf = tb->tc_ptr;
-    s->code_ptr = tb->tc_ptr;
+    s->code_buf = tb->tc.ptr;
+    s->code_ptr = tb->tc.ptr;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     s->ldst_labels = NULL;
-- 
2.13.6
