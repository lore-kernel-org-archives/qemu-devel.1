Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ui-00061T-8M
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ug-00036V-To
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:32 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Ug-000363-OI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:30 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so12524392pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:24 -0800
Message-Id: <20170111021820.24416-10-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 09/65] tcg/ppc: Implement field extraction
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/ppc/tcg-target.h     |  4 ++--
 tcg/ppc/tcg-target.inc.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index c765d3e..b42c57a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -69,7 +69,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i32         1
 #define TCG_TARGET_HAS_nor_i32          1
 #define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_mulu2_i32        0
@@ -102,7 +102,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_i64         1
 #define TCG_TARGET_HAS_nor_i64          1
 #define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_add2_i64         1
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a3262cf..7ec54a2 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -2396,6 +2396,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
         }
         break;
 
+    case INDEX_op_extract_i32:
+        tcg_out_rlw(s, RLWINM, args[0], args[1],
+                    32 - args[2], 32 - args[3], 31);
+        break;
+    case INDEX_op_extract_i64:
+        tcg_out_rld(s, RLDICL, args[0], args[1], 64 - args[2], 64 - args[3]);
+        break;
+
     case INDEX_op_movcond_i32:
         tcg_out_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1], args[2],
                         args[3], args[4], const_args[2]);
@@ -2530,6 +2538,7 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_movcond_i32, { "r", "r", "ri", "rZ", "rZ" } },
 
     { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
 
     { INDEX_op_muluh_i32, { "r", "r", "r" } },
     { INDEX_op_mulsh_i32, { "r", "r", "r" } },
@@ -2585,6 +2594,7 @@ static const TCGTargetOpDef ppc_op_defs[] = {
     { INDEX_op_movcond_i64, { "r", "r", "ri", "rZ", "rZ" } },
 
     { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i64, { "r", "r" } },
 
     { INDEX_op_mulsh_i64, { "r", "r", "r" } },
     { INDEX_op_muluh_i64, { "r", "r", "r" } },
-- 
2.9.3
