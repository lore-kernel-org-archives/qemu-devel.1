Received: from eggs.gnu.org ([2001:4830:134:3::10]:43325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDTLN-0004k6-1N
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDTLI-0006sd-3v
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:21:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDTLH-0006sN-Sa
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:21:08 -0400
Received: by mail-wr0-x242.google.com with SMTP id v5-v6so10548720wrf.9
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 04:21:07 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-10-richard.henderson@linaro.org>
Date: Tue, 01 May 2018 12:21:05 +0100
Message-ID: <87lgd3aafy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 9/9] target/arm: Implement FP
 data-processing (3 source) for fp16
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

> We missed all of the scalar fp16 fma operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 48 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 11b90b7eb0..0cb1fc4d67 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5154,6 +5154,44 @@ static void handle_fp_3src_double(DisasContext *s,=
 bool o0, bool o1,
>      tcg_temp_free_i64(tcg_res);
>  }
>
> +/* Floating-point data-processing (3 source) - half precision */
> +static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
> +                                int rd, int rn, int rm, int ra)
> +{
> +    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
> +    TCGv_i32 tcg_res =3D tcg_temp_new_i32();
> +    TCGv_ptr fpst =3D get_fpstatus_ptr(true);
> +
> +    tcg_op1 =3D read_fp_hreg(s, rn);
> +    tcg_op2 =3D read_fp_hreg(s, rm);
> +    tcg_op3 =3D read_fp_hreg(s, ra);
> +
> +    /* These are fused multiply-add, and must be done as one
> +     * floating point operation with no rounding between the
> +     * multiplication and addition steps.

I got confused first time reading this as we cover F[N]M[ADD|SUB].
Perhaps that is better enumerated at the top of the function?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +     * NB that doing the negations here as separate steps is
> +     * correct : an input NaN should come out with its sign bit
> +     * flipped if it is a negated-input.
> +     */
> +    if (o1 =3D=3D true) {
> +        tcg_gen_xori_i32(tcg_op3, tcg_op3, 0x8000);
> +    }
> +
> +    if (o0 !=3D o1) {
> +        tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
> +    }
> +
> +    gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_op3, fpst);
> +
> +    write_fp_sreg(s, rd, tcg_res);
> +
> +    tcg_temp_free_ptr(fpst);
> +    tcg_temp_free_i32(tcg_op1);
> +    tcg_temp_free_i32(tcg_op2);
> +    tcg_temp_free_i32(tcg_op3);
> +    tcg_temp_free_i32(tcg_res);
> +}
> +
>  /* Floating point data-processing (3 source)
>   *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
>   * +---+---+---+-----------+------+----+------+----+------+------+------+
> @@ -5183,6 +5221,16 @@ static void disas_fp_3src(DisasContext *s, uint32_=
t insn)
>          }
>          handle_fp_3src_double(s, o0, o1, rd, rn, rm, ra);
>          break;
> +    case 3:
> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        if (!fp_access_check(s)) {
> +            return;
> +        }
> +        handle_fp_3src_half(s, o0, o1, rd, rn, rm, ra);
> +        break;
>      default:
>          unallocated_encoding(s);
>      }


--
Alex Benn=C3=A9e
