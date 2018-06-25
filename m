Received: from eggs.gnu.org ([2001:4830:134:3::10]:37846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUmZ-0007RB-Uy
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUmZ-0005p9-4u
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:56:04 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXUmY-0005oY-VL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:56:03 -0400
Received: by mail-ot0-x241.google.com with SMTP id 92-v6so15826522otw.9
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:56:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-14-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 17:55:41 +0100
Message-ID: <CAFEAcA9xxh6tkpoLAoKaZ95SOtVi6Oqz+K2dMiEg2RnS-8dUHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 13/35] target/arm: Implement SVE gather
 loads
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
>  target/arm/helper-sve.h    |  67 ++++++++++++++++++++++++
>  target/arm/sve_helper.c    |  77 +++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 104 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  53 +++++++++++++++++++
>  4 files changed, 301 insertions(+)

> +static bool trans_LD1_zprz(DisasContext *s, arg_LD1_zprz *a, uint32_t insn)
> +{
> +    gen_helper_gvec_mem_scatter *fn = NULL;
> +
> +    if (a->esz < a->msz
> +        || (a->msz == 0 && a->scale)

Doesn't this check duplicate work you're already doing in the decode
entries in the .decode file? If we're going to throw out msz==0 scale==1
here we don't need to go to the effort to split this into 4 patterns
so we can force the scale bit to 0 in the msz=00 line:

> +LD1_zprz        1100010 00 .0 ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u esz=3 msz=0 scale=0
> +LD1_zprz        1100010 01 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3 msz=1
> +LD1_zprz        1100010 10 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3 msz=2
> +LD1_zprz        1100010 11 .. ..... 0.. ... ..... ..... \
> +                @rprr_g_load_xs_u_sc esz=3 msz=3

and could just have
LD1_zprz     1100010 msz:2 .. ..... 0.. ... ..... ..... \
                @rprr_g_load_xs_u_sc esz=3 scale=0

couldn't we?

(I don't really care which way round we do it.)

> +        || (a->esz == a->msz && !a->u)) {
> +        return false;
> +    }
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    /* TODO: handle LDFF1.  */

Is LDFF1 support going to appear later in this patchset?

For the moment should we UNDEF it?

> +    switch (a->esz) {
> +    case MO_32:
> +        fn = gather_load_fn32[a->xs][a->u][a->msz];
> +        break;
> +    case MO_64:
> +        fn = gather_load_fn64[a->xs][a->u][a->msz];
> +        break;
> +    }
> +    assert(fn != NULL);
> +
> +    do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
> +               cpu_reg_sp(s, a->rn), fn);
> +    return true;
> +}

thanks
-- PMM
