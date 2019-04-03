Received: from eggs.gnu.org ([209.51.188.92]:44285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBp3G-0003BW-0f
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBp3C-0007B5-Mq
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:12:13 -0400
MIME-Version: 1.0
References: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
In-Reply-To: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Apr 2019 16:10:13 -0700
Message-ID: <CAKmqyKNVno+jR_PYxgnyqQOSQFCn_ai7GH+hYPgaO=fkqHDa6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Behrens <fintelia@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Mon, Apr 1, 2019 at 1:39 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> The 'sfence.vma' instruction is privileged, and should only ever be allowed
> when executing in supervisor mode or higher.
>
> Jonathan
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index b7dc18a41e..644d0fb35f 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
>  {
>      RISCVCPU *cpu = riscv_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
> -    if (env->priv == PRV_S &&
> -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        get_field(env->mstatus, MSTATUS_TVM)) {
> +    if (!(env->priv >= PRV_S) ||
> +        (env->priv == PRV_S &&
> +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
> +         get_field(env->mstatus, MSTATUS_TVM))) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          tlb_flush(cs);
> --
> 2.20.1
