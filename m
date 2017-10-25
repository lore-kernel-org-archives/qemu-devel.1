Received: from eggs.gnu.org ([2001:4830:134:3::10]:45672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6c-0008NJ-C0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6a-0008JF-AY
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:10 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:46388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6Z-0008Hx-W0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:08 -0400
Received: by mail-wm0-x241.google.com with SMTP id m72so632386wmc.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:06 +0200
Message-Id: <20171025093535.10175-23-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/51] tcg: define CF_PARALLEL and use it for TB
 hashing along with CF_COUNT_MASK
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

This will enable us to decouple code translation from the value
of parallel_cpus at any given time. It will also help us minimize
TB flushes when generating code via EXCP_ATOMIC.

Note that the declaration of parallel_cpus is brought to exec-all.h
to be able to define there the "curr_cflags" inline.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 20 +++++++++++++++++++-
 include/exec/tb-hash-xx.h |  9 ++++++---
 include/exec/tb-hash.h    |  4 ++--
 include/exec/tb-lookup.h  |  6 +++---
 tcg/tcg.h                 |  1 -
 accel/tcg/cpu-exec.c      | 45 +++++++++++++++++++++++----------------------
 accel/tcg/tcg-runtime.c   |  2 +-
 accel/tcg/translate-all.c | 13 +++++++++----
 exec.c                    |  2 +-
 tests/qht-bench.c         |  2 +-
 10 files changed, 65 insertions(+), 39 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 53f1835c43..352abc7450 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -325,6 +325,9 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 #define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
+#define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
+/* cflags' mask for hashing/comparison */
+#define CF_HASH_MASK (CF_PARALLEL)
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
@@ -365,11 +368,26 @@ struct TranslationBlock {
     uintptr_t jmp_list_first;
 };
 
+extern bool parallel_cpus;
+
+/* Hide the atomic_read to make code a little easier on the eyes */
+static inline uint32_t tb_cflags(const TranslationBlock *tb)
+{
+    return atomic_read(&tb->cflags);
+}
+
+/* current cflags for hashing/comparison */
+static inline uint32_t curr_cflags(void)
+{
+    return parallel_cpus ? CF_PARALLEL : 0;
+}
+
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                   target_ulong cs_base, uint32_t flags);
+                                   target_ulong cs_base, uint32_t flags,
+                                   uint32_t cf_mask);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 6cd3022c07..747a9a612c 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -48,8 +48,8 @@
  * xxhash32, customized for input variables that are not guaranteed to be
  * contiguous in memory.
  */
-static inline
-uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f)
+static inline uint32_t
+tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g)
 {
     uint32_t v1 = TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 = TB_HASH_XX_SEED + PRIME32_2;
@@ -78,7 +78,7 @@ uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f)
     v4 *= PRIME32_1;
 
     h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 += 24;
+    h32 += 28;
 
     h32 += e * PRIME32_3;
     h32  = rol32(h32, 17) * PRIME32_4;
@@ -86,6 +86,9 @@ uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f)
     h32 += f * PRIME32_3;
     h32  = rol32(h32, 17) * PRIME32_4;
 
+    h32 += g * PRIME32_3;
+    h32  = rol32(h32, 17) * PRIME32_4;
+
     h32 ^= h32 >> 15;
     h32 *= PRIME32_2;
     h32 ^= h32 >> 13;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 17b5ee0edf..0526c4f678 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -59,9 +59,9 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
-                      uint32_t trace_vcpu_dstate)
+                      uint32_t cf_mask, uint32_t trace_vcpu_dstate)
 {
-    return tb_hash_func6(phys_pc, pc, flags, trace_vcpu_dstate);
+    return tb_hash_func7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
 }
 
 #endif
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 436b6d5ecf..296138591a 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -21,7 +21,7 @@
 /* Might cause an exception, so have a longjmp destination ready */
 static inline TranslationBlock *
 tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
-                     uint32_t *flags)
+                     uint32_t *flags, uint32_t cf_mask)
 {
     CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
@@ -35,10 +35,10 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate &&
-               !(atomic_read(&tb->cflags) & CF_INVALID))) {
+               (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == cf_mask)) {
         return tb;
     }
-    tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags);
+    tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags, cf_mask);
     if (tb == NULL) {
         return NULL;
     }
diff --git a/tcg/tcg.h b/tcg/tcg.h
index c85786fb47..92d7468cec 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -690,7 +690,6 @@ struct TCGContext {
 };
 
 extern TCGContext tcg_ctx;
-extern bool parallel_cpus;
 
 static inline size_t temp_idx(TCGTemp *ts)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 363dfa208a..39ec9508d1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -207,7 +207,8 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
     tb_lock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base, orig_tb->flags,
                      max_cycles | CF_NOCACHE
