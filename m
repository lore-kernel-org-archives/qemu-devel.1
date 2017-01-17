Received: from eggs.gnu.org ([2001:4830:134:3::10]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkn-0003GC-LY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkm-0003xp-Nv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:33 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50347 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkm-0003xG-9a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:32 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:55 +0300
Message-Id: <1484644078-21312-16-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 15/18] tcg: introduce qemu_ld_v128 and
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/i386/tcg-target.inc.c |  5 +++++
 tcg/tcg-op.c              | 16 ++++++++++++++++
 tcg/tcg-op.h              |  8 ++++++++
 tcg/tcg-opc.h             |  4 ++++
 4 files changed, 33 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index cd9de4d..c28fd09 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2438,6 +2438,11 @@ static const TCGTargetOpDef x86_op_defs[] = {
 #endif
 
 #ifdef TCG_TARGET_HAS_REG128
+    { INDEX_op_qemu_ld_v128, { "V", "L" } },
+    { INDEX_op_qemu_st_v128, { "V", "L" } },
+#endif
+
+#ifdef TCG_TARGET_HAS_REG128
     { INDEX_op_add_i8x16, { "V", "0", "V" } },
     { INDEX_op_add_i16x8, { "V", "0", "V" } },
     { INDEX_op_add_i32x4, { "V", "0", "V" } },
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0925fab..dd92e71 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2350,3 +2350,19 @@ static void tcg_gen_mov2_i64(TCGv_i64 r, TCGv_i64 a, TCGv_i64 b)
 GEN_ATOMIC_HELPER(xchg, mov2, 0)
 
 #undef GEN_ATOMIC_HELPER
+
+void tcg_gen_qemu_ld_v128(TCGv_v128 val, TCGv addr, TCGArg idx,
+                          TCGMemOp memop)
+{
+    assert((memop & MO_BSWAP) == MO_TE);
+    TCGMemOpIdx oi = make_memop_idx(memop, idx);
+    tcg_gen_op3si_v128(INDEX_op_qemu_ld_v128, val, addr, oi);
+}
+
+void tcg_gen_qemu_st_v128(TCGv_v128 val, TCGv addr, TCGArg idx,
+                          TCGMemOp memop)
+{
+    assert((memop & MO_BSWAP) == MO_TE);
+    TCGMemOpIdx oi = make_memop_idx(memop, idx);
+    tcg_gen_op3si_v128(INDEX_op_qemu_st_v128, val, addr, oi);
+}
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 5de74d3..4646f87 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -266,6 +266,12 @@ static inline void tcg_gen_op3_v128(TCGOpcode opc, TCGv_v128 a1,
                 GET_TCGV_V128(a3));
 }
 
+static inline void tcg_gen_op3si_v128(TCGOpcode opc, TCGv_v128 a1,
+                                     TCGv_i32 a2, TCGArg a3)
+{
+    tcg_gen_op3(&tcg_ctx, opc, GET_TCGV_V128(a1), GET_TCGV_I32(a2), a3);
+}
+
 static inline void tcg_gen_op1_v64(TCGOpcode opc, TCGv_v64 a1)
 {
     tcg_gen_op1(&tcg_ctx, opc, GET_TCGV_V64(a1));
@@ -885,6 +891,8 @@ void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
 void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_qemu_ld_v128(TCGv_v128, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_qemu_st_v128(TCGv_v128, TCGv, TCGArg, TCGMemOp);
 
 static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)
 {
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 0022535..8ff1416 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -222,6 +222,10 @@ DEF(qemu_ld_i64, DATA64_ARGS, TLADDR_ARGS, 1,
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
