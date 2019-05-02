Received: from eggs.gnu.org ([209.51.188.92]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDxN-0007a3-Go
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDxM-00034m-DW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:49:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDxM-000301-62
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:49:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id c12so4046186wrt.8
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:49:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q7sm19227001wra.57.2019.05.02.08.49.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 08:49:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 407141FF87
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 16:49:05 +0100 (BST)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-23-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190501050536.15580-23-richard.henderson@linaro.org>
Date: Thu, 02 May 2019 16:49:05 +0100
Message-ID: <871s1g6emm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 22/29] tcg/aarch64: Support vector
 absolute value
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
>  tcg/aarch64/tcg-target.h     | 2 +-
>  tcg/aarch64/tcg-target.inc.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 21d06d928c..e43554c3c7 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -132,7 +132,7 @@ typedef enum {
>  #define TCG_TARGET_HAS_orc_vec          1
>  #define TCG_TARGET_HAS_not_vec          1
>  #define TCG_TARGET_HAS_neg_vec          1
> -#define TCG_TARGET_HAS_abs_vec          0
> +#define TCG_TARGET_HAS_abs_vec          1
>  #define TCG_TARGET_HAS_shi_vec          1
>  #define TCG_TARGET_HAS_shs_vec          0
>  #define TCG_TARGET_HAS_shv_vec          1
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 61c2dbbff2..e7f8d96e21 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -554,6 +554,7 @@ typedef enum {
>      I3617_CMGE0     =3D 0x2e208800,
>      I3617_CMLE0     =3D 0x2e20a800,
>      I3617_NOT       =3D 0x2e205800,
> +    I3617_ABS       =3D 0x0e20b800,
>      I3617_NEG       =3D 0x2e20b800,
>
>      /* System instructions.  */
> @@ -2209,6 +2210,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode=
 opc,
>      case INDEX_op_neg_vec:
>          tcg_out_insn(s, 3617, NEG, is_q, vece, a0, a1);
>          break;
> +    case INDEX_op_abs_vec:
> +        tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
> +        break;
>      case INDEX_op_and_vec:
>          tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
>          break;
> @@ -2320,6 +2324,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type=
, unsigned vece)
>      case INDEX_op_andc_vec:
>      case INDEX_op_orc_vec:
>      case INDEX_op_neg_vec:
> +    case INDEX_op_abs_vec:
>      case INDEX_op_not_vec:
>      case INDEX_op_cmp_vec:
>      case INDEX_op_shli_vec:
> @@ -2563,6 +2568,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGO=
pcode op)
>          return &w_w_w;
>      case INDEX_op_not_vec:
>      case INDEX_op_neg_vec:
> +    case INDEX_op_abs_vec:
>      case INDEX_op_shli_vec:
>      case INDEX_op_shri_vec:
>      case INDEX_op_sari_vec:


--
Alex Benn=C3=A9e
