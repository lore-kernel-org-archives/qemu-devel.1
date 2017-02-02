Received: from eggs.gnu.org ([2001:4830:134:3::10]:35229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU1-0005Kh-20
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITv-0005O9-SE
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:33 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39775 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITv-0005NU-Jp
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:27 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:42 +0300
Message-Id: <1486046099-17726-5-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 04/21] tcg: add ld_v128, ld_v64,
 st_v128 and st_v64 opcodes
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
 tcg/tcg-op.h  | 38 ++++++++++++++++++++++++++++++++++++++
 tcg/tcg-opc.h | 18 ++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 517745e..250493b 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -501,6 +501,44 @@ static inline void tcg_gen_discard_v64(TCGv_v64 arg)
     tcg_gen_op1_v64(INDEX_op_discard, arg);
 }
 
+static inline void tcg_gen_ldst_op_v128(TCGOpcode opc, TCGv_v128 val,
+                                       TCGv_ptr base, TCGArg offset)
+{
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V128(val), GET_TCGV_PTR(base),
+                offset);
+}
+
+static inline void tcg_gen_st_v128(TCGv_v128 arg1, TCGv_ptr arg2,
+                                   tcg_target_long offset)
+{
+    tcg_gen_ldst_op_v128(INDEX_op_st_v128, arg1, arg2, offset);
+}
+
+static inline void tcg_gen_ld_v128(TCGv_v128 ret, TCGv_ptr arg2,
+                                   tcg_target_long offset)
+{
+    tcg_gen_ldst_op_v128(INDEX_op_ld_v128, ret, arg2, offset);
+}
+
+static inline void tcg_gen_ldst_op_v64(TCGOpcode opc, TCGv_v64 val,
+                                       TCGv_ptr base, TCGArg offset)
+{
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V64(val), GET_TCGV_PTR(base),
+                offset);
+}
+
+static inline void tcg_gen_st_v64(TCGv_v64 arg1, TCGv_ptr arg2,
+                                  tcg_target_long offset)
+{
+    tcg_gen_ldst_op_v64(INDEX_op_st_v64, arg1, arg2, offset);
+}
+
+static inline void tcg_gen_ld_v64(TCGv_v64 ret, TCGv_ptr arg2,
+                                  tcg_target_long offset)
+{
+    tcg_gen_ldst_op_v64(INDEX_op_ld_v64, ret, arg2, offset);
+}
+
 /* 64 bit ops */
 
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index f06f894..2365c97 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -42,6 +42,18 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 # define IMPL64  TCG_OPF_64BIT
 #endif
 
+#ifdef TCG_TARGET_HAS_REG128
+# define IMPL128 0
+#else
+# define IMPL128 TCG_OPF_NOT_PRESENT
+#endif
+
+#ifdef TCG_TARGET_HAS_REGV64
+# define IMPLV64 0
+#else
+# define IMPLV64 TCG_OPF_NOT_PRESENT
+#endif
+
 DEF(mb, 0, 0, 1, 0)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
@@ -188,6 +200,12 @@ DEF(mulsh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i64))
 #define TLADDR_ARGS  (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? 1 : 2)
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
+/* load/store */
+DEF(st_v128, 0, 2, 1, IMPL128)
+DEF(ld_v128, 1, 1, 1, IMPL128)
+DEF(st_v64, 0, 2, 1, IMPLV64)
+DEF(ld_v64, 1, 1, 1, IMPLV64)
+
 /* QEMU specific */
 DEF(insn_start, 0, 0, TLADDR_ARGS * TARGET_INSN_START_WORDS,
     TCG_OPF_NOT_PRESENT)
-- 
2.1.4
