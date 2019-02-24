Received: from eggs.gnu.org ([209.51.188.92]:42325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxofj-0002D9-Qy
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 02:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxofi-0005t5-Hu
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 02:58:03 -0500
MIME-Version: 1.0
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
	<f782bdde-2a42-c612-5769-1cde42e7c2a4@linaro.org>
In-Reply-To: <f782bdde-2a42-c612-5769-1cde42e7c2a4@linaro.org>
From: Amed Magdy <amagdy.afifi@gmail.com>
Date: Sun, 24 Feb 2019 09:57:47 +0200
Message-ID: <CAKV=O7mWBKQzVJRJT-bGW0Ojvb7eFraGniqG1-qPidZWHtp8Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

Thank you for your review and feedback, Richard.
As Eric mentioned, this is the first time contribution. I have been
exploring Qemu for some time and try to understand main flow, internals,
..etc.

>  You cannot manipulate env like this during translation.

>  Neither the write to env->pc_next nor the read from env->pending_rvc
here will
>  be in any synchronization with the execution of write_misa.

Does this applies for translated code in a single translation block only or
for different TBs also ?

So should I manipulate "env" from translation context through helpers only
? for example:

TCGv temp;
tcg_gen_movi_tl(temp, ctx->pc_succ_insn);
gen_helper_next_pc(cpu_env, temp);

while the helper function definition like that:
void helper_next_pc(CPURISCVState *env, target_ulong pc_next)
{
    env->pc_next = pc_next;
}

and the same to read "env->pending_rvc"

I'm thinking of a way to add 'C' extension at run time through waiting the
correct aligned instruction, which I believe it might be after branch
something quite similar to switching between ARM and THUMB states in ARM,
for misa 'RVC' enable to take effect since it will be no possibility to
check alignment with 'C' extension.

Thanks,
Ahmed


On Sat, 23 Feb 2019 at 01:57, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/22/19 8:25 AM, amagdy.afifi@gmail.com wrote:
> > @@ -373,9 +373,10 @@ static int write_misa(CPURISCVState *env, int
> csrno, target_ulong val)
> >      }
> >
> >      /* Suppress 'C' if next instruction is not aligned
> > -       TODO: this should check next_pc */
> > -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> > +       check next target pc */
> > +    if ((val & RVC) && (env->pc_next & 3) != 0) {
> >          val &= ~RVC;
> > +        env->pending_rvc = 1;
> >      }
> >
> >      /* misa.MXL writes are not supported by QEMU */
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index 2321bba..c9d84ea 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -1999,20 +1999,26 @@ static void decode_RV32_64G(DisasContext *ctx)
> >      }
> >  }
> >
> > -static void decode_opc(DisasContext *ctx)
> > +static void decode_opc(DisasContext *ctx, CPUState *cpu)
> >  {
> > +    CPURISCVState *env = cpu->env_ptr;
> >      /* check for compressed insn */
> >      if (extract32(ctx->opcode, 0, 2) != 3) {
> >          if (!has_ext(ctx, RVC)) {
> >              gen_exception_illegal(ctx);
> >          } else {
> > -            ctx->pc_succ_insn = ctx->base.pc_next + 2;
> > +            env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 2;
> >              decode_RV32_64C(ctx);
> >          }
> >      } else {
> > -        ctx->pc_succ_insn = ctx->base.pc_next + 4;
> > +        env->pc_next = ctx->pc_succ_insn = ctx->base.pc_next + 4;
> >          decode_RV32_64G(ctx);
> >      }
> > +    /* check pending RVC */
> > +    if (env->pending_rvc && ((env->pc_next & 3) != 0)) {
> > +        env->misa |= RVC;
> > +        env->pending_rvc = 0;
>
> You cannot manipulate env like this during translation.
>
> Neither the write to env->pc_next nor the read from env->pending_rvc here
> will
> be in any synchronization with the execution of write_misa.
>
> What semantics are you attempting to implement wrt setting/clearing RVC
> from MISA?
>
> > @@ -2061,7 +2067,7 @@ static void riscv_tr_translate_insn
> >      CPURISCVState *env = cpu->env_ptr;
> >
> >      ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> > -    decode_opc(ctx);
> > +    decode_opc(ctx, cpu);
>
> This is exactly the reason why cpu is *not* passed down to decode_opc, so
> that
> you cannot make this kind of mistake.
>
>
> r~
>
