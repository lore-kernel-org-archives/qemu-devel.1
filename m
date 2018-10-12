Received: from eggs.gnu.org ([2001:4830:134:3::10]:35836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2ju-0002lW-GQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2jq-0003dG-Jb
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gB2jo-0003bA-CR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 12 Oct 2018 15:04:34 -0400
Message-Id: <20181012190434.19477-4-cota@braap.org>
In-Reply-To: <20181012190434.19477-1-cota@braap.org>
References: <20181012190434.19477-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 3/3] tcg/i386: enable dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

Note that "indirection" (i.e. the "cputlb: introduce indirection for TLB size"
patch in this series) incurs no overhead, on average.

To conclude, here is a different look at the SPEC06int results, using
linux-user as the baseline and comparing master and this series ("tlb-dyn"):

            Softmmu slowdown vs. linux-user for SPEC06int (test set)
                    [ Y axis: slowdown over linux-user ]
  14 +-+--+----+----+----+----+----+-----+----+----+----+----+----+----+--+-+
     |                                                                      |
     |                                                       master         |
  12 +-+...............+**..................................tlb-dyn.......+-+
     |                  **                                                  |
     |                  **                                                  |
     |                  **                                                  |
  10 +-+................**................................................+-+
     |                  **                                                  |
     |                  **                                                  |
   8 +-+................**................................................+-+
     |                  **                                                  |
     |                  **                                                  |
     |                  **                                                  |
   6 +-+................**................................................+-+
     |       ***        **                                                  |
     |       * *        **                                                  |
   4 +-+.....*.*........**.................................***............+-+
     |       * *        **                                 * *              |
     |       * *  +++   **             ***            ***  * *  ***  ***    |
     |       * *  +**++ **   **##      *+*#      ***  * *#+* *  * *##* *    |
   2 +-+.....*.*##.**##.**##.**.#.**##.*+*#.***#.*+*#.*.*#.*.*#+*.*.#*.*##+-+
     |++***##*+*+#+**+#+**+#+**+#+**+#+*+*#+*+*#+*+*#+*+*#+*+*#+*+*+#*+*+#++|
     |  * * #* * # ** # ** # ** # ** # * *# * *# * *# * *# * *# * * #* * #  |
   0 +-+***##***##-**##-**##-**##-**##-***#-***#-***#-***#-***#-***##***##+-+
      401.bzi403.g429445.g456.hm462.libq464.h471.omn4483.xalancbgeomean

png: https://imgur.com/a/eXkjMCE

After this series, we bring down the average softmmu overhead
from 2.77x to 1.80x, with a maximum slowdown of 2.48x (omnetpp).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 9e4bfa90d1..8b6475d786 100644
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
index 436195894b..5cbb07deab 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -330,6 +330,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
 #define OPC_ANDN        (0xf2 | P_EXT38)
 #define OPC_ADD_GvEv	(OPC_ARITH_GvEv | (ARITH_ADD << 3))
+#define OPC_AND_GvEv    (OPC_ARITH_GvEv | (ARITH_AND << 3))
 #define OPC_BLENDPS     (0x0c | P_EXT3A | P_DATA16)
 #define OPC_BSF         (0xbc | P_EXT)
 #define OPC_BSR         (0xbd | P_EXT)
@@ -1625,7 +1626,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
         }
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (TARGET_PAGE_BITS + CPU_TLB_BITS > 32) {
+            if (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
@@ -1633,6 +1634,15 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
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
@@ -1642,20 +1652,10 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
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
        path function argument setup.  There are two cases worth note:
@@ -1672,7 +1672,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
         /* cmp 4(r0), addrhi */
-        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, 4);
+        tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi, r0, which + 4);
 
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
@@ -1684,7 +1684,7 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 
     /* add addend(r0), r1 */
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r1, r0,
-                         offsetof(CPUTLBEntry, addend) - which);
+                         offsetof(CPUTLBEntry, addend));
 }
 
 /*
-- 
2.17.1
