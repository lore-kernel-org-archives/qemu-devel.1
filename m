Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zN-0004Sg-71
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zF-00031i-Bi
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zE-000305-QO
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:50:14 -0400
Message-Id: <1499586614-20507-23-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 22/22] translate-all: do not hold tb_lock
 during code generation in softmmu
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

Each vCPU can now generate code with TCG in parallel. Thus,
drop tb_lock around code generation in softmmu.

Note that we still have to take tb_lock after code translation,
since there is global state that we have to update.

Nonetheless holding tb_lock for less time provides significant performance
improvements to workloads that are translation-heavy. A good example
of this is booting Linux; in my measurements, bootup+shutdown time of
debian-arm is reduced by 20% before/after this entire patchset, when
using -smp 8 and MTTCG on a machine with >= 8 real cores:

 Host: Intel(R) Xeon(R) CPU E5-2690 @ 2.90GHz
 Performance counter stats for 'qemu/build/arm-softmmu/qemu-system-arm \
	-machine type=virt -nographic -smp 1 -m 4096 \
	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
	-device virtio-net-device,netdev=unet \
	-drive file=foobar.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock \
	-kernel /foobar.img -append console=ttyAMA0 root=/dev/vda1 \
	-name arm,debug-threads=on -smp 8' (3 runs):

Before:
      28764.018852 task-clock                #    1.663 CPUs utilized            ( +-  0.30% )
           727,490 context-switches          #    0.025 M/sec                    ( +-  0.68% )
             2,429 CPU-migrations            #    0.000 M/sec                    ( +- 11.36% )
            14,042 page-faults               #    0.000 M/sec                    ( +-  1.00% )
    70,644,349,920 cycles                    #    2.456 GHz                      ( +-  0.96% ) [83.42%]
    37,129,806,098 stalled-cycles-frontend   #   52.56% frontend cycles idle     ( +-  1.27% ) [83.20%]
    26,620,190,524 stalled-cycles-backend    #   37.68% backend  cycles idle     ( +-  1.29% ) [66.50%]
    85,528,287,892 instructions              #    1.21  insns per cycle
                                             #    0.43  stalled cycles per insn  ( +-  0.62% ) [83.40%]
    14,417,482,689 branches                  #  501.233 M/sec                    ( +-  0.49% ) [83.36%]
       321,182,192 branch-misses             #    2.23% of all branches          ( +-  1.17% ) [83.53%]

      17.297750583 seconds time elapsed                                          ( +-  1.08% )

After:
      28690.888633 task-clock                #    2.069 CPUs utilized            ( +-  1.54% )
           473,947 context-switches          #    0.017 M/sec                    ( +-  1.32% )
             2,793 CPU-migrations            #    0.000 M/sec                    ( +- 18.74% )
            22,634 page-faults               #    0.001 M/sec                    ( +-  1.20% )
    69,314,663,510 cycles                    #    2.416 GHz                      ( +-  1.08% ) [83.50%]
    36,114,710,208 stalled-cycles-frontend   #   52.10% frontend cycles idle     ( +-  1.64% ) [83.26%]
    25,519,842,658 stalled-cycles-backend    #   36.82% backend  cycles idle     ( +-  1.70% ) [66.77%]
    84,588,443,638 instructions              #    1.22  insns per cycle
                                             #    0.43  stalled cycles per insn  ( +-  0.78% ) [83.44%]
    14,258,100,183 branches                  #  496.956 M/sec                    ( +-  0.87% ) [83.32%]
       324,984,804 branch-misses             #    2.28% of all branches          ( +-  0.51% ) [83.17%]

      13.870347754 seconds time elapsed                                          ( +-  1.65% )

That is, a speedup of 17.29/13.87=1.24X.

Similar numbers on a slower machine:

Host: AMD Opteron(tm) Processor 6376:

