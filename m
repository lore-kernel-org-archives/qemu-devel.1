Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4U-0004yw-4v
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4P-0008Tj-Ut
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:06 -0500
Date: Mon, 17 Dec 2018 16:37:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217053702.GF5597@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <20181211223823.13770-10-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 09/12] spapr: set the interrupt
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


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:38:20PM +0100, C=E9dric Le Goater wrote:
> Currently, the interrupt presenter of the vCPU is set at realize
> time. Setting it at reset will become necessary when the new machine
> supporting both interrupt modes is introduced. In this machine, the
> interrupt mode is chosen at CAS time and activated after a reset.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Ugly, but necessary.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v7:
>=20
>  - introduced spapr_irq_reset_xics().=20
>=20
>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>  hw/ppc/spapr_cpu_core.c         | 26 ++++++++++++++++++++++++++
>  hw/ppc/spapr_irq.c              | 13 +++++++++++++
>  3 files changed, 41 insertions(+)
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
> index 82666436e9b4..afc5d4f4e739 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -397,3 +397,29 @@ static const TypeInfo spapr_cpu_core_type_infos[] =
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
> index 0999a2b2d69c..814500f22d34 100644
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
> @@ -208,6 +209,15 @@ static int spapr_irq_post_load_xics(sPAPRMachineStat=
e *spapr, int version_id)
>      return 0;
>  }
> =20
> +static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
> +{
> +   CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
> +    }
> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -225,6 +235,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .dt_populate =3D spapr_dt_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
> +    .reset       =3D spapr_irq_reset_xics,
>  };
> =20
>  /*
> @@ -325,6 +336,8 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> +        spapr_cpu_core_set_intc(cpu, TYPE_XIVE_TCTX);
> +
>          /* (TCG) Set the OS CAM line of the thread interrupt context. */
>          spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXNf4ACgkQbDjKyiDZ
s5Lpuw/+KC6pKygq7D8TkuIPdhLhb4goEHAVAj8Rh3kxLingCAwjNvrb0VL+G2g6
o7Zl7xc8CCXQHj/+7pVZ4uM0YKgjRUqbzxOQPibhIahtfCJ9AnB4KwWRda/HPrt1
xH/unwBsyaTcMuoc8xF2VnmGo7EeRAYbYNWKUS0GQc780YdaI0VNK99A3eYAcguT
BYrAK6S/TPRRwwDsSDHsM1M83MNXZHi/0bsFpSQNMc9xMMWnN2hB/+FCxtn0+DAm
25X6bd5VWAOnXJa4EF6+R+mQsHTvTYxHE+TRpVIkKHjKdImArHUqRtp3WjrBFX/h
JHrHSrsmizd15kZmVZjS7fj9kx76WselKE6VAEg+7gHdCNxN4tXUOH8OUgJD1B66
yJhpTQxbjq2x407gdiFvFD3lwORW1Wu6ijRwVStdcwH6WOB8pz/85l6fwDR1trTz
iC19YIGnUHf6+BuDz6wV1Ds0eF8SVqCyucbHuV2ncjuopaGca1y0DvFggcRP0RYo
thRxLA77AjYGMhqeLU7jyOOTJl15cPo1RPAbsKizzCsgZr7JwUIDcE/2BFPmhsrC
e+M8v5LDxmPYNSRypb+XxtePgdu5JjoMRUnK6Ki+wLOxvsiCbCDEcbifBY/4vlDQ
ZrS8RwqTMtqP666OmALjhfMTL7X0eol58mdwmmda6bVJZkbM32M=
=6fuj
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
