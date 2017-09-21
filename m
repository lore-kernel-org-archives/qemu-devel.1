Received: from eggs.gnu.org ([2001:4830:134:3::10]:60487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XW-0003EG-Gy
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XO-00038x-4U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:26 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XN-00033w-Ds
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-0005AV-8d
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:28 +0100
Message-Id: <1506012099-13605-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/31] target/arm: Remove out of date ARM ARM
 section references in A64 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the A64 decoder, we have a lot of references to section numbers
from version A.a of the v8A ARM ARM (DDI0487). This version of the
document is now long obsolete (we are currently on revision B.a),
and various intervening versions renumbered all the sections.

The most recent B.a version of the document doesn't assign
section numbers at all to the individual instruction classes
in the way that the various A.x versions did. The simplest thing
to do is just to delete all the out of date C.x.x references.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20170915150849.23557-1-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 227 +++++++++++++++++++++++----------------------
 1 file changed, 114 insertions(+), 113 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 083568c..899ffb9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1203,12 +1203,14 @@ static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
 }
 
 /*
- * the instruction disassembly implemented here matches
- * the instruction encoding classifications in chapter 3 (C3)
- * of the ARM Architecture Reference Manual (DDI0487A_a)
+ * The instruction disassembly implemented here matches
+ * the instruction encoding classifications in chapter C4
+ * of the ARM Architecture Reference Manual (DDI0487B_a);
+ * classification names and decode diagrams here should generally
+ * match up with those in the manual.
  */
 
-/* C3.2.7 Unconditional branch (immediate)
+/* Unconditional branch (immediate)
  *   31  30       26 25                                  0
  * +----+-----------+-------------------------------------+
  * | op | 0 0 1 0 1 |                 imm26               |
@@ -1219,15 +1221,15 @@ static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
     uint64_t addr = s->pc + sextract32(insn, 0, 26) * 4 - 4;
 
     if (insn & (1U << 31)) {
-        /* C5.6.26 BL Branch with link */
+        /* BL Branch with link */
         tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
     }
 
-    /* C5.6.20 B Branch / C5.6.26 BL Branch with link */
+    /* B Branch / BL Branch with link */
     gen_goto_tb(s, 0, addr);
 }
 
-/* C3.2.1 Compare & branch (immediate)
+/* Compare and branch (immediate)
  *   31  30         25  24  23                  5 4      0
  * +----+-------------+----+---------------------+--------+
  * | sf | 0 1 1 0 1 0 | op |         imm19       |   Rt   |
@@ -1256,7 +1258,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
     gen_goto_tb(s, 1, addr);
 }
 
-/* C3.2.5 Test & branch (immediate)
+/* Test and branch (immediate)
  *   31  30         25  24  23   19 18          5 4    0
  * +----+-------------+----+-------+-------------+------+
  * | b5 | 0 1 1 0 1 1 | op |  b40  |    imm14    |  Rt  |
@@ -1285,7 +1287,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
     gen_goto_tb(s, 1, addr);
 }
 
-/* C3.2.2 / C5.6.19 Conditional branch (immediate)
+/* Conditional branch (immediate)
  *  31           25  24  23                  5   4  3    0
  * +---------------+----+---------------------+----+------+
  * | 0 1 0 1 0 1 0 | o1 |         imm19       | o0 | cond |
@@ -1316,7 +1318,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C5.6.68 HINT */
+/* HINT instruction group, including various allocated HINTs */
 static void handle_hint(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int crm)
 {
@@ -1401,7 +1403,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
     }
 }
 
-/* C5.6.130 MSR (immediate) - move immediate to processor state field */
+/* MSR (immediate) - move immediate to processor state field */
 static void handle_msr_i(DisasContext *s, uint32_t insn,
                          unsigned int op1, unsigned int op2, unsigned int crm)
 {
@@ -1477,10 +1479,10 @@ static void gen_set_nzcv(TCGv_i64 tcg_rt)
     tcg_temp_free_i32(nzcv);
 }
 
