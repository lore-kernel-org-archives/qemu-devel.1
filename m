Received: from eggs.gnu.org ([209.51.188.92]:39502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMCRh-0001qp-EV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMCRg-0000dN-A7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:12:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMCRg-0000Y5-2C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:12:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so3623388wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 07:12:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z7sm12273258wme.26.2019.05.02.07.12.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 07:12:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EC31C1FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 15:12:16 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-17-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-17-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 15:12:16 +0100
Message-ID: <87a7g554jj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/29] tcg/aarch64: Support vector
 variable shift opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.h     |  2 +-
>  tcg/aarch64/tcg-target.opc.h |  2 ++
>  tcg/aarch64/tcg-target.inc.c | 42 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index ce2bb1f90b..f5640a229b 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -134,7 +134,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_neg_vec          1
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          0
> -#define TCG_TARGET_HAS_shv_vec          0
> +#define TCG_TARGET_HAS_shv_vec          1
>  #define TCG_TARGET_HAS_cmp_vec          1
>  #define TCG_TARGET_HAS_mul_vec          1
>  #define TCG_TARGET_HAS_sat_vec          1
> diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
> index 4816a6c3d4..59e1d3f7f7 100644
> --- a/tcg/aarch64/tcg-target.opc.h
> +++ b/tcg/aarch64/tcg-target.opc.h
> @@ -1,3 +1,5 @@
>  /* Target-specific opcodes for host vector expansion.  These will be
>     emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
>     consider these to be UNSPEC with names.  */
> +
> +DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 16381f5175..61c2dbbff2 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -538,12 +538,14 @@ typedef enum {
>      I3616_CMEQ      =3D 0x2e208c00,
>      I3616_SMAX      =3D 0x0e206400,
>      I3616_SMIN      =3D 0x0e206c00,
> +    I3616_SSHL      =3D 0x0e204400,
>      I3616_SQADD     =3D 0x0e200c00,
>      I3616_SQSUB     =3D 0x0e202c00,
>      I3616_UMAX      =3D 0x2e206400,
>      I3616_UMIN      =3D 0x2e206c00,
>      I3616_UQADD     =3D 0x2e200c00,
>      I3616_UQSUB     =3D 0x2e202c00,
> +    I3616_USHL      =3D 0x2e204400,
>
>      /* AdvSIMD two-reg misc.  */
>      I3617_CMGT0     =3D 0x0e208800,
> @@ -2258,6 +2260,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcod=
e opc,
>      case INDEX_op_sari_vec:
>          tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
>          break;
> +    case INDEX_op_shlv_vec:
> +        tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
> +        break;
> +    case INDEX_op_aa64_sshl_vec:
> +        tcg_out_insn(s, 3616, SSHL, is_q, vece, a0, a1, a2);
> +        break;
>      case INDEX_op_cmp_vec:
>          {
>              TCGCond cond =3D args[3];
> @@ -2325,7 +2333,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType typ=
e, unsigned vece)
>      case INDEX_op_smin_vec:
>      case INDEX_op_umax_vec:
>      case INDEX_op_umin_vec:
> +    case INDEX_op_shlv_vec:
>          return 1;
> +    case INDEX_op_shrv_vec:
> +    case INDEX_op_sarv_vec:
> +        return -1;
>      case INDEX_op_mul_vec:
>          return vece < MO_64;
>
> @@ -2337,6 +2349,32 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType typ=
e, unsigned vece)
>  void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
>                         TCGArg a0, ...)
>  {
> +    va_list va;
> +    TCGv_vec v0, v1, v2, t1;
> +
> +    va_start(va, a0);
> +    v0 =3D temp_tcgv_vec(arg_temp(a0));
> +    v1 =3D temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
> +    v2 =3D temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
> +
> +    switch (opc) {
> +    case INDEX_op_shrv_vec:
> +    case INDEX_op_sarv_vec:
> +        /* Right shifts are negative left shifts for AArch64.  */
> +        t1 =3D tcg_temp_new_vec(type);
> +        tcg_gen_neg_vec(vece, t1, v2);
> +        opc =3D (opc =3D=3D INDEX_op_shrv_vec
> +               ? INDEX_op_shlv_vec : INDEX_op_aa64_sshl_vec);
> +        vec_gen_3(opc, type, vece, tcgv_vec_arg(v0),
> +                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
> +        tcg_temp_free_vec(t1);
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    va_end(va);
>  }
>
>  static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
> @@ -2518,6 +2556,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCG=
Opcode op)
>      case INDEX_op_smin_vec:
>      case INDEX_op_umax_vec:
>      case INDEX_op_umin_vec:
> +    case INDEX_op_shlv_vec:
> +    case INDEX_op_shrv_vec:
> +    case INDEX_op_sarv_vec:
> +    case INDEX_op_aa64_sshl_vec:
>          return &w_w_w;
>      case INDEX_op_not_vec:
>      case INDEX_op_neg_vec:


--
Alex Benn=C3=A9e
