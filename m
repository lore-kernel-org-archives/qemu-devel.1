Received: from eggs.gnu.org ([209.51.188.92]:57199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtR36-0003wf-O7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtR35-0001mU-3m
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:56:04 -0500
Date: Tue, 12 Feb 2019 16:41:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190212054131.GM1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ybNbZnZ8tziJ7D6"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 06/19] target/ppc: Remove some #if 0'ed code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--4ybNbZnZ8tziJ7D6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:12AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Some debug stuff we don't need to keep there
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This looks a good idea independent of the rest of the series, so I've
applied it to ppc-for-4.0.

> ---
>  target/ppc/excp_helper.c | 12 ------------
>  target/ppc/mmu_helper.c  | 12 ------------
>  2 files changed, 24 deletions(-)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 0ec7ae1ad4ce..751d759fcc1d 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -748,13 +748,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
>  static void ppc_hw_interrupt(CPUPPCState *env)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> -#if 0
> -    CPUState *cs =3D CPU(cpu);
> =20
> -    qemu_log_mask(CPU_LOG_INT, "%s: %p pending %08x req %08x me %d ee %d=
\n",
> -                  __func__, env, env->pending_interrupts,
> -                  cs->interrupt_request, (int)msr_me, (int)msr_ee);
> -#endif
>      /* External reset */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
>          env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_RESET);
> @@ -797,12 +791,6 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>      if (msr_ce !=3D 0) {
>          /* External critical interrupt */
>          if (env->pending_interrupts & (1 << PPC_INTERRUPT_CEXT)) {
> -            /* Taking a critical external interrupt does not clear the e=
xternal
> -             * critical interrupt status
> -             */
> -#if 0
> -            env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_CEXT);
> -#endif
>              powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_CRITICAL);
>              return;
>          }
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index cefed34da4f2..bcf19da61d56 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1415,10 +1415,6 @@ static int get_physical_address_wtlb(
>      bool real_mode =3D (access_type =3D=3D ACCESS_CODE && msr_ir =3D=3D =
0)
>          || (access_type !=3D ACCESS_CODE && msr_dr =3D=3D 0);
> =20
> -#if 0
> -    qemu_log("%s\n", __func__);
> -#endif
> -
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:
>      case POWERPC_MMU_SOFT_74xx:
> @@ -1468,10 +1464,6 @@ static int get_physical_address_wtlb(
>          cpu_abort(CPU(cpu), "Unknown or invalid MMU model\n");
>          return -1;
>      }
> -#if 0
> -    qemu_log("%s address " TARGET_FMT_lx " =3D> %d " TARGET_FMT_plx "\n",
> -             __func__, eaddr, ret, ctx->raddr);
> -#endif
> =20
>      return ret;
>  }
> @@ -1805,10 +1797,6 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *e=
nv, target_ulong address,
>                  break;
>              }
>          }
> -#if 0
> -        printf("%s: set exception to %d %02x\n", __func__,
> -               cs->exception, env->error_code);
> -#endif
>          ret =3D 1;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ybNbZnZ8tziJ7D6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiXIoACgkQbDjKyiDZ
s5JxLBAAj+GKYfWrT7PSP2Sk2Q2L+1lQ+k9XWcyH10leHG/ZhS1axDyy2X4REvuY
qKXcMNAe4FficxBexxAU3iZo/W5oYAFhviCl1smtKt8GQq8WldR4KAnSq5ZMVPZT
7XI8aOG2pc0gcFfhDY4DzaRKYzJUPxwQ5M3UsDtDmxwz6TGIhUf9Xy94+7AVgzwQ
opmgjk/8lU7iMJEH7U5bjbBv6SaV+MdzwsVVj2BB3AJ8tBElnQWO9+s8Wdl2Z9x4
eJeKZq6BHAcD3+LkPd88qJ2k7AmoU2aXQ+A5ZjjMRbsrYNjeEiYqx6g+BxIJsQdF
AlkLcjoJLc55SiLzO9eZ80ks4o1Gkt+lusR6GGdmSVoVJq7j5Uop1eWM5lJGn1sc
Ivg2IkOduPTZ9bI+VS5/wpkC9cGbzFo+JWHiRGGvswmcoVn3KsFOvj6G+n4KBE9E
wCBzvrtG5HZOS1CeXlcIU0/qAUxyVF1yHJn1mWjpLOlVi9feVUwjCc/moDDeNM32
3jCVaNA+Gc+9KhEACfFaUt5J9Ss/n0ePklRGm9oFklp8IGF/Dfj4yxRrA92FoWpA
QOMJrrJj3hGUmHrO05VcJLVnmUboh23rYawMj5c9t2YXJwUTQk0u0U/Z8rTPnK2u
UMEnzxxsIvfr3FapX2TmyeJf8ZzKMsLf1SK+QWOfMeL/Ae199JM=
=oh85
-----END PGP SIGNATURE-----

--4ybNbZnZ8tziJ7D6--