-/* C5.6.129 MRS - move from system register
- * C5.6.131 MSR (register) - move to system register
- * C5.6.204 SYS
- * C5.6.205 SYSL
+/* MRS - move from system register
+ * MSR (register) - move to system register
+ * SYS
+ * SYSL
  * These are all essentially the same insn in 'read' and 'write'
  * versions, with varying op0 fields.
  */
@@ -1603,7 +1605,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     }
 }
 
-/* C3.2.4 System
+/* System
  *  31                 22 21  20 19 18 16 15   12 11    8 7   5 4    0
  * +---------------------+---+-----+-----+-------+-------+-----+------+
  * | 1 1 0 1 0 1 0 1 0 0 | L | op0 | op1 |  CRn  |  CRm  | op2 |  Rt  |
@@ -1626,13 +1628,13 @@ static void disas_system(DisasContext *s, uint32_t insn)
             return;
         }
         switch (crn) {
-        case 2: /* C5.6.68 HINT */
+        case 2: /* HINT (including allocated hints like NOP, YIELD, etc) */
             handle_hint(s, insn, op1, op2, crm);
             break;
         case 3: /* CLREX, DSB, DMB, ISB */
             handle_sync(s, insn, op1, op2, crm);
             break;
-        case 4: /* C5.6.130 MSR (immediate) */
+        case 4: /* MSR (immediate) */
             handle_msr_i(s, insn, op1, op2, crm);
             break;
         default:
@@ -1644,7 +1646,7 @@ static void disas_system(DisasContext *s, uint32_t insn)
     handle_sys(s, insn, l, op0, op1, op2, crn, crm, rt);
 }
 
-/* C3.2.3 Exception generation
+/* Exception generation
  *
  *  31             24 23 21 20                     5 4   2 1  0
  * +-----------------+-----+------------------------+-----+----+
@@ -1751,7 +1753,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.2.7 Unconditional branch (register)
+/* Unconditional branch (register)
  *  31           25 24   21 20   16 15   10 9    5 4     0
  * +---------------+-------+-------+-------+------+-------+
  * | 1 1 0 1 0 1 1 |  opc  |  op2  |  op3  |  Rn  |  op4  |
@@ -1806,7 +1808,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     s->base.is_jmp = DISAS_JUMP;
 }
 
-/* C3.2 Branches, exception generating and system instructions */
+/* Branches, exception generating and system instructions */
 static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 7)) {
@@ -1966,7 +1968,7 @@ static bool disas_ldst_compute_iss_sf(int size, bool is_signed, int opc)
     return regsize == 64;
 }
 
