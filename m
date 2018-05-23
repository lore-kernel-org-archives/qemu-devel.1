Received: from eggs.gnu.org ([2001:4830:134:3::10]:42938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSxZ-0006q5-Te
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSxU-0007KU-6Q
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:33:41 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLSxU-0007KG-1k
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:33:36 -0400
Received: by mail-qk0-x242.google.com with SMTP id z75-v6so17249931qkb.6
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:33:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-16-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <625fe1a3-fe18-6216-eeb2-393f90817bff@amsat.org>
Date: Wed, 23 May 2018 09:33:30 -0300
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-16-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 15/30] RISC-V: Add hartid and \n to
 interrupt logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

Hi Michael,

On 05/22/2018 09:15 PM, Michael Clark wrote:
> Add carriage return that was erroneously removed
> when converting to qemu_log. Change hard coded
> core number to the actual hartid.

I think it makes more sens to move this patch before your 6/30 "Move
non-ops from op_helper to cpu_helper".

> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/cpu_helper.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bc15e19022cc..69592c037042 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -446,11 +446,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (RISCV_DEBUG_INTERRUPT) {
>          int log_cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>          if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
> -            qemu_log_mask(LOG_TRACE, "core   0: trap %s, epc 0x" TARGET_FMT_lx,
> -                riscv_intr_names[log_cause], env->pc);
> +            qemu_log_mask(LOG_TRACE, "core "
> +                TARGET_FMT_ld ": trap %s, epc 0x" TARGET_FMT_lx "\n",
> +                env->mhartid, riscv_intr_names[log_cause], env->pc);
>          } else {
> -            qemu_log_mask(LOG_TRACE, "core   0: intr %s, epc 0x" TARGET_FMT_lx,
> -                riscv_excp_names[log_cause], env->pc);
> +            qemu_log_mask(LOG_TRACE, "core "
> +                TARGET_FMT_ld ": intr %s, epc 0x" TARGET_FMT_lx "\n",
> +                env->mhartid, riscv_excp_names[log_cause], env->pc);
>          }
>      }
>  
> @@ -512,8 +514,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>  
>          if (hasbadaddr) {
>              if (RISCV_DEBUG_INTERRUPT) {
> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr 0x"
> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>              }
>              env->sbadaddr = env->badaddr;
>          } else {
> @@ -537,8 +539,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>  
>          if (hasbadaddr) {
>              if (RISCV_DEBUG_INTERRUPT) {
> -                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
> -                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
> +                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr 0x"
> +                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
>              }
>              env->mbadaddr = env->badaddr;
>          } else {
> 
