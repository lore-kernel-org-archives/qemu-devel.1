Received: from eggs.gnu.org ([2001:4830:134:3::10]:46302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmd-0001B9-J5
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008ID-4o
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008Gk-U8
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:57 -0400
Message-Id: <1500235468-15341-15-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 14/45] tcg: define CF_PARALLEL and use it
 for TB hashing
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

This will enable us to decouple code translation from the value
of parallel_cpus at any given time. It will also help us minimize
TB flushes when generating code via EXCP_ATOMIC.

Note that the declaration of parallel_cpus is brought to exec-all.h
to be able to define there the inlines. The inlines use an unnecessary
temp variable that is there just to make it easier to add more bits
to the mask in the future.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 26 ++++++++++++++++++++++-
 include/exec/tb-hash-xx.h |  9 +++++---
 include/exec/tb-hash.h    |  4 ++--
 include/exec/tb-lookup.h  |  5 +++--
 tcg/tcg.h                 |  1 -
 accel/tcg/cpu-exec.c      | 53 +++++++++++++++++++++++++++--------------------
 accel/tcg/translate-all.c | 23 ++++++++++++++++----
 exec.c                    |  7 ++++++-
 hw/i386/kvmvapic.c        |  7 ++++++-
 tcg/tcg-runtime.c         |  2 +-
 tests/qht-bench.c         |  2 +-
 11 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 78a1714..b3f04c3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,6 +327,7 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 #define CF_INVALID     0x80000 /* Protected by tb_lock */
+#define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
@@ -370,11 +371,34 @@ struct TranslationBlock {
     uintptr_t jmp_list_first;
 };
 
+extern bool parallel_cpus;
+
+/* mask cflags for hashing/comparison */
+static inline uint32_t mask_cf(uint32_t cflags)
+{
+    uint32_t mask = 0;
+
+    mask |= CF_PARALLEL;
+    return cflags & mask;
+}
+
+/* current cflags, masked for hashing/comparison */
+static inline uint32_t curr_cf_mask(void)
+{
+    uint32_t val = 0;
+
+    if (parallel_cpus) {
+        val |= CF_PARALLEL;
+    }
+    return val;
+}
+
 void tb_free(TranslationBlock *tb);
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                   target_ulong cs_base, uint32_t flags);
+                                   target_ulong cs_base, uint32_t flags,
+                                   uint32_t cf_mask);
 
 #if defined(USE_DIRECT_JUMP)
 
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 6cd3022..747a9a6 100644
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
index 17b5ee0..0526c4f 100644
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
index 5e3f104..9948b67 100644
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
@@ -34,10 +34,11 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
                tb->pc == *pc &&
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
+               mask_cf(tb->cflags) == cf_mask &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate)) {
         return tb;
     }
-    tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags);
+    tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags, cf_mask);
     if (tb == NULL) {
         return NULL;
     }
diff --git a/tcg/tcg.h b/tcg/tcg.h
index da78721..96872f8 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -730,7 +730,6 @@ struct TCGContext {
 };
 
 extern TCGContext tcg_ctx;
-extern bool parallel_cpus;
 
 static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3a08ad0..efe5c85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -198,16 +198,20 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
                              TranslationBlock *orig_tb, bool ignore_icount)
 {
     TranslationBlock *tb;
+    uint32_t cflags;
 
     /* Should never happen.
        We only end up here when an existing TB is too long.  */
     if (max_cycles > CF_COUNT_MASK)
         max_cycles = CF_COUNT_MASK;
 
+    cflags = max_cycles | CF_NOCACHE | (ignore_icount ? CF_IGNORE_ICOUNT : 0);
+    if (parallel_cpus) {
+        cflags |= CF_PARALLEL;
+    }
     tb_lock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base, orig_tb->flags,
-                     max_cycles | CF_NOCACHE
-                         | (ignore_icount ? CF_IGNORE_ICOUNT : 0));
+                     cflags);
     tb->orig_tb = orig_tb;
     tb_unlock();
 
@@ -225,31 +229,26 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
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
+        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, mask_cf(cflags));
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
@@ -281,6 +280,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    uint32_t cf_mask;
     uint32_t trace_vcpu_dstate;
 };
 
