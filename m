Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsC-00061c-9B
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005dQ-TN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:52 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46085 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005cD-IV
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:48 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:18 +0300
Message-Id: <1485951502-28774-17-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 16/20] tcg: introduce qemu_ld_v128 and
 qemu_st_v128 opcodes
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
 tcg/i386/tcg-target.inc.c |  5 +++++
 tcg/tcg-op.c              | 24 ++++++++++++++++++++++++
 tcg/tcg-op.h              | 15 +++++++++++++++
 tcg/tcg-opc.h             |  4 ++++
 4 files changed, 48 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 263c15e..1e6edc0 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2448,6 +2448,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         = { .args_ct_str = { "L", "L", "L", "L" } };
     static const TCGTargetOpDef V_r = { .args_ct_str  = { "V", "r" } };
     static const TCGTargetOpDef V_0_V = { .args_ct_str  = { "V", "0", "V" } };
+    static const TCGTargetOpDef V_L = { .args_ct_str  = { "V", "L" } };
 
     switch (op) {
     case INDEX_op_ld8u_i32:
@@ -2662,6 +2663,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i64x1:
         return &V_0_V;
 
+    case INDEX_op_qemu_ld_v128:
+    case INDEX_op_qemu_st_v128:
+        return &V_L;
+
     default:
         break;
     }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0dfe611..db74017 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -3102,3 +3102,27 @@ void tcg_v64_to_ptr(TCGv_v64 tmp, TCGv_ptr base, int slot,
         }
     }
 }
+
+void tcg_gen_qemu_ld_v128(TCGv_v128 val, TCGv addr, TCGArg idx,
+                          TCGMemOp memop)
+{
+#ifdef TCG_TARGET_HAS_REG128
+    tcg_debug_assert((memop & MO_BSWAP) == MO_TE);
+    TCGMemOpIdx oi = make_memop_idx(memop, idx);
+    tcg_gen_op3si_v128(INDEX_op_qemu_ld_v128, val, addr, oi);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+void tcg_gen_qemu_st_v128(TCGv_v128 val, TCGv addr, TCGArg idx,
+                          TCGMemOp memop)
+{
+#ifdef TCG_TARGET_HAS_REG128
+    tcg_debug_assert((memop & MO_BSWAP) == MO_TE);
+    TCGMemOpIdx oi = make_memop_idx(memop, idx);
+    tcg_gen_op3si_v128(INDEX_op_qemu_st_v128, val, addr, oi);
+#else
+    g_assert_not_reached();
+#endif
+}
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 3727be7..dc1d032 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -266,6 +266,19 @@ static inline void tcg_gen_op3_v128(TCGOpcode opc, TCGv_v128 a1,
                 GET_TCGV_V128(a3));
 }
 
+static inline void tcg_gen_op3si_v128(TCGOpcode opc, TCGv_v128 a1,
+                                      TCGv a2, TCGArg a3)
+{
+#if TARGET_LONG_BITS == 64 && TCG_TARGET_REG_BITS == 32
+    tcg_gen_op4(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_I32(TCGV_LOW(a2)),
+                GET_TCGV_I32(TCGV_HIGH(a2)), a3);
+#elif TARGET_LONG_BITS == 32
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_I32(a2), a3);
+#else
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_I64(a2), a3);
+#endif
+}
+
 static inline void tcg_gen_op1_v64(TCGOpcode opc, TCGv_v64 a1)
 {
     tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_V64(a1));
@@ -909,6 +922,8 @@ void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_qemu_ld_v128(TCGv_v128, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_qemu_st_v128(TCGv_v128, TCGv, TCGArg, TCGMemOp);
 
 static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)
 {
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4c8f195..6c2e697 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -232,6 +232,10 @@ DEF(qemu_ld_i64, DATA64_ARGS, TLADDR_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
 DEF(qemu_st_i64, 0, TLADDR_ARGS + DATA64_ARGS, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | TCG_OPF_64BIT)
+DEF(qemu_ld_v128, 1, 1, 1,
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | IMPL128)
+DEF(qemu_st_v128, 0, 2, 1,
+    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS | IMPL128)
 
 #undef TLADDR_ARGS
 #undef DATA64_ARGS
-- 
2.1.4
