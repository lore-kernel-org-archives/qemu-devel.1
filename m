Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVq-0006QR-Kq
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVp-0005Sx-Mz
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:50 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVp-0005Rb-Bz
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:49 -0500
Received: by mail-pg0-x242.google.com with SMTP id n5so2482283pgh.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:49 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:47 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:43 -0800
Message-Id: <20161224040042.12654-7-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/65] tcg/arm: Implement field extraction
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
