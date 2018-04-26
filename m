Received: from eggs.gnu.org ([2001:4830:134:3::10]:38475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkgt-0002vl-8P
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkgs-00057X-9b
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:19 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBkgs-00056y-1V
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:18 -0400
Received: by mail-lf0-x243.google.com with SMTP id d20-v6so31920583lfe.3
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-17-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-17-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 17:27:51 +0000
Message-ID: <CAKmqyKNUzW=N6O5TTcW-aN6YH+yg4=DMarwWVmuYGk00roZ-yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 16/35] RISC-V: Make mtvec/stvec ignore
 vectored traps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Wed, Apr 25, 2018 at 5:08 PM Michael Clark <mjc@sifive.com> wrote:

> Vectored traps for asynchrounous interrupts are optional.
> The mtvec/stvec mode field is WARL and hence does not trap
> if an illegal value is written. Illegal values are ignored.

> Later we can add RISCV_FEATURE_VECTORED_TRAPS however
> until then the correct behavior for WARL (Write Any, Read
> Legal) fields is to drop writes to unsupported bits.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>   target/riscv/op_helper.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)

> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 101dac1..828f20c 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -276,11 +276,10 @@ void csr_write_helper(CPURISCVState *env,
target_ulong val_to_write,
>           env->sepc = val_to_write;
>           break;
>       case CSR_STVEC:
> -        if (val_to_write & 1) {
> -            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not
supported");

Should the unimplemented log be removed?

Alistair

> -            goto do_illegal;
> +        /* we do not support vectored traps for asynchrounous interrupts
*/
> +        if ((val_to_write & 3) == 0) {
> +            env->stvec = val_to_write >> 2 << 2;
>           }
> -        env->stvec = val_to_write >> 2 << 2;
>           break;
>       case CSR_SCOUNTEREN:
>           env->scounteren = val_to_write;
> @@ -298,11 +297,10 @@ void csr_write_helper(CPURISCVState *env,
target_ulong val_to_write,
>           env->mepc = val_to_write;
>           break;
>       case CSR_MTVEC:
> -        if (val_to_write & 1) {
> -            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not
supported");
> -            goto do_illegal;
> +        /* we do not support vectored traps for asynchrounous interrupts
*/
> +        if ((val_to_write & 3) == 0) {
> +            env->mtvec = val_to_write >> 2 << 2;
>           }
> -        env->mtvec = val_to_write >> 2 << 2;
>           break;
>       case CSR_MCOUNTEREN:
>           env->mcounteren = val_to_write;
> --
> 2.7.0
