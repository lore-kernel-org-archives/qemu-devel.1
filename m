Received: from eggs.gnu.org ([209.51.188.92]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmNB-0008UL-QM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:17:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grmNA-0006V4-R3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:17:57 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grmNA-0006Be-E3
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:17:56 -0500
Received: by mail-ot1-x344.google.com with SMTP id u16so673350otk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-6-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 16:17:14 +0000
Message-ID: <CAFEAcA-EA9DHLiuJc=GBjQo6ajN_nU7EhEY_yniEbke5NgWK5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/17] target/arm: Suppress tag check for
 sp+offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 14 Jan 2019 at 01:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> R0078 specifies that base register, or base register plus immediate
> offset, is unchecked when the base register is SP.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 5c2577a9ac..ee95ba7165 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -336,12 +336,11 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
>   * This is always a fresh temporary, as we need to be able to
>   * increment this independently of a dirty write-back address.
>   */
> -static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
> +static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr, bool sp_off)

I think sp_off is not sufficiently general here. For instance
if you look at the pseudocode for LDR (immediate)
 https://developer.arm.com/docs/ddi0596/b/base-instructions-alphabetic-order/ldr-immediate-load-register-immediate
we do the tag check if wback || n != 31.

That is, when the spec says "base register only, or base register
plus immediate offset addressing form", it is referencing the
list of addressing modes in the v8A Arm ARM DDA0487D.a C1.3.3,
and "pre-indexed" and "post-indexed" are separate from "base + immediate".
It looks like your patch is treating pre-indexed and
post-indexed the same as base+imm.

thanks
-- PMM
