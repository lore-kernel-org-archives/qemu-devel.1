Received: from eggs.gnu.org ([2001:4830:134:3::10]:42052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99Q-0000M7-Fk
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en99P-0000qu-Dg
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:04 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en99P-0000qk-7Y
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:32:03 -0500
Received: by mail-pl0-x244.google.com with SMTP id v3so3541212plg.3
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:32:03 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.32.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:32:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:29 -0800
Message-Id: <20180217203132.31780-17-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/19] target/hppa: Convert halt/reset insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 49 +++++++++++++++---------------------------------
 target/hppa/insns.decode |  5 +++++
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1973923a18..5abe4cd610 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2384,20 +2384,27 @@ static void trans_rfi_r(DisasContext *ctx, arg_rfi_r *a, uint32_t insn)
     do_rfi(ctx, true);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void gen_hlt(DisasContext *ctx, int reset)
+static void trans_halt(DisasContext *ctx, arg_halt *a, uint32_t insn)
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
     nullify_end(ctx);
+#endif
+}
+
+static void trans_reset(DisasContext *ctx, arg_reset *a, uint32_t insn)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    nullify_over(ctx);
+    gen_helper_reset(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    nullify_end(ctx);
+#endif
 }
-#endif /* !CONFIG_USER_ONLY */
 
 static void trans_nop_addrx(DisasContext *ctx, arg_ldst *a, uint32_t insn)
 {
@@ -4126,32 +4133,6 @@ static void translate_one(DisasContext *ctx, uint32_t insn)
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
index 1e4579e080..ddbbaefd83 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -101,6 +101,11 @@ ssm		000000 ..........  000 01101011 t:5	i=%sm_imm
 rfi		000000 ----- ----- --- 01100000 00000
 rfi_r		000000 ----- ----- --- 01100101 00000
 
+# These are artificial instructions used by QEMU firmware.
+# They are allocated from the unassigned instruction space.
+halt		1111 1111 1111 1101 1110 1010 1101 0000
+reset		1111 1111 1111 1101 1110 1010 1101 0001
+
 ####
 # Memory Management
 ####
-- 
2.14.3
