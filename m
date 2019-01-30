Received: from eggs.gnu.org ([209.51.188.92]:36104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe49-0000Qq-V9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe48-0001ei-Up
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:21 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe48-0001Hq-QK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:48:11 -0500
Message-Id: <20190130004811.27372-74-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 73/73] cputlb: queue async flush jobs
 without the BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This yields sizable scalability improvements, as the below results show.

Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)

Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
"make -j N", where N is the number of cores in the guest.

                      Speedup vs a single thread (higher is better):

         14 +---------------------------------------------------------------+
            |       +    +       +      +       +      +      $$$$$$  +     |
            |                                            $$$$$              |
            |                                      $$$$$$                   |
         12 |-+                                $A$$                       +-|
            |                                $$                             |
            |                             $$$                               |
         10 |-+                         $$    ##D#####################D   +-|
            |                        $$$ #####**B****************           |
            |                      $$####*****                   *****      |
            |                    A$#*****                             B     |
          8 |-+                $$B**                                      +-|
            |                $$**                                           |
            |               $**                                             |
          6 |-+           $$*                                             +-|
            |            A**                                                |
            |           $B                                                  |
            |           $                                                   |
          4 |-+        $*                                                 +-|
            |          $                                                    |
            |         $                                                     |
          2 |-+      $                                                    +-|
            |        $                                 +cputlb-no-bql $$A$$ |
            |       A                                   +per-cpu-lock ##D## |
            |       +    +       +      +       +      +     baseline **B** |
          0 +---------------------------------------------------------------+
                    1    4       8      12      16     20      24     28
                                       Guest vCPUs
  png: https://imgur.com/zZRvS7q

Some notes:
- baseline corresponds to the commit before this series

- per-cpu-lock is the commit that converts the CPU loop to per-cpu locks.

- cputlb-no-bql is this commit.

- I'm using taskset to assign cores to threads, favouring locality whenever
  possible but not using SMT. When N=1, I'm using a single host core, which
  leads to superlinear speedups (since with more cores the I/O thread can execute
  while vCPU threads sleep). In the future I might use N+1 host cores for N
  guest cores to avoid this, or perhaps pin guest threads to cores one-by-one.

Single-threaded performance is affected very lightly. Results
below for debian aarch64 bootup+test for the entire series
on an Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz host:

- Before:

 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7269.033478      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.06% )
    30,659,870,302      cycles                    #    4.218 GHz                      ( +-  0.06% )
    54,790,540,051      instructions              #    1.79  insns per cycle          ( +-  0.05% )
     9,796,441,380      branches                  # 1347.695 M/sec                    ( +-  0.05% )
       165,132,201      branch-misses             #    1.69% of all branches          ( +-  0.12% )

       7.287011656 seconds time elapsed                                          ( +-  0.10% )

- After:

       7375.924053      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.13% )
    31,107,548,846      cycles                    #    4.217 GHz                      ( +-  0.12% )
    55,355,668,947      instructions              #    1.78  insns per cycle          ( +-  0.05% )
     9,929,917,664      branches                  # 1346.261 M/sec                    ( +-  0.04% )
       166,547,442      branch-misses             #    1.68% of all branches          ( +-  0.09% )

       7.389068145 seconds time elapsed                                          ( +-  0.13% )

That is, a 1.37% slowdown.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dad9b7796c..8491d36bcf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -260,7 +260,7 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 
     CPU_FOREACH(cpu) {
         if (cpu != src) {
-            async_run_on_cpu(cpu, fn, d);
+            async_run_on_cpu_no_bql(cpu, fn, d);
         }
     }
 }
@@ -336,8 +336,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
+        async_run_on_cpu_no_bql(cpu, tlb_flush_by_mmuidx_async_work,
+                                RUN_ON_CPU_HOST_INT(idxmap));
     } else {
         tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -481,8 +481,8 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
     addr_and_mmu_idx |= idxmap;
 
     if (!qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_work,
-                         RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_work,
+                                RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
     } else {
         tlb_flush_page_by_mmuidx_async_work(
             cpu, RUN_ON_CPU_TARGET_PTR(addr_and_mmu_idx));
-- 
2.17.1
