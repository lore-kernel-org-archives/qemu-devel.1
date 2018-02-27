Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgMx-0001is-EZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgMw-00072B-Ao
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:39 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqgMw-00071j-1Y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:36:38 -0500
Received: by mail-ot0-x241.google.com with SMTP id w38so3938317ota.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:36:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-54-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:36:16 +0000
Message-ID: <CAFEAcA8Zt6S2x=bZ6Vxs8T07D6fpMGoYZP38csaKvKsYjyvjxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 53/67] target/arm: Implement SVE scatter
 stores
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 41 ++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 62 ++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 39 +++++++++++++++++++++++++
>  4 files changed, 213 insertions(+)


> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 5d8e1481d7..edd9340c02 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -81,6 +81,7 @@
>  &rpri_load     rd pg rn imm dtype nreg
>  &rprr_store    rd pg rn rm msz esz nreg
>  &rpri_store    rd pg rn imm msz esz nreg
> +&rprr_scatter_store    rd pg rn rm esz msz xs scale
>
>  ###########################################################################
>  # Named instruction formats.  These are generally used to
> @@ -199,6 +200,8 @@
>  @rpri_store_msz     ....... msz:2 .. . imm:s4 ... pg:3 rn:5 rd:5    &rpri_store
>  @rprr_store_esz_n0  ....... ..    esz:2  rm:5 ... pg:3 rn:5 rd:5 \
>                     &rprr_store nreg=0
> +@rprr_scatter_store ....... msz:2 ..     rm:5 ... pg:3 rn:5 rd:5 \
> +                   &rprr_scatter_store
>
>  ###########################################################################
>  # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
> @@ -832,3 +835,39 @@ ST_zpri            1110010 .. nreg:2 1.... 111 ... ..... ..... \
>  # SVE store multiple structures (scalar plus scalar)         (nreg != 0)
>  ST_zprr                1110010 msz:2 nreg:2 ..... 011 ... ..... ..... \
>                 @rprr_store esz=%size_23
> +
> +# SVE 32-bit scatter store (scalar plus 32-bit scaled offsets)
> +# Require msz > 0 && msz <= esz.
> +ST1_zprz       1110010 .. 11 ..... 100 ... ..... ..... \
> +               @rprr_scatter_store xs=0 esz=2 scale=1
> +ST1_zprz       1110010 .. 11 ..... 110 ... ..... ..... \
> +               @rprr_scatter_store xs=1 esz=2 scale=1
> +
> +# SVE 32-bit scatter store (scalar plus 32-bit unscaled offsets)
> +# Require msz <= esz.
> +ST1_zprz       1110010 .. 10 ..... 100 ... ..... ..... \
> +               @rprr_scatter_store xs=0 esz=2 scale=0
> +ST1_zprz       1110010 .. 10 ..... 110 ... ..... ..... \
> +               @rprr_scatter_store xs=1 esz=2 scale=0
> +
> +# SVE 64-bit scatter store (scalar plus 64-bit scaled offset)
> +# Require msz > 0
> +ST1_zprz       1110010 .. 01 ..... 101 ... ..... ..... \
> +               @rprr_scatter_store xs=2 esz=3 scale=1
> +
> +# SVE 64-bit scatter store (scalar plus 64-bit unscaled offset)
> +ST1_zprz       1110010 .. 00 ..... 101 ... ..... ..... \
> +               @rprr_scatter_store xs=2 esz=3 scale=0
> +
> +# SVE 64-bit scatter store (scalar plus unpacked 32-bit scaled offset)
> +# Require msz > 0
> +ST1_zprz       1110010 .. 01 ..... 100 ... ..... ..... \
> +               @rprr_scatter_store xs=0 esz=3 scale=1
> +ST1_zprz       1110010 .. 01 ..... 110 ... ..... ..... \
> +               @rprr_scatter_store xs=1 esz=3 scale=1
> +
> +# SVE 64-bit scatter store (scalar plus unpacked 32-bit unscaled offset)
> +ST1_zprz       1110010 .. 00 ..... 100 ... ..... ..... \
> +               @rprr_scatter_store xs=0 esz=3 scale=0
> +ST1_zprz       1110010 .. 00 ..... 110 ... ..... ..... \
> +               @rprr_scatter_store xs=1 esz=3 scale=0


Could you write all these with the 'scale=n' part picked up from bit 21,
rather than one pattern for scale=0 and one for scale=1 ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
