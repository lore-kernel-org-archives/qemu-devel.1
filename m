Received: from eggs.gnu.org ([2001:4830:134:3::10]:44035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epC4Q-0006RX-Q1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epC4P-0003Mv-Ph
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:03:22 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epC4P-0003Lo-Ks
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:03:21 -0500
Received: by mail-pf0-x241.google.com with SMTP id a17so3425687pff.8
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 04:03:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-12-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 12:03:00 +0000
Message-ID: <CAFEAcA_5bBJiFKZ7PGW6KW0Em9rGsZU57s97t11674Yify60Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 11/67] target/arm: Implement
 SVE bitwise shift by immediate (predicated)
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  25 +++++
>  target/arm/sve_helper.c    | 265 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 128 ++++++++++++++++++++++
>  target/arm/sve.decode      |  29 ++++-
>  4 files changed, 445 insertions(+), 2 deletions(-)

>
> +/*
> + * Helpers for extracting complex instruction fields.
> + */
> +
> +/* See e.g. ASL (immediate, predicated).

Typo for "ASR", I guess ?

> + * Returns -1 for unallocated encoding; diagnose later.
> + */
> +static int tszimm_esz(int x)
> +{
> +    x >>= 3;  /* discard imm3 */
> +    return 31 - clz32(x);
> +}
> +
> +static int tszimm_shr(int x)
> +{
> +    return (16 << tszimm_esz(x)) - x;
> +}
> +
> +/* See e.g. LSL (immediate, predicated).  */
> +static int tszimm_shl(int x)
> +{
> +    return x - (8 << tszimm_esz(x));
> +}

> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -22,12 +22,20 @@
>  ###########################################################################
>  # Named fields.  These are primarily for disjoint fields.
>
> +%imm6_22_5     22:1 5:5
>  %imm9_16_10    16:s6 10:3
>  %preg4_5       5:4
>
> +# A combination of tsz:imm3 -- extract esize.
> +%tszimm_esz    22:2 5:5 !function=tszimm_esz
> +# A combination of tsz:imm3 -- extract (2 * esize) - (tsz:imm3)
> +%tszimm_shr    22:2 5:5 !function=tszimm_shr
> +# A combination of tsz:imm3 -- extract (tsz:imm3) - esize
> +%tszimm_shl    22:2 5:5 !function=tszimm_shl
> +
>  # Either a copy of rd (at bit 0), or a different source
>  # as propagated via the MOVPRFX instruction.
> -%reg_movprfx           0:5
> +%reg_movprfx   0:5

Squash into relevant previous patch.

>  ###########################################################################
>  # Named attribute sets.  These are used to make nice(er) names
> @@ -40,7 +48,7 @@
>  &rpr_esz       rd pg rn esz
>  &rprr_s                rd pg rn rm s
>  &rprr_esz      rd pg rn rm esz
> -
> +&rpri_esz      rd pg rn imm esz

Should either not delete the blank line, or don't add it in the first place.

>  &ptrue         rd esz pat s
>
>  ###########################################################################
> @@ -68,6 +76,11 @@
>  # One register operand, with governing predicate, vector element size
>  @rd_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
>
> +# Two register operand, one immediate operand, with predicate,
> +# element size encoded as TSZHL.  User must fill in imm.
> +@rdn_pg_tszimm ........ .. ... ... ... pg:3 ..... rd:5 \
> +               &rpri_esz rn=%reg_movprfx esz=%tszimm_esz
> +
>  # Basic Load/Store with 9-bit immediate offset
>  @pd_rn_i9      ........ ........ ...... rn:5 . rd:4    \
>                 &rri imm=%imm9_16_10
> @@ -126,6 +139,18 @@ UMAXV              00000100 .. 001 001 001 ... ..... .....         @rd_pg_rn
>  SMINV          00000100 .. 001 010 001 ... ..... .....         @rd_pg_rn
>  UMINV          00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
>
> +### SVE Shift by Immediate - Predicated Group
> +
> +# SVE bitwise shift by immediate (predicated)
> +ASR_zpzi       00000100 .. 000 000 100 ... .. ... ..... \
> +               @rdn_pg_tszimm imm=%tszimm_shr
> +LSR_zpzi       00000100 .. 000 001 100 ... .. ... ..... \
> +               @rdn_pg_tszimm imm=%tszimm_shr
> +LSL_zpzi       00000100 .. 000 011 100 ... .. ... ..... \
> +               @rdn_pg_tszimm imm=%tszimm_shl
> +ASRD           00000100 .. 000 100 100 ... .. ... ..... \
> +               @rdn_pg_tszimm imm=%tszimm_shr
> +
>  ### SVE Logical - Unpredicated Group
>
>  # SVE bitwise logical operations (unpredicated)
> --
> 2.14.3

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
