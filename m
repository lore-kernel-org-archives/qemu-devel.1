Received: from eggs.gnu.org ([209.51.188.92]:40898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSR-0005s4-EZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmRSL-00049O-Lw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:15 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmRSL-00048E-7x
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 17:57:13 -0500
Received: by mail-pf1-x442.google.com with SMTP id q1so1934850pfi.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:57:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 23 Jan 2019 14:56:55 -0800
Message-Id: <20190123225705.28963-4-richard.henderson@linaro.org>
In-Reply-To: <20190123225705.28963-1-richard.henderson@linaro.org>
References: <20190123225705.28963-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/13] tcg/i386: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

From: "Emilio G. Cota" <cota@braap.org>

As the following experiments show, this series is a net perf gain,
particularly for memory-heavy workloads. Experiments are run on an
Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

1. System boot + shudown, debian aarch64:

- Before (v3.1.0):
 Performance counter stats for './die.sh v3.1.0' (10 runs):

       9019.797015      task-clock (msec)         #    0.993 CPUs utilized            ( +-  0.23% )
    29,910,312,379      cycles                    #    3.316 GHz                      ( +-  0.14% )
    54,699,252,014      instructions              #    1.83  insn per cycle           ( +-  0.08% )
    10,061,951,686      branches                  # 1115.541 M/sec                    ( +-  0.08% )
       172,966,530      branch-misses             #    1.72% of all branches          ( +-  0.07% )

       9.084039051 seconds time elapsed                                          ( +-  0.23% )

- After:
 Performance counter stats for './die.sh tlb-dyn-v5' (10 runs):

       8624.084842      task-clock (msec)         #    0.993 CPUs utilized            ( +-  0.23% )
    28,556,123,404      cycles                    #    3.311 GHz                      ( +-  0.13% )
    51,755,089,512      instructions              #    1.81  insn per cycle           ( +-  0.05% )
     9,526,513,946      branches                  # 1104.641 M/sec                    ( +-  0.05% )
       166,578,509      branch-misses             #    1.75% of all branches          ( +-  0.19% )

       8.680540350 seconds time elapsed                                          ( +-  0.24% )

That is, a 4.4% perf increase.

2. System boot + shutdown, ubuntu 18.04 x86_64:

- Before (v3.1.0):
      56100.574751      task-clock (msec)         #    1.016 CPUs utilized            ( +-  4.81% )
   200,745,466,128      cycles                    #    3.578 GHz                      ( +-  5.24% )
   431,949,100,608      instructions              #    2.15  insn per cycle           ( +-  5.65% )
    77,502,383,330      branches                  # 1381.490 M/sec                    ( +-  6.18% )
       844,681,191      branch-misses             #    1.09% of all branches          ( +-  3.82% )

      55.221556378 seconds time elapsed                                          ( +-  5.01% )

- After:
      56603.419540      task-clock (msec)         #    1.019 CPUs utilized            ( +- 10.19% )
   202,217,930,479      cycles                    #    3.573 GHz                      ( +- 10.69% )
   439,336,291,626      instructions              #    2.17  insn per cycle           ( +- 14.14% )
    80,538,357,447      branches                  # 1422.853 M/sec                    ( +- 16.09% )
       776,321,622      branch-misses             #    0.96% of all branches          ( +-  3.77% )

      55.549661409 seconds time elapsed                                          ( +- 10.44% )

No improvement (within noise range). Note that for this workload,
increasing the time window too much can lead to perf degradation,
since it flushes the TLB *very* frequently.

3. x86_64 SPEC06int:

           x86_64-softmmu speedup vs. v3.1.0 for SPEC06int (test set)
            Host: Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (Skylake)

5.5 +------------------------------------------------------------------------+
    |                   +-+                                                  |
  5 |-+.................+-+...............................tlb-dyn-v5.......+-|
    |                   * *                                                  |
4.5 |-+.................*.*................................................+-|
    |                   * *                                                  |
  4 |-+.................*.*................................................+-|
    |                   * *                                                  |
3.5 |-+.................*.*................................................+-|
    |                   * *                                                  |
  3 |-+......+-+*.......*.*................................................+-|
    |        *  *       * *                                                  |
2.5 |-+......*..*.......*.*.................................+-+*...........+-|
    |        *  *       * *                                 *  *             |
  2 |-+......*..*.......*.*.................................*..*...........+-|
    |        *  *       * *                                 *  *  +-+        |
1.5 |-+......*..*.......*.*.................................*..*.*+-+.*+-+.+-|
    |        *  * *+-+  * *  +-+       *+-+  +-+       +-+  *  * *  * *  *   |
  1 |++++-+*+*++*+*++*++*+*++*+*+++-+*+*+-++*+-++++-++++-+++*++*+*++*+*++*+++|
    |   *  * *  * *  *  * *  * *  *  * *  * *  *  * *  * *  *  * *  * *  *   |
0.5 +------------------------------------------------------------------------+
  400.perlb401.bzip403.g429445.g456.hm462.libq464.h471.omn47483.xalancbgeomean
  png: https://imgur.com/YRF90f7

That is, a 1.51x average speedup over the baseline, with a max speedup
of 5.17x.

