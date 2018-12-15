Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlS-0005oq-6g
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlP-0008Pv-1d
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:58 -0500
Date: Sat, 15 Dec 2018 20:02:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215090258.GN29278@umbus.fritz.box>
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-19-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Content-Disposition: inline
In-Reply-To: <20181213050453.9677-19-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 18/73] ppc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:03:58AM -0500, Emilio G. Cota wrote:
> In ppce500_spin.c, acquire the lock just once to update
> both cpu->halted and cpu->stopped.
>=20
> In hw/ppc/spapr_hcall.c, acquire the lock just once to
> update cpu->halted and call cpu_has_work, since later
> in the series we'll acquire the BQL (if not already held)
> from cpu_has_work.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper_regs.h        |  2 +-
>  hw/ppc/e500.c                   |  4 ++--
>  hw/ppc/ppc.c                    | 10 +++++-----
>  hw/ppc/ppce500_spin.c           |  6 ++++--
>  hw/ppc/spapr_cpu_core.c         |  4 ++--
>  hw/ppc/spapr_hcall.c            |  4 +++-
>  hw/ppc/spapr_rtas.c             |  6 +++---
>  target/ppc/excp_helper.c        |  4 ++--
>  target/ppc/kvm.c                |  4 ++--
>  target/ppc/translate_init.inc.c |  6 +++---
>  10 files changed, 27 insertions(+), 23 deletions(-)
>=20
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 5efd18049e..9298052ac5 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -161,7 +161,7 @@ static inline int hreg_store_msr(CPUPPCState *env, ta=
rget_ulong value,
>  #if !defined(CONFIG_USER_ONLY)
>      if (unlikely(msr_pow =3D=3D 1)) {
>          if (!env->pending_interrupts && (*env->check_pow)(env)) {
> -            cs->halted =3D 1;
> +            cpu_halted_set(cs, 1);
>              excp =3D EXCP_HALTED;
>          }
>      }
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index e6747fce28..6843c545b7 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -657,7 +657,7 @@ static void ppce500_cpu_reset_sec(void *opaque)
> =20
>      /* Secondary CPU starts in halted state for now. Needs to change when
>         implementing non-kernel boot. */
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index =3D EXCP_HLT;
>  }
> =20
> @@ -671,7 +671,7 @@ static void ppce500_cpu_reset(void *opaque)
>      cpu_reset(cs);
> =20
>      /* Set initial guest state. */
> -    cs->halted =3D 0;
> +    cpu_halted_set(cs, 0);
>      env->gpr[1] =3D (16 * MiB) - 8;
>      env->gpr[3] =3D bi->dt_base;
>      env->gpr[4] =3D 0;
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index ec4be25f49..d1a5a0b877 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -151,7 +151,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int=
 level)
