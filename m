Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWiwN-0003ov-71
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWiwJ-0005eO-3P
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:11 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWiwI-0005eB-TE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:14:07 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so50050349wme.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 04:14:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170123021748.13170-1-rth@twiddle.net>
	<20170123021748.13170-22-rth@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d010ae34-9ddd-d5fc-1fa0-82d3d2341c95@redhat.com>
Date: Thu, 26 Jan 2017 13:14:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170123021748.13170-22-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/26] target-hppa: Implement branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

I haven't studied the code much, so I'm just reporting what Coverity
says.  Not sure if the code has a bug or can just be simplified.

On 23/01/2017 03:17, Richard Henderson wrote:
> +/* Emit a conditional branch to a direct target.  If the branch itself
> +   is nullified, we should have already used nullify_over.  */
> +static ExitStatus do_cbranch(DisasContext *ctx, target_long disp, bool is_n,
> +                             DisasCond *cond)
> +{
> +    target_ulong dest = iaoq_dest(ctx, disp);
> +    TCGLabel *taken = NULL;
> +    TCGCond c = cond->c;
> +    int which = 0;
> +    bool n;
> +
> +    assert(ctx->null_cond.c == TCG_COND_NEVER);
> +
> +    /* Handle TRUE and NEVER as direct branches.  */
> +    if (c == TCG_COND_ALWAYS) {
> +        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
> +    }
> +    if (c == TCG_COND_NEVER) {
> +        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
> +    }
> +
> +    taken = gen_new_label();
> +    cond_prep(cond);
> +    tcg_gen_brcond_tl(c, cond->a0, cond->a1, taken);
> +    cond_free(cond);
> +
> +    /* Not taken: Condition not satisfied; nullify on backward branches. */
> +    n = is_n && disp < 0;
> +    if (n && use_nullify_skip(ctx)) {
> +        nullify_set(ctx, 0);
> +        gen_goto_tb(ctx, which++, ctx->iaoq_n, ctx->iaoq_n + 4);
> +    } else {
> +        if (!n && ctx->null_lab) {
> +            gen_set_label(ctx->null_lab);
> +            ctx->null_lab = NULL;
> +        }
> +        nullify_set(ctx, n);
> +        gen_goto_tb(ctx, which++, ctx->iaoq_b, ctx->iaoq_n);
> +    }

Both branches increment "which", so you can replace it with 0 and which
is always 1 now.

> +    gen_set_label(taken);
> +
> +    /* Taken: Condition satisfied; nullify on forward branches.  */
> +    n = is_n && disp >= 0;
> +    if (n && use_nullify_skip(ctx)) {
> +        nullify_set(ctx, 0);
> +        gen_goto_tb(ctx, which++, dest, dest + 4);
> +    } else {
> +        nullify_set(ctx, n);
> +        gen_goto_tb(ctx, which++, ctx->iaoq_b, dest);
> +    }

Both branches increment "which", so you can replace it with 1 and which
is always 2.

> +    /* Not taken: the branch itself was nullified.  */
> +    if (ctx->null_lab) {
> +        gen_set_label(ctx->null_lab);
> +        ctx->null_lab = NULL;
> +        if (which < 2) {
> +            nullify_set(ctx, 0);
> +            gen_goto_tb(ctx, which, ctx->iaoq_b, ctx->iaoq_n);
> +            return EXIT_GOTO_TB;

So this branch of the "if" is dead.

> +        } else {
> +            return EXIT_IAQ_N_STALE;
> +        }
> +    } else {
> +        return EXIT_GOTO_TB;
> +    }
> +}
