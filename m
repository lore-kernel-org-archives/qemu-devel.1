Received: from eggs.gnu.org ([2001:4830:134:3::10]:42288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBE-0004Zd-Cd
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBD-0008KX-6R
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:00 -0500
Date: Thu, 29 Nov 2018 15:03:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129040302.GD14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-26-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-26-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 25/36] spapr: set the interrupt
 presenter at reset
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


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:18AM +0100, C=E9dric Le Goater wrote:
> Currently, the interrupt presenter of the VPCU is set at realize
> time. Setting it at reset will become useful when the new machine
> supporting both interrupt modes is introduced. In this machine, the
> interrupt mode is chosen at CAS time and activated after a reset.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>  hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
>  hw/ppc/spapr_irq.c              | 11 +++++++++++
>  3 files changed, 39 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 9e2821e4b31f..fc8ea9021656 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -53,4 +53,6 @@ static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU=
 *cpu)
>      return (sPAPRCPUState *)cpu->machine_data;
>  }
> =20
> +void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type);
> +
>  #endif
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 1811cd48db90..529de0b6b9c8 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -398,3 +398,29 @@ static const TypeInfo spapr_cpu_core_type_infos[] =
=3D {
>  };
> =20
>  DEFINE_TYPES(spapr_cpu_core_type_infos)
> +
> +typedef struct ForeachFindIntCArgs {
> +    const char *intc_type;
> +    Object *intc;
> +} ForeachFindIntCArgs;
> +
> +static int spapr_cpu_core_find_intc(Object *child, void *opaque)
> +{
> +    ForeachFindIntCArgs *args =3D opaque;
> +
> +    if (object_dynamic_cast(child, args->intc_type)) {
> +        args->intc =3D child;
> +    }
> +
> +    return args->intc !=3D NULL;
> +}
> +
> +void spapr_cpu_core_set_intc(PowerPCCPU *cpu, const char *intc_type)
> +{
> +    ForeachFindIntCArgs args =3D { intc_type, NULL };
> +
> +    object_child_foreach(OBJECT(cpu), spapr_cpu_core_find_intc, &args);
> +    g_assert(args.intc);

We could create some extra links on the cpu to avoid scanning all the
children, but I guess that's a refinement.

Then again.. what do we actually use the cpu->intc pointer for in XIVE
context?  I had a feeling because of the different way notifications
are handled we might not ever need to go from a cpu handle to the
associated TCTX.


> +    cpu->intc =3D args.intc;
> +}
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 984c6d60cd9f..969efad7e6e9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -218,6 +218,11 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
> =20
>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
>  {
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
> +    }
>  }
> =20
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> @@ -370,6 +375,12 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
> =20
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
>  {
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->xive_tctx_type);
> +    }
> +
>      spapr_xive_mmio_map(spapr->xive);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/ZPMACgkQbDjKyiDZ
s5LmLhAAyMXF+tWtl7EIg59Orl5fnvug4za5kvHlzezx9kICjP6r/L44SKHiIPRZ
AtWRHKo3S7TSpUMHXfGAFeVuuOKcVQmhci1uKphZYJYg1s5YtyvF3tfjKhlLgQO7
Kaw+7waoDkFFMPL8NQ3DGqXnHgKrvCUKoJ20Brvhi+1BTtp2W9pL03rWqLyGVCil
Me3tIYno+U7Gw7inKihnmM5O6KJkHu4Imj7lZpLc9HP9OPrcZh2PUbix9vuXMKJL
8VhgpXPR0QNTmnrkoi0tnwPI6SIs1QeyXswr1oeX0S4bnr31rwmpUDdZ5VzoZGap
kMWwkusHnTImwpKk2efW9WQNAvQLnZKo3ihgUnvI5tcXXOgoiGwarjROBpXnyCOV
b5FykOMos/0XlPRon+2KQd2MUGa3l0PtGbogU03/qIksyVi+NJ8yGJd6vzwRpXan
voheywvhSDIZeg9GN7GlxBt2vKMVGizdXnCBBUUXtfb/nhcKTKOBGitObSAF23Fv
PqlX/PkvXt5gr0XeZ9aCUCiyQ2crQUxdx9cPdXbeHh9GXKaeJ0P0+lB7PqFInEyn
43b9zNcyVU2+Ybbaz2z05usakkFiMzMKk9tffJOHnUwC3pSbmpXdX1Sq2KJB76Kw
5ao3mCOk+yaM2O0yxWNx7zjVwgZ8KnX5Vgb8TNPB4yMkUjGDedg=
=AdKv
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
