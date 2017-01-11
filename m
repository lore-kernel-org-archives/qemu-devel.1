Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uf-0005rU-9O
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ue-000341-8g
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:29 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ue-00033Y-1s
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:28 -0500
Received: by mail-pf0-x243.google.com with SMTP id f144so12524203pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:27 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:21 -0800
Message-Id: <20170111021820.24416-7-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/65] tcg/arm: Implement field extraction
 opcodes
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
 tcg/arm/tcg-target.inc.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index d1fe12b..4e30728 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -111,8 +111,8 @@ extern bool use_idiv_instructions;
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
+#define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 1415c27..2d5af0f 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -713,6 +713,22 @@ static inline void tcg_out_deposit(TCGContext *s, int cond, TCGReg rd,
               | (ofs << 7) | ((ofs + len - 1) << 16));
 }
 
+static inline void tcg_out_extract(TCGContext *s, int cond, TCGReg rd,
+                                   TCGArg a1, int ofs, int len)
+{
+    /* ubfx */
+    tcg_out32(s, 0x07e00050 | (cond << 28) | (rd << 12) | a1
+              | (ofs << 7) | ((len - 1) << 16));
+}
+
+static inline void tcg_out_sextract(TCGContext *s, int cond, TCGReg rd,
+                                    TCGArg a1, int ofs, int len)
+{
+    /* sbfx */
+    tcg_out32(s, 0x07a00050 | (cond << 28) | (rd << 12) | a1
+              | (ofs << 7) | ((len - 1) << 16));
+}
+
 /* Note that this routine is used for both LDR and LDRH formats, so we do
    not wish to include an immediate shift at this point.  */
 static void tcg_out_memop_r(TCGContext *s, int cond, ARMInsn opc, TCGReg rt,
@@ -1894,6 +1910,12 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_deposit(s, COND_AL, args[0], args[2],
                         args[3], args[4], const_args[2]);
         break;
+    case INDEX_op_extract_i32:
+        tcg_out_extract(s, COND_AL, args[0], args[1], args[2], args[3]);
+        break;
+    case INDEX_op_sextract_i32:
+        tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
+        break;
 
     case INDEX_op_div_i32:
         tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
@@ -1976,6 +1998,8 @@ static const TCGTargetOpDef arm_op_defs[] = {
     { INDEX_op_ext16u_i32, { "r", "r" } },
 
     { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
+    { INDEX_op_sextract_i32, { "r", "r" } },
 
     { INDEX_op_div_i32, { "r", "r", "r" } },
     { INDEX_op_divu_i32, { "r", "r", "r" } },
-- 
2.9.3