-                         | (ignore_icount ? CF_IGNORE_ICOUNT : 0));
+                         | (ignore_icount ? CF_IGNORE_ICOUNT : 0)
+                         | curr_cflags());
     tb->orig_tb = orig_tb;
     tb_unlock();
 
@@ -225,31 +226,27 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 static void cpu_exec_step(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
+    uint32_t cflags = 1 | CF_IGNORE_ICOUNT;
 
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-        mmap_lock();
-        tb_lock();
-        tb = tb_gen_code(cpu, pc, cs_base, flags,
-                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
-        tb->orig_tb = NULL;
-        tb_unlock();
-        mmap_unlock();
+        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags,
+                                  cflags & CF_HASH_MASK);
+        if (tb == NULL) {
+            mmap_lock();
+            tb_lock();
+            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+            tb_unlock();
+            mmap_unlock();
+        }
 
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
-        trace_exec_tb_nocache(tb, pc);
+        trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);
-
-        tb_lock();
-        tb_phys_invalidate(tb, -1);
-        tb_free(tb);
-        tb_unlock();
     } else {
         /* We may have exited due to another problem here, so we need
          * to reset any tb_locks we may have taken but didn't release.
@@ -281,6 +278,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    uint32_t cf_mask;
     uint32_t trace_vcpu_dstate;
 };
 
@@ -294,7 +292,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
-        !(atomic_read(&tb->cflags) & CF_INVALID)) {
+        (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == desc->cf_mask) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
             return true;
@@ -313,7 +311,8 @@ static bool tb_cmp(const void *p, const void *d)
 }
 
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                   target_ulong cs_base, uint32_t flags)
+                                   target_ulong cs_base, uint32_t flags,
+                                   uint32_t cf_mask)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
@@ -322,11 +321,12 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.env = (CPUArchState *)cpu->env_ptr;
     desc.cs_base = cs_base;
     desc.flags = flags;
+    desc.cf_mask = cf_mask;
     desc.trace_vcpu_dstate = *cpu->trace_dstate;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
-    h = tb_hash_func(phys_pc, pc, flags, *cpu->trace_dstate);
+    h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
 
@@ -373,8 +373,9 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     target_ulong cs_base, pc;
     uint32_t flags;
     bool acquired_tb_lock = false;
+    uint32_t cf_mask = curr_cflags();
 
-    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
     if (tb == NULL) {
         /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
          * taken outside tb_lock. As system emulation is currently
@@ -387,10 +388,10 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
         /* There's a chance that our desired tb has been translated while
          * taking the locks so we check again inside the lock.
          */
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
+        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
         if (likely(tb == NULL)) {
             /* if no translated code available, then translate it now */
-            tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
+            tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
         }
 
         mmap_unlock();
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 54d89100d9..25f0cabfed 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -151,7 +151,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     target_ulong cs_base, pc;
     uint32_t flags;
 
-    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
     if (tb == NULL) {
         return tcg_ctx.code_gen_epilogue;
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1b43deb0cd..7ad65bc705 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1101,7 +1101,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+                     tb->trace_vcpu_dstate);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
 
     /* remove the TB from the page list */
@@ -1245,7 +1246,8 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     }
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+                     tb->trace_vcpu_dstate);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
 
 #ifdef CONFIG_USER_ONLY
@@ -1548,7 +1550,8 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
         /* we generate a block containing just the instruction
            modifying the memory. It will ensure that it cannot modify
            itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, 1);
+        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
+                    1 | curr_cflags());
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1666,7 +1669,8 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
         /* we generate a block containing just the instruction
            modifying the memory. It will ensure that it cannot modify
            itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, 1);
+        tb_gen_code(cpu, current_pc, current_cs_base, current_flags,
+                    1 | curr_cflags());
         /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
          * back into the cpu_exec loop. */
         return true;
@@ -1810,6 +1814,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     }
 
     cflags = n | CF_LAST_IO;
+    cflags |= curr_cflags();
     pc = tb->pc;
     cs_base = tb->cs_base;
     flags = tb->flags;
diff --git a/exec.c b/exec.c
index de03053d32..3e0a3dae46 100644
--- a/exec.c
+++ b/exec.c
@@ -2476,7 +2476,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                     cpu_loop_exit(cpu);
                 } else {
                     cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
-                    tb_gen_code(cpu, pc, cs_base, cpu_flags, 1);
+                    tb_gen_code(cpu, pc, cs_base, cpu_flags, 1 | curr_cflags());
                     cpu_loop_exit_noexc(cpu);
                 }
             }
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 11c1cec766..4cabdfd62a 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -103,7 +103,7 @@ static bool is_equal(const void *obj, const void *userp)
 
 static inline uint32_t h(unsigned long v)
 {
-    return tb_hash_func6(v, 0, 0, 0);
+    return tb_hash_func7(v, 0, 0, 0, 0);
 }
 
 /*
-- 
2.13.6
