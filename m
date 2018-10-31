Received: from eggs.gnu.org ([2001:4830:134:3::10]:34140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrOS-0002Qn-1f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrOO-000800-Nx
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:22:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHrON-0007zI-IF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:22:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id 74-v6so8497157wrb.13
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:22:43 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-22-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-22-cota@braap.org>
Date: Wed, 31 Oct 2018 14:22:40 +0000
Message-ID: <874ld28abz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 22/71] mips: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, James Hogan <jhogan@kernel.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: James Hogan <jhogan@kernel.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/mips/cps.c           | 2 +-
>  hw/misc/mips_itu.c      | 4 ++--
>  target/mips/kvm.c       | 2 +-
>  target/mips/op_helper.c | 8 ++++----
>  target/mips/translate.c | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4285d1964e..a8b27eee78 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -49,7 +49,7 @@ static void main_cpu_reset(void *opaque)
>      cpu_reset(cs);
>
>      /* All VPs are halted on reset. Leave powering up to CPC. */
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>  }
>
>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
> diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
> index 43bbec46cf..7c383939a7 100644
> --- a/hw/misc/mips_itu.c
> +++ b/hw/misc/mips_itu.c
> @@ -162,7 +162,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
>  {
>      CPUState *cs;
>      CPU_FOREACH(cs) {
> -        if (cs->halted && (c->blocked_threads & (1ULL << cs->cpu_index))=
) {
> +        if (cpu_halted(cs) && (c->blocked_threads & (1ULL << cs->cpu_ind=
ex))) {
>              cpu_interrupt(cs, CPU_INTERRUPT_WAKE);
>          }
>      }
> @@ -172,7 +172,7 @@ static void wake_blocked_threads(ITCStorageCell *c)
>  static void QEMU_NORETURN block_thread_and_exit(ITCStorageCell *c)
>  {
>      c->blocked_threads |=3D 1ULL << current_cpu->cpu_index;
> -    current_cpu->halted =3D 1;
> +    cpu_halted_set(current_cpu, 1);
>      current_cpu->exception_index =3D EXCP_HLT;
>      cpu_loop_exit_restore(current_cpu, current_cpu->mem_io_pc);
>  }
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 8e72850962..0b177a7577 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -156,7 +156,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm=
_run *run)
>
>  int kvm_arch_process_async_events(CPUState *cs)
>  {
> -    return cs->halted;
> +    return cpu_halted(cs);
>  }
>
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index c148b310cd..8904dfa2b4 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -649,7 +649,7 @@ static bool mips_vpe_is_wfi(MIPSCPU *c)
>
>      /* If the VPE is halted but otherwise active, it means it's waiting =
for
>         an interrupt.  */
> -    return cpu->halted && mips_vpe_active(env);
> +    return cpu_halted(cpu) && mips_vpe_active(env);
>  }
>
>  static bool mips_vp_is_wfi(MIPSCPU *c)
> @@ -657,7 +657,7 @@ static bool mips_vp_is_wfi(MIPSCPU *c)
>      CPUState *cpu =3D CPU(c);
>      CPUMIPSState *env =3D &c->env;
>
> -    return cpu->halted && mips_vp_active(env);
> +    return cpu_halted(cpu) && mips_vp_active(env);
>  }
>
>  static inline void mips_vpe_wake(MIPSCPU *c)
> @@ -674,7 +674,7 @@ static inline void mips_vpe_sleep(MIPSCPU *cpu)
>
>      /* The VPE was shut off, really go to bed.
>         Reset any old _WAKE requests.  */
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
>  }
>
> @@ -2519,7 +2519,7 @@ void helper_wait(CPUMIPSState *env)
>  {
>      CPUState *cs =3D CPU(mips_env_get_cpu(env));
>
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      cpu_reset_interrupt(cs, CPU_INTERRUPT_WAKE);
>      /* Last instruction in the block, PC was updated before
>         - no need to recover PC and icount */
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ab16cdb911..544e4dc19c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -25753,7 +25753,7 @@ void cpu_state_reset(CPUMIPSState *env)
>              env->tcs[i].CP0_TCHalt =3D 1;
>          }
>          env->active_tc.CP0_TCHalt =3D 1;
> -        cs->halted =3D 1;
> +        cpu_halted_set(cs, 1);
>
>          if (cs->cpu_index =3D=3D 0) {
>              /* VPE0 starts up enabled.  */
> @@ -25761,7 +25761,7 @@ void cpu_state_reset(CPUMIPSState *env)
>              env->CP0_VPEConf0 |=3D (1 << CP0VPEC0_MVP) | (1 << CP0VPEC0_=
VPA);
>
>              /* TC0 starts up unhalted.  */
> -            cs->halted =3D 0;
> +            cpu_halted_set(cs, 0);
>              env->active_tc.CP0_TCHalt =3D 0;
>              env->tcs[0].CP0_TCHalt =3D 0;
>              /* With thread 0 active.  */


--
Alex Benn=C3=A9e
