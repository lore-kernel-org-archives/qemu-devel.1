Received: from eggs.gnu.org ([209.51.188.92]:42825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggvu4-0002B5-N4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggvu0-0006V5-5D
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:15:04 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggvtz-0006O9-ST
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:14:59 -0500
Received: by mail-oi1-x243.google.com with SMTP id y1so4074323oie.12
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 10:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20190106225035.5671-1-richard.henderson@linaro.org>
	<20190106225035.5671-4-richard.henderson@linaro.org>
In-Reply-To: <20190106225035.5671-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 18:14:46 +0000
Message-ID: <CAFEAcA_Qp4t7xOrprhhjPSMDiPH5HNkJuVm57AfvTu53ZYOK8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Use vector minmax
 expanders for aarch32
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

On Sun, 6 Jan 2019 at 22:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 33b1860148..f3f172f384 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6368,6 +6368,25 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>              tcg_gen_gvec_cmp(u ? TCG_COND_GEU : TCG_COND_GE, size,
>                               rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size);
>              return 0;
> +
> +        case NEON_3R_VMAX:
> +            if (u) {
> +                tcg_gen_gvec_umax(size, rd_ofs, rn_ofs, rm_ofs,
> +                                  vec_size, vec_size);
> +            } else {
> +                tcg_gen_gvec_smax(size, rd_ofs, rn_ofs, rm_ofs,
> +                                  vec_size, vec_size);
> +            }
> +            return 0;
> +        case NEON_3R_VMIN:
> +            if (u) {
> +                tcg_gen_gvec_umin(size, rd_ofs, rn_ofs, rm_ofs,
> +                                  vec_size, vec_size);
> +            } else {
> +                tcg_gen_gvec_smin(size, rd_ofs, rn_ofs, rm_ofs,
> +                                  vec_size, vec_size);
> +            }
> +            return 0;
>          }
>
>          if (size == 3) {
> @@ -6533,12 +6552,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>          case NEON_3R_VQRSHL:
>              GEN_NEON_INTEGER_OP_ENV(qrshl);
>              break;
> -        case NEON_3R_VMAX:
> -            GEN_NEON_INTEGER_OP(max);
> -            break;
> -        case NEON_3R_VMIN:
> -            GEN_NEON_INTEGER_OP(min);
> -            break;
>          case NEON_3R_VABD:
>              GEN_NEON_INTEGER_OP(abd);
>              break;
> --

This leaves the helpers neon_max_[su]{8,16} unused and deletable,
I think? neon_max_[su]32 is used only via the #defines of
neon_pmax_[su]32 so could be renamed to pmax. Similarly min/pmin.

thanks
-- PMM
