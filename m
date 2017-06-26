Received: from eggs.gnu.org ([2001:4830:134:3::10]:46968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVEr-0008Sd-Dg
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPVEo-0006og-BN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:43:41 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPVEo-0006oO-2H
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 10:43:38 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so145799786wrc.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 07:43:37 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-2-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170621024831.26019-2-rth@twiddle.net>
Date: Mon, 26 Jun 2017 15:44:26 +0100
Message-ID: <878tkeyfjp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/16] tcg: Merge opcode arguments into
 TCGOp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> Rather than have a separate buffer of 10*max_ops entries,
> give each opcode 10 entries.  The result is actually a bit
> smaller and should have slightly more cache locality.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
<snip>

The changes look fine, some questions bellow:

> index 9e37722..720e04e 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -51,8 +51,6 @@
>  #define OPC_BUF_SIZE 640
>  #define OPC_MAX_SIZE (OPC_BUF_SIZE - MAX_OP_PER_INSTR)
>
> -#define OPPARAM_BUF_SIZE (OPC_BUF_SIZE * MAX_OPC_PARAM)
> -
>  #define CPU_TEMP_BUF_NLONGS 128
>
>  /* Default target word size to pointer size.  */
> @@ -613,33 +611,29 @@ typedef struct TCGTempSet {
>  #define SYNC_ARG  1
>  typedef uint16_t TCGLifeData;
>
> -/* The layout here is designed to avoid crossing of a 32-bit boundary.
> -   If we do so, gcc adds padding, expanding the size to 12.  */
> +/* The layout here is designed to avoid crossing of a 32-bit
> boundary.  */

This isn't correct now? Do we mean we now aim to be cache line aligned?

>  typedef struct TCGOp {
>      TCGOpcode opc   : 8;        /*  8 */
>
> -    /* Index of the prev/next op, or 0 for the end of the list.  */
> -    unsigned prev   : 10;       /* 18 */
> -    unsigned next   : 10;       /* 28 */
> -
>      /* The number of out and in parameter for a call.  */
> -    unsigned calli  : 4;        /* 32 */
> -    unsigned callo  : 2;        /* 34 */
> +    unsigned calli  : 4;        /* 12 */
> +    unsigned callo  : 2;        /* 14 */
> +    unsigned        : 2;        /* 16 */
>
> -    /* Index of the arguments for this op, or 0 for zero-operand ops.  */
> -    unsigned args   : 14;       /* 48 */
> +    /* Index of the prev/next op, or 0 for the end of the list.  */
> +    unsigned prev   : 16;       /* 32 */
> +    unsigned next   : 16;       /* 48 */
>
>      /* Lifetime data of the operands.  */
>      unsigned life   : 16;       /* 64 */
> +
> +    /* Arguments for the opcode.  */
> +    TCGArg args[MAX_OPC_PARAM];
>  } TCGOp;
>
>  /* Make sure operands fit in the bitfields above.  */
>  QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
> -QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 10));
> -QEMU_BUILD_BUG_ON(OPPARAM_BUF_SIZE > (1 << 14));
> -
> -/* Make sure that we don't overflow 64 bits without noticing.  */
> -QEMU_BUILD_BUG_ON(sizeof(TCGOp) > 8);
> +QEMU_BUILD_BUG_ON(OPC_BUF_SIZE > (1 << 16));

OPC_BUF_SIZE is statically assigned, we don't seem to be taking notice
of sizeof(TCGOp) anymore here. In fact OPC_BUF_SIZE is really
MAX_TCG_OPS right?

I see TCGArg is currently target_ulong. Is this because we never leak
the host size details into generated code safe for the statically
assigned env_ptr?

I mention this because in looking at modelling SIMD registers I'm going
to need to carry a host ptr around in TCG registers that can be passed
to helpers and the like.

>
>  struct TCGContext {
>      uint8_t *pool_cur, *pool_end;
> @@ -691,7 +685,6 @@ struct TCGContext {
>  #endif
>
>      int gen_next_op_idx;
> -    int gen_next_parm_idx;
>
>      /* Code generation.  Note that we specifically do not use tcg_insn_unit
>         here, because there's too much arithmetic throughout that relies
> @@ -723,7 +716,6 @@ struct TCGContext {
>      TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
>
>      TCGOp gen_op_buf[OPC_BUF_SIZE];
> -    TCGArg gen_opparam_buf[OPPARAM_BUF_SIZE];
>
>      uint16_t gen_insn_end_off[TCG_MAX_INSNS];
>      target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> @@ -734,8 +726,7 @@ extern bool parallel_cpus;
>
>  static inline void tcg_set_insn_param(int op_idx, int arg, TCGArg v)
>  {
> -    int op_argi = tcg_ctx.gen_op_buf[op_idx].args;
> -    tcg_ctx.gen_opparam_buf[op_argi + arg] = v;
> +    tcg_ctx.gen_op_buf[op_idx].args[arg] = v;
>  }
>
>  /* The number of opcodes emitted so far.  */


--
Alex Bennée
