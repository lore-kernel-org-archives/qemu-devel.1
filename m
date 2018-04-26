Received: from eggs.gnu.org ([2001:4830:134:3::10]:41276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkov-0008EU-A5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBkou-0008OG-HT
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:37 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBkou-0008O5-AR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:36:36 -0400
Received: by mail-lf0-x242.google.com with SMTP id h4-v6so5165066lfc.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-19-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 17:36:09 +0000
Message-ID: <CAKmqyKOoyFv=oc818gJa509StObGhnuQDbusP1YsT8OJt7oD4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 18/35] RISC-V: Clear mtval/stval on
 exceptions without info
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

On Wed, Apr 25, 2018 at 4:59 PM Michael Clark <mjc@sifive.com> wrote:

> mtval/stval must be set on all exceptions but zero is
> a legal value if there is no exception specific info.
> Placing the instruction bytes for illegal instruction
> exceptions in mtval/stval is an optional feature and
> is currently not supported by QEMU RISC-V.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/target/riscv/helper.c b/target/riscv/helper.c
> index 459fc97..3b57e13 100644
> --- a/target/riscv/helper.c
> +++ b/target/riscv/helper.c
> @@ -492,6 +492,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                       ": badaddr 0x" TARGET_FMT_lx, env->mhartid,
env->badaddr);
>               }
>               env->sbadaddr = env->badaddr;
> +        } else {
> +            /* otherwise we must clear sbadaddr/stval
> +             * todo: support populating stval on illegal instructions */
> +            env->sbadaddr = 0;
>           }

>           target_ulong s = env->mstatus;
> @@ -513,6 +517,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                       ": badaddr 0x" TARGET_FMT_lx, env->mhartid,
env->badaddr);
>               }
>               env->mbadaddr = env->badaddr;
> +        } else {
> +            /* otherwise we must clear mbadaddr/mtval
> +             * todo: support populating mtval on illegal instructions */
> +            env->mbadaddr = 0;
>           }

>           target_ulong s = env->mstatus;
> --
> 2.7.0
