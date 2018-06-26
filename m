Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXoAy-0006up-6L
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXoAx-0008Hp-4f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:38:32 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXoAw-0008HN-Vb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:38:31 -0400
Received: by mail-oi0-x241.google.com with SMTP id c6-v6so16030119oiy.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:38:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-31-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 14:38:09 +0100
Message-ID: <CAFEAcA8jwqotqyGHSA5BFniRa9XttAebQgwpsWgL68WArZkJHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 30/35] target/arm: Pass index to AdvSIMD
 FCMLA (indexed)
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
> The original commit failed to pass, or use, the index.
>
> Fixes: d17b7cdcf4ea
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 21 ++++++++++++---------
>  target/arm/vec_helper.c    | 10 ++++++----
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8d8a4cecb0..038e48278f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -12669,15 +12669,18 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>      case 0x13: /* FCMLA #90 */
>      case 0x15: /* FCMLA #180 */
>      case 0x17: /* FCMLA #270 */
> -        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> -                           vec_full_reg_offset(s, rn),
> -                           vec_reg_offset(s, rm, index, size), fpst,
> -                           is_q ? 16 : 8, vec_full_reg_size(s),
> -                           extract32(insn, 13, 2), /* rot */
> -                           size == MO_64
> -                           ? gen_helper_gvec_fcmlas_idx
> -                           : gen_helper_gvec_fcmlah_idx);
> -        tcg_temp_free_ptr(fpst);
> +        {
> +            int rot = extract32(insn, 13, 2);
> +            int data = index * 4 + rot;

Using arithmetic to do bit operations again.

> +            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
> +                               vec_full_reg_offset(s, rn),
> +                               vec_reg_offset(s, rm, index, size), fpst,
> +                               is_q ? 16 : 8, vec_full_reg_size(s), data,
> +                               size == MO_64
> +                               ? gen_helper_gvec_fcmlas_idx
> +                               : gen_helper_gvec_fcmlah_idx);

We're already using vec_reg_offset() to pass the helper the address
of the index'th element in Vm -- why do we need to also add
2*index when we use that pointer as an array base in the helper?

thanks
-- PMM
