Received: from eggs.gnu.org ([2001:4830:134:3::10]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDTE8-0003NL-DU
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDTE5-0003ac-5j
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:13:44 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDTE4-0003Zu-UF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 07:13:41 -0400
Received: by mail-wr0-x242.google.com with SMTP id 94-v6so9215532wrf.5
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 04:13:40 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-9-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425012300.14698-9-richard.henderson@linaro.org>
Date: Tue, 01 May 2018 12:13:38 +0100
Message-ID: <87muxjaasd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement FP
 data-processing (2 source) for fp16
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

> We missed all of the scalar fp16 binary operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 73 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 794ede7222..11b90b7eb0 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -532,6 +532,14 @@ static TCGv_i32 read_fp_sreg(DisasContext *s, int re=
g)
>      return v;
>  }
>
> +static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
> +{
> +    TCGv_i32 v =3D tcg_temp_new_i32();
> +
> +    tcg_gen_ld16u_i32(v, cpu_env, fp_reg_offset(s, reg, MO_16));
> +    return v;
> +}
> +
>  /* Clear the bits above an N-bit vector, for N =3D (is_q ? 128 : 64).
>   * If SVE is not enabled, then there are only 128 bits in the vector.
>   */
> @@ -4968,6 +4976,61 @@ static void handle_fp_2src_double(DisasContext *s,=
 int opcode,
>      tcg_temp_free_i64(tcg_res);
>  }
>
> +/* Floating-point data-processing (2 source) - half precision */
> +static void handle_fp_2src_half(DisasContext *s, int opcode,
> +                                int rd, int rn, int rm)
> +{
> +    TCGv_i32 tcg_op1;
> +    TCGv_i32 tcg_op2;
> +    TCGv_i32 tcg_res;
> +    TCGv_ptr fpst;
> +
> +    tcg_res =3D tcg_temp_new_i32();
> +    fpst =3D get_fpstatus_ptr(true);
> +    tcg_op1 =3D read_fp_hreg(s, rn);
> +    tcg_op2 =3D read_fp_hreg(s, rm);
> +
> +    switch (opcode) {
> +    case 0x0: /* FMUL */
> +        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x1: /* FDIV */
> +        gen_helper_advsimd_divh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x2: /* FADD */
> +        gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x3: /* FSUB */
> +        gen_helper_advsimd_subh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x4: /* FMAX */
> +        gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x5: /* FMIN */
> +        gen_helper_advsimd_minh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x6: /* FMAXNM */
> +        gen_helper_advsimd_maxnumh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x7: /* FMINNM */
> +        gen_helper_advsimd_minnumh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        break;
> +    case 0x8: /* FNMUL */
> +        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
> +        tcg_gen_xori_i32(tcg_res, tcg_res, 0x8000);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    write_fp_sreg(s, rd, tcg_res);

If we are going to the trouble of adding a read_fp_hreg() we might as
well do the same for the write case. Then we can convert the various:

  read_vec_element_i32(s, tcg_vm, rm, 0, MO_16);

that we used before.

> +
> +    tcg_temp_free_ptr(fpst);
> +    tcg_temp_free_i32(tcg_op1);
> +    tcg_temp_free_i32(tcg_op2);
> +    tcg_temp_free_i32(tcg_res);
> +}
> +
>  /* Floating point data-processing (2 source)
>   *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4   =
 0
>   * +---+---+---+-----------+------+---+------+--------+-----+------+----=
--+
> @@ -5000,6 +5063,16 @@ static void disas_fp_2src(DisasContext *s, uint32_=
t insn)
>          }
>          handle_fp_2src_double(s, opcode, rd, rn, rm);
>          break;
> +    case 3:
> +        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +            unallocated_encoding(s);
> +            return;
> +        }
> +        if (!fp_access_check(s)) {
> +            return;
> +        }
> +        handle_fp_2src_half(s, opcode, rd, rn, rm);
> +        break;
>      default:
>          unallocated_encoding(s);
>      }

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e
