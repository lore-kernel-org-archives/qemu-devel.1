Received: from eggs.gnu.org ([2001:4830:134:3::10]:40371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVOYW-0006VJ-Gb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVOYR-0003aR-Vr
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:48:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVOYI-0003UX-5D
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:48:15 -0400
Date: Wed, 12 Jul 2017 16:48:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712204804.GA25618@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-10-git-send-email-cota@braap.org>
	<cb152594-248b-85fb-180a-fb83eecf4998@twiddle.net>
	<20170710235751.GA16131@flamenco>
	<57e5db60-7008-7c60-7139-7eb426078c0d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e5db60-7008-7c60-7139-7eb426078c0d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 09/22] exec-all: shrink tb->invalid to
 uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Tue, Jul 11, 2017 at 14:53:00 -1000, Richard Henderson wrote:
> On 07/10/2017 01:57 PM, Emilio G. Cota wrote:
> >>What I would prefer to do is generalize tb->cflags.  Those values *do*
> >>affect how we compile the TB, and yet we don't take them into account.  So I
> >>think it would be a good idea to feed that into the TB hash.
> >
> >I'm having trouble seeing how this could work.
> >Where do we get the "current" values from the current state, i.e.
> >the ones we need to generate the hash and perform comparisons?
> >In particular:
> >- CF_COUNT_MASK: just use CF_COUNT_MASK?
> >- CF_LAST_IO: ?
> >- CF_NOCACHE: always 0 I guess
> 
> All of these are set by cpu_io_recompile as needed.
> They are all clear for normal TBs.
> 
> >- CF_USE/IGNORE_ICOUNT: ?
> CF_IGNORE_ICOUNT probably shouldn't exist.  Probably the callers of
> tb_gen_code should simply set CF_USE_ICOUNT properly if use_icount is true,
> rather than having two flags control the same feature.
> 
> At which point CF_USE_ICOUNT should be set iff use_icount is true.
> 
> Likewise CF_PARALLEL would be set iff parallel_cpus is true, except for
> within cpu_exec_step_atomic where we would always use 0 (because that's the
> whole point of that function).

Would it be OK for this series to just start with CF_PARALLEL? I'm not
too familiar with how icount mode recompiles code, and I'm now on
patch 27 of v2 and still have quite a few patches to go through.

In v2 I have a helper function to mask which bits from cflags to
use--it would be easy to add more flags there. See a preview below
(tb_lookup__cpu_state is introduced earlier in the series.)
The current WIP v2 tree is here:
  https://github.com/cota/qemu/commits/multi-tcg-v2-2017-07-12

Thanks,

		Emilio


commit 6a55d5225a708f1c8eea263a71c8ca3cb5d40bf0
Author: Emilio G. Cota <cota@braap.org>
Date:   Tue Jul 11 14:29:37 2017 -0400

    tcg: bring parallel_cpus to tb->cflags and use it for TB hashing
    
    This allows us to avoid flushing TB's when parallel_cpus is set.
    
    Note that the declaration of parallel_cpus is brought to exec-all.h
    to be able to define there the inlines. The inlines use an unnecessary
    temp variable that is there just to make it easier to add more bits
    to the mask in the future.
    
    Signed-off-by: Emilio G. Cota <cota@braap.org>

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c9f27f9..f770e15 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -327,6 +327,7 @@ struct TranslationBlock {
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
 #define CF_INVALID     0x80000 /* Protected by tb_lock */
+#define CF_PARALLEL    0x100000 /* matches the parallel_cpus global */
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
@@ -370,6 +371,28 @@ struct TranslationBlock {
     uintptr_t jmp_list_first;
 };
 
+extern bool parallel_cpus;
+
+/* tb->cflags, masked for hashing/comparison */
+static inline uint32_t tb_cf_mask(const TranslationBlock *tb)
+{
+    uint32_t mask = 0;
+
+    mask |= CF_PARALLEL;
+    return tb->cflags & mask;
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
index 49c1ecf..2531b73 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -224,31 +224,27 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 static void cpu_exec_step(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
 
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-        mmap_lock();
-        tb_lock();
-        tb = tb_gen_code(cpu, pc, cs_base, flags,
-                         1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
-        tb->orig_tb = NULL;
-        tb_unlock();
-        mmap_unlock();
+        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+        if (tb == NULL) {
+            mmap_lock();
+            tb_lock();
+            tb = tb_gen_code(cpu, pc, cs_base, flags,
+                             1 | CF_IGNORE_ICOUNT);
+            tb->orig_tb = NULL;
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
@@ -280,6 +276,7 @@ struct tb_desc {
     CPUArchState *env;
     tb_page_addr_t phys_page1;
     uint32_t flags;
+    uint32_t cf_mask;
     uint32_t trace_vcpu_dstate;
 };
 
@@ -292,6 +289,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] == desc->phys_page1 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
+        tb_cf_mask(tb) == desc->cf_mask &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
@@ -320,11 +318,12 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.env = (CPUArchState *)cpu->env_ptr;
     desc.cs_base = cs_base;
     desc.flags = flags;
+    desc.cf_mask = curr_cf_mask();
     desc.trace_vcpu_dstate = *cpu->trace_dstate;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
-    h = tb_hash_func(phys_pc, pc, flags, *cpu->trace_dstate);
+    h = tb_hash_func(phys_pc, pc, flags, curr_cf_mask(), *cpu->trace_dstate);
     return qht_lookup(&tcg_ctx.tb_ctx.htable, tb_cmp, &desc, h);
 }
 
@@ -345,6 +344,7 @@ TranslationBlock *tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc,
                tb->pc == *pc &&
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
+               tb_cf_mask(tb) == curr_cf_mask() &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate)) {
         return tb;
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 53fbb06..c9e8c1d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1075,7 +1075,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cf_mask(tb),
+                     tb->trace_vcpu_dstate);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
 
     /*
@@ -1226,7 +1227,8 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     }
 
     /* add in the hash table */
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cf_mask(tb),
+                     tb->trace_vcpu_dstate);
     qht_insert(&tcg_ctx.tb_ctx.htable, tb, h);
 
 #ifdef DEBUG_TB_CHECK
@@ -1254,6 +1256,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if (use_icount && !(cflags & CF_IGNORE_ICOUNT)) {
         cflags |= CF_USE_ICOUNT;
     }
+    if (parallel_cpus) {
+        cflags |= CF_PARALLEL;
+    }
 
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 925ae11..fa40f6c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6312,11 +6312,10 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
 
         /* If this is our first additional thread, we need to ensure we
-         * generate code for parallel execution and flush old translations.
+         * generate code for parallel execution.
          */
         if (!parallel_cpus) {
             parallel_cpus = true;
-            tb_flush(cpu);
         }
 
         ret = pthread_create(&info.thread, &attr, clone_func, &info);
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
