Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXQS-0001JQ-Og
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXQO-0006f1-OX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:40:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPXQO-0006cL-H8
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:40:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so6753738wrx.9
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:40:32 -0800 (PST)
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-3-farosas@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd9147ba-3542-5a1e-d313-a7b8ec54e942@redhat.com>
Date: Wed, 21 Nov 2018 19:40:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181121181347.24035-3-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/3] kvm-all: Introduce
 kvm_set_singlestep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>

On 21/11/18 19:13, Fabiano Rosas wrote:
> This will be used in a future patch to implement an
> architecture-specific single step mechanism for POWER.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   accel/kvm/kvm-all.c  | 10 ++++++++++
>   exec.c               |  1 +
>   include/sysemu/kvm.h |  4 ++++
>   target/arm/kvm.c     |  4 ++++
>   target/i386/kvm.c    |  4 ++++
>   target/mips/kvm.c    |  4 ++++
>   target/ppc/kvm.c     |  4 ++++
>   target/s390x/kvm.c   |  4 ++++
>   8 files changed, 35 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..4fb7199a15 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2313,6 +2313,11 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
>       return data.err;
>   }
>   
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +    kvm_arch_set_singlestep(cs, enabled);
> +}
> +
>   int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>                             target_ulong len, int type)
>   {
> @@ -2439,6 +2444,11 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
>   void kvm_remove_all_breakpoints(CPUState *cpu)
>   {
>   }
> +
> +void kvm_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   #endif /* !KVM_CAP_SET_GUEST_DEBUG */
>   
>   static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
> diff --git a/exec.c b/exec.c
> index bb6170dbff..55614822c3 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1233,6 +1233,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
>       if (cpu->singlestep_enabled != enabled) {
>           cpu->singlestep_enabled = enabled;
>           if (kvm_enabled()) {
> +            kvm_set_singlestep(cpu, enabled);
>               kvm_update_guest_debug(cpu, 0);
>           } else {
>               /* must flush all the translated code to avoid inconsistencies */
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 97d8d9d0d5..a01a8d58dd 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -259,6 +259,8 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
>   void kvm_remove_all_breakpoints(CPUState *cpu);
>   int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
>   
> +void kvm_set_singlestep(CPUState *cpu, int enabled);
> +
>   int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>   int kvm_on_sigbus(int code, void *addr);
>   
> @@ -431,6 +433,8 @@ void kvm_arch_remove_all_hw_breakpoints(void);
>   
>   void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
>   
> +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
> +
>   bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
>   
>   int kvm_check_extension(KVMState *s, unsigned int extension);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 44dd0ce6ce..dd8e43ab7e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -670,6 +670,10 @@ int kvm_arch_process_async_events(CPUState *cs)
>       return 0;
>   }
>   
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   /* The #ifdef protections are until 32bit headers are imported and can
>    * be removed once both 32 and 64 bit reach feature parity.
>    */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..ba56f2ee1f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3521,6 +3521,10 @@ static int kvm_handle_debug(X86CPU *cpu,
>       return ret;
>   }
>   
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
>   {
>       const uint8_t type_code[] = {
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 8e72850962..8035262131 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -119,6 +119,10 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       return 0;
>   }
>   
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   static inline int cpu_mips_io_interrupts_pending(MIPSCPU *cpu)
>   {
>       CPUMIPSState *env = &cpu->env;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f81327d6cd..9d0b4f1f3f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1551,6 +1551,10 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>       nb_hw_breakpoint = nb_hw_watchpoint = 0;
>   }
>   
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>   {
>       int n;
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26adfe..4bde183458 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -975,6 +975,10 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>       hw_breakpoints = NULL;
>   }
>   
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +}
> +
>   void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
>   {
>       int i;
> 
