Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO9-0000Aa-7g
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO7-0007HY-Od
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:29 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO7-0007FH-FG
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:08 -0400
Message-Id: <20181006214508.5331-7-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 6/6] cputlb: dynamically resize TLBs based on use
 rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Perform the resizing only on flushes, otherwise we'd
have to take a perf hit by either rehashing the array
or unnecessarily flushing it.

We grow the array aggressively, and reduce the size more
slowly. This accommodates mixed workloads, where some
processes might be memory-heavy while others are not.

As the following experiments show, this a net perf gain,
particularly for memory-heavy workloads. Experiments
are run on an Intel i7-6700K CPU @ 4.00GHz.

1. System boot + shudown, debian aarch64:

- Before (tb-lock-v3):
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7469.363393      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.07% )
    31,507,707,190      cycles                    #    4.218 GHz                      ( +-  0.07% )
    57,101,577,452      instructions              #    1.81  insns per cycle          ( +-  0.08% )
    10,265,531,804      branches                  # 1374.352 M/sec                    ( +-  0.07% )
       173,020,681      branch-misses             #    1.69% of all branches          ( +-  0.10% )

       7.483359063 seconds time elapsed                                          ( +-  0.08% )

- After:
 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7185.036730      task-clock (msec)         #    0.999 CPUs utilized            ( +-  0.11% )
    30,303,501,143      cycles                    #    4.218 GHz                      ( +-  0.11% )
    54,198,386,487      instructions              #    1.79  insns per cycle          ( +-  0.08% )
     9,726,518,945      branches                  # 1353.719 M/sec                    ( +-  0.08% )
       167,082,307      branch-misses             #    1.72% of all branches          ( +-  0.08% )

       7.195597842 seconds time elapsed                                          ( +-  0.11% )

That is, a 3.8% improvement.

2. System boot + shutdown, ubuntu 18.04 x86_64:

- Before (tb-lock-v3):
Performance counter stats for 'taskset -c 0 ../img/x86_64/ubuntu-die.sh -nographic' (2 runs):

      49971.036482      task-clock (msec)         #    0.999 CPUs utilized            ( +-  1.62% )
   210,766,077,140      cycles                    #    4.218 GHz                      ( +-  1.63% )
   428,829,830,790      instructions              #    2.03  insns per cycle          ( +-  0.75% )
    77,313,384,038      branches                  # 1547.164 M/sec                    ( +-  0.54% )
       835,610,706      branch-misses             #    1.08% of all branches          ( +-  2.97% )

      50.003855102 seconds time elapsed                                          ( +-  1.61% )

- After:
 Performance counter stats for 'taskset -c 0 ../img/x86_64/ubuntu-die.sh -nographic' (2 runs):

      50118.124477      task-clock (msec)         #    0.999 CPUs utilized            ( +-  4.30% )
           132,396      context-switches          #    0.003 M/sec                    ( +-  1.20% )
                 0      cpu-migrations            #    0.000 K/sec                    ( +-100.00% )
           167,754      page-faults               #    0.003 M/sec                    ( +-  0.06% )
   211,414,701,601      cycles                    #    4.218 GHz                      ( +-  4.30% )
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
   431,618,818,597      instructions              #    2.04  insns per cycle          ( +-  6.40% )
    80,197,256,524      branches                  # 1600.165 M/sec                    ( +-  8.59% )
       794,830,352      branch-misses             #    0.99% of all branches          ( +-  2.05% )

      50.177077175 seconds time elapsed                                          ( +-  4.23% )

No improvement (within noise range).

3. x86_64 SPEC06int:
                              SPEC06int (test set)
                         [ Y axis: speedup over master ]
  8 +-+--+----+----+-----+----+----+----+----+----+----+-----+----+----+--+-+
    |                                                                       |
    |                                                   tlb-lock-v3         |
  7 +-+..................$$$...........................+indirection       +-+
    |                    $ $                              +resizing         |
    |                    $ $                                                |
  6 +-+..................$.$..............................................+-+
    |                    $ $                                                |
    |                    $ $                                                |
  5 +-+..................$.$..............................................+-+
    |                    $ $                                                |
    |                    $ $                                                |
  4 +-+..................$.$..............................................+-+
    |                    $ $                                                |
    |          +++       $ $                                                |
  3 +-+........$$+.......$.$..............................................+-+
    |          $$        $ $                                                |
    |          $$        $ $                                 $$$            |
  2 +-+........$$........$.$.................................$.$..........+-+
    |          $$        $ $                                 $ $       +$$  |
    |          $$   $$+  $ $  $$$       +$$                  $ $  $$$   $$  |
  1 +-+***#$***#$+**#$+**#+$**#+$**##$**##$***#$***#$+**#$+**#+$**#+$**##$+-+
    |  * *#$* *#$ **#$ **# $**# $** #$** #$* *#$* *#$ **#$ **# $**# $** #$  |
    |  * *#$* *#$ **#$ **# $**# $** #$** #$* *#$* *#$ **#$ **# $**# $** #$  |
  0 +-+***#$***#$-**#$-**#$$**#$$**##$**##$***#$***#$-**#$-**#$$**#$$**##$+-+
     401.bzi403.gc429445.g456.h462.libq464.h471.omne4483.xalancbgeomean