Before:
      74765.850569      task-clock (msec)         #    1.956 CPUs utilized            ( +-  1.42% )
           841,430      context-switches          #    0.011 M/sec                    ( +-  2.50% )
            18,228      cpu-migrations            #    0.244 K/sec                    ( +-  2.87% )
            26,565      page-faults               #    0.355 K/sec                    ( +-  9.19% )
    98,775,815,944      cycles                    #    1.321 GHz                      ( +-  1.40% )  (83.44%)
    26,325,365,757      stalled-cycles-frontend   #   26.65% frontend cycles idle     ( +-  1.96% )  (83.26%)
    17,270,620,447      stalled-cycles-backend    #   17.48% backend  cycles idle     ( +-  3.45% )  (33.32%)
    82,998,905,540      instructions              #    0.84  insns per cycle
                                                  #    0.32  stalled cycles per insn  ( +-  0.71% )  (50.06%)
    14,209,593,402      branches                  #  190.055 M/sec                    ( +-  1.01% )  (66.74%)
       571,258,648      branch-misses             #    4.02% of all branches          ( +-  0.20% )  (83.40%)

      38.220740889 seconds time elapsed                                          ( +-  0.72% )

After:
      73281.226761      task-clock (msec)         #    2.415 CPUs utilized            ( +-  0.29% )
           571,984      context-switches          #    0.008 M/sec                    ( +-  1.11% )
            14,301      cpu-migrations            #    0.195 K/sec                    ( +-  2.90% )
            42,635      page-faults               #    0.582 K/sec                    ( +-  7.76% )
    98,478,185,775      cycles                    #    1.344 GHz                      ( +-  0.32% )  (83.39%)
    25,555,945,935      stalled-cycles-frontend   #   25.95% frontend cycles idle     ( +-  0.47% )  (83.37%)
    15,174,223,390      stalled-cycles-backend    #   15.41% backend  cycles idle     ( +-  0.83% )  (33.26%)
    81,939,511,983      instructions              #    0.83  insns per cycle
                                                  #    0.31  stalled cycles per insn  ( +-  0.12% )  (49.95%)
    13,992,075,918      branches                  #  190.937 M/sec                    ( +-  0.16% )  (66.65%)
       580,790,655      branch-misses             #    4.15% of all branches          ( +-  0.20% )  (83.26%)

      30.340574988 seconds time elapsed                                          ( +-  0.39% )

That is, a speedup of 1.25X.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      |  7 ++++++-
 accel/tcg/translate-all.c | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 54ecae2..2b34d58 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -351,6 +351,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
              * single threaded the locks are NOPs.
              */
             mmap_lock();
+#ifdef CONFIG_USER_ONLY
             tb_lock();
             have_tb_lock = true;
 
@@ -362,7 +363,11 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
                 /* if no translated code available, then translate it now */
                 tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
             }
-
+#else
+            tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
+            /* tb_gen_code returns with tb_lock acquired */
+            have_tb_lock = true;
+#endif
             mmap_unlock();
         }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 17b18a9..6cab609 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -887,7 +887,9 @@ static TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
 
+#ifdef CONFIG_USER_ONLY
     assert_tb_locked();
+#endif
 
     tb = tcg_tb_alloc(&tcg_ctx);
     if (unlikely(tb == NULL)) {
@@ -1314,7 +1316,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     TCGProfile *prof = &tcg_ctx.prof;
     int64_t ti;
 #endif
+#ifdef CONFIG_USER_ONLY
     assert_memory_lock();
+#endif
 
     phys_pc = get_page_addr_code(env, pc);
     if (use_icount && !(cflags & CF_IGNORE_ICOUNT)) {
@@ -1430,6 +1434,24 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
     }
+    if (!have_tb_lock) {
+        TranslationBlock *t;
+
+        tb_lock();
+        /*
+         * There's a chance that our desired tb has been translated while
+         * we were translating it.
+         */
+        t = tb_htable_lookup(cpu, pc, cs_base, flags);
+        if (unlikely(t)) {
+            /* discard what we just translated */
+            uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
+
+            orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
+            atomic_set(&tcg_ctx.code_gen_ptr, orig_aligned);
+            return t;
+        }
+    }
     /* As long as consistency of the TB stuff is provided by tb_lock in user
      * mode and is implicit in single-threaded softmmu emulation, no explicit
      * memory barrier is required before tb_link_page() makes the TB visible
-- 
2.7.4
