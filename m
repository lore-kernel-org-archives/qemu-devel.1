Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gMkyf-0001zI-AS
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 21:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1gMkyd-0000Oh-LM
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 21:32:25 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1gMkyd-0000Lc-2v
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 21:32:23 -0500
Received: by mail-oi1-x241.google.com with SMTP id u130-v6so12309653oie.7
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 18:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20181113235045.14155-1-palmer@sifive.com>
	<20181113235045.14155-5-palmer@sifive.com>
In-Reply-To: <20181113235045.14155-5-palmer@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 14 Nov 2018 15:32:08 +1300
Message-ID: <CAHNT7Nu7NAc-=7DEQggnWXq-v-5xAwfrB4yrvWVCJp6S6T5=0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/4] RISC-V: Respect fences for user-only
 emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

Nits. Please improve your commit message to make them more impersonal...

On Wed, Nov 14, 2018 at 12:52 PM Palmer Dabbelt <palmer@sifive.com> wrote:

> Our current fence implementation ignores fences for the user-only
> configurations.  This is incorrect but unlikely to manifest: it requires
> multi-threaded user-only code that takes advantage of the weakness in
> the host's memory model and can be inlined by TCG.
>

The RISC-V fence implementation...


> This patch simply treats fences the same way for all our emulators.
> I've given it to testing as I don't want to construct a test that would
> actually trigger the failure.
>

Testing has been limited to... ? Reproducer?


> Our fence implementation has an additional deficiency where we map all
> RISC-V fences to full fences.  Now that we have a formal memory model
> for RISC-V we can start to take advantage of the strength bits on our
> fence instructions.  This requires a bit more though, so I'm going to
> split it out because the implementation is still correct without taking
> advantage of these weaker fences.
>

The fence implementation...

A formal memory model for RISC-V allows...


> Thanks to Richard Henderson for pointing out both of the issues.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


Assuming you fix up the commit message. I am not sure if I am present in
any of the commit messages I wrote, however perhaps thats just a matter
style with respect to writing (or re-writing) history.

Reviewed-by: Michael Clark <mjc@sifive.com>

---
>  target/riscv/translate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index f44eb9c41b48..312bf298b3c2 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1776,7 +1776,6 @@ static void decode_RV32_64G(CPURISCVState *env,
> DisasContext *ctx)
>                       GET_RM(ctx->opcode));
>          break;
>      case OPC_RISC_FENCE:
> -#ifndef CONFIG_USER_ONLY
>          if (ctx->opcode & 0x1000) {
>              /* FENCE_I is a no-op in QEMU,
>               * however we need to end the translation block */
> @@ -1787,7 +1786,6 @@ static void decode_RV32_64G(CPURISCVState *env,
> DisasContext *ctx)
>              /* FENCE is a full memory barrier. */
>              tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>          }
> -#endif
>          break;
>      case OPC_RISC_SYSTEM:
>          gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
> --
> 2.18.1
>
>
>
