Received: from eggs.gnu.org ([2001:4830:134:3::10]:51711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrEF-00026G-L1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrEE-0004Uc-F1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:11 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBrEE-0004U5-AR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:27:10 -0400
Received: by mail-pg0-x244.google.com with SMTP id z4-v6so134262pgu.13
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 17:27:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Apr 2018 14:26:47 -1000
Message-Id: <20180427002651.28356-6-richard.henderson@linaro.org>
In-Reply-To: <20180427002651.28356-1-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/9] target/riscv: Use new atomic min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 72 ++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 808eab7f50..9cab717088 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -725,7 +725,6 @@ static void gen_atomic(DisasContext *ctx, uint32_t opc,
     TCGv src1, src2, dat;
     TCGLabel *l1, *l2;
     TCGMemOp mop;
-    TCGCond cond;
     bool aq, rl;
 
     /* Extract the size of the atomic operation.  */
@@ -823,60 +822,29 @@ static void gen_atomic(DisasContext *ctx, uint32_t opc,
         tcg_gen_atomic_fetch_or_tl(src2, src1, src2, ctx->mem_idx, mop);
         gen_set_gpr(rd, src2);
         break;
-
     case OPC_RISC_AMOMIN:
-        cond = TCG_COND_LT;
-        goto do_minmax;
-    case OPC_RISC_AMOMAX:
-        cond = TCG_COND_GT;
-        goto do_minmax;
-    case OPC_RISC_AMOMINU:
-        cond = TCG_COND_LTU;
-        goto do_minmax;
-    case OPC_RISC_AMOMAXU:
-        cond = TCG_COND_GTU;
-        goto do_minmax;
-    do_minmax:
-        /* Handle the RL barrier.  The AQ barrier is handled along the
-           parallel path by the SC atomic cmpxchg.  On the serial path,
-           of course, barriers do not matter.  */
-        if (rl) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        }
-        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
-            l1 = gen_new_label();
-            gen_set_label(l1);
-        } else {
-            l1 = NULL;
-        }
-
         gen_get_gpr(src1, rs1);
         gen_get_gpr(src2, rs2);
-        if ((mop & MO_SSIZE) == MO_SL) {
-            /* Sign-extend the register comparison input.  */
-            tcg_gen_ext32s_tl(src2, src2);
-        }
-        dat = tcg_temp_local_new();
-        tcg_gen_qemu_ld_tl(dat, src1, ctx->mem_idx, mop);
-        tcg_gen_movcond_tl(cond, src2, dat, src2, dat, src2);
-
-        if (tb_cflags(ctx->tb) & CF_PARALLEL) {
-            /* Parallel context.  Make this operation atomic by verifying
-               that the memory didn't change while we computed the result.  */
-            tcg_gen_atomic_cmpxchg_tl(src2, src1, dat, src2, ctx->mem_idx, mop);
-
-            /* If the cmpxchg failed, retry. */
-            /* ??? There is an assumption here that this will eventually
-               succeed, such that we don't live-lock.  This is not unlike
-               a similar loop that the compiler would generate for e.g.
-               __atomic_fetch_and_xor, so don't worry about it.  */
-            tcg_gen_brcond_tl(TCG_COND_NE, dat, src2, l1);
-        } else {
-            /* Serial context.  Directly store the result.  */
-            tcg_gen_qemu_st_tl(src2, src1, ctx->mem_idx, mop);
-        }
-        gen_set_gpr(rd, dat);
-        tcg_temp_free(dat);
+        tcg_gen_atomic_fetch_smin_tl(src2, src1, src2, ctx->mem_idx, mop);
+        gen_set_gpr(rd, src2);
+        break;
+    case OPC_RISC_AMOMAX:
+        gen_get_gpr(src1, rs1);
+        gen_get_gpr(src2, rs2);
+        tcg_gen_atomic_fetch_smax_tl(src2, src1, src2, ctx->mem_idx, mop);
+        gen_set_gpr(rd, src2);
+        break;
+    case OPC_RISC_AMOMINU:
+        gen_get_gpr(src1, rs1);
+        gen_get_gpr(src2, rs2);
+        tcg_gen_atomic_fetch_umin_tl(src2, src1, src2, ctx->mem_idx, mop);
+        gen_set_gpr(rd, src2);
+        break;
+    case OPC_RISC_AMOMAXU:
+        gen_get_gpr(src1, rs1);
+        gen_get_gpr(src2, rs2);
+        tcg_gen_atomic_fetch_umax_tl(src2, src1, src2, ctx->mem_idx, mop);
+        gen_set_gpr(rd, src2);
         break;
 
     default:
-- 
2.14.3
