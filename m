Received: from eggs.gnu.org ([2001:4830:134:3::10]:34987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ug-0005wr-QI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uf-00035Q-Qe
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:30 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uf-00034x-Ku
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:29 -0500
Received: by mail-pf0-x244.google.com with SMTP id b22so15071120pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:29 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:23 -0800
Message-Id: <20170111021820.24416-9-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 08/65] tcg/mips: Implement field extraction
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.h     | 4 +++-
 tcg/mips/tcg-target.inc.c | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index fcc2986..92d203a 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -158,7 +158,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_movcond_i32      use_movnz_instructions
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
@@ -170,6 +170,8 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_extract_i64      use_mips32r2_instructions
+#define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_ext8s_i64        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i64       use_mips32r2_instructions
 #define TCG_TARGET_HAS_rot_i64          use_mips32r2_instructions
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 5b2fe98..24c4949 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -2051,6 +2051,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_bf64(s, OPC_DINS, OPC_DINSM, OPC_DINSU, a0, a2,
                          args[3] + args[4] - 1, args[3]);
         break;
+    case INDEX_op_extract_i32:
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, a2 + args[3] - 1, a2);
+        break;
+    case INDEX_op_extract_i64:
+        tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1,
+                         a2 + args[3] - 1, a2);
+        break;
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
@@ -2155,6 +2162,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_ext16s_i32, { "r", "rZ" } },
 
     { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
 
     { INDEX_op_brcond_i32, { "rZ", "rZ" } },
 #if use_mips32r6_instructions
@@ -2224,6 +2232,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_extrh_i64_i32, { "r", "rZ" } },
 
     { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i64, { "r", "r" } },
 
     { INDEX_op_brcond_i64, { "rZ", "rZ" } },
 #if use_mips32r6_instructions
-- 
2.9.3
