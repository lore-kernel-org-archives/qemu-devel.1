Received: from eggs.gnu.org ([209.51.188.92]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002n2-9s
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8o-0001vp-AK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:01 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:32919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8m-0001hX-IM
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:54 -0500
Received: by mail-pg1-x531.google.com with SMTP id z11so680771pgu.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:13 -0800
Message-Id: <20190212045721.28041-17-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 16/24] target/hppa: Convert halt/reset insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 49 ++++++++++++----------------------------
 target/hppa/insns.decode |  5 ++++
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4ecd522e51..c73a7ab3db 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2376,20 +2376,27 @@ static bool trans_rfi_r(DisasContext *ctx, arg_rfi_r *a)
     return do_rfi(ctx, true);
 }
 
-#ifndef CONFIG_USER_ONLY
-static bool gen_hlt(DisasContext *ctx, int reset)
+static bool trans_halt(DisasContext *ctx, arg_halt *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
     nullify_over(ctx);
-    if (reset) {
-        gen_helper_reset(cpu_env);
-    } else {
-        gen_helper_halt(cpu_env);
-    }
+    gen_helper_halt(cpu_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
+#endif
+}
+
+static bool trans_reset(DisasContext *ctx, arg_reset *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+    gen_helper_reset(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return nullify_end(ctx);
+#endif
 }
-#endif /* !CONFIG_USER_ONLY */
 
 static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
 {
@@ -4134,32 +4141,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
     case 0x2E:
         translate_table(ctx, insn, table_fp_fused);
         return;
-
-    case 0x04: /* spopn */
-    case 0x05: /* diag */
-    case 0x0F: /* product specific */
-        break;
-
-    case 0x07: /* unassigned */
-    case 0x15: /* unassigned */
-    case 0x1D: /* unassigned */
-    case 0x37: /* unassigned */
-        break;
-    case 0x3F:
-#ifndef CONFIG_USER_ONLY
-        /* Unassigned, but use as system-halt.  */
-        if (insn == 0xfffdead0) {
-            gen_hlt(ctx, 0); /* halt system */
-            return;
-        }
-        if (insn == 0xfffdead1) {
-            gen_hlt(ctx, 1); /* reset system */
-            return;
-        }
-#endif
-        break;
-    default:
-        break;
     }
     gen_illegal(ctx);
 }
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 25ac09d9d6..f564e54f1d 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -103,6 +103,11 @@ ssm             000000 ..........  000 01101011 t:5     i=%sm_imm
 rfi             000000 ----- ----- --- 01100000 00000
 rfi_r           000000 ----- ----- --- 01100101 00000
 
+# These are artificial instructions used by QEMU firmware.
+# They are allocated from the unassigned instruction space.
+halt            1111 1111 1111 1101 1110 1010 1101 0000
+reset           1111 1111 1111 1101 1110 1010 1101 0001
+
 ####
 # Memory Management
 ####
-- 
2.17.2