png: https://imgur.com/a/b1wn3wc

That is, a 1.53x average speedup over master, with a max speedup of 7.13x.

Note that "indirection" (i.e. the first patch in this series) incurs
no overhead, on average.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-defs.h |  1 +
 accel/tcg/cputlb.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 27b9433976..4d1d6b2b8b 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -145,6 +145,7 @@ typedef struct CPUTLBDesc {
     size_t size;
     size_t mask; /* (.size - 1) << CPU_TLB_ENTRY_BITS for TLB fast path */
     size_t used;
+    size_t n_flushes_low_rate;
 } CPUTLBDesc;
 
 #define CPU_COMMON_TLB  \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1ca71ecfc4..afb61e9c2b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -85,6 +85,7 @@ void tlb_init(CPUState *cpu)
         desc->size = MIN_CPU_TLB_SIZE;
         desc->mask = (desc->size - 1) << CPU_TLB_ENTRY_BITS;
         desc->used = 0;
+        desc->n_flushes_low_rate = 0;
         env->tlb_table[i] = g_new(CPUTLBEntry, desc->size);
         env->iotlb[i] = g_new0(CPUIOTLBEntry, desc->size);
     }
@@ -122,6 +123,39 @@ size_t tlb_flush_count(void)
     return count;
 }
 
+/* Call with tlb_lock held */
+static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
+{
+    CPUTLBDesc *desc = &env->tlb_desc[mmu_idx];
+    size_t rate = desc->used * 100 / desc->size;
+    size_t new_size = desc->size;
+
+    if (rate == 100) {
+        new_size = MIN(desc->size << 2, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
+    } else if (rate > 70) {
+        new_size = MIN(desc->size << 1, 1 << TCG_TARGET_TLB_MAX_INDEX_BITS);
+    } else if (rate < 30) {
+        desc->n_flushes_low_rate++;
+        if (desc->n_flushes_low_rate == 100) {
+            new_size = MAX(desc->size >> 1, 1 << MIN_CPU_TLB_BITS);
+            desc->n_flushes_low_rate = 0;
+        }
+    }
+
+    if (new_size == desc->size) {
+        return;
+    }
+
+    g_free(env->tlb_table[mmu_idx]);
+    g_free(env->iotlb[mmu_idx]);
+
+    desc->size = new_size;
+    desc->mask = (desc->size - 1) << CPU_TLB_ENTRY_BITS;
+    desc->n_flushes_low_rate = 0;
+    env->tlb_table[mmu_idx] = g_new(CPUTLBEntry, desc->size);
+    env->iotlb[mmu_idx] = g_new0(CPUIOTLBEntry, desc->size);
+}
+
 /* This is OK because CPU architectures generally permit an
  * implementation to drop entries from the TLB at any time, so
  * flushing more entries than required is only an efficiency issue,
@@ -151,6 +185,7 @@ static void tlb_flush_nocheck(CPUState *cpu)
      */
     qemu_spin_lock(&env->tlb_lock);
     for (i = 0; i < NB_MMU_MODES; i++) {
+        tlb_mmu_resize_locked(env, i);
         memset(env->tlb_table[i], -1,
                env->tlb_desc[i].size * sizeof(CPUTLBEntry));
         env->tlb_desc[i].used = 0;
@@ -215,6 +250,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
         if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
             tlb_debug("%d\n", mmu_idx);
 
+            tlb_mmu_resize_locked(env, mmu_idx);
             memset(env->tlb_table[mmu_idx], -1,
                    env->tlb_desc[mmu_idx].size * sizeof(CPUTLBEntry));
             memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
-- 
2.17.1
