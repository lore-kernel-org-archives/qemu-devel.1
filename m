Received: from eggs.gnu.org ([2001:4830:134:3::10]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V9-0006Vk-4e
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V8-0003QC-5X
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:59 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8V8-0003Pj-0N
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:58 -0500
Received: by mail-pf0-x244.google.com with SMTP id b22so15072912pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:57 -0800
Message-Id: <20170111021820.24416-43-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/65] tcg/arm: Handle ctz and clz opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.h     |  4 ++--
 tcg/arm/tcg-target.inc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 02cc242..4cb94dc 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -110,8 +110,8 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_eqv_i32          0
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_clz_i32          use_armv5t_instructions
+#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index ec0b861..e75a6d4 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -256,6 +256,9 @@ typedef enum {
     ARITH_BIC = 0xe << 21,
     ARITH_MVN = 0xf << 21,
 
+    INSN_CLZ       = 0x016f0f10,
+    INSN_RBIT      = 0x06ff0f30,
+
     INSN_LDR_IMM   = 0x04100000,
     INSN_LDR_REG   = 0x06100000,
     INSN_STR_IMM   = 0x04000000,
@@ -1829,6 +1832,28 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_ctz_i32:
+        tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
+        a1 = TCG_REG_TMP;
+        goto do_clz;
+
+    case INDEX_op_clz_i32:
+        a1 = args[1];
+    do_clz:
+        a0 = args[0];
+        a2 = args[2];
+        c = const_args[2];
+        if (c && a2 == 32) {
+            tcg_out_dat_reg(s, COND_AL, INSN_CLZ, a0, 0, a1, 0);
+            break;
+        }
+        tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
+        tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
+        if (c || a0 != a2) {
+            tcg_out_dat_rIK(s, COND_EQ, ARITH_MOV, ARITH_MVN, a0, 0, a2, c);
+        }
+        break;
+
     case INDEX_op_brcond_i32:
         tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
                        args[0], args[1], const_args[1]);
@@ -1963,6 +1988,8 @@ static const TCGTargetOpDef arm_op_defs[] = {
     { INDEX_op_sar_i32, { "r", "r", "ri" } },
     { INDEX_op_rotl_i32, { "r", "r", "ri" } },
     { INDEX_op_rotr_i32, { "r", "r", "ri" } },
+    { INDEX_op_clz_i32, { "r", "r", "rIK" } },
+    { INDEX_op_ctz_i32, { "r", "r", "rIK" } },
 
     { INDEX_op_brcond_i32, { "r", "rIN" } },
     { INDEX_op_setcond_i32, { "r", "r", "rIN" } },
-- 
2.9.3
