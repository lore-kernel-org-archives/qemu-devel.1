Received: from eggs.gnu.org ([2001:4830:134:3::10]:50295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEIAg-00020j-Ql
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEIAb-0001aq-2D
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:05:18 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:48875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEIAa-0001Zk-Ox
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 12:05:13 -0500
Received: by mail-wr0-x241.google.com with SMTP id 15so15030468wrb.5
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 09:05:12 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-8-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-8-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 17:05:09 +0000
Message-ID: <87r2t29kje.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/12] target/arm: Decode aa32 armv8.1
 two reg and a scalar
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
> ---
>  target/arm/translate.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0cd58710b3..ee1e364fb5 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6941,10 +6941,42 @@ static int disas_neon_data_insn(DisasContext *s, =
uint32_t insn)
>                          }
>                          neon_store_reg64(cpu_V0, rd + pass);
>                      }
> +                    break;
> +                case 14: /* VQRDMLAH scalar */
> +                case 15: /* VQRDMLSH scalar */
> +                    if (!arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
> +                        return 1;
> +                    }
> +                    if (u && ((rd | rn) & 1)) {
> +                        return 1;
> +                    }
> +                    tmp2 =3D neon_get_scalar(size, rm);
> +                    for (pass =3D 0; pass < (u ? 4 : 2); pass++) {
> +                        void (*fn)(TCGv_i32, TCGv_env, TCGv_i32,
> +                                   TCGv_i32, TCGv_i32);
>
> -
> +                        tmp =3D neon_load_reg(rn, pass);
> +                        tmp3 =3D neon_load_reg(rd, pass);
> +                        if (op =3D=3D 14) {
> +                            if (size =3D=3D 1) {
> +                                fn =3D gen_helper_neon_qrdmlah_s16;
> +                            } else {
> +                                fn =3D gen_helper_neon_qrdmlah_s32;
> +                            }
> +                        } else {
> +                            if (size =3D=3D 1) {
> +                                fn =3D gen_helper_neon_qrdmlsh_s16;
> +                            } else {
> +                                fn =3D gen_helper_neon_qrdmlsh_s32;
> +                            }
> +                        }
> +                        fn(tmp, cpu_env, tmp, tmp2, tmp3);
> +                        tcg_temp_free_i32(tmp3);
> +                        neon_store_reg(rd, pass, tmp);
> +                    }
> +                    tcg_temp_free_i32(tmp2);
>                      break;
> -                default: /* 14 and 15 are RESERVED */
> +                default:
>                      return 1;

I think this should now be g_assert_not_reached() as we decode the whole
op space. That said it's tricky to follow in the mega function that
extracts op with old-school shifts 5 different ways :-/

>                  }
>              }


--
Alex Benn=C3=A9e