@@ -293,6 +293,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] == desc->phys_page1 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
+        mask_cf(tb->cflags) == desc->cf_mask &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
@@ -312,7 +313,8 @@ static bool tb_cmp(const void *p, const void *d)
 }
 
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                   target_ulong cs_base, uint32_t flags)
+                                   target_ulong cs_base, uint32_t flags,
+                                   uint32_t cf_mask)
 {
     tb_page_addr_t phys_pc;
     struct tb_desc desc;
@@ -321,11 +323,12 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
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
 
@@ -337,8 +340,9 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     target_ulong cs_base, pc;
     uint32_t flags;
     bool acquired_tb_lock = false;
+    uint32_t cf_mask = curr_cf_mask();
 
-    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
     if (tb == NULL) {
         /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
          * taken outside tb_lock. As system emulation is currently
@@ -351,10 +355,15 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
         /* There's a chance that our desired tb has been translated while
          * taking the locks so we check again inside the lock.
          */
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
+        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
         if (likely(tb == NULL)) {
+            uint32_t cflags = 0;
+
+            if (parallel_cpus) {
+                cflags |= CF_PARALLEL;
+            }
             /* if no translated code available, then translate it now */
-            tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
+            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
         }
 
         mmap_unlock();
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 53fbb06..483248f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1075,7 +1075,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, mask_cf(tb->cflags),
+                     tb->trace_vcpu_dstate);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
 
     /*
@@ -1226,7 +1227,8 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     }
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, mask_cf(tb->cflags),
+                     tb->trace_vcpu_dstate);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
 
 #ifdef DEBUG_TB_CHECK
@@ -1504,10 +1506,15 @@ void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
 #endif
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
+        uint32_t cflags = 1;
+
+        if (parallel_cpus) {
+            cflags |= CF_PARALLEL;
+        }
         /* we generate a block containing just the instruction
            modifying the memory. It will ensure that it cannot modify
            itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, 1);
+        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, cflags);
         cpu_loop_exit_noexc(cpu);
     }
 #endif
@@ -1622,10 +1629,15 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     p->first_tb = NULL;
 #ifdef TARGET_HAS_PRECISE_SMC
     if (current_tb_modified) {
+        uint32_t cflags = 1;
+
+        if (parallel_cpus) {
+            cflags |= CF_PARALLEL;
+        }
         /* we generate a block containing just the instruction
            modifying the memory. It will ensure that it cannot modify
            itself */
-        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, 1);
+        tb_gen_code(cpu, current_pc, current_cs_base, current_flags, cflags);
         /* tb_lock will be reset after cpu_loop_exit_noexc longjmps
          * back into the cpu_exec loop. */
         return true;
@@ -1769,6 +1781,9 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     }
 
     cflags = n | CF_LAST_IO;
+    if (parallel_cpus) {
+        cflags |= CF_PARALLEL;
+    }
     pc = tb->pc;
     cs_base = tb->cs_base;
     flags = tb->flags;
diff --git a/exec.c b/exec.c
index a083ff8..adc160f 100644
--- a/exec.c
+++ b/exec.c
@@ -2414,8 +2414,13 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                     cpu->exception_index = EXCP_DEBUG;
                     cpu_loop_exit(cpu);
                 } else {
+                    uint32_t cflags = 1;
+
+                    if (parallel_cpus) {
+                        cflags |= CF_PARALLEL;
+                    }
                     cpu_get_tb_cpu_state(env, &pc, &cs_base, &cpu_flags);
-                    tb_gen_code(cpu, pc, cs_base, cpu_flags, 1);
+                    tb_gen_code(cpu, pc, cs_base, cpu_flags, cflags);
                     cpu_loop_exit_noexc(cpu);
                 }
             }
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 0d9ef77..22e151d 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -458,10 +458,15 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
     resume_all_vcpus();
 
     if (tcg_enabled()) {
+        uint32_t cflags = 1;
+
+        if (parallel_cpus) {
+            cflags |= CF_PARALLEL;
+        }
         /* Both tb_lock and iothread_mutex will be reset when
          *  longjmps back into the cpu_exec loop. */
         tb_lock();
-        tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
+        tb_gen_code(cs, current_pc, current_cs_base, current_flags, cflags);
         cpu_loop_exit_noexc(cs);
     }
 }
diff --git a/tcg/tcg-runtime.c b/tcg/tcg-runtime.c
index 7100339..bf6f248 100644
--- a/tcg/tcg-runtime.c
+++ b/tcg/tcg-runtime.c
@@ -151,7 +151,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     target_ulong cs_base, pc;
     uint32_t flags;
 
-    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cf_mask());
     if (tb == NULL) {
         return tcg_ctx.code_gen_epilogue;
     }
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 11c1cec..4cabdfd 100644
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
2.7.4
