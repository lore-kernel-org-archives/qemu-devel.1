Received: from eggs.gnu.org ([2001:4830:134:3::10]:59193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlQ-0005oh-7N
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlP-0008Q9-2B
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:56 -0500
Date: Sat, 15 Dec 2018 20:06:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215090646.GO29278@umbus.fritz.box>
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-45-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Iys0Un1O+0sigPHU"
Content-Disposition: inline
In-Reply-To: <20181213050453.9677-45-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 44/73] ppc: convert to
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
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--Iys0Un1O+0sigPHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:04:24AM -0500, Emilio G. Cota wrote:
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc.c                    |  2 +-
>  target/ppc/excp_helper.c        |  2 +-
>  target/ppc/kvm.c                |  4 ++--
>  target/ppc/translate_init.inc.c | 14 +++++++-------
>  4 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index d1a5a0b877..bc1cefa13f 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -91,7 +91,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
> =20
>      LOG_IRQ("%s: %p n_IRQ %d level %d =3D> pending %08" PRIx32
>                  "req %08x\n", __func__, env, n_IRQ, level,
> -                env->pending_interrupts, CPU(cpu)->interrupt_request);
> +                env->pending_interrupts, cpu_interrupt_request(CPU(cpu))=
);
> =20
>      if (locked) {
>          qemu_mutex_unlock_iothread();
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 737c9c72be..75a434f46b 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -753,7 +753,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
> =20
>      qemu_log_mask(CPU_LOG_INT, "%s: %p pending %08x req %08x me %d ee %d=
\n",
>                    __func__, env, env->pending_interrupts,
> -                  cs->interrupt_request, (int)msr_me, (int)msr_ee);
> +                  cpu_interrupt_request(cs), (int)msr_me, (int)msr_ee);
>  #endif
>      /* External reset */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 557faa3637..cebb73bd98 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1336,7 +1336,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run =
*run)
>       * interrupt, reset, etc) in PPC-specific env->irq_input_state. */
>      if (!cap_interrupt_level &&
>          run->ready_for_interrupt_injection &&
> -        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +        (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
>          (env->irq_input_state & (1<<PPC_INPUT_INT)))
>      {
>          /* For now KVM disregards the 'irq' argument. However, in the
> @@ -1378,7 +1378,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) && (msr_ee)) {
> +    if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) && (msr_ee)) {
>          cpu_halted_set(cs, 1);
>          cs->exception_index =3D EXCP_HLT;
>      }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 986bbd7eb4..757eb6df16 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8463,7 +8463,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cpu_halted(cs)) {
> -        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
> @@ -8487,7 +8487,7 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>          }
>          return false;
>      } else {
> -        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
> +        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD=
);
>      }
>  }
> =20
> @@ -8617,7 +8617,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cpu_halted(cs)) {
> -        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_EXT)) &&
> @@ -8649,7 +8649,7 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>          }
>          return false;
>      } else {
> -        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
> +        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD=
);
>      }
>  }
> =20
> @@ -8809,7 +8809,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cpu_halted(cs)) {
> -        if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
> +        if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
>          /* External Exception */
> @@ -8842,7 +8842,7 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>          }
>          return false;
>      } else {
> -        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
> +        return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD=
);
>      }
>  }
> =20
> @@ -10253,7 +10253,7 @@ static bool ppc_cpu_has_work(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> -    return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
> +    return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
>  }
> =20
>  /* CPUClass::reset() */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Iys0Un1O+0sigPHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUxCYACgkQbDjKyiDZ
s5JDpQ//TBNYih6gJVzlDwhLKlIMx5yYjYHoNwX0bcodEYbFi+FuHYLuAoiEFFE0
4LSdIzYFyER9q/PohqmX1hbO1s8rtkm1ur+3uDF9tKK/H25TUdjsS9vexQnzd8hX
aCufQDs18/CVsv0lr241FMUZMWoTi6sBiL56S3gIQt0j2fj6ZJ0ufFK0NjOEvMtr
CF5icLBrXEeIEgxguSL47vyYylbmqEmej9zL5Lg0NHGITup3Sy1kqRT+45PMfAly
E7y++1Wrbs8kANqBpdzv611uK1VUQuHksxR7BMLe4w22FCcW53zcV2pGVz5etKA0
Bci+g5M4FPaqn7Ekc0unF3/IDxMH4DRQ0wbQXJP/iezrjoZh0nO5sHvfCuo7vnlq
c4UfPPs8Ct5R+lXBnqldYcV4weuq+XPhT2QFox5vT2I1+e4aC1rWqpQH+z+78JQ7
yrAXR6c5O0tZqc/BH/gi9AUkD10k/p4UaxktCQx0QVrwfJVO0Pkl4ADVYf0HZYSp
TIylgRD436XvCbGCFPuY2DYtKY9UUawaXjxcDni2COtRNdGssPt79Y/acpPvA31G
VCysgig1wUzpL6qBxe4+qnuaVlmAHPozb1YPAyIU+S/D+i7k8AWQSxapZqas1osh
NLtIA7J/CVFjoc0lbN59zqz25tyikQR7y4UU9ZOyPUwPrYweNU0=
=lOAm
-----END PGP SIGNATURE-----

--Iys0Un1O+0sigPHU--
