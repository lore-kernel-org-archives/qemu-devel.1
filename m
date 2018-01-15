Received: from eggs.gnu.org ([2001:4830:134:3::10]:35493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9du-0002yR-Sm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9dq-00028i-04
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:37:58 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:46009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb9dp-00028L-QE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:37:53 -0500
Received: by mail-pg0-x232.google.com with SMTP id c194so8312970pga.12
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:37:53 -0800 (PST)
References: <20180113004338.16867-1-laurent@vivier.eu>
	<20180113004338.16867-6-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca9dca07-3551-3e7b-cd1c-f1b41e1e3fc4@linaro.org>
Date: Mon, 15 Jan 2018 10:37:49 -0800
MIME-Version: 1.0
In-Reply-To: <20180113004338.16867-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/m68k: add moves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/12/2018 04:43 PM, Laurent Vivier wrote:
> index 1aadc622db..efe2bf90ee 100644
> --- a/target/m68k/qregs.def
> +++ b/target/m68k/qregs.def
> @@ -1,5 +1,7 @@
>  DEFO32(PC, pc)
>  DEFO32(SR, sr)
> +DEFO32(DFC, dfc)
> +DEFO32(SFC, sfc)

These are unused.  No need to define or initialize.

>  #if defined(CONFIG_SOFTMMU)
> +DISAS_INSN(moves)
> +{
> +    int opsize;
> +    uint16_t ext;
> +    TCGv reg;
> +    TCGv addr;
> +    int extend;
> +
> +    if (IS_USER(s)) {
> +        gen_exception(s, s->insn_pc, EXCP_PRIVILEGE);
> +        return;
> +    }
> +
> +    ext = read_im16(env, s);
> +
> +    opsize = insn_opsize(insn);
> +
> +    if (ext & 0x8000) {
> +        /* address register */
> +        reg = AREG(ext, 12);
> +        extend = 1;
> +    } else {
> +        /* data register */
> +        reg = DREG(ext, 12);
> +        extend = 0;
> +    }
> +
> +    addr = gen_lea(env, s, insn, opsize);
> +    if (IS_NULL_QREG(addr)) {
> +        gen_addr_fault(s);
> +        return;
> +    }
> +
> +    if (ext & 0x0800) {
> +        /* from reg to ea */
> +        gen_store(s, opsize, addr, reg, DFC_INDEX(s));
> +    } else {
> +        /* from ea to reg */
> +        TCGv tmp = gen_load(s, opsize, addr, 0, SFC_INDEX(s));
> +        if (extend) {
> +            gen_ext(reg, tmp, opsize, 1);
> +        } else {
> +            gen_partset_reg(opsize, reg, tmp);
> +        }
> +    }
> +    switch (extract32(insn, 3, 3)) {
> +    case 3: /* Indirect postincrement.  */
> +        tcg_gen_addi_i32(AREG(insn, 0), addr,
> +                         REG(insn, 0) == 7 && opsize == OS_BYTE
> +                         ? 2
> +                         : opsize_bytes(opsize));
> +        break;
> +    case 4: /* Indirect predecrememnt.  */
> +        tcg_gen_mov_i32(AREG(insn, 0), addr);
> +        break;
> +    }
> +}

Looks ok.

> -    dc->user = (env->sr & SR_S) == 0;
> +#if defined(CONFIG_SOFTMMU)
> +    dc->user = (env->sr & SR_S) == 0 ? M68K_USER_FROM_MSR : 0;
> +    dc->user |= (env->sfc & 4) == 0 ? M68K_USER_FROM_SFC : 0;
> +    dc->user |= (env->dfc & 4) == 0 ? M68K_USER_FROM_DFC : 0;
> +#endif

Really you should be extracting these from tb->flags.

You also need to end the TB when assigning to SFC and DFC.  Otherwise the
generated code is not in sync with the register contents.



r~
