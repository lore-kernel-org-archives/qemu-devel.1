Received: from eggs.gnu.org ([2001:4830:134:3::10]:55198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVr-0006Qz-5j
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVq-0005Tq-9y
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:51 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVq-0005So-3I
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:50 -0500
Received: by mail-pg0-x241.google.com with SMTP id i5so2479495pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:49 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:48 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:44 -0800
Message-Id: <20161224040042.12654-8-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 07/65] tcg/i386: Implement field extraction
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.h     | 12 +++++++++---
 tcg/i386/tcg-target.inc.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7625188..dc19c47 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -94,8 +94,8 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -126,7 +126,7 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
@@ -142,6 +142,12 @@ extern bool have_bmi1;
      ((ofs) == 0 && (len) == 16))
 #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
+/* Check for the possibility of high-byte extraction and, for 64-bit,
+   zero-extending 32-bit right-shift.  */
+#define TCG_TARGET_extract_i32_valid(ofs, len) ((ofs) == 8 && (len) == 8)
+#define TCG_TARGET_extract_i64_valid(ofs, len) \
+    (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
+
 #if TCG_TARGET_REG_BITS == 64
 # define TCG_AREG0 TCG_REG_R14
 #else
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index eeb1777..39f62bd 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2143,6 +2143,40 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_extract_i64:
+        if (args[2] + args[3] == 32) {
+            /* This is a 32-bit zero-extending right shift.  */
+            tcg_out_mov(s, TCG_TYPE_I32, args[0], args[1]);
+            tcg_out_shifti(s, SHIFT_SHR, args[0], args[2]);
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_extract_i32:
+        /* On the off-chance that we can use the high-byte registers.
+           Otherwise we emit the same ext16 + shift pattern that we
+           would have gotten from the normal tcg-op.c expansion.  */
+        tcg_debug_assert(args[2] == 8 && args[3] == 8);
+        if (args[1] < 4 && args[0] < 8) {
+            tcg_out_modrm(s, OPC_MOVZBL, args[0], args[1] + 4);
+        } else {
+            tcg_out_ext16u(s, args[0], args[1]);
+            tcg_out_shifti(s, SHIFT_SHR, args[0], 8);
+        }
+        break;
+
+    case INDEX_op_sextract_i32:
+        /* We don't implement sextract_i64, as we cannot sign-extend to
+           64-bits without using the REX prefix that explicitly excludes
+           access to the high-byte registers.  */
+        tcg_debug_assert(args[2] == 8 && args[3] == 8);
+        if (args[1] < 4 && args[0] < 8) {
+            tcg_out_modrm(s, OPC_MOVSBL, args[0], args[1] + 4);
+        } else {
+            tcg_out_ext16s(s, args[0], args[1], 0);
+            tcg_out_shifti(s, SHIFT_SAR, args[0], 8);
+        }
+        break;
+
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -2204,6 +2238,9 @@ static const TCGTargetOpDef x86_op_defs[] = {
     { INDEX_op_setcond_i32, { "q", "r", "ri" } },
 
     { INDEX_op_deposit_i32, { "Q", "0", "Q" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
+    { INDEX_op_sextract_i32, { "r", "r" } },
+
     { INDEX_op_movcond_i32, { "r", "r", "ri", "r", "0" } },
 
     { INDEX_op_mulu2_i32, { "a", "d", "a", "r" } },
@@ -2265,6 +2302,7 @@ static const TCGTargetOpDef x86_op_defs[] = {
     { INDEX_op_extu_i32_i64, { "r", "r" } },
 
     { INDEX_op_deposit_i64, { "Q", "0", "Q" } },
+    { INDEX_op_extract_i64, { "r", "r" } },
     { INDEX_op_movcond_i64, { "r", "r", "re", "r", "0" } },
 
     { INDEX_op_mulu2_i64, { "a", "d", "a", "r" } },
-- 
2.9.3
