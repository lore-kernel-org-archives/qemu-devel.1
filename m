Received: from eggs.gnu.org ([2001:4830:134:3::10]:33489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrMh-0000wX-58
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrMZ-0007Bn-1Q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHrMY-000760-BA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id y16so16699492wrw.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:44 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-19-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-19-cota@braap.org>
Date: Wed, 31 Oct 2018 14:20:41 +0000
Message-ID: <877ehy8afa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 19/71] i386: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/cpu.h         |  2 +-
>  target/i386/cpu.c         |  2 +-
>  target/i386/hax-all.c     |  4 ++--
>  target/i386/helper.c      |  4 ++--
>  target/i386/hvf/hvf.c     |  8 ++++----
>  target/i386/hvf/x86hvf.c  |  4 ++--
>  target/i386/kvm.c         | 10 +++++-----
>  target/i386/misc_helper.c |  2 +-
>  target/i386/whpx-all.c    |  6 +++---
>  9 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 730c06f80a..461459520a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1600,7 +1600,7 @@ static inline void cpu_x86_load_seg_cache_sipi(X86C=
PU *cpu,
>                             sipi_vector << 12,
>                             env->segs[R_CS].limit,
>                             env->segs[R_CS].flags);
> -    cs->halted =3D 0;
> +    cpu_halted_set(cs, 0);
>  }
>
>  int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c88876dfe3..b91d80af0a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4524,7 +4524,7 @@ static void x86_cpu_reset(CPUState *s)
>      /* We hard-wire the BSP to the first CPU. */
>      apic_designate_bsp(cpu->apic_state, s->cpu_index =3D=3D 0);
>
> -    s->halted =3D !cpu_is_bsp(cpu);
> +    cpu_halted_set(s, !cpu_is_bsp(cpu));
>
>      if (kvm_enabled()) {
>          kvm_arch_reset_vcpu(cpu);
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..f095c527e3 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -480,7 +480,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>          return 0;
>      }
>
> -    cpu->halted =3D 0;
> +    cpu_halted_set(cpu, 0);
>
>      if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
>          cpu->interrupt_request &=3D ~CPU_INTERRUPT_POLL;
> @@ -557,7 +557,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>                  !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
>                  /* hlt instruction with interrupt disabled is shutdown */
>                  env->eflags |=3D IF_MASK;
> -                cpu->halted =3D 1;
> +                cpu_halted_set(cpu, 1);
>                  cpu->exception_index =3D EXCP_HLT;
>                  ret =3D 1;
>              }
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e695f8ba7a..a75278f954 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -454,7 +454,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprint=
f_function cpu_fprintf,
>                      (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
>                      (env->a20_mask >> 20) & 1,
>                      (env->hflags >> HF_SMM_SHIFT) & 1,
> -                    cs->halted);
> +                    cpu_halted(cs));
>      } else
>  #endif
>      {
> @@ -481,7 +481,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprint=
f_function cpu_fprintf,
>                      (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
>                      (env->a20_mask >> 20) & 1,
>                      (env->hflags >> HF_SMM_SHIFT) & 1,
> -                    cs->halted);
> +                    cpu_halted(cs));
>      }
>
>      for(i =3D 0; i < 6; i++) {
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 9f52bc413a..fb3b2a26a1 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -500,7 +500,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
>      }
>
>      hv_vm_sync_tsc(0);
> -    cpu->halted =3D 0;
> +    cpu_halted_set(cpu, 0);
>      hv_vcpu_invalidate_tlb(cpu->hvf_fd);
>      hv_vcpu_flush(cpu->hvf_fd);
>  }
> @@ -665,7 +665,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>      int ret =3D 0;
>      uint64_t rip =3D 0;
>
> -    cpu->halted =3D 0;
> +    cpu_halted_set(cpu, 0);
>
>      if (hvf_process_events(cpu)) {
>          return EXCP_HLT;
> @@ -683,7 +683,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>          vmx_update_tpr(cpu);
>
>          qemu_mutex_unlock_iothread();
> -        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
> +        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu_halted(cpu)) {
>              qemu_mutex_lock_iothread();
>              return EXCP_HLT;
>          }
> @@ -717,7 +717,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>                  (EFLAGS(env) & IF_MASK))
>                  && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
>                  !(idtvec_info & VMCS_IDT_VEC_VALID)) {
> -                cpu->halted =3D 1;
> +                cpu_halted_set(cpu, 1);
>                  ret =3D EXCP_HLT;
>              }
>              ret =3D EXCP_INTERRUPT;
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index df8e946fbc..163bbed23f 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -446,7 +446,7 @@ int hvf_process_events(CPUState *cpu_state)
>      if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
>          (EFLAGS(env) & IF_MASK)) ||
>          (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
> -        cpu_state->halted =3D 0;
> +        cpu_halted_set(cpu_state, 0);
>      }
>      if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
>          hvf_cpu_synchronize_state(cpu_state);
> @@ -458,5 +458,5 @@ int hvf_process_events(CPUState *cpu_state)
>          apic_handle_tpr_access_report(cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
>      }
> -    return cpu_state->halted;
> +    return cpu_halted(cpu);
>  }
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index dc4047b02f..d593818cd5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2650,7 +2650,7 @@ static int kvm_get_mp_state(X86CPU *cpu)
>      }
>      env->mp_state =3D mp_state.mp_state;
>      if (kvm_irqchip_in_kernel()) {
> -        cs->halted =3D (mp_state.mp_state =3D=3D KVM_MP_STATE_HALTED);
> +        cpu_halted_set(cs, mp_state.mp_state =3D=3D KVM_MP_STATE_HALTED);
>      }
>      return 0;
>  }
> @@ -3136,7 +3136,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>          env->exception_injected =3D EXCP12_MCHK;
>          env->has_error_code =3D 0;
>
> -        cs->halted =3D 0;
> +        cpu_halted_set(cs, 0);
>          if (kvm_irqchip_in_kernel() && env->mp_state =3D=3D KVM_MP_STATE=
_HALTED) {
>              env->mp_state =3D KVM_MP_STATE_RUNNABLE;
>          }
> @@ -3159,7 +3159,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>      if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
>           (env->eflags & IF_MASK)) ||
>          (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
> -        cs->halted =3D 0;
> +        cpu_halted_set(cs, 0);
>      }
>      if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
>          kvm_cpu_synchronize_state(cs);
> @@ -3172,7 +3172,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>                                        env->tpr_access_type);
>      }
>
> -    return cs->halted;
> +    return cpu_halted(cs);
>  }
>
>  static int kvm_handle_halt(X86CPU *cpu)
> @@ -3183,7 +3183,7 @@ static int kvm_handle_halt(X86CPU *cpu)
>      if (!((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
>            (env->eflags & IF_MASK)) &&
>          !(cs->interrupt_request & CPU_INTERRUPT_NMI)) {
> -        cs->halted =3D 1;
> +        cpu_halted_set(cs, 1);
>          return EXCP_HLT;
>      }
>
> diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
> index 78f2020ef2..fcd6d833e8 100644
> --- a/target/i386/misc_helper.c
> +++ b/target/i386/misc_helper.c
> @@ -554,7 +554,7 @@ static void do_hlt(X86CPU *cpu)
>      CPUX86State *env =3D &cpu->env;
>
>      env->hflags &=3D ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just befo=
re */
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index =3D EXCP_HLT;
>      cpu_loop_exit(cs);
>  }
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index 57e53e1f1f..b9c79ccd99 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -697,7 +697,7 @@ static int whpx_handle_halt(CPUState *cpu)
>            (env->eflags & IF_MASK)) &&
>          !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
>          cpu->exception_index =3D EXCP_HLT;
> -        cpu->halted =3D true;
> +        cpu_halted_set(cpu, true);
>          ret =3D 1;
>      }
>      qemu_mutex_unlock_iothread();
> @@ -857,7 +857,7 @@ static void whpx_vcpu_process_async_events(CPUState *=
cpu)
>      if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
>           (env->eflags & IF_MASK)) ||
>          (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
> -        cpu->halted =3D false;
> +        cpu_halted_set(cpu, false);
>      }
>
>      if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
> @@ -887,7 +887,7 @@ static int whpx_vcpu_run(CPUState *cpu)
>      int ret;
>
>      whpx_vcpu_process_async_events(cpu);
> -    if (cpu->halted) {
> +    if (cpu_halted(cpu)) {
>          cpu->exception_index =3D EXCP_HLT;
>          atomic_set(&cpu->exit_request, false);
>          return 0;


--
Alex Benn=C3=A9e
