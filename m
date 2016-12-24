Received: from eggs.gnu.org ([2001:4830:134:3::10]:56026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWb-0007BK-K8
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWa-00069Q-PN
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:37 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWa-000694-Kr
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:36 -0500
Received: by mail-pf0-x241.google.com with SMTP id c4so14580923pfb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:36 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.35 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:42 -0800
Message-Id: <20161224040042.12654-66-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 65/65] tcg/i386: Handle ctpop opcode
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
 tcg/i386/tcg-target.h     |  5 +++--
 tcg/i386/tcg-target.inc.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b8f73f5..21d96ec 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -76,6 +76,7 @@ typedef enum {
 #endif
 
 extern bool have_bmi1;
+extern bool have_popcnt;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
@@ -95,7 +96,7 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_ctpop_i32        have_popcnt
 #define TCG_TARGET_HAS_deposit_i32      1
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
@@ -130,7 +131,7 @@ extern bool have_bmi1;
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_ctpop_i64        have_popcnt
 #define TCG_TARGET_HAS_deposit_i64      1
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3650340..01177a9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -130,9 +130,10 @@ static bool have_movbe;
 # define have_movbe 0
 #endif
 
-/* We need this symbol in tcg-target.h, and we can't properly conditionalize
+/* We need these symbols in tcg-target.h, and we can't properly conditionalize
    it there.  Therefore we always define the variable.  */
 bool have_bmi1;
+bool have_popcnt;
 
 #if defined(CONFIG_CPUID_H) && defined(bit_BMI2)
 static bool have_bmi2;
@@ -337,6 +338,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
 #define OPC_POP_r32	(0x58)
+#define OPC_POPCNT      (0xb8 | P_EXT | P_SIMDF3)
 #define OPC_PUSH_r32	(0x50)
 #define OPC_PUSH_Iv	(0x68)
 #define OPC_PUSH_Ib	(0x6a)
@@ -2083,6 +2085,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(clz):
         tcg_out_clz(s, rexw, args[0], args[1], args[2], const_args[2]);
         break;
+    OP_32_64(ctpop):
+        tcg_out_modrm(s, OPC_POPCNT + rexw, a0, a1);
+        break;
 
     case INDEX_op_brcond_i32:
         tcg_out_brcond32(s, a2, a0, a1, const_args[1], arg_label(args[3]), 0);
@@ -2398,6 +2403,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
+    case INDEX_op_ctpop_i32:
+    case INDEX_op_ctpop_i64:
         return &r_r;
 
     case INDEX_op_deposit_i32:
@@ -2602,6 +2609,9 @@ static void tcg_target_init(TCGContext *s)
            need to probe for it.  */
         have_movbe = (c & bit_MOVBE) != 0;
 #endif
+#ifdef bit_POPCNT
+        have_popcnt = (c & bit_POPCNT) != 0;
+#endif
     }
 
     if (max >= 7) {
-- 
2.9.3
