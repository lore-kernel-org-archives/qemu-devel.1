Received: from eggs.gnu.org ([2001:4830:134:3::10]:60613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eosKx-0004nX-2c
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eosKv-0002G8-Sq
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:59:07 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eosKv-0002Fm-OV
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:59:05 -0500
Received: by mail-oi0-x243.google.com with SMTP id a207so3877821oii.10
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:59:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217164037.15727-3-richard.henderson@linaro.org>
References: <20180217164037.15727-1-richard.henderson@linaro.org>
	<20180217164037.15727-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:58:44 +0000
Message-ID: <CAFEAcA8NvZeD_eXCvP8NyA8usVy+fPKkcVnqgvnDddcNhZCLHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Add missing tcg_can_emit_vec_op
 check in tcg_gen_gvec_2s
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

On 17 February 2018 at 16:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This lead to an assertion failure for 64-bit vector multiply,
> which is not available in the AVX instruction set.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 29f9cf34b4..432e577c35 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -979,12 +979,15 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
>
>      type = 0;
>      if (g->fniv) {
> -        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)) {
> +        if (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
> +            && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
>              type = TCG_TYPE_V256;
> -        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)) {
> +        } else if (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
> +                   && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
>              type = TCG_TYPE_V128;
>          } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
> -               && check_size_impl(oprsz, 8)) {
> +                   && check_size_impl(oprsz, 8)
> +                   && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
>              type = TCG_TYPE_V64;
>          }
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Incidentally, I notice that the condition checks
     (TCG_TARGET_HAS_v256 && check_size_impl(oprsz, 32)
      && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))

     (TCG_TARGET_HAS_v128 && check_size_impl(oprsz, 16)
      && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))

     (TCG_TARGET_HAS_v64 && check_size_impl(oprsz, 8)
      && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))

seem to be quite commonly used -- perhaps factoring these out
into suitably named functions would make the code more readable?

thanks
-- PMM