-/* C3.3.6 Load/store exclusive
+/* Load/store exclusive
  *
  *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
  * +-----+-------------+----+---+----+------+----+-------+------+------+
@@ -2043,7 +2045,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.3.5 Load register (literal)
+ * Load register (literal)
  *
  *  31 30 29   27  26 25 24 23                5 4     0
  * +-----+-------+---+-----+-------------------+-------+
@@ -2099,15 +2101,15 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C5.6.80 LDNP (Load Pair - non-temporal hint)
- * C5.6.81 LDP (Load Pair - non vector)
- * C5.6.82 LDPSW (Load Pair Signed Word - non vector)
- * C5.6.176 STNP (Store Pair - non-temporal hint)
- * C5.6.177 STP (Store Pair - non vector)
- * C6.3.165 LDNP (Load Pair of SIMD&FP - non-temporal hint)
- * C6.3.165 LDP (Load Pair of SIMD&FP)
- * C6.3.284 STNP (Store Pair of SIMD&FP - non-temporal hint)
- * C6.3.284 STP (Store Pair of SIMD&FP)
+ * LDNP (Load Pair - non-temporal hint)
+ * LDP (Load Pair - non vector)
+ * LDPSW (Load Pair Signed Word - non vector)
+ * STNP (Store Pair - non-temporal hint)
+ * STP (Store Pair - non vector)
+ * LDNP (Load Pair of SIMD&FP - non-temporal hint)
+ * LDP (Load Pair of SIMD&FP)
+ * STNP (Store Pair of SIMD&FP - non-temporal hint)
+ * STP (Store Pair of SIMD&FP)
  *
  *  31 30 29   27  26  25 24   23  22 21   15 14   10 9    5 4    0
  * +-----+-------+---+---+-------+---+-----------------------------+
@@ -2253,9 +2255,9 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.3.8 Load/store (immediate post-indexed)
- * C3.3.9 Load/store (immediate pre-indexed)
- * C3.3.12 Load/store (unscaled immediate)
+ * Load/store (immediate post-indexed)
+ * Load/store (immediate pre-indexed)
+ * Load/store (unscaled immediate)
  *
  * 31 30 29   27  26 25 24 23 22 21  20    12 11 10 9    5 4    0
  * +----+-------+---+-----+-----+---+--------+-----+------+------+
@@ -2371,7 +2373,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
 }
 
 /*
- * C3.3.10 Load/store (register offset)
+ * Load/store (register offset)
  *
  * 31 30 29   27  26 25 24 23 22 21  20  16 15 13 12 11 10 9  5 4  0
  * +----+-------+---+-----+-----+---+------+-----+--+-----+----+----+
@@ -2468,7 +2470,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
 }
 
 /*
- * C3.3.13 Load/store (unsigned immediate)
+ * Load/store (unsigned immediate)
  *
  * 31 30 29   27  26 25 24 23 22 21        10 9     5
  * +----+-------+---+-----+-----+------------+-------+------+
@@ -2579,14 +2581,14 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.3.1 AdvSIMD load/store multiple structures
+/* AdvSIMD load/store multiple structures
  *
  *  31  30  29           23 22  21         16 15    12 11  10 9    5 4    0
  * +---+---+---------------+---+-------------+--------+------+------+------+
  * | 0 | Q | 0 0 1 1 0 0 0 | L | 0 0 0 0 0 0 | opcode | size |  Rn  |  Rt  |
  * +---+---+---------------+---+-------------+--------+------+------+------+
  *
- * C3.3.2 AdvSIMD load/store multiple structures (post-indexed)
+ * AdvSIMD load/store multiple structures (post-indexed)
  *
  *  31  30  29           23 22  21  20     16 15    12 11  10 9    5 4    0
  * +---+---+---------------+---+---+---------+--------+------+------+------+
@@ -2711,14 +2713,14 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_addr);
 }
 
-/* C3.3.3 AdvSIMD load/store single structure
+/* AdvSIMD load/store single structure
  *
  *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
  * +---+---+---------------+-----+-----------+-----+---+------+------+------+
  * | 0 | Q | 0 0 1 1 0 1 0 | L R | 0 0 0 0 0 | opc | S | size |  Rn  |  Rt  |
  * +---+---+---------------+-----+-----------+-----+---+------+------+------+
  *
- * C3.3.4 AdvSIMD load/store single structure (post-indexed)
+ * AdvSIMD load/store single structure (post-indexed)
  *
  *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
  * +---+---+---------------+-----+-----------+-----+---+------+------+------+
@@ -2861,7 +2863,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_addr);
 }
 
-/* C3.3 Loads and stores */
+/* Loads and stores */
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
@@ -2891,7 +2893,7 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.4.6 PC-rel. addressing
+/* PC-rel. addressing
  *   31  30   29 28       24 23                5 4    0
  * +----+-------+-----------+-------------------+------+
  * | op | immlo | 1 0 0 0 0 |       immhi       |  Rd  |
@@ -2920,7 +2922,7 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.4.1 Add/subtract (immediate)
+ * Add/subtract (immediate)
  *
  *  31 30 29 28       24 23 22 21         10 9   5 4   0
  * +--+--+--+-----------+-----+-------------+-----+-----+
@@ -3070,7 +3072,7 @@ static bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
     return true;
 }
 
-/* C3.4.4 Logical (immediate)
+/* Logical (immediate)
  *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
  * +----+-----+-------------+---+------+------+------+------+
  * | sf | opc | 1 0 0 1 0 0 | N | immr | imms |  Rn  |  Rd  |
@@ -3143,7 +3145,7 @@ static void disas_logic_imm(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.4.5 Move wide (immediate)
+ * Move wide (immediate)
  *
  *  31 30 29 28         23 22 21 20             5 4    0
  * +--+-----+-------------+-----+----------------+------+
@@ -3195,7 +3197,7 @@ static void disas_movw_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.4.2 Bitfield
+/* Bitfield
  *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
  * +----+-----+-------------+---+------+------+------+------+
  * | sf | opc | 1 0 0 1 1 0 | N | immr | imms |  Rn  |  Rd  |
@@ -3273,7 +3275,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.4.3 Extract
+/* Extract
  *   31  30  29 28         23 22   21  20  16 15    10 9    5 4    0
  * +----+------+-------------+---+----+------+--------+------+------+
  * | sf | op21 | 1 0 0 1 1 1 | N | o0 |  Rm  |  imms  |  Rn  |  Rd  |
@@ -3333,7 +3335,7 @@ static void disas_extract(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.4 Data processing - immediate */
+/* Data processing - immediate */
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
@@ -3427,7 +3429,7 @@ static void shift_reg_imm(TCGv_i64 dst, TCGv_i64 src, int sf,
     }
 }
 
