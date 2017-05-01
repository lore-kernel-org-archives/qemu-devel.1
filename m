Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5JMm-0006IN-4w
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5JMh-0000cT-L6
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:00:22 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5JMh-0000cP-FX
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:00:19 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so18885632qkh.0
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 15:00:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170430145254.25616-1-aurelien@aurel32.net>
	<20170430145254.25616-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58c270d7-2b24-f529-145d-46d4b569e358@amsat.org>
Date: Mon, 1 May 2017 19:00:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170430145254.25616-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5++ 1/3] tcg/mips: implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>

On 04/30/2017 11:52 AM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/mips/tcg-target.h     |  2 +-
>  tcg/mips/tcg-target.inc.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
> index e3240cfba7..d75cb63ed3 100644
> --- a/tcg/mips/tcg-target.h
> +++ b/tcg/mips/tcg-target.h
> @@ -130,7 +130,7 @@ extern bool use_mips32r2_instructions;
>  #define TCG_TARGET_HAS_muluh_i32        1
>  #define TCG_TARGET_HAS_mulsh_i32        1
>  #define TCG_TARGET_HAS_bswap32_i32      1
> -#define TCG_TARGET_HAS_goto_ptr         0
> +#define TCG_TARGET_HAS_goto_ptr         1
>
>  #if TCG_TARGET_REG_BITS == 64
>  #define TCG_TARGET_HAS_add2_i32         0
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 01ac7b2c81..9e5b9f42da 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1747,6 +1747,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          tcg_out_nop(s);
>          s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
>          break;
> +    case INDEX_op_goto_ptr:
> +        /* jmp to the given host address (could be epilogue) */
> +        tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
> +        tcg_out_nop(s);
> +        break;
>      case INDEX_op_br:
>          tcg_out_brcond(s, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO,
>                         arg_label(a0));
> @@ -2160,6 +2165,7 @@ static const TCGTargetOpDef mips_op_defs[] = {
>      { INDEX_op_exit_tb, { } },
>      { INDEX_op_goto_tb, { } },
>      { INDEX_op_br, { } },
> +    { INDEX_op_goto_ptr, { "r" } },
>
>      { INDEX_op_ld8u_i32, { "r", "r" } },
>      { INDEX_op_ld8s_i32, { "r", "r" } },
> @@ -2451,6 +2457,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>      /* delay slot */
>      tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
>
> +    /*
> +     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
> +     * and fall through to the rest of the epilogue.
> +     */
> +    s->code_gen_epilogue = s->code_ptr;
> +    tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_V0, TCG_REG_ZERO);
> +
>      /* TB epilogue */
>      tb_ret_addr = s->code_ptr;
>      for (i = 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
>
