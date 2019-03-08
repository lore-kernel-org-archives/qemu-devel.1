Received: from eggs.gnu.org ([209.51.188.92]:58356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2KnQ-0004Oi-A6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2KnO-0005w9-Ed
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:04:40 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2KnM-0005uW-EZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:04:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id i8so16690105oib.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 11:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20190308185932.4954-1-richard.henderson@linaro.org>
In-Reply-To: <20190308185932.4954-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 19:04:23 +0000
Message-ID: <CAFEAcA_ri8+bspkOhfmWu2fyPxomECZ2WPButBG6qOscBOWLZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/hppa: Check for page crossings in
 use_goto_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sven Schnelle <svens@stackframe.org>

On Fri, 8 Mar 2019 at 19:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We got away with eliding this check when target/hppa was user-only,
> but missed adding this check when adding system support.
>
> Fixes an early crash in the HP-UX 11 installer.
>
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index dc5636fe94..6c815e05c2 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -816,12 +816,10 @@ static bool gen_illegal(DisasContext *ctx)
>
>  static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
>  {
> -    /* Suppress goto_tb in the case of single-steping and IO.  */
> -    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO)
> -        || ctx->base.singlestep_enabled) {
> -        return false;
> -    }
> -    return true;
> +    /* Suppress goto_tb for page crossing, IO, or single-steping.  */

"stepping"

> +    return !(((ctx->base.pc_first ^ dest) & TARGET_PAGE_MASK)
> +             || (tb_cflags(ctx->base.tb) & CF_LAST_IO)
> +             || ctx->base.singlestep_enabled);
>  }

I note that (a) this isn't the way every other port phrases
the "same page" check -- they generally use something like
 (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK)
and (b) the other ports generally keep that check inside an
ifndef CONFIG_USER_ONLY.

>
>  /* If the next insn is to be nullified, and it's on the same page,
> --
> 2.17.2

thanks
-- PMM
