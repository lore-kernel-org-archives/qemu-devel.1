Received: from eggs.gnu.org ([2001:4830:134:3::10]:60900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIWtQ-00063l-P0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIWtP-0002MV-Ds
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:09:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIWtP-0002ML-8A
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:09:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id e80-v6so13403046oig.11
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:09:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-11-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:08:54 +0100
Message-ID: <CAFEAcA8kszX4c8WjMabKm6otWFgak8jVJ69o9N2M+uCYfcxFCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 10/28] target/arm: convert conversion
 helpers to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> w=
rote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Instead of passing env and leaving it up to the helper to get the
> right fpstatus we pass it explicitly. There was already a get_fpstatus
> helper for neon for the 32 bit code. We also add an get_ahp_flag() for
> passing the state of the alternative FP16 format flag. This leaves
> scope for later tracking the AHP state in translation flags.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v4
>   - remove neon_fcvt_*; they are now identical to vfp_fcvt_*.
>   - add flags to vfp_fcvt_* helper decls.
>   - add some missing tcg_temp_free_*.
> v5
>   - always use get_fpstatus_ptr(false) for FZ, since FZ16 is
>     supposed to be supressed.
> ---

> @@ -9053,12 +9066,17 @@ static void handle_2misc_narrow(DisasContext *s, =
bool scalar,
>              } else {
>                  TCGv_i32 tcg_lo =3D tcg_temp_new_i32();
>                  TCGv_i32 tcg_hi =3D tcg_temp_new_i32();
> +                TCGv_ptr fpst =3D get_fpstatus_ptr(true);

Still the wrong fpstatus here...

> +                TCGv_i32 ahp =3D get_ahp_flag();
> +
>                  tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
> -                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, cpu_env);
> -                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, cpu_env);
> +                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp=
);
> +                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp=
);
>                  tcg_gen_deposit_i32(tcg_res[pass], tcg_lo, tcg_hi, 16, 1=
6);
>                  tcg_temp_free_i32(tcg_lo);
>                  tcg_temp_free_i32(tcg_hi);
> +                tcg_temp_free_ptr(fpst);
> +                tcg_temp_free_i32(ahp);
>              }
>              break;
>          case 0x56:  /* FCVTXN, FCVTXN2 */

> @@ -11532,18 +11550,24 @@ static void handle_2misc_widening(DisasContext =
*s, int opcode, bool is_q,
>          /* 16 -> 32 bit fp conversion */
>          int srcelt =3D is_q ? 4 : 0;
>          TCGv_i32 tcg_res[4];
> +        TCGv_ptr fpst =3D get_fpstatus_ptr(true);

...and here.

> +        TCGv_i32 ahp =3D get_ahp_flag();
> +
>
>          for (pass =3D 0; pass < 4; pass++) {
>              tcg_res[pass] =3D tcg_temp_new_i32();
>
>              read_vec_element_i32(s, tcg_res[pass], rn, srcelt + pass, MO=
_16);
>              gen_helper_vfp_fcvt_f16_to_f32(tcg_res[pass], tcg_res[pass],
> -                                           cpu_env);
> +                                           fpst, ahp);
>          }
>          for (pass =3D 0; pass < 4; pass++) {
>              write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_32);
>              tcg_temp_free_i32(tcg_res[pass]);
>          }
> +
> +        tcg_temp_free_ptr(fpst);
> +        tcg_temp_free_i32(ahp);
>      }
>  }

thanks
-- PMM
