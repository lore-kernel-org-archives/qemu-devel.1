Received: from eggs.gnu.org ([209.51.188.92]:52425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2Pal-0000qi-Ov
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2Pak-0007et-Rr
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:11:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2Pak-0007dd-Ia
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:11:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id g12so23099790wrm.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 16:11:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bb7933e-276d-3236-b4cc-ce18ce5ac9d4@amsat.org>
Date: Sat, 9 Mar 2019 01:11:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/9] tcg/arm: Support INDEX_op_extract2_i32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com

On 3/7/19 3:41 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/arm/tcg-target.h     |  2 +-
>  tcg/arm/tcg-target.inc.c | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 4ee6c98958..17e771374d 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -116,7 +116,7 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
> -#define TCG_TARGET_HAS_extract2_i32     0
> +#define TCG_TARGET_HAS_extract2_i32     1
>  #define TCG_TARGET_HAS_movcond_i32      1
>  #define TCG_TARGET_HAS_mulu2_i32        1
>  #define TCG_TARGET_HAS_muls2_i32        1
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 2245a8aeb9..6873b0cf95 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -2064,6 +2064,27 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>      case INDEX_op_sextract_i32:
>          tcg_out_sextract(s, COND_AL, args[0], args[1], args[2], args[3]);
>          break;
> +    case INDEX_op_extract2_i32:
> +        /* ??? These optimization vs zero should be generic.  */
> +        /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
> +        if (const_args[1]) {
> +            if (const_args[2]) {
> +                tcg_out_movi(s, TCG_TYPE_REG, args[0], 0);
> +            } else {
> +                tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
> +                                args[2], SHIFT_IMM_LSL(32 - args[3]));
> +            }
> +        } else if (const_args[2]) {
> +            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
> +                            args[1], SHIFT_IMM_LSR(args[3]));
> +        } else {
> +            /* We can do extract2 in 2 insns, vs the 3 required otherwise.  */
> +            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0,
> +                            args[2], SHIFT_IMM_LSL(32 - args[3]));
> +            tcg_out_dat_reg(s, COND_AL, ARITH_ORR, args[0], TCG_REG_TMP,
> +                            args[1], SHIFT_IMM_LSR(args[3]));
> +        }

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        break;
>  
>      case INDEX_op_div_i32:
>          tcg_out_sdiv(s, COND_AL, args[0], args[1], args[2]);
> @@ -2108,6 +2129,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>          = { .args_ct_str = { "s", "s", "s", "s" } };
>      static const TCGTargetOpDef br
>          = { .args_ct_str = { "r", "rIN" } };
> +    static const TCGTargetOpDef ext2
> +        = { .args_ct_str = { "r", "rZ", "rZ" } };
>      static const TCGTargetOpDef dep
>          = { .args_ct_str = { "r", "0", "rZ" } };
>      static const TCGTargetOpDef movc
> @@ -2174,6 +2197,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>          return &br;
>      case INDEX_op_deposit_i32:
>          return &dep;
> +    case INDEX_op_extract2_i32:
> +        return &ext2;
>      case INDEX_op_movcond_i32:
>          return &movc;
>      case INDEX_op_add2_i32:
> 
