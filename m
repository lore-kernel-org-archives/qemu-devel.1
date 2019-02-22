Received: from eggs.gnu.org ([209.51.188.92]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxKhg-0005M9-JI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 18:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxKhd-0002C1-QF
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 18:58:04 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxKhd-00020d-GU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 18:58:01 -0500
Received: by mail-pl1-x643.google.com with SMTP id y5so1774198plk.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 15:57:44 -0800 (PST)
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f782bdde-2a42-c612-5769-1cde42e7c2a4@linaro.org>
Date: Fri, 22 Feb 2019 15:57:40 -0800
MIME-Version: 1.0
In-Reply-To: <20190222162555.13764-2-amagdy.afifi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv: Add proper alignment check and
 pending 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amagdy.afifi@gmail.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

On 2/22/19 8:25 AM, amagdy.afifi@gmail.com wrote:
> @@ -373,9 +373,10 @@ static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
>      }
>  
>      /* Suppress 'C' if next instruction is not aligned
> -       TODO: this should check next_pc */
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> +       check next target pc */
> +    if ((val & RVC) && (env->pc_next & 3) != 0) {
>          val &= ~RVC;
> +        env->pending_rvc = 1;
>      }
>  
>      /* misa.MXL writes are not supported by QEMU */
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 2321bba..c9d84ea 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1999,20 +1999,26 @@ static void decode_RV32_64G(DisasContext *ctx)
>      }
>  }
>  
> -static void decode_opc(DisasContext *ctx)
> +static void decode_opc(DisasContext *ctx, CPUState *cpu)
>  {
> +    CPURISCVState *env = cpu->env_ptr;
>      /* check for compressed insn */
>      if (extract32(ctx->opcode, 0, 2) != 3) {
>          if (!has_ext(ctx, RVC)) {
>              gen_exception_illegal(ctx);
>          } else {
> -            ctx->pc_succ_insn = ctx->base.pc_next + 2;
> +            env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 2;
>              decode_RV32_64C(ctx);
>          }
>      } else {
> -        ctx->pc_succ_insn = ctx->base.pc_next + 4;
> +        env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 4;
>          decode_RV32_64G(ctx);
>      }
> +    /* check pending RVC */
> +    if (env->pending_rvc && ((env->pc_next & 3) != 0)) {
> +        env->misa |= RVC;
> +        env->pending_rvc = 0;

You cannot manipulate env like this during translation.

Neither the write to env->pc_next nor the read from env->pending_rvc here will
be in any synchronization with the execution of write_misa.

What semantics are you attempting to implement wrt setting/clearing RVC from MISA?

> @@ -2061,7 +2067,7 @@ static void riscv_tr_translate_insn
>      CPURISCVState *env = cpu->env_ptr;
>  
>      ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> -    decode_opc(ctx);
> +    decode_opc(ctx, cpu);

This is exactly the reason why cpu is *not* passed down to decode_opc, so that
you cannot make this kind of mistake.


r~
