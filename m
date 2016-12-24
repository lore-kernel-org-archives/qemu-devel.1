Received: from eggs.gnu.org ([2001:4830:134:3::10]:55216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVr-0006Rq-Rp
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdVr-0005Ug-23
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:51 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdVq-0005Tw-Se
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:00:50 -0500
Received: by mail-pf0-x244.google.com with SMTP id 127so4599825pfg.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:00:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:45 -0800
Message-Id: <20161224040042.12654-9-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 08/65] tcg/mips: Implement field extraction
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
Cc: Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.h     | 2 +-
 tcg/mips/tcg-target.inc.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 1bcea3b..f1c3137 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -123,7 +123,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap32_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
-#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_ext8s_i32        use_mips32r2_instructions
 #define TCG_TARGET_HAS_ext16s_i32       use_mips32r2_instructions
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index abce602..1ecae08 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1637,6 +1637,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_deposit_i32:
         tcg_out_opc_bf(s, OPC_INS, a0, a2, args[3] + args[4] - 1, args[3]);
         break;
+    case INDEX_op_extract_i32:
+        tcg_out_opc_bf(s, OPC_EXT, a0, a1, a2 + args[3] - 1, a2);
+        break;
 
     case INDEX_op_brcond_i32:
         tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
@@ -1736,6 +1739,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
     { INDEX_op_ext16s_i32, { "r", "rZ" } },
 
     { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
+    { INDEX_op_extract_i32, { "r", "r" } },
 
     { INDEX_op_brcond_i32, { "rZ", "rZ" } },
 #if use_mips32r6_instructions
-- 
2.9.3
