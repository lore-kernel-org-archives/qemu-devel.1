Received: from eggs.gnu.org ([2001:4830:134:3::10]:55159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVo-0006Pf-Vs
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVo-0005Pq-6L
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:49 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVn-0005PA-QJ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:48 -0500
Received: by mail-pg0-x242.google.com with SMTP id i5so2479391pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:47 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:41 -0800
Message-Id: <20161224040042.12654-5-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/65] tcg/aarch64: Implement field extraction
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
 tcg/aarch64/tcg-target.h     |  8 ++++----
 tcg/aarch64/tcg-target.inc.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 410c31b..4a74bd8 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -63,8 +63,8 @@ typedef enum {
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
@@ -95,8 +95,8 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1939d35..c0e9890 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1640,6 +1640,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_dep(s, ext, a0, REG0(2), args[3], args[4]);
         break;
 
+    case INDEX_op_extract_i64:
+    case INDEX_op_extract_i32:
+        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        break;
+
+    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract_i32:
+        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
                         (int32_t)args[4], args[5], const_args[4],
@@ -1785,6 +1795,10 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
 
     { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
     { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
+    { INDEX_op_extract_i64, { "r", "r" } },
+    { INDEX_op_sextract_i32, { "r", "r" } },
+    { INDEX_op_sextract_i64, { "r", "r" } },
 
     { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
     { INDEX_op_add2_i64, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
-- 
2.9.3
