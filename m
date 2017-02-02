Received: from eggs.gnu.org ([2001:4830:134:3::10]:35296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU3-0005MO-7z
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITy-0005QP-LT
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:35 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39804 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITy-0005Ow-9r
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:30 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:51 +0300
Message-Id: <1486046099-17726-14-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 13/21] tcg/i386: support remaining vector
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---

I believe checkpatch warning here to be false-positive.

---
 tcg/i386/tcg-target.h     | 10 +++++++++
 tcg/i386/tcg-target.inc.c | 54 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 755ebaa..bd6cfe1 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -172,7 +172,17 @@ extern bool have_popcnt;
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
index 208bb81..d8f0d81 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -168,6 +168,11 @@ static bool have_lzcnt;
 #else
 # define have_lzcnt 0
 #endif
+#if defined(CONFIG_CPUID_H) && defined(bit_AVX) && defined(bit_OSXSAVE)
+static bool have_avx;
+#else
+# define have_avx 0
+#endif
 
 static tcg_insn_unit *tb_ret_addr;
 
@@ -393,7 +398,10 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVQ_M2R    (0x7e | P_SSE_F30F)
 #define OPC_MOVQ_R2M    (0xd6 | P_SSE_660F)
 #define OPC_MOVQ_R2R    (0x7e | P_SSE_F30F)
+#define OPC_PADDB       (0xfc | P_SSE_660F)
+#define OPC_PADDW       (0xfd | P_SSE_660F)
 #define OPC_PADDD       (0xfe | P_SSE_660F)
+#define OPC_PADDQ       (0xd4 | P_SSE_660F)
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -1963,6 +1971,19 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     TCGArg a0, a1, a2;
     int c, const_a2, vexop, rexw = 0;
 
+    static const int vect_binop[] = {
+        [INDEX_op_add_i8x16] = OPC_PADDB,
+        [INDEX_op_add_i16x8] = OPC_PADDW,
+        [INDEX_op_add_i32x4] = OPC_PADDD,
+        [INDEX_op_add_i64x2] = OPC_PADDQ,
+
+        [INDEX_op_add_i8x8]  = OPC_PADDB,
+        [INDEX_op_add_i16x4] = OPC_PADDW,
+        [INDEX_op_add_i32x2] = OPC_PADDD,
+        [INDEX_op_add_i64x1] = OPC_PADDQ,
+    };
+
+
 #if TCG_TARGET_REG_BITS == 64
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_, x), _i64): \
@@ -1972,6 +1993,17 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 # define OP_32_64(x) \
         case glue(glue(INDEX_op_, x), _i32)
 #endif
+#define OP_V128_ALL(x) \
+        case glue(glue(INDEX_op_, x), _i8x16): \
+        case glue(glue(INDEX_op_, x), _i16x8): \
+        case glue(glue(INDEX_op_, x), _i32x4): \
+        case glue(glue(INDEX_op_, x), _i64x2)
+
+#define OP_V64_ALL(x) \
+        case glue(glue(INDEX_op_, x), _i8x8):  \
+        case glue(glue(INDEX_op_, x), _i16x4): \
+        case glue(glue(INDEX_op_, x), _i32x2): \
+        case glue(glue(INDEX_op_, x), _i64x1)
 
     /* Hoist the loads of the most common arguments.  */
     a0 = args[0];
@@ -2369,8 +2401,13 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_mb(s, a0);
         break;
 
-    case INDEX_op_add_i32x4:
-        tcg_out_modrm(s, OPC_PADDD, args[0], args[2]);
+    OP_V128_ALL(add):
+    OP_V64_ALL(add):
+        if (have_avx) {
+            tcg_out_vex_modrm(s, vect_binop[opc], args[0], args[1], args[2]);
+        } else {
+            tcg_out_modrm(s, vect_binop[opc], args[0], args[2]);
+        }
         break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
@@ -2383,6 +2420,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 
 #undef OP_32_64
+#undef OP_V128_ALL
+#undef OP_V64_ALL
 }
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
@@ -2613,7 +2652,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
             return &s2;
         }
 
+    case INDEX_op_add_i8x16:
+    case INDEX_op_add_i16x8:
     case INDEX_op_add_i32x4:
+    case INDEX_op_add_i64x2:
+    case INDEX_op_add_i8x8:
+    case INDEX_op_add_i16x4:
+    case INDEX_op_add_i32x2:
+    case INDEX_op_add_i64x1:
         return &V_0_V;
 
     default:
@@ -2728,6 +2774,10 @@ static void tcg_target_init(TCGContext *s)
 #ifdef bit_POPCNT
         have_popcnt = (c & bit_POPCNT) != 0;
 #endif
+#if defined(bit_AVX) && defined(bit_OSXSAVE)
+        have_avx = (c & (bit_AVX | bit_OSXSAVE)) == (bit_AVX | bit_OSXSAVE);
+#endif
+
     }
 
     if (max >= 7) {
-- 
2.1.4
