Received: from eggs.gnu.org ([2001:4830:134:3::10]:50719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTm2-0000Ig-S4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTm1-00013u-W8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:51:26 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTm1-00013g-Qf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:51:25 -0400
Received: by mail-ot0-x243.google.com with SMTP id i17-v6so4717470otl.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:51:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-11-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:51:04 +0100
Message-ID: <CAFEAcA8iD6mqimB5T4jfstfqWpUp8Pv=CtH3GwvM1mNaS0bQiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 10/35] target/arm: Implement SVE store
 vector/predicate register
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 103 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |   6 +++
>  2 files changed, 109 insertions(+)
>
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 954d6653d3..50f1ff75ef 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3762,6 +3762,89 @@ static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
>      tcg_temp_free_i64(t0);
>  }
>
> +/* Similarly for stores.  */
> +static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
> +                   int rn, int imm)
> +{


> +    /* Predicate register stores can be any multiple of 2.  */
> +    if (len_remain) {
> +        tcg_gen_ld_i64(t0, cpu_env, vofs + len_align);
> +        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
> +
> +        switch (len_remain) {
> +        case 2:
> +        case 4:
> +        case 8:
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
> +            break;
> +
> +        case 6:
> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUL);
> +            tcg_gen_addi_i64(addr, addr, 4);
> +            tcg_gen_shri_i64(addr, addr, 32);

Shouldn't this be shifting t0 rather than addr ?

> +            tcg_gen_qemu_st_i64(t0, addr, midx, MO_LEUW);
> +            break;
> +
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
