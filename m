Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDSlj-0005iE-IF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDSlg-00008a-8m
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:44:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDSlg-000083-38
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:44:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id j5so18487257wme.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:44:19 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-5-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-5-richard.henderson@linaro.org>
Date: Tue, 01 May 2018 11:44:17 +0100
Message-ID: <87r2mvac5a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] target/arm: Clear SVE high bits for
 FMOV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Use write_fp_dreg and clear_vec_high to zero the bits
> that need zeroing for these cases.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index b27892d971..f2241d8174 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5356,31 +5356,24 @@ static void handle_fmov(DisasContext *s, int rd, =
int rn, int type, bool itof)
>
>      if (itof) {
>          TCGv_i64 tcg_rn =3D cpu_reg(s, rn);
> +        TCGv_i64 tmp;
>
>          switch (type) {
>          case 0:
> -        {
>              /* 32 bit */
> -            TCGv_i64 tmp =3D tcg_temp_new_i64();
> +            tmp =3D tcg_temp_new_i64();
>              tcg_gen_ext32u_i64(tmp, tcg_rn);
> -            tcg_gen_st_i64(tmp, cpu_env, fp_reg_offset(s, rd, MO_64));
> -            tcg_gen_movi_i64(tmp, 0);
> -            tcg_gen_st_i64(tmp, cpu_env, fp_reg_hi_offset(s, rd));
> +            write_fp_dreg(s, rd, tmp);
>              tcg_temp_free_i64(tmp);
>              break;
> -        }
>          case 1:
> -        {
>              /* 64 bit */
> -            TCGv_i64 tmp =3D tcg_const_i64(0);
> -            tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_offset(s, rd, MO_64));
> -            tcg_gen_st_i64(tmp, cpu_env, fp_reg_hi_offset(s, rd));
> -            tcg_temp_free_i64(tmp);
> +            write_fp_dreg(s, rd, tcg_rn);
>              break;
> -        }
>          case 2:
>              /* 64 bit to top half. */
>              tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_hi_offset(s, rd));
> +            clear_vec_high(s, true, rd);

I was going to suggest maybe a write_fp_dreg_hi() helper here but there
are only a couple of cases so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>              break;
>          }
>      } else {


--
Alex Benn=C3=A9e
