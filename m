Received: from eggs.gnu.org ([2001:4830:134:3::10]:36565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkad-0008GX-Jq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkac-0001KT-Mg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:21:51 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:45373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBkac-0001Jo-EF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:21:50 -0400
Received: by mail-lf0-x243.google.com with SMTP id q5-v6so31854488lff.12
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-16-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 17:21:23 +0000
Message-ID: <CAKmqyKMPGUri_gq8S9tz1JUovfFp5kJ1yVzmGYkkNvATzDBvTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 15/35] RISC-V: Hardwire satp to 0 for
 no-mmu case
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

On Wed, Apr 25, 2018 at 4:56 PM Michael Clark <mjc@sifive.com> wrote:

> satp is WARL so it should not trap on illegal writes, rather
> it can be hardwired to zero and silently ignore illegal writes.

> It seems the RISC-V WARL behaviour is preferred to having to
> trap overhead versus simply reading back the value and checking
> if the write took (saves hundreds of cycles and more complex
> trap handling code).

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/op_helper.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 7c6068b..101dac1 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -255,7 +255,7 @@ void csr_write_helper(CPURISCVState *env,
target_ulong val_to_write,
>       }
>       case CSR_SATP: /* CSR_SPTBR */ {
>           if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> -            goto do_illegal;
> +            break;
>           }
>           if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val_to_write ^
env->sptbr))
>           {
> @@ -465,7 +465,10 @@ target_ulong csr_read_helper(CPURISCVState *env,
target_ulong csrno)
>           return env->scounteren;
>       case CSR_SCAUSE:
>           return env->scause;
> -    case CSR_SPTBR:
> +    case CSR_SATP: /* CSR_SPTBR */
> +        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> +            return 0;
> +        }
>           if (env->priv_ver >= PRIV_VERSION_1_10_0) {
>               return env->satp;
>           } else {
> --
> 2.7.0
