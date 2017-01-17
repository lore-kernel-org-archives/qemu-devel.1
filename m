Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkl-0003Dy-Js
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkk-0003wC-KL
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:31 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50279 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkk-0003vp-65
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:30 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:52 +0300
Message-Id: <1484644078-21312-13-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 12/18] tcg/i386: support remaining vector
 addition operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.h     | 10 ++++++++++
 tcg/i386/tcg-target.inc.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 849b339..5deb08e 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -151,7 +151,17 @@ extern bool have_bmi1;
 #endif
 
 #ifdef TCG_TARGET_HAS_REG128
+#define TCG_TARGET_HAS_add_i8x16        1
+#define TCG_TARGET_HAS_add_i16x8        1
 #define TCG_TARGET_HAS_add_i32x4        1
+#define TCG_TARGET_HAS_add_i64x2        1
+#endif
+
+#ifdef TCG_TARGET_HAS_REGV64
+#define TCG_TARGET_HAS_add_i8x8         1
+#define TCG_TARGET_HAS_add_i16x4        1
+#define TCG_TARGET_HAS_add_i32x2        1
+#define TCG_TARGET_HAS_add_i64x1        1
 #endif
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index a2d5e09..d00bd12 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -377,7 +377,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVQ_M2R    (0x7e | P_SSE_F30F)
 #define OPC_MOVQ_R2M    (0xd6 | P_SSE_660F)
 #define OPC_MOVQ_R2R    (0xd6 | P_SSE_660F)
+#define OPC_PADDB       (0xfc | P_SSE_660F)
+#define OPC_PADDW       (0xfd | P_SSE_660F)
 #define OPC_PADDD       (0xfe | P_SSE_660F)
+#define OPC_PADDQ       (0xd4 | P_SSE_660F)
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -2251,9 +2254,33 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
 #ifdef TCG_TARGET_HAS_REG128
+    case INDEX_op_add_i8x16:
+        tcg_out_modrm(s, OPC_PADDB, args[0], args[2]);
+        break;
+    case INDEX_op_add_i16x8:
+        tcg_out_modrm(s, OPC_PADDW, args[0], args[2]);
+        break;
     case INDEX_op_add_i32x4:
         tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
         break;
+    case INDEX_op_add_i64x2:
+        tcg_out_modrm(s, OPC_PADDQ, args[0], args[2]);
+        break;
+#endif
+
+#ifdef TCG_TARGET_HAS_REGV64
+    case INDEX_op_add_i8x8:
+        tcg_out_modrm(s, OPC_PADDB, args[0], args[2]);
+        break;
+    case INDEX_op_add_i16x4:
+        tcg_out_modrm(s, OPC_PADDW, args[0], args[2]);
+        break;
+    case INDEX_op_add_i32x2:
+        tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
+        break;
+    case INDEX_op_add_i64x1:
+        tcg_out_modrm(s, OPC_PADDQ, args[0], args[2]);
+        break;
 #endif
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
@@ -2411,7 +2438,17 @@ static const TCGTargetOpDef x86_op_defs[] = {
 #endif
 
 #ifdef TCG_TARGET_HAS_REG128
+    { INDEX_op_add_i8x16, { "V", "0", "V" } },
+    { INDEX_op_add_i16x8, { "V", "0", "V" } },
     { INDEX_op_add_i32x4, { "V", "0", "V" } },
+    { INDEX_op_add_i64x2, { "V", "0", "V" } },
+#endif
+
+#ifdef TCG_TARGET_HAS_REGV64
+    { INDEX_op_add_i8x8, { "V", "0", "V" } },
+    { INDEX_op_add_i16x4, { "V", "0", "V" } },
+    { INDEX_op_add_i32x2, { "V", "0", "V" } },
+    { INDEX_op_add_i64x1, { "V", "0", "V" } },
 #endif
     { -1 },
 };
-- 
2.1.4
