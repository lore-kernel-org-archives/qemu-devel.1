Received: from eggs.gnu.org ([2001:4830:134:3::10]:45147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTUK-0007gN-I1
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTUJ-00027c-I2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:33:08 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTUJ-00027E-2d
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:33:07 -0400
Received: by mail-ot0-x242.google.com with SMTP id i19-v6so15508338otk.10
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-8-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:32:45 +0100
Message-ID: <CAFEAcA-n1fcCk9LfgZPnphHpft+iYXH3t1+2-7RtdmjH2jRksw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 07/35] target/arm: Implement SVE FP
 Multiply-Add Group
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
>  target/arm/helper-sve.h    |  16 ++++
>  target/arm/sve_helper.c    | 158 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  49 ++++++++++++
>  target/arm/sve.decode      |  17 ++++
>  4 files changed, 240 insertions(+)

> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 636212a638..70e5a3aeb5 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -128,6 +128,8 @@
>                  &rprrr_esz ra=%reg_movprfx
>  @rdn_pg_ra_rm   ........ esz:2 . rm:5  ... pg:3 ra:5 rd:5 \
>                  &rprrr_esz rn=%reg_movprfx
> +@rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
> +                &rprrr_esz rn=%reg_movprfx

>  # One register operand, with governing predicate, vector element size
>  @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
> @@ -701,6 +703,21 @@ FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
>  FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
>  FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
>
> +### SVE FP Multiply-Add Group
> +
> +# SVE floating-point multiply-accumulate writing addend
> +FMLA_zpzzz      01100101 .. 1 ..... 000 ... ..... .....         @rda_pg_rn_rm
> +FMLS_zpzzz      01100101 .. 1 ..... 001 ... ..... .....         @rda_pg_rn_rm
> +FNMLA_zpzzz     01100101 .. 1 ..... 010 ... ..... .....         @rda_pg_rn_rm
> +FNMLS_zpzzz     01100101 .. 1 ..... 011 ... ..... .....         @rda_pg_rn_rm
> +
> +# SVE floating-point multiply-accumulate writing multiplicand
> +# FMAD, FMSB, FNMAD, FNMS
> +FMLA_zpzzz      01100101 .. 1 ..... 100 ... ..... .....         @rdn_pg_rm_ra
> +FMLS_zpzzz      01100101 .. 1 ..... 101 ... ..... .....         @rdn_pg_rm_ra
> +FNMLA_zpzzz     01100101 .. 1 ..... 110 ... ..... .....         @rdn_pg_rm_ra
> +FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra

It's not clear to me how we can implement both of these groups
with the same functions. Some commentary might help.

thanks
-- PMM
