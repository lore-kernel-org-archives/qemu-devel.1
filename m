Received: from eggs.gnu.org ([2001:4830:134:3::10]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNShe-0001ed-2J
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNShZ-0006LJ-GH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:13:45 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNShY-0006Ky-BJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 20:13:40 -0500
Date: Thu, 15 Nov 2018 20:13:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181116011338.GB17566@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Thu, Nov 15, 2018 at 23:04:50 +0100, Richard Henderson wrote:
> On 11/15/18 7:48 PM, Emilio G. Cota wrote:
> > - Segfault in code_gen_buffer. This one I don't have a fix for,
> >   but it's *much* easier to reproduce when -tb-size is very small,
> >   e.g. "-tb-size 5 -smp 2" (BTW it crashes with x86_64 guests too.)
> >   So at first I thought the code cache flushing was the problem,
> >   but I don't see how that could be, at least from a TCGContext
> >   viewpoint -- I agree that clearing the hash table in
> >   tcg_region_assign is a good place to do so.
> 
> Ho hum.
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 639f0b2728..115ea186e5 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1831,10 +1831,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      existing_tb = tb_link_page(tb, phys_pc, phys_page2);
>      /* if the TB already exists, discard what we just translated */
>      if (unlikely(existing_tb != tb)) {
> -        uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
> -
> -        orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> -        atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
>          return existing_tb;
>      }
>      tcg_tb_insert(tb);
> 
> We can't easily undo the hash table insert, and for a relatively rare
> occurrence it's not worth the effort.

Nice catch! Everything works now =D

In the bootup+shutdown aarch64 test with -smp 12, we end up
discarding ~2500 TB's--that's ~439K of space for code that we
do not waste; note that I'm assuming 180 host bytes per TB,
which is the average reported by info jit.

We can still discard most of these by increasing a counter every
time we insert a new element into the OOL table, and checking
this counter before/after tcg_gen_code. (Note that checking
g_hash_table_size before/after is not enough, because we might
have replaced an existing item from the table.)
Then, we discard a TB iff an OOL thunk was generated. (Diff below.)

This allows us to discard most TBs; in the example above,
we end up *not* discarding only ~70 TBs, that is we end up keeping
only 70/2500 = 2.8% of the TBs that we'd discard without OOL.

Performance-wise it doesn't make a difference for -smp 1:

Host: Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (5 runs):

- Before (3.1.0-rc1):

      14351.436177      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.24% )
    49,963,260,126      cycles                    #    3.481 GHz                      ( +-  0.22% )  (83.32%)
    26,047,650,654      stalled-cycles-frontend   #   52.13% frontend cycles idle     ( +-  0.29% )  (83.34%)
    19,717,480,482      stalled-cycles-backend    #   39.46% backend  cycles idle     ( +-  0.27% )  (66.67%)
    59,278,011,067      instructions              #    1.19  insns per cycle        
                                                  #    0.44  stalled cycles per insn  ( +-  0.17% )  (83.34%)
    10,632,601,608      branches                  #  740.874 M/sec                    ( +-  0.17% )  (83.34%)
       236,153,469      branch-misses             #    2.22% of all branches          ( +-  0.16% )  (83.35%)

      14.382847823 seconds time elapsed                                          ( +-  0.25% )

- After this series (with the fixes we've discussed):

      13256.198927      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.04% )
    46,146,457,353      cycles                    #    3.481 GHz                      ( +-  0.08% )  (83.34%)
    22,632,342,565      stalled-cycles-frontend   #   49.04% frontend cycles idle     ( +-  0.12% )  (83.35%)
    16,534,690,741      stalled-cycles-backend    #   35.83% backend  cycles idle     ( +-  0.15% )  (66.67%)
    58,047,832,548      instructions              #    1.26  insns per cycle        
                                                  #    0.39  stalled cycles per insn  ( +-  0.18% )  (83.34%)
    11,031,634,880      branches                  #  832.187 M/sec                    ( +-  0.12% )  (83.33%)
       210,593,929      branch-misses             #    1.91% of all branches          ( +-  0.30% )  (83.33%)

      13.285023783 seconds time elapsed                                          ( +-  0.05% )

- After the fixup below:

      13240.889734      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.19% )
    46,074,292,775      cycles                    #    3.480 GHz                      ( +-  0.12% )  (83.35%)
    22,670,132,770      stalled-cycles-frontend   #   49.20% frontend cycles idle     ( +-  0.17% )  (83.35%)
    16,598,822,504      stalled-cycles-backend    #   36.03% backend  cycles idle     ( +-  0.26% )  (66.66%)
    57,796,083,344      instructions              #    1.25  insns per cycle        
                                                  #    0.39  stalled cycles per insn  ( +-  0.16% )  (83.34%)
    11,002,340,174      branches                  #  830.937 M/sec                    ( +-  0.11% )  (83.35%)
       211,023,549      branch-misses             #    1.92% of all branches          ( +-  0.22% )  (83.32%)

      13.264499034 seconds time elapsed                                          ( +-  0.19% )

I'll generate now some more perf numbers that we could include in the
commit logs.

Thanks,

		Emilio

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 115ea18..15f7d4e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1678,6 +1678,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     target_ulong virt_page2;
     tcg_insn_unit *gen_code_buf;
     int gen_code_size, search_size;
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    size_t n_ool_thunks;
+#endif
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &tcg_ctx->prof;
     int64_t ti;
@@ -1744,6 +1747,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+    n_ool_thunks = tcg_ctx->n_ool_thunks;
+#endif
+
     /* ??? Overflow could be handled better here.  In particular, we
        don't need to re-do gen_intermediate_code, nor should we re-do
        the tcg optimization currently hidden inside tcg_gen_code.  All
@@ -1831,6 +1838,18 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     existing_tb = tb_link_page(tb, phys_pc, phys_page2);
     /* if the TB already exists, discard what we just translated */
     if (unlikely(existing_tb != tb)) {
+        bool discard = true;
+
+#ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
+        /* only discard the TB if we didn't generate an OOL thunk */
+        discard = tcg_ctx->n_ool_thunks == n_ool_thunks;
+#endif
+        if (discard) {
+            uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
+
+            orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
+            atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
+        }
         return existing_tb;
     }
     tcg_tb_insert(tb);
diff --git a/tcg/tcg-ldst-ool.inc.c b/tcg/tcg-ldst-ool.inc.c
index 8fb6550..61da060 100644
--- a/tcg/tcg-ldst-ool.inc.c
+++ b/tcg/tcg-ldst-ool.inc.c
@@ -69,6 +69,7 @@ static bool tcg_out_ldst_ool_finalize(TCGContext *s)
 
         /* Remember the thunk for next time.  */
         g_hash_table_replace(s->ldst_ool_thunks, key, dest);
+        s->n_ool_thunks++;
 
         /* The new thunk must be in range.  */
         ok = patch_reloc(lb->label, lb->reloc, (intptr_t)dest, lb->addend);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 1255d2a..d4f07a6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -709,6 +709,7 @@ struct TCGContext {
 #ifdef TCG_TARGET_NEED_LDST_OOL_LABELS
     QSIMPLEQ_HEAD(ldst_labels, TCGLabelQemuLdstOol) ldst_ool_labels;
     GHashTable *ldst_ool_thunks;
+    size_t n_ool_thunks;
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     struct TCGLabelPoolData *pool_labels;
