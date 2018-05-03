Received: from eggs.gnu.org ([2001:4830:134:3::10]:44070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELjO-00008o-JS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELjM-0002OZ-Oe
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:25:38 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fELjL-0002L6-3a
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:25:35 -0400
Received: by mail-lf0-x242.google.com with SMTP id g12-v6so28065978lfb.10
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-35-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-35-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:25:07 +0000
Message-ID: <CAKmqyKMEr8HcUxL8nko8OXeFpY2hRHYGVq7vtjB=LRqOpHDUAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 34/35] RISC-V: Add hartid and \n to
 interrupt logging
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

On Wed, Apr 25, 2018 at 5:05 PM Michael Clark <mjc@sifive.com> wrote:

> Add carriage return that was erroneously removed
> when converting to qemu_log. Change hard coded
> core number to the actual hartid.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/cpu_helper.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)

> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 5d33f7b..a45885f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -445,11 +445,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>       if (RISCV_DEBUG_INTERRUPT) {
>           int log_cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>           if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
> -            qemu_log_mask(LOG_TRACE, "core   0: trap %s, epc 0x"
TARGET_FMT_lx,
> -                riscv_intr_names[log_cause], env->pc);
> +            qemu_log_mask(LOG_TRACE, "core "
> +                TARGET_FMT_ld ": trap %s, epc 0x" TARGET_FMT_lx "\n",
> +                env->mhartid, riscv_intr_names[log_cause], env->pc);
>           } else {
> -            qemu_log_mask(LOG_TRACE, "core   0: intr %s, epc 0x"
TARGET_FMT_lx,
> -                riscv_excp_names[log_cause], env->pc);
> +            qemu_log_mask(LOG_TRACE, "core "
> +                TARGET_FMT_ld ": intr %s, epc 0x" TARGET_FMT_lx "\n",
> +                env->mhartid, riscv_excp_names[log_cause], env->pc);
>           }
>       }

> @@ -511,8 +513,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)

>           if (hasbadaddr) {
>               if (RISCV_DEBUG_INTERRUPT) {
> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid,
env->badaddr);
> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ":
badaddr 0x"
> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>               }
>               env->sbadaddr = env->badaddr;
>           } else {
> @@ -536,8 +538,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)

>           if (hasbadaddr) {
>               if (RISCV_DEBUG_INTERRUPT) {
> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid,
env->badaddr);
> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ":
badaddr 0x"
> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>               }
>               env->mbadaddr = env->badaddr;
>           } else {
> --
> 2.7.0
