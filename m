Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXbw-0008KC-JF
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXMw-0003lv-Qd
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:01:57 -0500
Date: Tue, 11 Dec 2018 12:46:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211014614.GD4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T/5gogCFEf4tDWvL"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 14/19] spapr: set the interrupt
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


--T/5gogCFEf4tDWvL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:46:05PM +0100, C=E9dric Le Goater wrote:
> Currently, the interrupt presenter of the vCPU is set at realize
> time. Setting it at reset will become useful when the new machine
> supporting both interrupt modes is introduced. In this machine, the
> interrupt mode is chosen at CAS time and activated after a reset.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Shouldn't this also remove the code which sets cpu->intc at realize
time, in order to avoid confusion?

> ---
>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>  hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
>  hw/ppc/spapr_irq.c              | 12 ++++++++++++
>  3 files changed, 40 insertions(+)
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
> +
> +    cpu->intc =3D args.intc;
> +}
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 7a0d4f529763..b423cee30e2c 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -12,6 +12,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/spapr_xive.h"
>  #include "hw/ppc/xics.h"
>  #include "sysemu/kvm.h"
> @@ -211,6 +212,11 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
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
> @@ -341,6 +347,12 @@ static int spapr_irq_post_load_xive(sPAPRMachineStat=
e *spapr, int version_id)
> =20
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
>  {
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), TYPE_XIVE_TCTX);
> +    }
> +
>      /*
>       * Set the OS CAM line of the cpu interrupt thread context. Needs
>       * to come after the XiveTCTX reset handlers.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T/5gogCFEf4tDWvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPFuYACgkQbDjKyiDZ
s5JyJhAAmY9yL48IG6sm9cnQ55hxu+uA+19YnaNA+PWNPlF7dkk66DzTdRI++f10
5XDtw9gdlyWop7E3vPFtMrz/TTxvzuD6xKwcSKzu9LdinSsdcxwXO/PqBI7nDn7H
z/F15n+hpWXfTedM6j8mDzThVwp+7plViYyttclllssZZ8zPCITjH/RmU1IyFSW9
n352b+wpn+xT0YoetjFcb1zFlWIACoNfLjn/tVF68Q5u9Jg+/rox4RJjBTUoZgiy
XiJkVwjeMJgie58hPk1NIrA3tvqvu+tTHV4AqmuETh600K9TMQWSa2aLdqxPS1cx
4J5hHaJ5XhdHzxJChYT7vIzxLtfsb2DCZnaIhWaS+5mkeEjcQ9PvBEmwbpGfYjiC
hAfiRwxE2WmbQJ+L4XDXlWHZQ4H4zP/fGCF2dnb6gPM4wn/E5IKUTBtOJ4my1+nS
2rxZKyFXbMUHIF/cvGjVm/9mVW9jNryePkGhMdNMK964hAZsU4ab6/sjOze9bDfX
cAL6pMQXQHx3IShFpTnkIHFgMnbMgMProbo/jRkPOqiIVMIZieijn3AbbR1r+7Ou
/x0MlaWXbVCS4mDdkLYAipLo0rWEtpS+QWT8EKR9FiBNYw5z73XCEEHigbwIncg3
t6aoG6Y6mG6DQytCWZHYfeMmqnLfyGhjENKA3NcY9lCiIGODCu8=
=7nrF
-----END PGP SIGNATURE-----

--T/5gogCFEf4tDWvL--
