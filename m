Received: from eggs.gnu.org ([209.51.188.92]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h2ic3-0005mS-1C
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1h2ic1-0000dn-U4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:30:31 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1h2ic1-0000Sh-LI
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:30:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id q24so789128otk.0
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 12:30:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-4-richard.henderson@linaro.org>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-4-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 9 Mar 2019 21:30:24 +0100
Message-ID: <CAL1e-=iVz3aKwz6-DxjWgLxhx32_PdA45Kk6Uh7f1ezatv6SdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/9] tcg: Use extract2 in tcg_gen_shifti_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "david@redhat.com" <david@redhat.com>

On Thursday, March 7, 2019, Richard Henderson <richard.henderson@linaro.org>
wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
>
Extract2 is not a good name for this new function, IMHO.



> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index deacc63e3b..34e0dbc6e0 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1355,31 +1355,32 @@ static inline void tcg_gen_shifti_i64(TCGv_i64
> ret, TCGv_i64 arg1,
>              tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
>              tcg_gen_movi_i32(TCGV_LOW(ret), 0);
>          }
> -    } else {
> -        TCGv_i32 t0, t1;
> -
> -        t0 = tcg_temp_new_i32();
> -        t1 = tcg_temp_new_i32();
> -        if (right) {
> -            tcg_gen_shli_i32(t0, TCGV_HIGH(arg1), 32 - c);
> -            if (arith) {
> -                tcg_gen_sari_i32(t1, TCGV_HIGH(arg1), c);
> -            } else {
> -                tcg_gen_shri_i32(t1, TCGV_HIGH(arg1), c);
> -            }
> -            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
> -            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t0);
> -            tcg_gen_mov_i32(TCGV_HIGH(ret), t1);
> +    } else if (right) {
> +        if (TCG_TARGET_HAS_extract2_i32) {
> +            tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
> +                                 TCGV_HIGH(arg1), c);
>          } else {
> -            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
> -            /* Note: ret can be the same as arg1, so we use t1 */
> -            tcg_gen_shli_i32(t1, TCGV_LOW(arg1), c);
> -            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> -            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t0);
> -            tcg_gen_mov_i32(TCGV_LOW(ret), t1);
> +            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
> +            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
> +                                TCGV_HIGH(arg1), 32 - c, c);
>          }
> -        tcg_temp_free_i32(t0);
> -        tcg_temp_free_i32(t1);
> +        if (arith) {
> +            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> +        } else {
> +            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> +        }
> +    } else {
> +        if (TCG_TARGET_HAS_extract2_i32) {
> +            tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
> +                                 TCGV_HIGH(arg1), 32 - c);
> +        } else {
> +            TCGv_i32 t0 = tcg_temp_new_i32();
> +            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
> +            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
> +                                TCGV_HIGH(arg1), c, 32 - c);
> +            tcg_temp_free_i32(t0);
> +        }
> +        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
>      }
>  }
>
> --
> 2.17.2
>
>
>
