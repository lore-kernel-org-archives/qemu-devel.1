Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXn1K-0003Xq-1X
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXn1J-0000Kz-4k
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:30 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXn1I-0000Ki-NF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:24:29 -0400
Received: by mail-oi0-x242.google.com with SMTP id f79-v6so15787354oib.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 05:24:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-28-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 13:24:07 +0100
Message-ID: <CAFEAcA90Wp1N8e25SXLmnJOHPeQNZMvd_Xd1G-oJmtzHDaepgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 27/35] target/arm: Implement SVE MOVPRFX
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
>  target/arm/translate-sve.c | 60 +++++++++++++++++++++++++++++++++++++-
>  target/arm/sve.decode      |  7 +++++
>  2 files changed, 66 insertions(+), 1 deletion(-)

> +/*
> + * Move Prefix
> + *
> + * TODO: The implementation so far could handle predicated merging movprfx.
> + * The helper functions as written take an extra source register to
> + * use in the operation, but the result is only written when predication
> + * succeeds.  For unpredicated movprfx, we need to rearrange the helpers
> + * to allow the final write back to the destination to be unconditional.
> + * For predicated zering movprfz, we need to rearrange the helpers to

"zeroing". Should that be "movprfx" or is "movprfz" a thing? (the SVE
spec doesn't mention it.)

> + * allow the final write back to zero inactives.
> + *
> + * In the meantime, just emit the moves.
> + */
> +
> +static bool trans_MOVPRFX(DisasContext *s, arg_MOVPRFX *a, uint32_t insn)
> +{
> +    return do_mov_z(s, a->rd, a->rn);
> +}

A bit confusing that do_mov_z() does the sve_access_check() for us
but do_sel_z() and do_movz_zpz() do not...

> +
> +static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> +{
> +    if (sve_access_check(s)) {
> +        do_sel_z(s, a->rd, a->rn, a->rd, a->pg, a->esz);
> +    }
> +    return true;
> +}
> +
> +static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
> +{
> +    if (sve_access_check(s)) {
> +        do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz);
> +    }
> +    return true;
> +}

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