-/* C3.5.10 Logical (shifted register)
+/* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
  * | sf | opc | 0 1 0 1 0 | shift | N |  Rm  |  imm6  |  Rn  |  Rd  |
@@ -3518,7 +3520,7 @@ static void disas_logic_reg(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.5.1 Add/subtract (extended register)
+ * Add/subtract (extended register)
  *
  *  31|30|29|28       24|23 22|21|20   16|15  13|12  10|9  5|4  0|
  * +--+--+--+-----------+-----+--+-------+------+------+----+----+
@@ -3591,7 +3593,7 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
 }
 
 /*
- * C3.5.2 Add/subtract (shifted register)
+ * Add/subtract (shifted register)
  *
  *  31 30 29 28       24 23 22 21 20   16 15     10 9    5 4    0
  * +--+--+--+-----------+-----+--+-------+---------+------+------+
@@ -3654,13 +3656,12 @@ static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_result);
 }
 
-/* C3.5.9 Data-processing (3 source)
-
-   31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
-  +--+------+-----------+------+------+----+------+------+------+
-  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
-  +--+------+-----------+------+------+----+------+------+------+
-
+/* Data-processing (3 source)
+ *
+ *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
+ *  +--+------+-----------+------+------+----+------+------+------+
+ *  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
+ *  +--+------+-----------+------+------+----+------+------+------+
  */
 static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
 {
@@ -3753,7 +3754,7 @@ static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_tmp);
 }
 
-/* C3.5.3 - Add/subtract (with carry)
+/* Add/subtract (with carry)
  *  31 30 29 28 27 26 25 24 23 22 21  20  16  15   10  9    5 4   0
  * +--+--+--+------------------------+------+---------+------+-----+
  * |sf|op| S| 1  1  0  1  0  0  0  0 |  rm  | opcode2 |  Rn  |  Rd |
@@ -3795,7 +3796,7 @@ static void disas_adc_sbc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.5.4 - C3.5.5 Conditional compare (immediate / register)
+/* Conditional compare (immediate / register)
  *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
  * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
  * |sf|op| S| 1  1  0  1  0  0  1  0 |imm5/rm | cond |i/r |o2|  Rn  |o3|nzcv |
@@ -3900,7 +3901,7 @@ static void disas_cc(DisasContext *s, uint32_t insn)
     tcg_temp_free_i32(tcg_t2);
 }
 
-/* C3.5.6 Conditional select
+/* Conditional select
  *   31   30  29  28             21 20  16 15  12 11 10 9    5 4    0
  * +----+----+---+-----------------+------+------+-----+------+------+
  * | sf | op | S | 1 1 0 1 0 1 0 0 |  Rm  | cond | op2 |  Rn  |  Rd  |
@@ -4011,7 +4012,7 @@ static void handle_rbit(DisasContext *s, unsigned int sf,
     }
 }
 
-/* C5.6.149 REV with sf==1, opcode==3 ("REV64") */
+/* REV with sf==1, opcode==3 ("REV64") */
 static void handle_rev64(DisasContext *s, unsigned int sf,
                          unsigned int rn, unsigned int rd)
 {
@@ -4022,8 +4023,8 @@ static void handle_rev64(DisasContext *s, unsigned int sf,
     tcg_gen_bswap64_i64(cpu_reg(s, rd), cpu_reg(s, rn));
 }
 
-/* C5.6.149 REV with sf==0, opcode==2
- * C5.6.151 REV32 (sf==1, opcode==2)
+/* REV with sf==0, opcode==2
+ * REV32 (sf==1, opcode==2)
  */
 static void handle_rev32(DisasContext *s, unsigned int sf,
                          unsigned int rn, unsigned int rd)
@@ -4048,7 +4049,7 @@ static void handle_rev32(DisasContext *s, unsigned int sf,
     }
 }
 
