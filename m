Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWL-0006xe-Mi
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWK-0005uT-Pp
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:21 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWK-0005uA-LW
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:20 -0500
Received: by mail-pf0-x244.google.com with SMTP id c4so14580640pfb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:20 -0800
Message-Id: <20161224040042.12654-44-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 43/65] tcg/mips: Handle clz opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.h     |  4 ++--
 tcg/mips/tcg-target.inc.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index f133684..0526018 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -109,8 +109,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
 #define TCG_TARGET_HAS_andc_i32         0
 #define TCG_TARGET_HAS_orc_i32          0
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -130,6 +128,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_clz_i32          use_mips32r2_instructions
+#define TCG_TARGET_HAS_ctz_i32          0
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_neg_i32          0 /* sub  rd, zero, rt   */
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 4341ea2..732246a 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -160,6 +160,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_S16  0x400    /* Signed 16-bit: -32768 - 32767 */
 #define TCG_CT_CONST_P2M1 0x800    /* Power of 2 minus 1.  */
 #define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
+#define TCG_CT_CONST_WSZ  0x2000   /* word size */
 
 static inline bool is_p2m1(tcg_target_long val)
 {
@@ -215,6 +216,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'N':
         ct->ct |= TCG_CT_CONST_N16;
         break;
+    case 'W':
+        ct->ct |= TCG_CT_CONST_WSZ;
+        break;
     case 'Z':
         /* We are cheating a bit here, using the fact that the register
            ZERO is also the register number 0. Hence there is no need
@@ -246,6 +250,8 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
     } else if ((ct & TCG_CT_CONST_P2M1)
                && use_mips32r2_instructions && is_p2m1(val)) {
         return 1;
+    } else if ((ct & TCG_CT_CONST_WSZ) && val == 32) {
+        return 1;
     }
     return 0;
 }
@@ -313,6 +319,7 @@ typedef enum {
     OPC_SLTU     = OPC_SPECIAL | 0x2B,
     OPC_SELEQZ   = OPC_SPECIAL | 0x35,
     OPC_SELNEZ   = OPC_SPECIAL | 0x37,
+    OPC_CLZ_R6   = OPC_SPECIAL | 0120,
 
     OPC_REGIMM   = 0x01 << 26,
     OPC_BLTZ     = OPC_REGIMM | (0x00 << 16),
@@ -320,6 +327,7 @@ typedef enum {
 
     OPC_SPECIAL2 = 0x1c << 26,
     OPC_MUL_R5   = OPC_SPECIAL2 | 0x002,
+    OPC_CLZ      = OPC_SPECIAL2 | 040,
 
     OPC_SPECIAL3 = 0x1f << 26,
     OPC_EXT      = OPC_SPECIAL3 | 0x000,
@@ -1625,6 +1633,31 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_clz_i32:
+        if (use_mips32r6_instructions) {
+            if (a2 == 32) {
+                tcg_out_opc_reg(s, OPC_CLZ_R6, a0, a1, 0);
+            } else {
+                tcg_out_opc_reg(s, OPC_CLZ_R6, TCG_TMP0, a1, 0);
+                tcg_out_movcond(s, TCG_COND_EQ, a0, a1, 0, a2, TCG_TMP0);
+            }
+        } else {
+            if (a2 == 32) {
+                tcg_out_opc_reg(s, OPC_CLZ, a0, a1, a1);
+            } else if (a0 == a2) {
+                tcg_out_opc_reg(s, OPC_CLZ, TCG_TMP0, a1, a1);
+                tcg_out_opc_reg(s, OPC_MOVN, a0, TCG_TMP0, a1);
+            } else if (a0 != a1) {
+                tcg_out_opc_reg(s, OPC_CLZ, a0, a1, a1);
+                tcg_out_opc_reg(s, OPC_MOVZ, a0, a2, a1);
+            } else {
+                tcg_out_opc_reg(s, OPC_CLZ, TCG_TMP0, a1, a1);
+                tcg_out_opc_reg(s, OPC_MOVZ, TCG_TMP0, a2, a1);
+                tcg_out_mov(s, TCG_TYPE_REG, a0, TCG_TMP0);
+            }
+        }
+        break;
+
     case INDEX_op_bswap32_i32:
         tcg_out_opc_reg(s, OPC_WSBH, a0, 0, a1);
         tcg_out_opc_sa(s, OPC_ROTR, a0, a0, 16);
@@ -1727,6 +1760,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_sar_i32, { "r", "rZ", "ri" } },
     { INDEX_op_rotr_i32, { "r", "rZ", "ri" } },
     { INDEX_op_rotl_i32, { "r", "rZ", "ri" } },
+    { INDEX_op_clz_i32,  { "r", "r", "rWZ" } },
 
     { INDEX_op_bswap16_i32, { "r", "r" } },
     { INDEX_op_bswap32_i32, { "r", "r" } },
-- 
2.9.3
