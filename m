Received: from eggs.gnu.org ([2001:4830:134:3::10]:55254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVu-0006VE-ST
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVs-0005WJ-TQ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:55 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVs-0005VJ-L1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:52 -0500
Received: by mail-pg0-x241.google.com with SMTP id i5so2479605pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:52 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:51 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:47 -0800
Message-Id: <20161224040042.12654-11-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 10/65] tcg/s390: Expose host facilities to
 tcg-target.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This lets us expose facilities to TCG_TARGET_HAS_* defines
directly, rather than hiding behind function calls.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.h     | 126 ++++++++++++++++++++++++----------------------
 tcg/s390/tcg-target.inc.c |  74 +++++++++++----------------
 2 files changed, 96 insertions(+), 104 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 9583df4..d650a72 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -49,67 +49,75 @@ typedef enum TCGReg {
 
 #define TCG_TARGET_NB_REGS 16
 
-/* optional instructions */
-#define TCG_TARGET_HAS_div2_i32         1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          0
-#define TCG_TARGET_HAS_neg_i32          1
-#define TCG_TARGET_HAS_andc_i32         0
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+/* A list of relevant facilities used by this translator.  Some of these
+   are required for proper operation, and these are checked at startup.  */
+
+#define FACILITY_ZARCH_ACTIVE         (1ULL << (63 - 2))
+#define FACILITY_LONG_DISP            (1ULL << (63 - 18))
+#define FACILITY_EXT_IMM              (1ULL << (63 - 21))
+#define FACILITY_GEN_INST_EXT         (1ULL << (63 - 34))
+#define FACILITY_LOAD_ON_COND         (1ULL << (63 - 45))
+#define FACILITY_FAST_BCR_SER         FACILITY_LOAD_ON_COND
 
-#define TCG_TARGET_HAS_div2_i64         1
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_neg_i64          1
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_movcond_i64      1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        1
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
+extern uint64_t s390_facilities;
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div2_i32       1
+#define TCG_TARGET_HAS_rot_i32        1
+#define TCG_TARGET_HAS_ext8s_i32      1
+#define TCG_TARGET_HAS_ext16s_i32     1
+#define TCG_TARGET_HAS_ext8u_i32      1
+#define TCG_TARGET_HAS_ext16u_i32     1
+#define TCG_TARGET_HAS_bswap16_i32    1
+#define TCG_TARGET_HAS_bswap32_i32    1
+#define TCG_TARGET_HAS_not_i32        0
+#define TCG_TARGET_HAS_neg_i32        1
+#define TCG_TARGET_HAS_andc_i32       0
+#define TCG_TARGET_HAS_orc_i32        0
+#define TCG_TARGET_HAS_eqv_i32        0
+#define TCG_TARGET_HAS_nand_i32       0
+#define TCG_TARGET_HAS_nor_i32        0
+#define TCG_TARGET_HAS_deposit_i32    (s390_facilities & FACILITY_GEN_INST_EXT)
+#define TCG_TARGET_HAS_extract_i32    0
+#define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_movcond_i32    1
+#define TCG_TARGET_HAS_add2_i32       1
+#define TCG_TARGET_HAS_sub2_i32       1
+#define TCG_TARGET_HAS_mulu2_i32      0
+#define TCG_TARGET_HAS_muls2_i32      0
+#define TCG_TARGET_HAS_muluh_i32      0
+#define TCG_TARGET_HAS_mulsh_i32      0
+#define TCG_TARGET_HAS_extrl_i64_i32  0
+#define TCG_TARGET_HAS_extrh_i64_i32  0
 
-extern bool tcg_target_deposit_valid(int ofs, int len);
-#define TCG_TARGET_deposit_i32_valid  tcg_target_deposit_valid
-#define TCG_TARGET_deposit_i64_valid  tcg_target_deposit_valid
+#define TCG_TARGET_HAS_div2_i64       1
+#define TCG_TARGET_HAS_rot_i64        1
+#define TCG_TARGET_HAS_ext8s_i64      1
+#define TCG_TARGET_HAS_ext16s_i64     1
+#define TCG_TARGET_HAS_ext32s_i64     1
+#define TCG_TARGET_HAS_ext8u_i64      1
+#define TCG_TARGET_HAS_ext16u_i64     1
+#define TCG_TARGET_HAS_ext32u_i64     1
+#define TCG_TARGET_HAS_bswap16_i64    1
+#define TCG_TARGET_HAS_bswap32_i64    1
+#define TCG_TARGET_HAS_bswap64_i64    1
+#define TCG_TARGET_HAS_not_i64        0
+#define TCG_TARGET_HAS_neg_i64        1
+#define TCG_TARGET_HAS_andc_i64       0
+#define TCG_TARGET_HAS_orc_i64        0
+#define TCG_TARGET_HAS_eqv_i64        0
+#define TCG_TARGET_HAS_nand_i64       0
+#define TCG_TARGET_HAS_nor_i64        0
+#define TCG_TARGET_HAS_deposit_i64    (s390_facilities & FACILITY_GEN_INST_EXT)
+#define TCG_TARGET_HAS_extract_i64    0
+#define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_movcond_i64    1
+#define TCG_TARGET_HAS_add2_i64       1
+#define TCG_TARGET_HAS_sub2_i64       1
+#define TCG_TARGET_HAS_mulu2_i64      1
+#define TCG_TARGET_HAS_muls2_i64      0
+#define TCG_TARGET_HAS_muluh_i64      0
+#define TCG_TARGET_HAS_mulsh_i64      0
 
 /* used for function call generation */
 #define TCG_REG_CALL_STACK		TCG_REG_R15
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 253d4a0..9f51133 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -334,18 +334,7 @@ static void * const qemu_st_helpers[16] = {
 #endif
 
 static tcg_insn_unit *tb_ret_addr;
-
-/* A list of relevant facilities used by this translator.  Some of these
-   are required for proper operation, and these are checked at startup.  */
-
-#define FACILITY_ZARCH_ACTIVE	(1ULL << (63 - 2))
-#define FACILITY_LONG_DISP	(1ULL << (63 - 18))
-#define FACILITY_EXT_IMM	(1ULL << (63 - 21))
-#define FACILITY_GEN_INST_EXT	(1ULL << (63 - 34))
-#define FACILITY_LOAD_ON_COND   (1ULL << (63 - 45))
-#define FACILITY_FAST_BCR_SER   FACILITY_LOAD_ON_COND
-
-static uint64_t facilities;
+uint64_t s390_facilities;
 
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
@@ -432,7 +421,7 @@ static int target_parse_constraint(TCGArgConstraint *ct, const char **pct_str)
 
 static int tcg_match_ori(TCGType type, tcg_target_long val)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         if (type == TCG_TYPE_I32) {
             /* All 32-bit ORs can be performed with 1 48-bit insn.  */
             return 1;
@@ -444,7 +433,7 @@ static int tcg_match_ori(TCGType type, tcg_target_long val)
         if (val == (int16_t)val) {
             return 0;
         }
-        if (facilities & FACILITY_EXT_IMM) {
+        if (s390_facilities & FACILITY_EXT_IMM) {
             if (val == (int32_t)val) {
                 return 0;
             }
@@ -461,7 +450,7 @@ static int tcg_match_ori(TCGType type, tcg_target_long val)
 
 static int tcg_match_xori(TCGType type, tcg_target_long val)
 {
-    if ((facilities & FACILITY_EXT_IMM) == 0) {
+    if ((s390_facilities & FACILITY_EXT_IMM) == 0) {
         return 0;
     }
 
@@ -482,7 +471,7 @@ static int tcg_match_xori(TCGType type, tcg_target_long val)
 
 static int tcg_match_cmpi(TCGType type, tcg_target_long val)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         /* The COMPARE IMMEDIATE instruction is available.  */
         if (type == TCG_TYPE_I32) {
             /* We have a 32-bit immediate and can compare against anything.  */
@@ -511,7 +500,7 @@ static int tcg_match_cmpi(TCGType type, tcg_target_long val)
 
 static int tcg_match_add2i(TCGType type, tcg_target_long val)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         if (type == TCG_TYPE_I32) {
             return 1;
         } else if (val >= -0xffffffffll && val <= 0xffffffffll) {
@@ -541,7 +530,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
            general-instruction-extensions, then we have MULTIPLY SINGLE
            IMMEDIATE with a signed 32-bit, otherwise we have only
            MULTIPLY HALFWORD IMMEDIATE, with a signed 16-bit.  */
-        if (facilities & FACILITY_GEN_INST_EXT) {
+        if (s390_facilities & FACILITY_GEN_INST_EXT) {
             return val == (int32_t)val;
         } else {
             return val == (int16_t)val;
@@ -668,7 +657,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 
     /* Try all 48-bit insns that can load it in one go.  */
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         if (sval == (int32_t)sval) {
             tcg_out_insn(s, RIL, LGFI, ret, sval);
             return;
@@ -694,7 +683,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 
     /* If extended immediates are not present, then we may have to issue
        several instructions to load the low 32 bits.  */
-    if (!(facilities & FACILITY_EXT_IMM)) {
+    if (!(s390_facilities & FACILITY_EXT_IMM)) {
         /* A 32-bit unsigned value can be loaded in 2 insns.  And given
            that the lli_insns loop above did not succeed, we know that
            both insns are required.  */
@@ -727,7 +716,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 
     /* Insert data into the high 32-bits.  */
     uval = uval >> 31 >> 1;
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         if (uval < 0x10000) {
             tcg_out_insn(s, RI, IIHL, ret, uval);
         } else if ((uval & 0xffff) == 0) {
@@ -810,7 +799,7 @@ static void tcg_out_ld_abs(TCGContext *s, TCGType type, TCGReg dest, void *abs)
 {
     intptr_t addr = (intptr_t)abs;
 
-    if ((facilities & FACILITY_GEN_INST_EXT) && !(addr & 1)) {
+    if ((s390_facilities & FACILITY_GEN_INST_EXT) && !(addr & 1)) {
         ptrdiff_t disp = tcg_pcrel_diff(s, abs) >> 1;
         if (disp == (int32_t)disp) {
             if (type == TCG_TYPE_I32) {
@@ -837,7 +826,7 @@ static inline void tcg_out_risbg(TCGContext *s, TCGReg dest, TCGReg src,
 
 static void tgen_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         tcg_out_insn(s, RRE, LGBR, dest, src);
         return;
     }
@@ -857,7 +846,7 @@ static void tgen_ext8s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext8u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         tcg_out_insn(s, RRE, LLGCR, dest, src);
         return;
     }
@@ -877,7 +866,7 @@ static void tgen_ext8u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext16s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         tcg_out_insn(s, RRE, LGHR, dest, src);
         return;
     }
@@ -897,7 +886,7 @@ static void tgen_ext16s(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 
 static void tgen_ext16u(TCGContext *s, TCGType type, TCGReg dest, TCGReg src)
 {
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         tcg_out_insn(s, RRE, LLGHR, dest, src);
         return;
     }
@@ -985,7 +974,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
         tgen_ext32u(s, dest, dest);
         return;
     }
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         if ((val & valid) == 0xff) {
             tgen_ext8u(s, TCG_TYPE_I64, dest, dest);
             return;
@@ -1006,7 +995,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
     }
 
     /* Try all 48-bit insns that can perform it in one go.  */
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         for (i = 0; i < 2; i++) {
             tcg_target_ulong mask = ~(0xffffffffull << i*32);
             if (((val | ~valid) & mask) == mask) {
@@ -1015,7 +1004,7 @@ static void tgen_andi(TCGContext *s, TCGType type, TCGReg dest, uint64_t val)
             }
         }
     }
-    if ((facilities & FACILITY_GEN_INST_EXT) && risbg_mask(val)) {
+    if ((s390_facilities & FACILITY_GEN_INST_EXT) && risbg_mask(val)) {
         tgen_andi_risbg(s, dest, dest, val);
         return;
     }
@@ -1045,7 +1034,7 @@ static void tgen64_ori(TCGContext *s, TCGReg dest, tcg_target_ulong val)
         return;
     }
 
-    if (facilities & FACILITY_EXT_IMM) {
+    if (s390_facilities & FACILITY_EXT_IMM) {
         /* Try all 32-bit insns that can perform it in one go.  */
         for (i = 0; i < 4; i++) {
             tcg_target_ulong mask = (0xffffull << i*16);
@@ -1220,7 +1209,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 
     cc = tgen_cmp(s, type, cond, c1, c2, c2const);
-    if (facilities & FACILITY_LOAD_ON_COND) {
+    if (s390_facilities & FACILITY_LOAD_ON_COND) {
         /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
         tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
         tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
@@ -1237,7 +1226,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
                          TCGReg c1, TCGArg c2, int c2const, TCGReg r3)
 {
     int cc;
-    if (facilities & FACILITY_LOAD_ON_COND) {
+    if (s390_facilities & FACILITY_LOAD_ON_COND) {
         cc = tgen_cmp(s, type, c, c1, c2, c2const);
         tcg_out_insn(s, RRF, LOCGR, dest, r3, cc);
     } else {
@@ -1250,11 +1239,6 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
     }
 }
 
-bool tcg_target_deposit_valid(int ofs, int len)
-{
-    return (facilities & FACILITY_GEN_INST_EXT) != 0;
-}
-
 static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len)
 {
@@ -1332,7 +1316,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
 {
     int cc;
 
-    if (facilities & FACILITY_GEN_INST_EXT) {
+    if (s390_facilities & FACILITY_GEN_INST_EXT) {
         bool is_unsigned = is_unsigned_cond(c);
         bool in_range;
         S390Opcode opc;
@@ -1519,7 +1503,7 @@ static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp opc,
     a_off = (a_bits >= s_bits ? 0 : s_mask - a_mask);
     tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
 
-    if (facilities & FACILITY_GEN_INST_EXT) {
+    if (s390_facilities & FACILITY_GEN_INST_EXT) {
         tcg_out_risbg(s, TCG_REG_R2, addr_reg,
                       64 - CPU_TLB_BITS - CPU_TLB_ENTRY_BITS,
                       63 - CPU_TLB_ENTRY_BITS,
@@ -1790,7 +1774,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                     tcg_out_insn(s, RI, AHI, a0, a2);
                     break;
                 }
-                if (facilities & FACILITY_EXT_IMM) {
+                if (s390_facilities & FACILITY_EXT_IMM) {
                     tcg_out_insn(s, RIL, AFI, a0, a2);
                     break;
                 }
@@ -1986,7 +1970,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                     tcg_out_insn(s, RI, AGHI, a0, a2);
                     break;
                 }
-                if (facilities & FACILITY_EXT_IMM) {
+                if (s390_facilities & FACILITY_EXT_IMM) {
                     if (a2 == (int32_t)a2) {
                         tcg_out_insn(s, RIL, AGFI, a0, a2);
                         break;
@@ -2175,7 +2159,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
            serialize the instruction stream.  */
         if (args[0] & TCG_MO_ST_LD) {
             tcg_out_insn(s, RR, BCR,
-                         facilities & FACILITY_FAST_BCR_SER ? 14 : 15, 0);
+                         s390_facilities & FACILITY_FAST_BCR_SER ? 14 : 15, 0);
         }
         break;
 
@@ -2304,7 +2288,7 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { -1 },
 };
 
-static void query_facilities(void)
+static void query_s390_facilities(void)
 {
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
 
@@ -2315,7 +2299,7 @@ static void query_facilities(void)
         register void *r1 __asm__("1");
 
         /* stfle 0(%r1) */
-        r1 = &facilities;
+        r1 = &s390_facilities;
         asm volatile(".word 0xb2b0,0x1000"
                      : "=r"(r0) : "0"(0), "r"(r1) : "memory", "cc");
     }
@@ -2323,7 +2307,7 @@ static void query_facilities(void)
 
 static void tcg_target_init(TCGContext *s)
 {
-    query_facilities();
+    query_s390_facilities();
 
     tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I32], 0, 0xffff);
     tcg_regset_set32(tcg_target_available_regs[TCG_TYPE_I64], 0, 0xffff);
-- 
2.9.3
