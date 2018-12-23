Received: from eggs.gnu.org ([2001:4830:134:3::10]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gb7Sy-0007pI-9M
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gb7Sw-0003QS-I0
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:23:04 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gb7Sw-0003OR-9l
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 12:23:02 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so9374663otj.2
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 09:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-6-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217200444.14812-6-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 23 Dec 2018 18:22:47 +0100
Message-ID: <CAL1e-=gUE7KPL+MwBOd_sb2KocHox-4Davo_SN2fwozBoOa20Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] target/mips: MXU: Add handlers for
 max/min instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, "Janeczek, Craig" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Mon, Dec 17, 2018 at 9:11 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add translation handlers for max/min MXU instructions.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 356 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 335 insertions(+), 21 deletions(-)
>

It would be shorter and cleaner if loops were used for processing bits
2, 1, 0 in Q8MAX and Q8MIN handlers, but, if there is no objection
over that, I can do it while applying, without respin of ghe whole
series.

Thanks,
Aleksandar

> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index c74a831a17..339de8c32b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -24815,6 +24815,338 @@ static void gen_mxu_S32XOR(DisasContext *ctx)
>  }
>
>
> +/*
> + *                   MXU instruction category max/min
> + *                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *                     S32MAX     D16MAX     Q8MAX
> + *                     S32MIN     D16MIN     Q8MIN
> + */
> +
> +/*
> + *  S32MAX XRa, XRb, XRc
> + *    Update XRa with the maximum of signed 32-bit integers contained
> + *    in XRb and XRc.
> + *
> + *  S32MIN XRa, XRb, XRc
> + *    Update XRa with the minimum of signed 32-bit integers contained
> + *    in XRb and XRc.
> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL00|
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + */
> +static void gen_mxu_S32MAX_S32MIN(DisasContext *ctx)
> +{
> +    uint32_t pad, opc, XRc, XRb, XRa;
> +
> +    pad = extract32(ctx->opcode, 21, 5);
> +    opc = extract32(ctx->opcode, 18, 3);
> +    XRc = extract32(ctx->opcode, 14, 4);
> +    XRb = extract32(ctx->opcode, 10, 4);
> +    XRa = extract32(ctx->opcode,  6, 4);
> +
> +    if (unlikely(pad != 0)) {
> +        /* opcode padding incorrect -> do nothing */
> +    } else if (unlikely(XRa == 0)) {
> +        /* destination is zero register -> do nothing */
> +    } else if (unlikely((XRb == 0) && (XRc == 0))) {
> +        /* both operands zero registers -> just set destination to zero */
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
> +    } else if (unlikely((XRb == 0) || (XRc == 0))) {
> +        /* exactly one operand is zero register - find which one is not...*/
> +        uint32_t XRx = XRb ? XRb : XRc;
> +        /* ...and do max/min operation with one operand 0 */
> +        if (opc == OPC_MXU_S32MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
> +        }
> +    } else if (unlikely(XRb == XRc)) {
> +        /* both operands same -> just set destination to one of them */
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +    } else {
> +        /* the most general case */
> +        if (opc == OPC_MXU_S32MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
> +                                               mxu_gpr[XRc - 1]);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
> +                                               mxu_gpr[XRc - 1]);
> +        }
> +    }
> +}
> +
> +/*
> + *  D16MAX
> + *    Update XRa with the 16-bit-wise maximums of signed integers
> + *    contained in XRb and XRc.
> + *
> + *  D16MIN
> + *    Update XRa with the 16-bit-wise minimums of signed integers
> + *    contained in XRb and XRc.
> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL00|
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + */
> +static void gen_mxu_D16MAX_D16MIN(DisasContext *ctx)
> +{
> +    uint32_t pad, opc, XRc, XRb, XRa;
> +
> +    pad = extract32(ctx->opcode, 21, 5);
> +    opc = extract32(ctx->opcode, 18, 3);
> +    XRc = extract32(ctx->opcode, 14, 4);
> +    XRb = extract32(ctx->opcode, 10, 4);
> +    XRa = extract32(ctx->opcode,  6, 4);
> +
> +    if (unlikely(pad != 0)) {
> +        /* opcode padding incorrect -> do nothing */
> +    } else if (unlikely(XRc == 0)) {
> +        /* destination is zero register -> do nothing */
> +    } else if (unlikely((XRb == 0) && (XRa == 0))) {
> +        /* both operands zero registers -> just set destination to zero */
> +        tcg_gen_movi_i32(mxu_gpr[XRc - 1], 0);
> +    } else if (unlikely((XRb == 0) || (XRa == 0))) {
> +        /* exactly one operand is zero register - find which one is not...*/
> +        uint32_t XRx = XRb ? XRb : XRc;
> +        /* ...and do half-word-wise max/min with one operand 0 */
> +        TCGv_i32 t0 = tcg_temp_new();
> +        TCGv_i32 t1 = tcg_const_i32(0);
> +
> +        /* the left half-word first */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0xFFFF0000);
> +        if (opc == OPC_MXU_D16MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
> +        }
> +
> +        /* the right half-word */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0x0000FFFF);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 16);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_D16MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting half-words to its original position */
> +        tcg_gen_shri_i32(t0, t0, 16);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        tcg_temp_free(t1);
> +        tcg_temp_free(t0);
> +    } else if (unlikely(XRb == XRc)) {
> +        /* both operands same -> just set destination to one of them */
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +    } else {
> +        /* the most general case */
> +        TCGv_i32 t0 = tcg_temp_new();
> +        TCGv_i32 t1 = tcg_temp_new();
> +
> +        /* the left half-word first */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0xFFFF0000);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFFFF0000);
> +        if (opc == OPC_MXU_D16MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
> +        }
> +
> +        /* the right half-word */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x0000FFFF);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0x0000FFFF);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 16);
> +        tcg_gen_shli_i32(t1, t1, 16);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_D16MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting half-words to its original position */
> +        tcg_gen_shri_i32(t0, t0, 16);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        tcg_temp_free(t1);
> +        tcg_temp_free(t0);
> +    }
> +}
> +
> +/*
> + *  Q8MAX
> + *    Update XRa with the 8-bit-wise maximums of signed integers
> + *    contained in XRb and XRc.
> + *
> + *  Q8MIN
> + *    Update XRa with the 8-bit-wise minimums of signed integers
> + *    contained in XRb and XRc.
> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + *  |  SPECIAL2 |0 0 0 0 0| opc |  XRc  |  XRb  |  XRa  |MXU__POOL00|
> + *  +-----------+---------+-----+-------+-------+-------+-----------+
> + */
> +static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
> +{
> +    uint32_t pad, opc, XRc, XRb, XRa;
> +
> +    pad = extract32(ctx->opcode, 21, 5);
> +    opc = extract32(ctx->opcode, 18, 3);
> +    XRc = extract32(ctx->opcode, 14, 4);
> +    XRb = extract32(ctx->opcode, 10, 4);
> +    XRa = extract32(ctx->opcode,  6, 4);
> +
> +    if (unlikely(pad != 0)) {
> +        /* opcode padding incorrect -> do nothing */
> +    } else if (unlikely(XRa == 0)) {
> +        /* destination is zero register -> do nothing */
> +    } else if (unlikely((XRb == 0) && (XRc == 0))) {
> +        /* both operands zero registers -> just set destination to zero */
> +        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
> +    } else if (unlikely((XRb == 0) || (XRc == 0))) {
> +        /* exactly one operand is zero register - make it be the first...*/
> +        uint32_t XRx = XRb ? XRb : XRc;
> +        /* ...and do byte-wise max/min with one operand 0 */
> +        TCGv_i32 t0 = tcg_temp_new();
> +        TCGv_i32 t1 = tcg_const_i32(0);
> +
> +        /* the leftmost byte (byte 3) first */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0xFF000000);
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
> +        }
> +
> +        /* byte 2 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0x00FF0000);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 8);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 8);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        /* byte 1 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0x0000FF00);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 16);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 24);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        /* byte 0 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRx - 1], 0x000000FF);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 24);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 8);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        tcg_temp_free(t1);
> +        tcg_temp_free(t0);
> +    } else if (unlikely(XRb == XRc)) {
> +        /* both operands same -> just set destination to one of them */
> +        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
> +    } else {
> +        /* the most general case */
> +        TCGv_i32 t0 = tcg_temp_new();
> +        TCGv_i32 t1 = tcg_temp_new();
> +
> +        /* the leftmost byte (byte 3) first */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0xFF000000);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0xFF000000);
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(mxu_gpr[XRa - 1], t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(mxu_gpr[XRa - 1], t0, t1);
> +        }
> +
> +        /* byte 2 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x00FF0000);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0x00FF0000);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 8);
> +        tcg_gen_shli_i32(t1, t1, 8);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 8);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        /* byte 1 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x0000FF00);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0x0000FF00);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 16);
> +        tcg_gen_shli_i32(t1, t1, 16);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 24);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        /* byte 0 */
> +        tcg_gen_andi_i32(t0, mxu_gpr[XRb - 1], 0x000000FF);
> +        tcg_gen_andi_i32(t1, mxu_gpr[XRc - 1], 0x000000FF);
> +        /* move half-words to the leftmost position */
> +        tcg_gen_shli_i32(t0, t0, 24);
> +        tcg_gen_shli_i32(t1, t1, 24);
> +        /* t0 will be max/min of t0 and t1 */
> +        if (opc == OPC_MXU_Q8MAX) {
> +            tcg_gen_smax_i32(t0, t0, t1);
> +        } else {
> +            tcg_gen_smin_i32(t0, t0, t1);
> +        }
> +        /* return resulting byte to its original position */
> +        tcg_gen_shri_i32(t0, t0, 8);
> +        /* finaly update the destination */
> +        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRa - 1], t0);
> +
> +        tcg_temp_free(t1);
> +        tcg_temp_free(t0);
> +    }
> +}
> +
> +
>  /*
>   * Decoding engine for MXU
>   * =======================
> @@ -24836,34 +25168,16 @@ static void decode_opc_mxu__pool00(CPUMIPSState *env, DisasContext *ctx)
>
>      switch (opcode) {
>      case OPC_MXU_S32MAX:
> -        /* TODO: Implement emulation of S32MAX instruction. */
> -        MIPS_INVAL("OPC_MXU_S32MAX");
> -        generate_exception_end(ctx, EXCP_RI);
> -        break;
>      case OPC_MXU_S32MIN:
> -        /* TODO: Implement emulation of S32MIN instruction. */
> -        MIPS_INVAL("OPC_MXU_S32MIN");
> -        generate_exception_end(ctx, EXCP_RI);
> +        gen_mxu_S32MAX_S32MIN(ctx);
>          break;
>      case OPC_MXU_D16MAX:
> -        /* TODO: Implement emulation of D16MAX instruction. */
> -        MIPS_INVAL("OPC_MXU_D16MAX");
> -        generate_exception_end(ctx, EXCP_RI);
> -        break;
>      case OPC_MXU_D16MIN:
> -        /* TODO: Implement emulation of D16MIN instruction. */
> -        MIPS_INVAL("OPC_MXU_D16MIN");
> -        generate_exception_end(ctx, EXCP_RI);
> +        gen_mxu_D16MAX_D16MIN(ctx);
>          break;
>      case OPC_MXU_Q8MAX:
> -        /* TODO: Implement emulation of Q8MAX instruction. */
> -        MIPS_INVAL("OPC_MXU_Q8MAX");
> -        generate_exception_end(ctx, EXCP_RI);
> -        break;
>      case OPC_MXU_Q8MIN:
> -        /* TODO: Implement emulation of Q8MIN instruction. */
> -        MIPS_INVAL("OPC_MXU_Q8MIN");
> -        generate_exception_end(ctx, EXCP_RI);
> +        gen_mxu_Q8MAX_Q8MIN(ctx);
>          break;
>      case OPC_MXU_Q8SLT:
>          /* TODO: Implement emulation of Q8SLT instruction. */
> --
> 2.17.1
>
>
