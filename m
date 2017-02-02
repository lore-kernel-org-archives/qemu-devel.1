Received: from eggs.gnu.org ([2001:4830:134:3::10]:35280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU2-0005M6-RJ
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITy-0005Q6-7G
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:34 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39800 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITy-0005OW-0L
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:30 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:50 +0300
Message-Id: <1486046099-17726-13-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 12/21] tcg/i386: support 64-bit vector
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.h     |  1 +
 tcg/i386/tcg-target.inc.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b0704e8..755ebaa 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -31,6 +31,7 @@
 #ifdef __x86_64__
 # if defined(TARGET_WORDS_BIGENDIAN) == defined(HOST_WORDS_BIGENDIAN)
 #  define TCG_TARGET_HAS_REG128 1
+#  define TCG_TARGET_HAS_REGV64 1
 # endif
 # ifdef TCG_TARGET_HAS_REG128
 #  define TCG_TARGET_REG_BITS  64
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3e718f3..208bb81 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -390,6 +390,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVDQU_M2R  (0x6f | P_SSE_F30F)  /* store 128-bit value */
 #define OPC_MOVDQU_R2M  (0x7f | P_SSE_F30F)  /* load 128-bit value */
 #define OPC_MOVDQA_R2R  (0x6f | P_SSE_660F)  /* reg-to-reg 128-bit mov */
+#define OPC_MOVQ_M2R    (0x7e | P_SSE_F30F)
+#define OPC_MOVQ_R2M    (0xd6 | P_SSE_660F)
+#define OPC_MOVQ_R2R    (0x7e | P_SSE_F30F)
 #define OPC_PADDD       (0xfe | P_SSE_660F)
 
 /* Group 1 opcode extensions for 0x80-0x83.
@@ -700,6 +703,15 @@ static inline void tcg_out_mov(TCGContext *s, TCGType type,
                 tcg_out_modrm(s, OPC_MOVDQA_R2R, ret, arg);
             }
             break;
+        case TCG_TYPE_V64:
+            ret -= TCG_REG_XMM0;
+            arg -= TCG_REG_XMM0;
+            if (have_avx) {
+                tcg_out_vex_modrm(s, OPC_MOVQ_R2R, ret, 15, arg);
+            } else {
+                tcg_out_modrm(s, OPC_MOVQ_R2R, ret, arg);
+            }
+            break;
         case TCG_TYPE_I32:
         case TCG_TYPE_I64:
             opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -788,6 +800,10 @@ static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         ret -= TCG_REG_XMM0;
         tcg_out_modrm_offset(s, OPC_MOVDQU_M2R, ret, arg1, arg2);
         break;
+    case TCG_TYPE_V64:
+        ret -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVQ_M2R, ret, arg1, arg2);
+        break;
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
         opc = OPC_MOVL_GvEv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -807,6 +823,10 @@ static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         arg -= TCG_REG_XMM0;
         tcg_out_modrm_offset(s, OPC_MOVDQU_R2M, arg, arg1, arg2);
         break;
+    case TCG_TYPE_V64:
+        arg -= TCG_REG_XMM0;
+        tcg_out_modrm_offset(s, OPC_MOVQ_R2M, arg, arg1, arg2);
+        break;
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
         opc = OPC_MOVL_EvGv + (type == TCG_TYPE_I64 ? P_REXW : 0);
@@ -2407,6 +2427,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_ld_v128:
     case INDEX_op_st_v128:
+    case INDEX_op_ld_v64:
+    case INDEX_op_st_v64:
         return &V_r;
 
     case INDEX_op_st8_i32:
-- 
2.1.4
