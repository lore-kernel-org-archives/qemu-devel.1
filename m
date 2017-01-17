Received: from eggs.gnu.org ([2001:4830:134:3::10]:50955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkk-0003D1-LE
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkj-0003vf-Jt
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:30 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50259 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkj-0003vE-Bg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:29 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:51 +0300
Message-Id: <1484644078-21312-12-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 11/18] tcg/i386: support 64-bit vector
 operations
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
 tcg/i386/tcg-target.h     |  1 +
 tcg/i386/tcg-target.inc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 974a58b..849b339 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -30,6 +30,7 @@
 
 #ifdef __x86_64__
 # define TCG_TARGET_HAS_REG128 1
+# define TCG_TARGET_HAS_REGV64 1
 # ifdef TCG_TARGET_HAS_REG128
 #  define TCG_TARGET_REG_BITS  64
 #  define TCG_TARGET_NB_REGS   24
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 69e3198..a2d5e09 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -374,6 +374,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVDQU_M2R  (0x6f | P_SSE_F30F)  /* store 128-bit value */
 #define OPC_MOVDQU_R2M  (0x7f | P_SSE_F30F)  /* load 128-bit value */
 #define OPC_MOVDQA_R2R  (0x6f | P_SSE_660F)  /* reg-to-reg 128-bit mov */
+#define OPC_MOVQ_M2R    (0x7e | P_SSE_F30F)
+#define OPC_MOVQ_R2M    (0xd6 | P_SSE_660F)
+#define OPC_MOVQ_R2R    (0xd6 | P_SSE_660F)
 #define OPC_PADDD       (0xfe | P_SSE_660F)
 
 /* Group 1 opcode extensions for 0x80-0x83.
@@ -672,6 +675,13 @@ static inline void tcg_out_mov(TCGContext *s, TCGType type,
             tcg_out_modrm(s, OPC_MOVDQA_R2R, ret, arg);
             break;
 #endif
+#ifdef TCG_TARGET_HAS_REGV64
+        case TCG_TYPE_V64:
+            ret -= TCG_REG_XMM0;
+            arg -= TCG_REG_XMM0;
+            tcg_out_modrm(s, OPC_MOVQ_R2R, ret, arg);
+            break;
+#endif
         case TCG_TYPE_I32:
         case TCG_TYPE_I64:
             opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -762,6 +772,12 @@ static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out_modrm_offset(s, OPC_MOVDQU_M2R, ret, arg1, arg2);
         break;
 #endif
+#ifdef TCG_TARGET_HAS_REGV64
+    case TCG_TYPE_V64:
+        ret -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVQ_M2R, ret, arg1, arg2);
+        break;
+#endif
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
         opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -783,6 +799,12 @@ static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         tcg_out_modrm_offset(s, OPC_MOVDQU_R2M, arg, arg1, arg2);
         break;
 #endif
+#ifdef TCG_TARGET_HAS_REGV64
+    case TCG_TYPE_V64:
+        arg -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVQ_R2M, arg, arg1, arg2);
+        break;
+#endif
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
         opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -2264,6 +2286,11 @@ static const TCGTargetOpDef x86_op_defs[] = {
     { INDEX_op_st_v128, { "V", "r" } },
 #endif
 
+#ifdef TCG_TARGET_HAS_REGV64
+    { INDEX_op_ld_v64, { "V", "r" } },
+    { INDEX_op_st_v64, { "V", "r" } },
+#endif
+
     { INDEX_op_add_i32, { "r", "r", "ri" } },
     { INDEX_op_sub_i32, { "r", "0", "ri" } },
     { INDEX_op_mul_i32, { "r", "0", "ri" } },
-- 
2.1.4
