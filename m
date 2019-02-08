Received: from eggs.gnu.org ([209.51.188.92]:34254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs48E-0004vn-Nv
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs488-0002cV-G7
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs484-0002RT-Ae
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id q15so3083606wro.12
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:15:30 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-41-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-41-cota@braap.org>
Date: Fri, 08 Feb 2019 11:15:27 +0000
Message-ID: <87d0o2msz4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 40/73] i386/kvm: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/kvm.c | 54 +++++++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ca2629f0fe..3f3c670897 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
<snip>
> @@ -3183,14 +3186,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_r=
un *run)
>  {
>      X86CPU *x86_cpu =3D X86_CPU(cpu);
>      CPUX86State *env =3D &x86_cpu->env;
> +    uint32_t interrupt_request;
>      int ret;
>
> +    interrupt_request =3D cpu_interrupt_request(cpu);
>      /* Inject NMI */
> -    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)=
) {
> -        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
> -            qemu_mutex_lock_iothread();
> +    if (interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
> +        if (interrupt_request & CPU_INTERRUPT_NMI) {
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
> -            qemu_mutex_unlock_iothread();
>              DPRINTF("injected NMI\n");
>              ret =3D kvm_vcpu_ioctl(cpu, KVM_NMI);
>              if (ret < 0) {
> @@ -3198,10 +3201,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_ru=
n *run)
>                          strerror(-ret));
>              }
>          }
> -        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
> -            qemu_mutex_lock_iothread();
> +        if (interrupt_request & CPU_INTERRUPT_SMI) {
>              cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
> -            qemu_mutex_unlock_iothread();
>              DPRINTF("injected SMI\n");
>              ret =3D kvm_vcpu_ioctl(cpu, KVM_SMI);
>              if (ret < 0) {
> @@ -3215,16 +3216,18 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_r=
un *run)
>          qemu_mutex_lock_iothread();
>      }
>
> +    interrupt_request =3D cpu_interrupt_request(cpu);
> +

This seems a bit smelly as we have already read interrupt_request once
before. So this says that something may have triggered an IRQ while we
were dealing with the above. It requires a comment at least.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
