Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gG2Ks-0005Un-B4
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gG2Km-0003eP-HD
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:39:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gG2Ki-0003ba-Lk
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:39:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id g9-v6so1410154wrq.4
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 06:39:24 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-36-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-36-cota@braap.org>
Date: Fri, 26 Oct 2018 14:39:21 +0100
Message-ID: <87d0rw25fa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 36/71] arm: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Peter Maydell <peter.maydell@linaro.org>

This will need to catch-up in the next re-base as there is a merge conflict.

> Cc: qemu-arm@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/arm/cpu.c    |  2 +-
>  target/arm/helper.c | 12 +++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 9c5cda8eb7..7330c2dae1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -49,7 +49,7 @@ static bool arm_cpu_has_work(CPUState *cs)
>      ARMCPU *cpu =3D ARM_CPU(cs);
>
>      return (cpu->power_state !=3D PSCI_OFF)
> -        && cs->interrupt_request &
> +        && cpu_interrupt_request(cs) &
>          (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
>           | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ
>           | CPU_INTERRUPT_EXITTB);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c83f7c1109..454954a56c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1294,11 +1294,12 @@ static uint64_t isr_read(CPUARMState *env, const =
ARMCPRegInfo *ri)
>  {
>      CPUState *cs =3D ENV_GET_CPU(env);
>      uint64_t ret =3D 0;
> +    uint32_t interrupt_request =3D cpu_interrupt_request(cs);
>
> -    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
>          ret |=3D CPSR_I;
>      }
> -    if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
> +    if (interrupt_request & CPU_INTERRUPT_FIQ) {
>          ret |=3D CPSR_F;
>      }
>      /* External aborts are not possible in QEMU so A bit is always clear=
 */
> @@ -8579,10 +8580,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>          return;
>      }
>
> -    /* Hooks may change global state so BQL should be held, also the
> -     * BQL needs to be held for any modification of
> -     * cs->interrupt_request.
> -     */
> +    /* Hooks may change global state so BQL should be held */
>      g_assert(qemu_mutex_iothread_locked());
>
>      arm_call_pre_el_change_hook(cpu);
> @@ -8597,7 +8595,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>      arm_call_el_change_hook(cpu);
>
>      if (!kvm_enabled()) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
>      }
>  }


--
Alex Benn=C3=A9e
