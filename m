Received: from eggs.gnu.org ([2001:4830:134:3::10]:54532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDkk-0005QN-30
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDkh-0003J0-W3
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:01:56 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egDkh-0003IG-Ov
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:01:55 -0500
Received: by mail-ot0-x244.google.com with SMTP id x4so7373044otg.7
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 10:01:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-6-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 18:01:34 +0000
Message-ID: <CAFEAcA_HKrxOc9rwiZfbVBW4r14F5u-+y-AATH1yvs6bELZnVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/arm: Add SVE state to
 TB->FLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 23 January 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Add both SVE exception state and vector length.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 10eef870fe..4c1eca7062 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11263,6 +11263,8 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>      dc->user = (dc->current_el == 0);
>  #endif
>      dc->fp_excp_el = ARM_TBFLAG_FPEXC_EL(dc->base.tb->flags);
> +    dc->sve_excp_el = ARM_TBFLAG_SVEEXC_EL(dc->base.tb->flags);
> +    dc->sve_len = (ARM_TBFLAG_ZCR_LEN(dc->base.tb->flags) + 1) * 16;

You've carefully arranged that the sve_excp checks are a superset
of the fp_excp checks, which means that we get the correct
exception prioritization by always doing the sve_excp check first
and then the fp_excp check second, without having to look at
whether fp_excp_el or sve_excp_el is larger to see which should
take precedence. We could
  assert(dc->sve_excp_el <= dc->fp_excp_el);
and perhaps have a comment noting why this is useful...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
