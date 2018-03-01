Received: from eggs.gnu.org ([2001:4830:134:3::10]:49907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOex-0007hy-4D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOew-00069G-Dy
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:54:11 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erOew-00068T-6q
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:54:10 -0500
Received: by mail-oi0-x241.google.com with SMTP id g5so4488660oiy.8
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 05:54:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-14-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 13:53:48 +0000
Message-ID: <CAFEAcA-M_5=8JFjqgLP9qCF+ZyHqWJGqpfaObZdt60K7W-AS-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 13/16] target/arm: Decode aa32 armv8.3
 3-same
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

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 9169b6b367..45513c9d86 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7680,6 +7680,68 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>      return 0;
>  }
>
> +/* Advanced SIMD three registers of the same length extension.
> + *  31           25    23  22    20   16   12  11   10   9    8        3     0
> + * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
> + * | 1 1 1 1 1 1 0 | op1 | D | op2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
> + * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
> + */
> +static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
> +{
> +    gen_helper_gvec_3_ptr *fn_gvec_ptr;
> +    int rd, rn, rm, rot, size, opr_sz;
> +    TCGv_ptr fpst;
> +    bool q;
> +
> +    q = extract32(insn, 6, 1);
> +    VFP_DREG_D(rd, insn);
> +    VFP_DREG_N(rn, insn);
> +    VFP_DREG_M(rm, insn);
> +    if ((rd | rn | rm) & q) {
> +        return 1;
> +    }
> +
> +    if ((insn & 0xfe200f10) == 0xfc200800) {

Slightly confusing to be re-checking bits we've already decoded,
rather than just looking at op1/op2/op3/op4/Q/U.

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