Here's a different look at the SPEC06int results, using KVM as the baseline:

             x86_64-softmmu slowdown vs. KVM for SPEC06int (test set)
             Host: Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (Skylake)

25 +---------------------------------------------------------------------------+
   |                   +-+                                        +-+          |
   |                   * *                             +-+      v3.1.0         |
   |                   * *                             +-+  tlb-dyn-v5         |
   |                   * *                             * *        +-+          |
20 |-+.................*.*.............................*.+-+......*.*........+-|
   |                   * *                             * # #      * *          |
   |        +-+        * *                             * # #      * *          |
   |        * *        * *                             * # #      * *          |
15 |-+......*.*........*.*.............................*.#.#......*.+-+......+-|
   |        * *        * *                             * # #      * #|#        |
   |        * *        * *        +-+                  * # #      * +-+        |
   |        * *  +-+   * *        ++-+       +-+       * # #      * # # +-+    |
   |        * *  +-+   * *        * ##       *|   +-+  * # #      * # # +-+    |
10 |-+......*.*..*.+-+.*.*........*.##.......++-+.*.+-+*.#.#......*.#.#.*.*..+-|
   |        * *  * +-+ * *        * ## +-+   *# # * # #* # # +-+  * # # * *    |
   |        * *  * # # * *  +-+   * ## * +-+ *# # * # #* # # * *  * # # *+-+   |
   |        * *  * # # * *  * +-+ * ## * # # *# # * # #* # # * *  * # # * ##   |
 5 |-+......*.+-+*.#.#.*.*..*.#.#.*.##.*.#.#.*#.#.*.#.#*.#.#.*.*..*.#.#.*.##.+-|
   |        * # #* # # * +-+* # # * ## * # # *# # * # #* # # * *  * # # * ##   |
   |        * # #* # # * # #* # # * ## * # # *# # * # #* # # * +-+* # # * ##   |
   |   ++-+ * # #* # # * # #* # # * ## * # # *# # * # #* # # * # #* # # * ##   |
   |+++*#+#+*+#+#*+#+#+*+#+#*+#+#+*+##+*+#+#+*#+#+*+#+#*+#+#+*+#+#*+#+#+*+##+++|
 0 +---------------------------------------------------------------------------+
 400.perlbe401.bzi403.gc429445.go456.h462.libqu464.h471.omne4483.xalancbmgeomean
  png: https://imgur.com/YzAMNEV

After this series, we bring down the average SPEC06int slowdown vs KVM
from 11.47x to 7.58x.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20190116170114.26802-4-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 94aa4cef7c..eb40312e67 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -27,7 +27,7 @@
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
-#define TCG_TARGET_IMPLEMENTS_DYN_TLB 0
+#define TCG_TARGET_IMPLEMENTS_DYN_TLB 1
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index dbf8253718..4d84aea3a9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -329,6 +329,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_AND_GvEv    (OPC_ARITH_GvEv | (ARITH_AND << 3))
 #define OPC_BLENDPS     (0x0c | P_EXT3A | P_DATA16)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
@@ -1641,7 +1642,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         }
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (TARGET_PAGE_BITS + CPU_TLB_BITS > 32) {
+            if (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
@@ -1649,6 +1650,15 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
     }
 
     tcg_out_mov(s, tlbtype, r0, addrlo);
+    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, r0,
+                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+
+    tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, r0, TCG_AREG0,
+                         offsetof(CPUArchState, tlb_mask[mem_index]));
+
+    tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r0, TCG_AREG0,
+                         offsetof(CPUArchState, tlb_table[mem_index]));
+
     /* If the required alignment is at least as large as the access, simply
        copy the address and mask.  For lesser alignments, check that we don't
        cross pages for the complete access.  */
@@ -1658,20 +1668,10 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         tcg_out_modrm_offset(s, OPC_LEA + trexw, r1, addrlo, s_mask - a_mask);
     }
     tlb_mask = (target_ulong)TARGET_PAGE_MASK | a_mask;
-
-    tcg_out_shifti(s, SHIFT_SHR + tlbrexw, r0,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
-
     tgen_arithi(s, ARITH_AND + trexw, r1, tlb_mask, 0);
-    tgen_arithi(s, ARITH_AND + tlbrexw, r0,
-                (CPU_TLB_SIZE - 1) << CPU_TLB_ENTRY_BITS, 0);
-
-    tcg_out_modrm_sib_offset(s, OPC_LEA + hrexw, r0, TCG_AREG0, r0, 0,
-                             offsetof(CPUArchState, tlb_table[mem_index][0])
-                             + which);
 
     /* cmp 0(r0), r1 */
-    tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw, r1, r0, 0);
+    tcg_out_modrm_offset(s, OPC_CMP_GvEv + trexw, r1, r0, which);
 
     /* Prepare for both the fast path add of the tlb addend, and the slow
        path function argument setup.  */
@@ -1684,7 +1684,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         /* cmp 4(r0), addrhi */
-        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, 4);
+        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, which + 4);
 
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
@@ -1696,7 +1696,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
-                         offsetof(CPUTLBEntry, addend) - which);
+                         offsetof(CPUTLBEntry, addend));
 }
 
 /*
-- 
2.17.2
