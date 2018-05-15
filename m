Received: from eggs.gnu.org ([2001:4830:134:3::10]:37301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXKy-0005Mu-Gx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXKv-00030e-Ci
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:37:44 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIXKv-0002zv-5c
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:37:41 -0400
Received: by mail-wr0-x243.google.com with SMTP id g21-v6so15429540wrb.8
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:37:40 -0700 (PDT)
References: <20180512003217.9105-1-richard.henderson@linaro.org>
	<20180512003217.9105-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180512003217.9105-2-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 11:37:38 +0100
Message-ID: <87wow5fbm5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/11] target/arm: Implement FMOV
 (general) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Adding the fp16 moves to/from general registers.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4d1b220cc6..5b8cf75e9f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5700,6 +5700,15 @@ static void handle_fmov(DisasContext *s, int rd, i=
nt rn, int type, bool itof)
>              tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_hi_offset(s, rd));
>              clear_vec_high(s, true, rd);
>              break;
> +        case 3:
> +            /* 16 bit */
> +            tmp =3D tcg_temp_new_i64();
> +            tcg_gen_ext16u_i64(tmp, tcg_rn);
> +            write_fp_dreg(s, rd, tmp);
> +            tcg_temp_free_i64(tmp);
> +            break;
> +        default:
> +            g_assert_not_reached();
>          }
>      } else {
>          TCGv_i64 tcg_rd =3D cpu_reg(s, rd);
> @@ -5717,6 +5726,12 @@ static void handle_fmov(DisasContext *s, int rd, i=
nt rn, int type, bool itof)
>              /* 64 bits from top half */
>              tcg_gen_ld_i64(tcg_rd, cpu_env, fp_reg_hi_offset(s, rn));
>              break;
> +        case 3:
> +            /* 16 bit */
> +            tcg_gen_ld16u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_1=
6));
> +            break;
> +        default:
> +            g_assert_not_reached();
>          }
>      }
>  }
> @@ -5756,6 +5771,12 @@ static void disas_fp_int_conv(DisasContext *s, uin=
t32_t insn)
>          case 0xa: /* 64 bit */
>          case 0xd: /* 64 bit to top half of quad */
>              break;
> +        case 0x6: /* 16-bit float, 32-bit int */
> +        case 0xe: /* 16-bit float, 64-bit int */
> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                break;
> +            }
> +            /* fallthru */
>          default:
>              /* all other sf/type/rmode combinations are invalid */
>              unallocated_encoding(s);


--
Alex Benn=C3=A9e
