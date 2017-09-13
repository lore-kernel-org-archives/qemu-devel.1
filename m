Received: from eggs.gnu.org ([2001:4830:134:3::10]:59082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBzo-00069R-By
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsBzl-0006JO-BP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:44 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:45267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsBzl-0006J5-6x
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:02:41 -0400
Received: by mail-qk0-x236.google.com with SMTP id r141so2419588qke.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:02:41 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506107741.19604.8328467942268087647.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3fb9d3ac-db86-2ff7-d6e1-988982d1eb18@linaro.org>
Date: Wed, 13 Sep 2017 10:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <150506107741.19604.8328467942268087647.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] trace: Add event "guest_bbl_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/10/2017 09:31 AM, Lluís Vilanova wrote:
> +void translator__gen_goto_tb(TCGContext *ctx)
> +{
> +    if (ctx->disas.in_guest_code &&
> +        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
> +        if (ctx->disas.inline_label == NULL) {
> +            ctx->disas.inline_label = gen_new_inline_label();
> +        }
> +        gen_set_inline_point(ctx->disas.inline_label);
> +        /* disable next exit_tb */
> +        ctx->disas.seen_goto_tb = true;
> +    }
> +}
> +
> +void translator__gen_exit_tb(TCGContext *ctx)
> +{
> +    if (ctx->disas.in_guest_code && !ctx->disas.seen_goto_tb &&
> +        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
> +        if (ctx->disas.inline_label == NULL) {
> +            ctx->disas.inline_label = gen_new_inline_label();
> +        }
> +        gen_set_inline_point(ctx->disas.inline_label);
> +        /* enable next exit_tb */
> +        ctx->disas.seen_goto_tb = false;
> +    }
> +}

I don't understand why you wouldn't just modify tcg_gen_goto_tb and
tcg_gen_exit_tb instead.


r~
