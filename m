Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFieh-0004SY-9D
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFiec-0000AC-Tl
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:38:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gFieX-0008So-IS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 12:38:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id a19-v6so4455690pfo.8
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:38:29 -0700 (PDT)
Date: Thu, 25 Oct 2018 09:38:27 -0700 (PDT)
In-Reply-To: <20181020071451.27808-2-kbastian@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-4055ca5c-cc16-4614-9e8f-d1692651282f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/29] target/riscv: Move CPURISCVState
 pointer to DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Sat, 20 Oct 2018 00:14:23 PDT (-0700), kbastian@mail.uni-paderborn.de wrote:
> CPURISCVState is rarely used, so there is no need to pass it to every
> translate function. This paves the way for decodetree which only passes
> DisasContext to translate functions.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/translate.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 18d7b6d147..e81b9f097e 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -52,6 +52,7 @@ typedef struct DisasContext {
>         to any system register, which includes CSR_FRM, so we do not have
>         to reset this known value.  */
>      int frm;
> +    CPURISCVState *env;
>  } DisasContext;
>
>  /* convert riscv funct3 to qemu memop for load/store */
> @@ -1789,19 +1790,19 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
>      }
>  }
>
> -static void decode_opc(CPURISCVState *env, DisasContext *ctx)
> +static void decode_opc(DisasContext *ctx)
>  {
>      /* check for compressed insn */
>      if (extract32(ctx->opcode, 0, 2) != 3) {
> -        if (!riscv_has_ext(env, RVC)) {
> +        if (!riscv_has_ext(ctx->env, RVC)) {
>              gen_exception_illegal(ctx);
>          } else {
>              ctx->pc_succ_insn = ctx->base.pc_next + 2;
> -            decode_RV32_64C(env, ctx);
> +            decode_RV32_64C(ctx->env, ctx);
>          }
>      } else {
>          ctx->pc_succ_insn = ctx->base.pc_next + 4;
> -        decode_RV32_64G(env, ctx);
> +        decode_RV32_64G(ctx->env, ctx);
>      }
>  }
>
> @@ -1846,10 +1847,10 @@ static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>  static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
> -    CPURISCVState *env = cpu->env_ptr;
> +    ctx->env = cpu->env_ptr;
>
> -    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> -    decode_opc(env, ctx);
> +    ctx->opcode = cpu_ldl_code(ctx->env, ctx->base.pc_next);
> +    decode_opc(ctx);
>      ctx->base.pc_next = ctx->pc_succ_insn;
>
>      if (ctx->base.is_jmp == DISAS_NEXT) {

I think this is OK, but I'm not sure.  All the other ports do this in a 
different way: rather than including the CPU state structure in DisasContext 
they explicitly call out the state that can change instruction decoding by 
duplicating it within DisasContext.  Michael's patch queue handles this in the 
canonical way, but I think it's a bit cleaner to avoid duplicating the state.  
My worry is that, since changing the CPU state changes the legal instructions, 
we will paint ourselves into a corner when it comes to faithfully implementing 
a writeable MISA register.
