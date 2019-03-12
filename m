Received: from eggs.gnu.org ([209.51.188.92]:39276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3WCm-0001dT-V5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3W3E-0001GY-67
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:17:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3W3A-0001E0-Lc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:17:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id b2so473062pgl.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:17:48 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-8-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef0b3df0-806d-bf50-1539-a57d925917d1@linaro.org>
Date: Mon, 11 Mar 2019 18:17:44 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-8-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/11] target/hppa: fix b,gate instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:15 PM, Sven Schnelle wrote:
> b,gate does GR[t] ← cat(GR[t]{0..29},IAOQ_Front{30..31});
> instead of saving the link address to register t.
> 

Quite right.  Silly mistake.

>  #ifndef CONFIG_USER_ONLY
> +    TCGv_reg tmp;
>      if (ctx->tb_flags & PSW_C) {
>          CPUHPPAState *env = ctx->cs->env_ptr;
>          int type = hppa_artype_for_page(env, ctx->base.pc_next);
> @@ -3480,12 +3481,13 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
>          if (type >= 4 && type - 4 < ctx->privilege) {
>              dest = deposit32(dest, 0, 2, type - 4);
>          }
> +        tmp = dest_gpr(ctx, a->l);
> +        tcg_gen_deposit_reg(tmp, tmp, cpu_iaoq_f, 0, 2);
>      } else {
>          dest &= -4;  /* priv = 0 */
>      }
>  #endif
> -
> -    return do_dbranch(ctx, dest, a->l, a->n);
> +    return do_dbranch(ctx, dest, 0, a->n);

This change needs to be outside the CONFIG_USER_ONLY.  It needs to handle
nullification (which was previously all handled in do_dbranch).  I'm thinking
of something like the following.


r~


diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f3e78b8e22..6ac196804b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3446,6 +3446,8 @@ static bool trans_b_gate
 {
     target_ureg dest = iaoq_dest(ctx, a->disp);

+    nullify_over(ctx);
+
     /* Make sure the caller hasn't done something weird with the queue.
      * ??? This is not quite the same as the PSW[B] bit, which would be
      * expensive to track.  Real hardware will trap for
@@ -3483,7 +3485,16 @@ static bool trans_b_gate
     }
 #endif

-    return do_dbranch(ctx, dest, a->l, a->n);
+    if (a->l) {
+        TCGv_reg tmp = dest_gpr(ctx, a->l);
+        if (ctx->privilege < 3) {
+            tcg_gen_andi_reg(tmp, tmp, -4);
+        }
+        tcg_gen_ori_reg(tmp, tmp, ctx->privilege);
+        save_gpr(ctx, a->l, tmp);
+    }
+
+    return do_dbranch(ctx, dest, 0, a->n);
 }

 static bool trans_blr(DisasContext *ctx, arg_blr *a)