-/* C5.6.150 REV16 (opcode==1) */
+/* REV16 (opcode==1) */
 static void handle_rev16(DisasContext *s, unsigned int sf,
                          unsigned int rn, unsigned int rd)
 {
@@ -4067,7 +4068,7 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     tcg_temp_free_i64(tcg_tmp);
 }
 
-/* C3.5.7 Data-processing (1 source)
+/* Data-processing (1 source)
  *   31  30  29  28             21 20     16 15    10 9    5 4    0
  * +----+---+---+-----------------+---------+--------+------+------+
  * | sf | 1 | S | 1 1 0 1 0 1 1 0 | opcode2 | opcode |  Rn  |  Rd  |
@@ -4136,7 +4137,7 @@ static void handle_div(DisasContext *s, bool is_signed, unsigned int sf,
     }
 }
 
-/* C5.6.115 LSLV, C5.6.118 LSRV, C5.6.17 ASRV, C5.6.154 RORV */
+/* LSLV, LSRV, ASRV, RORV */
 static void handle_shift_reg(DisasContext *s,
                              enum a64_shift_type shift_type, unsigned int sf,
                              unsigned int rm, unsigned int rn, unsigned int rd)
@@ -4198,7 +4199,7 @@ static void handle_crc32(DisasContext *s,
     tcg_temp_free_i32(tcg_bytes);
 }
 
-/* C3.5.8 Data-processing (2 source)
+/* Data-processing (2 source)
  *   31   30  29 28             21 20  16 15    10 9    5 4    0
  * +----+---+---+-----------------+------+--------+------+------+
  * | sf | 0 | S | 1 1 0 1 0 1 1 0 |  Rm  | opcode |  Rn  |  Rd  |
@@ -4257,7 +4258,7 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.5 Data processing - register */
+/* Data processing - register */
 static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 5)) {
@@ -4351,7 +4352,7 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
     tcg_temp_free_i64(tcg_flags);
 }
 
-/* C3.6.22 Floating point compare
+/* Floating point compare
  *   31  30  29 28       24 23  22  21 20  16 15 14 13  10    9    5 4     0
  * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | op  | 1 0 0 0 |  Rn  |  op2  |
@@ -4381,7 +4382,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
     handle_fp_compare(s, type, rn, rm, opc & 1, opc & 2);
 }
 
-/* C3.6.23 Floating point conditional compare
+/* Floating point conditional compare
  *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5  4   3    0
  * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 0 1 |  Rn  | op | nzcv |
@@ -4429,7 +4430,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.24 Floating point conditional select
+/* Floating point conditional select
  *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+------+-----+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 1 1 |  Rn  |  Rd  |
@@ -4476,7 +4477,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(t_true);
 }
 
-/* C3.6.25 Floating-point data-processing (1 source) - single precision */
+/* Floating-point data-processing (1 source) - single precision */
 static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 {
     TCGv_ptr fpst;
@@ -4532,7 +4533,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_temp_free_i32(tcg_res);
 }
 
-/* C3.6.25 Floating-point data-processing (1 source) - double precision */
+/* Floating-point data-processing (1 source) - double precision */
 static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 {
     TCGv_ptr fpst;
@@ -4654,7 +4655,7 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
     }
 }
 
-/* C3.6.25 Floating point data-processing (1 source)
+/* Floating point data-processing (1 source)
  *   31  30  29 28       24 23  22  21 20    15 14       10 9    5 4    0
  * +---+---+---+-----------+------+---+--------+-----------+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 | opcode | 1 0 0 0 0 |  Rn  |  Rd  |
@@ -4712,7 +4713,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.26 Floating-point data-processing (2 source) - single precision */
+/* Floating-point data-processing (2 source) - single precision */
 static void handle_fp_2src_single(DisasContext *s, int opcode,
                                   int rd, int rn, int rm)
 {
@@ -4765,7 +4766,7 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     tcg_temp_free_i32(tcg_res);
 }
 
