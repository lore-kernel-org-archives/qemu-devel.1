Received: from eggs.gnu.org ([209.51.188.92]:53292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grndV-0000XW-C6
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grndU-0002Er-HI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:38:53 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grndT-0002B2-JZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:38:52 -0500
Received: by mail-ot1-x342.google.com with SMTP id 32so1119308ota.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-10-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 17:38:21 +0000
Message-ID: <CAFEAcA8LJFuA_NguXbLooebcw6X2-9hpUdgBwSv70evAdR=gQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/17] target/arm: Implement the SUBP
 instruction
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

On Mon, 14 Jan 2019 at 01:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 6583ad93b1..98ff60c161 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5111,19 +5111,39 @@ static void handle_crc32(DisasContext *s,
>   */
>  static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>  {
> -    unsigned int sf, rm, opcode, rn, rd;
> +    unsigned int sf, rm, opcode, rn, rd, setflag;
>      sf = extract32(insn, 31, 1);
> +    setflag = extract32(insn, 29, 1);
>      rm = extract32(insn, 16, 5);
>      opcode = extract32(insn, 10, 6);
>      rn = extract32(insn, 5, 5);
>      rd = extract32(insn, 0, 5);
>
> -    if (extract32(insn, 29, 1)) {
> +    if (setflag && opcode != 0) {
>          unallocated_encoding(s);
>          return;
>      }
>
>      switch (opcode) {
> +    case 0: /* SUBP(S) */
> +        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
> +            goto do_unallocated;
> +        } else {
> +            TCGv_i64 tcg_n, tcg_m, tcg_d;
> +
> +            tcg_n = read_cpu_reg_sp(s, rn, true);
> +            tcg_m = read_cpu_reg_sp(s, rm, true);
> +            tcg_gen_sextract_i64(tcg_n, tcg_n, 0, 55);
> +            tcg_gen_sextract_i64(tcg_m, tcg_m, 0, 55);

Shouldn't the lengths here be 56, not 55 ? We're doing the
sign-extend of bits [55:0] to 64 bits.

> +            tcg_d = cpu_reg(s, rd);
> +
> +            if (setflag) {
> +                gen_sub_CC(true, tcg_d, tcg_n, tcg_m);
> +            } else {
> +                tcg_gen_sub_i64(tcg_d, tcg_n, tcg_m);
> +            }
> +        }
> +        break;
>      case 2: /* UDIV */
>          handle_div(s, false, sf, rm, rn, rd);
>          break;
> --
> 2.17.2

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
