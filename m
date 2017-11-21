Received: from eggs.gnu.org ([2001:4830:134:3::10]:43158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eHCmY-0003fX-R9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eHCmU-0002hC-Pc
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:56:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eHCmU-0002gs-EW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:56:22 -0500
Received: by mail-wm0-x243.google.com with SMTP id y80so5183183wmd.0
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:56:21 -0800 (PST)
References: <1511285538-22883-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1511285538-22883-1-git-send-email-richard.purdie@linuxfoundation.org>
Date: Tue, 21 Nov 2017 17:56:19 +0000
Message-ID: <87y3mzwm64.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix system lockups caused by
 interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org


Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> Occasionally in Linux guests on x86_64 we're seeing logs like:
>
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0004
>
> when they should read:
>
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0002
>
> The "00000004" is CPU_INTERRUPT_EXITTB yet the code calls
> cpu_interrupt(cs, CPU_INTERRUPT_HARD) ("00000002") in this function
> just before the log message. Something is causing the HARD bit setting
> to get lost.
>
> The knock on effect of losing that bit is the decrementer timer interrupts
> don't get delivered which causes the guest to sit idle in its idle handler
> and 'hang'.
>
> The issue occurs due to races from code which sets CPU_INTERRUPT_EXITTB.
>
> Rather than poking directly into cs->interrupt_request, that code needs t=
o:
>
> a) hold BQL
> b) use the cpu_interrupt() helper
>
> This patch fixes the call sites to do this, fixing the hang.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  target/ppc/excp_helper.c | 12 +++++++++---
>  target/ppc/helper_regs.h |  8 ++++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index e6009e7..f175c21 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -207,7 +207,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>                          "Entering checkstop state\n");
>              }
>              cs->halted =3D 1;
> -            cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +            qemu_mutex_lock_iothread();
> +            cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +            qemu_mutex_unlock_iothread();

Not directly related but I wonder why cs->halted is set here rather than
raising a CPU_INTERRUPT_HALT exception?

My worry with these locks is I think powerpc_excp gets called from both
paths which means you'll see an assert fire when the BQL is
double-locked.

>          }
>          if (env->msr_mask & MSR_HVB) {
>              /* ISA specifies HV, but can be delivered to guest with HV c=
lear
> @@ -940,7 +942,9 @@ void helper_store_msr(CPUPPCState *env, target_ulong =
val)
>
>      if (excp !=3D 0) {
>          CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>          raise_exception(env, excp);

This is fine as you only come here from TCG code.

>      }
>  }
> @@ -995,7 +999,9 @@ static inline void do_rfi(CPUPPCState *env, target_ul=
ong nip, target_ulong msr)
>      /* No need to raise an exception here,
>       * as rfi is always the last insn of a TB
>       */
> -    cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +    qemu_mutex_lock_iothread();
> +    cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +    qemu_mutex_unlock_iothread();

I think this is fine - as again you come from TCG code.

>
>      /* Reset the reservation */
>      env->reserve_addr =3D -1;
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 2627a70..13dd0b8 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -114,11 +114,15 @@ static inline int hreg_store_msr(CPUPPCState *env, =
target_ulong value,
>      }
>      if (((value >> MSR_IR) & 1) !=3D msr_ir ||
>          ((value >> MSR_DR) & 1) !=3D msr_dr) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>      }
>      if ((env->mmu_model & POWERPC_MMU_BOOKE) &&
>          ((value >> MSR_GS) & 1) !=3D msr_gs) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>      }
>      if (unlikely((env->flags & POWERPC_FLAG_TGPR) &&
>                   ((value ^ env->msr) & (1 << MSR_TGPR)))) {

And this looks good too.

--
Alex Benn=C3=A9e