-/* C3.6.26 Floating-point data-processing (2 source) - double precision */
+/* Floating-point data-processing (2 source) - double precision */
 static void handle_fp_2src_double(DisasContext *s, int opcode,
                                   int rd, int rn, int rm)
 {
@@ -4818,7 +4819,7 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     tcg_temp_free_i64(tcg_res);
 }
 
-/* C3.6.26 Floating point data-processing (2 source)
+/* Floating point data-processing (2 source)
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | opcode | 1 0 |  Rn  |  Rd  |
@@ -4855,7 +4856,7 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.27 Floating-point data-processing (3 source) - single precision */
+/* Floating-point data-processing (3 source) - single precision */
 static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
                                   int rd, int rn, int rm, int ra)
 {
@@ -4893,7 +4894,7 @@ static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
     tcg_temp_free_i32(tcg_res);
 }
 
-/* C3.6.27 Floating-point data-processing (3 source) - double precision */
+/* Floating-point data-processing (3 source) - double precision */
 static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
                                   int rd, int rn, int rm, int ra)
 {
@@ -4931,7 +4932,7 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
     tcg_temp_free_i64(tcg_res);
 }
 
-/* C3.6.27 Floating point data-processing (3 source)
+/* Floating point data-processing (3 source)
  *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
  * +---+---+---+-----------+------+----+------+----+------+------+------+
  * | M | 0 | S | 1 1 1 1 1 | type | o1 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
@@ -4965,7 +4966,7 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.28 Floating point immediate
+/* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
  * | M | 0 | S | 1 1 1 1 0 | type | 1 |    imm8    | 1 0 0 | imm5 |  Rd  |
@@ -5136,7 +5137,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
     tcg_temp_free_i32(tcg_shift);
 }
 
-/* C3.6.29 Floating point <-> fixed point conversions
+/* Floating point <-> fixed point conversions
  *   31   30  29 28       24 23  22  21 20   19 18    16 15   10 9    5 4    0
  * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
  * | sf | 0 | S | 1 1 1 1 0 | type | 0 | rmode | opcode | scale |  Rn  |  Rd  |
@@ -5236,7 +5237,7 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
     }
 }
 
-/* C3.6.30 Floating point <-> integer conversions
+/* Floating point <-> integer conversions
  *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
  * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
  * | sf | 0 | S | 1 1 1 1 0 | type | 1 | rmode | opc | 0 0 0 0 0 0 | Rn | Rd |
@@ -5371,7 +5372,7 @@ static void do_ext64(DisasContext *s, TCGv_i64 tcg_left, TCGv_i64 tcg_right,
     tcg_temp_free_i64(tcg_tmp);
 }
 
-/* C3.6.1 EXT
+/* EXT
  *   31  30 29         24 23 22  21 20  16 15  14  11 10  9    5 4    0
  * +---+---+-------------+-----+---+------+---+------+---+------+------+
  * | 0 | Q | 1 0 1 1 1 0 | op2 | 0 |  Rm  | 0 | imm4 | 0 |  Rn  |  Rd  |
@@ -5444,7 +5445,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resh);
 }
 
-/* C3.6.2 TBL/TBX
+/* TBL/TBX
  *   31  30 29         24 23 22  21 20  16 15  14 13  12  11 10 9    5 4    0
  * +---+---+-------------+-----+---+------+---+-----+----+-----+------+------+
  * | 0 | Q | 0 0 1 1 1 0 | op2 | 0 |  Rm  | 0 | len | op | 0 0 |  Rn  |  Rd  |
@@ -5512,7 +5513,7 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_resh);
 }
 
-/* C3.6.3 ZIP/UZP/TRN
+/* ZIP/UZP/TRN
  *   31  30 29         24 23  22  21 20   16 15 14 12 11 10 9    5 4    0
  * +---+---+-------------+------+---+------+---+------------------+------+
  * | 0 | Q | 0 0 1 1 1 0 | size | 0 |  Rm  | 0 | opc | 1 0 |  Rn  |  Rd  |
@@ -5624,7 +5625,7 @@ static void do_minmaxop(DisasContext *s, TCGv_i32 tcg_elt1, TCGv_i32 tcg_elt2,
     }
 }
 
-/* C3.6.4 AdvSIMD across lanes
+/* AdvSIMD across lanes
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
@@ -5791,7 +5792,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_res);
 }
 
-/* C6.3.31 DUP (Element, Vector)
+/* DUP (Element, Vector)
  *
  *  31  30   29              21 20    16 15        10  9    5 4    0
  * +---+---+-------------------+--------+-------------+------+------+
@@ -5834,7 +5835,7 @@ static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
     tcg_temp_free_i64(tmp);
 }
 
-/* C6.3.31 DUP (element, scalar)
+/* DUP (element, scalar)
  *  31                   21 20    16 15        10  9    5 4    0
  * +-----------------------+--------+-------------+------+------+
  * | 0 1 0 1 1 1 1 0 0 0 0 |  imm5  | 0 0 0 0 0 1 |  Rn  |  Rd  |
@@ -5867,7 +5868,7 @@ static void handle_simd_dupes(DisasContext *s, int rd, int rn,
     tcg_temp_free_i64(tmp);
 }
 
-/* C6.3.32 DUP (General)
+/* DUP (General)
  *
  *  31  30   29              21 20    16 15        10  9    5 4    0
  * +---+---+-------------------+--------+-------------+------+------+
@@ -5901,7 +5902,7 @@ static void handle_simd_dupg(DisasContext *s, int is_q, int rd, int rn,
     }
 }
 
-/* C6.3.150 INS (Element)
+/* INS (Element)
  *
  *  31                   21 20    16 15  14    11  10 9    5 4    0
  * +-----------------------+--------+------------+---+------+------+
@@ -5939,7 +5940,7 @@ static void handle_simd_inse(DisasContext *s, int rd, int rn,
 }
 
 
-/* C6.3.151 INS (General)
+/* INS (General)
  *
  *  31                   21 20    16 15        10  9    5 4    0
  * +-----------------------+--------+-------------+------+------+
@@ -5968,8 +5969,8 @@ static void handle_simd_insg(DisasContext *s, int rd, int rn, int imm5)
 }
 
 /*
- * C6.3.321 UMOV (General)
- * C6.3.237 SMOV (General)
+ * UMOV (General)
+ * SMOV (General)
  *
  *  31  30   29              21 20    16 15    12   10 9    5 4    0
  * +---+---+-------------------+--------+-------------+------+------+
@@ -6014,7 +6015,7 @@ static void handle_simd_umov_smov(DisasContext *s, int is_q, int is_signed,
     }
 }
 
-/* C3.6.5 AdvSIMD copy
+/* AdvSIMD copy
  *   31  30  29  28             21 20  16 15  14  11 10  9    5 4    0
  * +---+---+----+-----------------+------+---+------+---+------+------+
  * | 0 | Q | op | 0 1 1 1 0 0 0 0 | imm5 | 0 | imm4 | 1 |  Rn  |  Rd  |
@@ -6066,7 +6067,7 @@ static void disas_simd_copy(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.6 AdvSIMD modified immediate
+/* AdvSIMD modified immediate
  *  31  30   29  28                 19 18 16 15   12  11  10  9     5 4    0
  * +---+---+----+---------------------+-----+-------+----+---+-------+------+
  * | 0 | Q | op | 0 1 1 1 1 0 0 0 0 0 | abc | cmode | o2 | 1 | defgh |  Rd  |
@@ -6199,7 +6200,7 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     tcg_temp_free_i64(tcg_imm);
 }
 
-/* C3.6.7 AdvSIMD scalar copy
+/* AdvSIMD scalar copy
  *  31 30  29  28             21 20  16 15  14  11 10  9    5 4    0
  * +-----+----+-----------------+------+---+------+---+------+------+
  * | 0 1 | op | 1 1 1 1 0 0 0 0 | imm5 | 0 | imm4 | 1 |  Rn  |  Rd  |
@@ -6222,7 +6223,7 @@ static void disas_simd_scalar_copy(DisasContext *s, uint32_t insn)
     handle_simd_dupes(s, rd, rn, imm5);
 }
 
-/* C3.6.8 AdvSIMD scalar pairwise
+/* AdvSIMD scalar pairwise
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
@@ -6948,7 +6949,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     tcg_temp_free_i32(tcg_rmode);
 }
 
-/* C3.6.9 AdvSIMD scalar shift by immediate
+/* AdvSIMD scalar shift by immediate
  *  31 30  29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +-----+---+-------------+------+------+--------+---+------+------+
  * | 0 1 | U | 1 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
@@ -7023,7 +7024,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.10 AdvSIMD scalar three different
+/* AdvSIMD scalar three different
  *  31 30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+-----+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
@@ -7410,7 +7411,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
     }
 }
 
-/* C3.6.11 AdvSIMD scalar three same
+/* AdvSIMD scalar three same
  *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+---+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
@@ -8079,7 +8080,7 @@ static void handle_2misc_satacc(DisasContext *s, bool is_scalar, bool is_u,
     }
 }
 
-/* C3.6.12 AdvSIMD scalar two reg misc
+/* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 1 | U | 1 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
@@ -8507,7 +8508,7 @@ static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
 }
 
 
-/* C3.6.14 AdvSIMD shift by immediate
+/* AdvSIMD shift by immediate
  *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +---+---+---+-------------+------+------+--------+---+------+------+
  * | 0 | Q | U | 0 1 1 1 1 0 | immh | immb | opcode | 1 |  Rn  |  Rd  |
@@ -8926,7 +8927,7 @@ static void handle_pmull_64(DisasContext *s, int is_q, int rd, int rn, int rm)
     tcg_temp_free_i64(tcg_res);
 }
 
-/* C3.6.15 AdvSIMD three different
+/* AdvSIMD three different
  *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
@@ -9663,7 +9664,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.16 AdvSIMD three same
+/* AdvSIMD three same
  *  31  30  29  28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +---+---+---+-----------+------+---+------+--------+---+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 1 |  Rn  |  Rd  |
@@ -9932,7 +9933,7 @@ static void handle_shll(DisasContext *s, bool is_q, int size, int rn, int rd)
     }
 }
 
-/* C3.6.17 AdvSIMD two reg misc
+/* AdvSIMD two reg misc
  *   31  30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +---+---+---+-----------+------+-----------+--------+-----+------+------+
  * | 0 | Q | U | 0 1 1 1 0 | size | 1 0 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
@@ -10444,12 +10445,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.13 AdvSIMD scalar x indexed element
+/* AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
  * | 0 1 | U | 1 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
- * C3.6.18 AdvSIMD vector x indexed element
+ * AdvSIMD vector x indexed element
  *   31  30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +---+---+---+-----------+------+---+---+------+-----+---+---+------+------+
  * | 0 | Q | U | 0 1 1 1 1 | size | L | M |  Rm  | opc | H | 0 |  Rn  |  Rd  |
@@ -10899,7 +10900,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* C3.6.19 Crypto AES
+/* Crypto AES
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
  * | 0 1 0 0 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
@@ -10962,7 +10963,7 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     tcg_temp_free_i32(tcg_decrypt);
 }
 
-/* C3.6.20 Crypto three-reg SHA
+/* Crypto three-reg SHA
  *  31             24 23  22  21 20  16  15 14    12 11 10 9    5 4    0
  * +-----------------+------+---+------+---+--------+-----+------+------+
  * | 0 1 0 1 1 1 1 0 | size | 0 |  Rm  | 0 | opcode | 0 0 |  Rn  |  Rd  |
@@ -11034,7 +11035,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     tcg_temp_free_i32(tcg_rm_regno);
 }
 
-/* C3.6.21 Crypto two-reg SHA
+/* Crypto two-reg SHA
  *  31             24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----------------+------+-----------+--------+-----+------+------+
  * | 0 1 0 1 1 1 1 0 | size | 1 0 1 0 0 | opcode | 1 0 |  Rn  |  Rd  |
-- 
2.7.4
