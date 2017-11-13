Received: from eggs.gnu.org ([2001:4830:134:3::10]:43144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEHqO-0007k3-Jy
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEHqL-0000yy-Dx
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:44:20 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEHqL-0000yR-6b
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:44:17 -0500
Received: by mail-wm0-x241.google.com with SMTP id b189so9705871wmd.0
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 08:44:17 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-6-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-6-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 16:44:14 +0000
Message-ID: <87tvxy9li9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 05/12] target/arm: Decode
 aa64 armv8.1 scalar/vector x indexed element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 46 ++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 0ea47a9dff..b02aad8cd7 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10749,12 +10749,23 @@ static void disas_simd_indexed(DisasContext *s,=
 uint32_t insn)
>          is_long =3D true;
>          /* fall through */
>      case 0xc: /* SQDMULH */
> -    case 0xd: /* SQRDMULH */
>          if (u) {
>              unallocated_encoding(s);
>              return;
>          }
>          break;
> +    case 0xd: /* SQRDMULH / SQRDMLAH */
> +        if (u && !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        break;
> +    case 0xf: /* SQRDMLSH */
> +        if (!u || !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        break;
>      case 0x8: /* MUL */
>          if (u || is_scalar) {
>              unallocated_encoding(s);
> @@ -10941,13 +10952,36 @@ static void disas_simd_indexed(DisasContext *s,=
 uint32_t insn)
>                                                 tcg_op, tcg_idx);
>                  }
>                  break;
> -            case 0xd: /* SQRDMULH */
> +            case 0xd: /* SQRDMULH / SQRDMLAH */
> +                if (u) { /* SQRDMLAH */
> +                    read_vec_element_i32(s, tcg_res, rd, pass,
> +                                         is_scalar ? size : MO_32);
> +                    if (size =3D=3D 1) {
> +                        gen_helper_neon_qrdmlah_s16(tcg_res, cpu_env,
> +                                                    tcg_op, tcg_idx, tcg=
_res);
> +                    } else {
> +                        gen_helper_neon_qrdmlah_s32(tcg_res, cpu_env,
> +                                                    tcg_op, tcg_idx, tcg=
_res);
> +                    }
> +                } else { /* SQRDMULH */
> +                    if (size =3D=3D 1) {
> +                        gen_helper_neon_qrdmulh_s16(tcg_res, cpu_env,
> +                                                    tcg_op, tcg_idx);
> +                    } else {
> +                        gen_helper_neon_qrdmulh_s32(tcg_res, cpu_env,
> +                                                    tcg_op, tcg_idx);
> +                    }
> +                }
> +                break;
> +            case 0xf: /* SQRDMLSH */
> +                read_vec_element_i32(s, tcg_res, rd, pass,
> +                                     is_scalar ? size : MO_32);
>                  if (size =3D=3D 1) {
> -                    gen_helper_neon_qrdmulh_s16(tcg_res, cpu_env,
> -                                                tcg_op, tcg_idx);
> +                    gen_helper_neon_qrdmlsh_s16(tcg_res, cpu_env,
> +                                                tcg_op, tcg_idx, tcg_res=
);
>                  } else {
> -                    gen_helper_neon_qrdmulh_s32(tcg_res, cpu_env,
> -                                                tcg_op, tcg_idx);
> +                    gen_helper_neon_qrdmlsh_s32(tcg_res, cpu_env,
> +                                                tcg_op, tcg_idx, tcg_res=
);
>                  }
>                  break;
>              default:


--
Alex Benn=C3=A9e
