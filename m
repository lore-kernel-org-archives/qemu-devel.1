Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gLEzd-0004Y3-2v
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gLErb-0003K6-VT
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:02:52 -0500
MIME-Version: 1.0
References: <20181109191933.6641-1-palmer@sifive.com>
	<20181109191933.6641-2-palmer@sifive.com>
In-Reply-To: <20181109191933.6641-2-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Nov 2018 14:02:15 -0800
Message-ID: <CAKmqyKPDNncn5NTcBm+ubgAD3M22aKK2yvLmzuP5x4s4nP8Ozg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 3.1] RISC-V: Respect fences for
 user-only emulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Nov 9, 2018 at 11:21 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Our current fence implementation ignores fences for the user-only
> configurations.  This is incorrect but unlikely to manifest: it requires
> multi-threaded user-only code that takes advantage of the weakness in
> the host's memory model and can be inlined by TCG.
>
> This patch simply treats fences the same way for all our emulators.
> I've given it to testing as I don't want to construct a test that would
> actually trigger the failure.
>
> Our fence implementation has an additional deficiency where we map all
> RISC-V fences to full fences.  Now that we have a formal memory model
> for RISC-V we can start to take advantage of the strength bits on our
> fence instructions.  This requires a bit more though, so I'm going to

s/though/thought/g

> split it out because the implementation is still correct without taking
> advantage of these weaker fences.
>
> Thanks to Richard Henderson for pointing out both of the issues.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 18d7b6d1471d..624d1c679a84 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1766,7 +1766,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
>                       GET_RM(ctx->opcode));
>          break;
>      case OPC_RISC_FENCE:
> -#ifndef CONFIG_USER_ONLY
>          if (ctx->opcode & 0x1000) {
>              /* FENCE_I is a no-op in QEMU,
>               * however we need to end the translation block */
> @@ -1777,7 +1776,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
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
