Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2wy-00010b-ER
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cF2wv-0006Dt-D2
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:57:44 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cF2wu-0006De-TE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:57:41 -0500
Received: by mail-wm0-f43.google.com with SMTP id a197so228289898wmd.0
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 09:57:40 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-43-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-43-git-send-email-rth@twiddle.net>
Date: Thu, 08 Dec 2016 17:56:38 +0000
Message-ID: <871sxiz4mh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 42/64] tcg/arm: Handle ctz and clz
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/arm/tcg-target.h     |  4 ++--
>  tcg/arm/tcg-target.inc.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 02cc242..4cb94dc 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -110,8 +110,8 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> -#define TCG_TARGET_HAS_clz_i32          0
> -#define TCG_TARGET_HAS_ctz_i32          0
> +#define TCG_TARGET_HAS_clz_i32          use_armv5t_instructions
> +#define TCG_TARGET_HAS_ctz_i32          use_armv7_instructions
>  #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 473c170..2242d21 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -256,6 +256,9 @@ typedef enum {
>      ARITH_BIC = 0xe << 21,
>      ARITH_MVN = 0xf << 21,
>
> +    INSN_CLZ       = 0x016f0f10,
> +    INSN_RBIT      = 0x06ff0f30,
> +
>      INSN_LDR_IMM   = 0x04100000,
>      INSN_LDR_REG   = 0x06100000,
>      INSN_STR_IMM   = 0x04000000,
> @@ -1827,6 +1830,28 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          }
>          break;
>
> +    case INDEX_op_ctz_i32:
> +        tcg_out_dat_reg(s, COND_AL, INSN_RBIT, TCG_REG_TMP, 0, args[1], 0);
> +        a1 = TCG_REG_TMP;
> +        goto do_clz;
> +
> +    case INDEX_op_clz_i32:
> +        a1 = args[1];
> +    do_clz:
> +        a0 = args[0];
> +        a2 = args[2];
> +        c = const_args[2];
> +        if (c && a2 == 32) {
> +            tcg_out_dat_reg(s, COND_AL, INSN_CLZ, a0, 0, a1, 0);
> +            break;
> +        }

Why the early break instead of else leg?

> +        tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
> +        tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
> +        if (c || a0 != a2) {
> +            tcg_out_dat_rIK(s, COND_EQ, ARITH_MOV, ARITH_MVN, a0, 0, a2, c);
> +        }
> +        break;
> +
>      case INDEX_op_brcond_i32:
>          tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0,
>                         args[0], args[1], const_args[1]);
> @@ -1961,6 +1986,8 @@ static const TCGTargetOpDef arm_op_defs[] = {
>      { INDEX_op_sar_i32, { "r", "r", "ri" } },
>      { INDEX_op_rotl_i32, { "r", "r", "ri" } },
>      { INDEX_op_rotr_i32, { "r", "r", "ri" } },
> +    { INDEX_op_clz_i32, { "r", "r", "rIK" } },
> +    { INDEX_op_ctz_i32, { "r", "r", "rIK" } },
>
>      { INDEX_op_brcond_i32, { "r", "rIN" } },
>      { INDEX_op_setcond_i32, { "r", "r", "rIN" } },

Otherwise:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
