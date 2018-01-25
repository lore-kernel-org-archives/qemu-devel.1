Received: from eggs.gnu.org ([2001:4830:134:3::10]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekwM-0004EX-Nc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekwL-000685-PT
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:03:54 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekwL-00067O-Ka
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:03:53 -0500
Received: by mail-oi0-x242.google.com with SMTP id s11so5687771oih.11
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:03:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-16-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 17:03:32 +0000
Message-ID: <CAFEAcA_tFAC-Zcn4UGkOT6h1H+QPxttNJe=M+cfbbXLUvBqAYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10.5 15/20] target/arm: Use vector
 infrastructure for aa64 constant shifts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 386 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 329 insertions(+), 57 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 2495414603..1b5005637d 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -6489,17 +6489,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
>      }
>  }
>
> -/* Common SHL/SLI - Shift left with an optional insert */
> -static void handle_shli_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
> -                                 bool insert, int shift)
> -{
> -    if (insert) { /* SLI */
> -        tcg_gen_deposit_i64(tcg_res, tcg_res, tcg_src, shift, 64 - shift);
> -    } else { /* SHL */
> -        tcg_gen_shli_i64(tcg_res, tcg_src, shift);
> -    }
> -}
> -
>  /* SRI: shift right with insert */
>  static void handle_shri_with_ins(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
>                                   int size, int shift)
> @@ -6603,7 +6592,11 @@ static void handle_scalar_simd_shli(DisasContext *s, bool insert,
>      tcg_rn = read_fp_dreg(s, rn);
>      tcg_rd = insert ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
>
> -    handle_shli_with_ins(tcg_rd, tcg_rn, insert, shift);
> +    if (insert) {
> +        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, shift, 64 - shift);
> +    } else {
> +        tcg_gen_shli_i64(tcg_rd, tcg_rn, shift);
> +    }

It looks like you're folding handle_shli_with_ins() into its
now only callsite, but handle_shri_with_ins() has been left as
its own function?

> +static void gen_shr8_ins_i64(TCGv_i64 d, TCGv_i64 a, int64_t shift)
> +{
> +    uint64_t mask = (0xff >> shift) * (-1ull / 0xff);
> +    TCGv_i64 t = tcg_temp_new_i64();
> +
> +    tcg_gen_shri_i64(t, a, shift);
> +    tcg_gen_andi_i64(t, t, mask);
> +    tcg_gen_andi_i64(d, d, ~mask);
> +    tcg_gen_or_i64(d, d, t);
> +    tcg_temp_free_i64(t);

The previous code was able to work with just shifts and deposits --
why do we need to open-code this kind of mask-and-or now? Is this
because we now operate an i64 at a time when we used to operate
on smaller quantities at once?

thanks
-- PMM
