Received: from eggs.gnu.org ([2001:4830:134:3::10]:42074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW3uu-0001Wx-Ej
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cW3up-0003eX-FN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:25:56 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cW3up-0003eE-5E
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:25:51 -0500
Received: by mail-wm0-x233.google.com with SMTP id c206so217927539wme.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:25:51 -0800 (PST)
References: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
	<1484937883-1068-2-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484937883-1068-2-git-send-email-peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 16:25:47 +0000
Message-ID: <87wpdka0hg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/6] armv7m: MRS/MSR: handle
 unprivileged access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> The MRS and MSR instruction handling has a number of flaws:
>  * unprivileged accesses should only be able to read
>    CONTROL and the xPSR subfields, and only write APSR
>    (others RAZ/WI)
>  * privileged access should not be able to write xPSR
>    subfields other than APSR
>  * accesses to unimplemented registers should log as
>    guest errors, not abort QEMU
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> [PMM: rewrote commit message]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 79 +++++++++++++++++++++++++----------------------------
>  1 file changed, 37 insertions(+), 42 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7111c8c..ad23de3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8243,23 +8243,32 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>
>  uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    uint32_t mask;
> +    unsigned el = arm_current_el(env);
> +
> +    /* First handle registers which unprivileged can read */
> +
> +    switch (reg) {
> +    case 0 ... 7: /* xPSR sub-fields */

This reads a little confusingly compared to the pseudo-code in the ARM
ARM. Would it be clearer if we just went:

  switch(extract32(reg, 3, 5)) {
    case 0: /* xPSR */
    ...
    case 1: /* SP */
    ...
    case 2: /* Priority Mask or CONTROL.. */
    ...
  }

?

> +        mask = 0;
> +        if ((reg & 1) && el) {
> +            mask |= 0x000001ff; /* IPSR (unpriv. reads as zero) */

As B5.2.2 doesn't imply any particular access limit perhaps the comment
should read /* ISPR (reads as zero when not in exception) */

> +        }
> +        if (!(reg & 4)) {
> +            mask |= 0xf8000000; /* APSR */
> +        }
> +        /* EPSR reads as zero */
> +        return xpsr_read(env) & mask;
> +        break;
> +    case 20: /* CONTROL */
> +        return env->v7m.control;

I'm fairly sure this was meant to be 0x20 and either way the result is
gated by current privilege.

> +    }
> +
> +    if (el == 0) {
> +        return 0; /* unprivileged reads others as zero */
> +    }
>
>      switch (reg) {
> -    case 0: /* APSR */
> -        return xpsr_read(env) & 0xf8000000;
> -    case 1: /* IAPSR */
> -        return xpsr_read(env) & 0xf80001ff;
> -    case 2: /* EAPSR */
> -        return xpsr_read(env) & 0xff00fc00;
> -    case 3: /* xPSR */
> -        return xpsr_read(env) & 0xff00fdff;
> -    case 5: /* IPSR */
> -        return xpsr_read(env) & 0x000001ff;
> -    case 6: /* EPSR */
> -        return xpsr_read(env) & 0x0700fc00;
> -    case 7: /* IEPSR */
> -        return xpsr_read(env) & 0x0700edff;
>      case 8: /* MSP */
>          return env->v7m.current_sp ? env->v7m.other_sp : env->regs[13];
>      case 9: /* PSP */
> @@ -8271,40 +8280,26 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
>          return env->v7m.basepri;
>      case 19: /* FAULTMASK */
>          return (env->daif & PSTATE_F) != 0;
> -    case 20: /* CONTROL */
> -        return env->v7m.control;
>      default:
> -        /* ??? For debugging only.  */
> -        cpu_abort(CPU(cpu), "Unimplemented system register read (%d)\n", reg);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to read unknown special"
> +                                       " register %d\n", reg);
>          return 0;
>      }
>  }
>
>  void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
>  {
> -    ARMCPU *cpu = arm_env_get_cpu(env);
> +    if (arm_current_el(env) == 0 && reg > 7) {
> +        /* only xPSR sub-fields may be written by unprivileged */
> +        return;
> +    }
>
>      switch (reg) {
> -    case 0: /* APSR */
> -        xpsr_write(env, val, 0xf8000000);
> -        break;
> -    case 1: /* IAPSR */
> -        xpsr_write(env, val, 0xf8000000);
> -        break;
> -    case 2: /* EAPSR */
> -        xpsr_write(env, val, 0xfe00fc00);
> -        break;
> -    case 3: /* xPSR */
> -        xpsr_write(env, val, 0xfe00fc00);
> -        break;
> -    case 5: /* IPSR */
> -        /* IPSR bits are readonly.  */
> -        break;
> -    case 6: /* EPSR */
> -        xpsr_write(env, val, 0x0600fc00);
> -        break;
> -    case 7: /* IEPSR */
> -        xpsr_write(env, val, 0x0600fc00);
> +    case 0 ... 7: /* xPSR sub-fields */
> +        /* only APSR is actually writable */
> +        if (reg & 4) {
> +            xpsr_write(env, val, 0xf8000000); /* APSR */
> +        }

I assuming insn<10> selects a different helper....

>          break;
>      case 8: /* MSP */
>          if (env->v7m.current_sp)
> @@ -8345,8 +8340,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
>          switch_v7m_sp(env, (val & 2) != 0);
>          break;
>      default:
> -        /* ??? For debugging only.  */
> -        cpu_abort(CPU(cpu), "Unimplemented system register write (%d)\n", reg);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Attempt to write unknown special"
> +                                       " register %d\n", reg);
>          return;
>      }
>  }


--
Alex Bennée
