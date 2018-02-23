Received: from eggs.gnu.org ([2001:4830:134:3::10]:56802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epER9-0003Nc-Mx
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epER8-0000aH-Pn
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:34:59 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epER8-0000Zc-JK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:34:58 -0500
Received: by mail-pl0-x242.google.com with SMTP id 31so4983345ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:34:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-28-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:34:36 +0000
Message-ID: <CAFEAcA-TuO4F=QoU7WWVieX6OLDX2dEX-g-jz2Hjq4jGb3O9KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 27/67] target/arm: Implement SVE Permute
 - Unpredicated Group
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
>  target/arm/helper-sve.h    |  23 +++++++++
>  target/arm/translate-a64.h |  14 +++---
>  target/arm/sve_helper.c    | 114 +++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  29 +++++++++++-
>  5 files changed, 285 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
> index e519aee314..328aa7fce1 100644
> --- a/target/arm/translate-a64.h
> +++ b/target/arm/translate-a64.h
> @@ -66,18 +66,18 @@ static inline void assert_fp_access_checked(DisasContext *s)
>  static inline int vec_reg_offset(DisasContext *s, int regno,
>                                   int element, TCGMemOp size)
>  {
> -    int offs = 0;
> +    int element_size = 1 << size;
> +    int offs = element * element_size;
>  #ifdef HOST_WORDS_BIGENDIAN
>      /* This is complicated slightly because vfp.zregs[n].d[0] is
>       * still the low half and vfp.zregs[n].d[1] the high half
>       * of the 128 bit vector, even on big endian systems.
> -     * Calculate the offset assuming a fully bigendian 128 bits,
> -     * then XOR to account for the order of the two 64 bit halves.
> +     * Calculate the offset assuming a fully little-endian 128 bits,
> +     * then XOR to account for the order of the 64 bit units.
>       */
> -    offs += (16 - ((element + 1) * (1 << size)));
> -    offs ^= 8;
> -#else
> -    offs += element * (1 << size);
> +    if (element_size < 8) {
> +        offs ^= 8 - element_size;
> +    }
>  #endif
>      offs += offsetof(CPUARMState, vfp.zregs[regno]);
>      assert_fp_access_checked(s);

This looks like it should have been in an earlier patch?

> @@ -85,7 +86,9 @@
>  @pd_pg_pn_pm_s ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
>
>  # Three operand, vector element size
> -@rd_rn_rm      ........ esz:2 . rm:5  ... ...  rn:5 rd:5       &rrr_esz
> +@rd_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5         &rrr_esz

Another fragment that should be squashed.

> +@rdn_rm                ........ esz:2 ...... ...... rm:5 rd:5 \
> +               &rrr_esz rn=%reg_movprfx
>
>  # Three operand with "memory" size, aka immediate left shift
>  @rd_rn_msz_rm  ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