>              /* XXX: Note that the only way to restart the CPU is to rese=
t it */
>              if (level) {
>                  LOG_IRQ("%s: stop the CPU\n", __func__);
> -                cs->halted =3D 1;
> +                cpu_halted_set(cs, 1);
>              }
>              break;
>          case PPC6xx_INPUT_HRESET:
> @@ -230,10 +230,10 @@ static void ppc970_set_irq(void *opaque, int pin, i=
nt level)
>              /* XXX: TODO: relay the signal to CKSTP_OUT pin */
>              if (level) {
>                  LOG_IRQ("%s: stop the CPU\n", __func__);
> -                cs->halted =3D 1;
> +                cpu_halted_set(cs, 1);
>              } else {
>                  LOG_IRQ("%s: restart the CPU\n", __func__);
> -                cs->halted =3D 0;
> +                cpu_halted_set(cs, 0);
>                  qemu_cpu_kick(cs);
>              }
>              break;
> @@ -361,10 +361,10 @@ static void ppc40x_set_irq(void *opaque, int pin, i=
nt level)
>              /* Level sensitive - active low */
>              if (level) {
>                  LOG_IRQ("%s: stop the CPU\n", __func__);
> -                cs->halted =3D 1;
> +                cpu_halted_set(cs, 1);
>              } else {
>                  LOG_IRQ("%s: restart the CPU\n", __func__);
> -                cs->halted =3D 0;
> +                cpu_halted_set(cs, 0);
>                  qemu_cpu_kick(cs);
>              }
>              break;
> diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> index c45fc858de..4b3532730f 100644
> --- a/hw/ppc/ppce500_spin.c
> +++ b/hw/ppc/ppce500_spin.c
> @@ -107,9 +107,11 @@ static void spin_kick(CPUState *cs, run_on_cpu_data =
data)
>      map_start =3D ldq_p(&curspin->addr) & ~(map_size - 1);
>      mmubooke_create_initial_mapping(env, 0, map_start, map_size);
> =20
> -    cs->halted =3D 0;
> -    cs->exception_index =3D -1;
> +    cpu_mutex_lock(cs);
> +    cpu_halted_set(cs, 0);
>      cs->stopped =3D false;
> +    cpu_mutex_unlock(cs);
> +    cs->exception_index =3D -1;
>      qemu_cpu_kick(cs);
>  }
> =20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2398ce62c0..4c9c60b53b 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -37,7 +37,7 @@ static void spapr_cpu_reset(void *opaque)
>      /* All CPUs start halted.  CPU0 is unhalted from the machine level
>       * reset code and the rest are explicitly started up by the guest
>       * using an RTAS call */
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
> =20
>      /* Set compatibility mode to match the boot CPU, which was either set
>       * by the machine reset code or by CAS. This should never fail.
> @@ -91,7 +91,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_=
ulong nip, target_ulong r
>      env->nip =3D nip;
>      env->gpr[3] =3D r3;
>      kvmppc_set_reg_ppc_online(cpu, 1);
> -    CPU(cpu)->halted =3D 0;
> +    cpu_halted_set(CPU(cpu), 0);
>      /* Enable Power-saving mode Exit Cause exceptions */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>  }
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index ae913d070f..9891fc7740 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1088,11 +1088,13 @@ static target_ulong h_cede(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
> =20
>      env->msr |=3D (1ULL << MSR_EE);
>      hreg_compute_hflags(env);
> +    cpu_mutex_lock(cs);
>      if (!cpu_has_work(cs)) {
> -        cs->halted =3D 1;
> +        cpu_halted_set(cs, 1);
>          cs->exception_index =3D EXCP_HLT;
>          cs->exit_request =3D 1;
>      }
> +    cpu_mutex_unlock(cs);
>      return H_SUCCESS;
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d6a0952154..925f67123c 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -109,7 +109,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *=
cpu_,
>      id =3D rtas_ld(args, 0);
>      cpu =3D spapr_find_cpu(id);
>      if (cpu !=3D NULL) {
> -        if (CPU(cpu)->halted) {
> +        if (cpu_halted(CPU(cpu))) {
>              rtas_st(rets, 1, 0);
>          } else {
>              rtas_st(rets, 1, 2);
> @@ -153,7 +153,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPR=
MachineState *spapr,
>      env =3D &newcpu->env;
>      pcc =3D POWERPC_CPU_GET_CLASS(newcpu);
> =20
> -    if (!CPU(newcpu)->halted) {
> +    if (!cpu_halted(CPU(newcpu))) {
>          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
>          return;
>      }
> @@ -207,7 +207,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>       * This could deliver an interrupt on a dying CPU and crash the
>       * guest */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      kvmppc_set_reg_ppc_online(cpu, 0);
>      qemu_cpu_kick(cs);
>  }
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0ec7ae1ad4..5e1778584a 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -206,7 +206,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>                  qemu_log("Machine check while not allowed. "
>                          "Entering checkstop state\n");
>              }
> -            cs->halted =3D 1;
> +            cpu_halted_set(cs, 1);
>              cpu_interrupt_exittb(cs);
>          }
>          if (env->msr_mask & MSR_HVB) {
> @@ -954,7 +954,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
>      CPUState *cs;
> =20
>      cs =3D CPU(ppc_env_get_cpu(env));
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      env->in_pm_state =3D true;
> =20
>      /* The architecture specifies that HDEC interrupts are
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f81327d6cd..557faa3637 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1370,7 +1370,7 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct k=
vm_run *run)
> =20
>  int kvm_arch_process_async_events(CPUState *cs)
>  {
> -    return cs->halted;
> +    return cpu_halted(cs);
>  }
> =20
>  static int kvmppc_handle_halt(PowerPCCPU *cpu)
> @@ -1379,7 +1379,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
> -        cs->halted =3D 1;
> +        cpu_halted_set(cs, 1);
>          cs->exception_index =3D EXCP_HLT;
>      }
> =20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 168d0cec28..986bbd7eb4 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8462,7 +8462,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    if (cs->halted) {
> +    if (cpu_halted(cs)) {
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8616,7 +8616,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    if (cs->halted) {
> +    if (cpu_halted(cs)) {
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8808,7 +8808,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    if (cs->halted) {
> +    if (cpu_halted(cs)) {
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUw0IACgkQbDjKyiDZ
s5LG1RAAyed1YKsO+t/lPF5enpb4uO5UglZ+pVf5nXaXxo4ts3F4R0+OfWkB5XBx
10/xMBKnbefZCLF+66OugQJdbVvTVyBcmOBfoDYdI/RGGDQlnbZ84AU5e1KWpUvW
JyBkuztlxK+fkN0eaB2sdQC0xrekVPSEWxuc7vVqZMDwIzPwxfDgVBJwIVI1OFxp
8RYKKtlkpSftGwwYtMjwm0hlhNFKbLjZpn5iQNcdE0bPztsI+iq01gfOoVjUnAiV
Y2IcYy6hqelNLOIna/J+czdSrJzA5oKcqTxH2NEcPbXltA4M/LkMgRT91T/tjoo5
iKSa7XUE8N46CuTeS5wTBv1CNI5qnNP2OKVvDRumDLtzaNhCjhFpjGblWf2QQijl
5wz/zG679hNcBz9j11t2xBuXVfdkMt7CTHVflV11PjUDsc1xZv70fwghrjOQXxfu
3lQKTzLBe3CK/CE5DojRBj/wMuVw0VopudN9Z0Ycl9dCf/q1pEJBdu3SaYo1V86F
pbKm/LJcH97Bu3EqIcYBGnK3ewsKofExrCKskvFlbLhIYxXcHiFWjz5dANrucqIj
IhEioqchzomQFEhpv1J2jnmNwVpAJRucn7VKGHxKETuUCpnHg/k5OHlq83EuGHm5
AYcBRPNc/b0PCfME8MLx3gGbH3wwD2TxEt4DNZ+vrcR7EfcgQDE=
=zRXk
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
