Received: from eggs.gnu.org ([2001:4830:134:3::10]:50726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDE-00031W-3E
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDD-0004gL-1n
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:12 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDC-0004g2-Ru
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:10 -0500
Received: by mail-pl0-x244.google.com with SMTP id b12so22519302plm.3
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:23 -0800
Message-Id: <20171229063145.29167-17-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/38] target/hppa: Avoid privilege level
 decrease during branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

These instructions force the destination privilege level
of the branch destination to be no higher than current.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 52 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4d5974c94d..918b444895 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1859,6 +1859,40 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv_reg dest,
     return DISAS_NEXT;
 }
 
+/* Implement
+ *    if (IAOQ_Front{30..31} < GR[b]{30..31})
+ *      IAOQ_Next{30..31} ← GR[b]{30..31};
+ *    else
+ *      IAOQ_Next{30..31} ← IAOQ_Front{30..31};
+ * which keeps the privilege level from being increased.
+ */
+static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
+{
+#ifdef CONFIG_USER_ONLY
+    return offset;
+#else
+    TCGv_reg dest;
+    switch (ctx->privilege) {
+    case 0:
+        /* Privilege 0 is maximum and is allowed to decrease.  */
+        return offset;
+    case 3:
+        /* Privilege 3 is minimum and is never allowed increase.  */
+        dest = get_temp(ctx);
+        tcg_gen_ori_reg(dest, offset, 3);
+        break;
+    default:
+        dest = tcg_temp_new();
+        tcg_gen_andi_reg(dest, offset, -4);
+        tcg_gen_ori_reg(dest, dest, ctx->privilege);
+        tcg_gen_movcond_reg(TCG_COND_GTU, dest, dest, offset, dest, offset);
+        tcg_temp_free(dest);
+        break;
+    }
+    return dest;
+#endif
+}
+
 #ifdef CONFIG_USER_ONLY
 /* On Linux, page zero is normally marked execute only + gateway.
    Therefore normal read or write is supposed to fail, but specific
@@ -3438,6 +3472,7 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
     unsigned n = extract32(insn, 1, 1);
     unsigned b = extract32(insn, 21, 5);
     target_sreg disp = assemble_17(insn);
+    TCGv_reg tmp;
 
     /* unsigned s = low_uextract(insn, 13, 3); */
     /* ??? It seems like there should be a good way of using
@@ -3446,16 +3481,19 @@ static DisasJumpType trans_be(DisasContext *ctx, uint32_t insn, bool is_l)
        manage along side branch delay slots.  Therefore we handle
        entry into the gateway page via absolute address.  */
 
+#ifdef CONFIG_USER_ONLY
     /* Since we don't implement spaces, just branch.  Do notice the special
        case of "be disp(*,r0)" using a direct branch to disp, so that we can
        goto_tb to the TB containing the syscall.  */
     if (b == 0) {
         return do_dbranch(ctx, disp, is_l ? 31 : 0, n);
-    } else {
-        TCGv_reg tmp = get_temp(ctx);
-        tcg_gen_addi_reg(tmp, load_gpr(ctx, b), disp);
-        return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
     }
+#endif
+
+    tmp = get_temp(ctx);
+    tcg_gen_addi_reg(tmp, load_gpr(ctx, b), disp);
+    tmp = do_ibranch_priv(ctx, tmp);
+    return do_ibranch(ctx, tmp, is_l ? 31 : 0, n);
 }
 
 static DisasJumpType trans_bl(DisasContext *ctx, uint32_t insn,
@@ -3487,6 +3525,7 @@ static DisasJumpType trans_blr(DisasContext *ctx, uint32_t insn,
 
     tcg_gen_shli_reg(tmp, load_gpr(ctx, rx), 3);
     tcg_gen_addi_reg(tmp, tmp, ctx->iaoq_f + 8);
+    /* The computation here never changes privilege level.  */
     return do_ibranch(ctx, tmp, link, n);
 }
 
@@ -3505,6 +3544,7 @@ static DisasJumpType trans_bv(DisasContext *ctx, uint32_t insn,
         tcg_gen_shli_reg(dest, load_gpr(ctx, rx), 3);
         tcg_gen_add_reg(dest, dest, load_gpr(ctx, rb));
     }
+    dest = do_ibranch_priv(ctx, dest);
     return do_ibranch(ctx, dest, 0, n);
 }
 
@@ -3514,8 +3554,10 @@ static DisasJumpType trans_bve(DisasContext *ctx, uint32_t insn,
     unsigned n = extract32(insn, 1, 1);
     unsigned rb = extract32(insn, 21, 5);
     unsigned link = extract32(insn, 13, 1) ? 2 : 0;
+    TCGv_reg dest;
 
-    return do_ibranch(ctx, load_gpr(ctx, rb), link, n);
+    dest = do_ibranch_priv(ctx, load_gpr(ctx, rb));
+    return do_ibranch(ctx, dest, link, n);
 }
 
 static const DisasInsn table_branch[] = {
-- 
2.14.3
