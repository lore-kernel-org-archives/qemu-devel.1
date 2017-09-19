Received: from eggs.gnu.org ([2001:4830:134:3::10]:51366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtb-0001K1-HQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtY-00030d-7M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:51 -0400
Date: Tue, 19 Sep 2017 18:38:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919083818.GW27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ngiTnHdmUEG79yp6"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-17-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 16/21] spapr: add a XIVE object to
 the sPAPR machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--ngiTnHdmUEG79yp6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:30PM +0200, C=E9dric Le Goater wrote:
> If the machine supports XIVE (POWER9 CPU), create a XIVE object. The
> CAS negotiation process will decide which model (legacy or XIVE) will
> be used for the interrupt controller depending on the guest
> capabilities.
>=20
> Also extend the number of provisionned IRQs with the number of CPUs,
> this is required for XIVE which allocates one IRQ number for each IPI.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 63 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5d69df928434..b6577dbecdea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -44,6 +44,7 @@
>  #include "mmu-hash64.h"
>  #include "mmu-book3s-v3.h"
>  #include "qom/cpu.h"
> +#include "target/ppc/cpu-models.h"
> =20
>  #include "hw/boards.h"
>  #include "hw/ppc/ppc.h"
> @@ -54,6 +55,7 @@
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/pci-host/spapr.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/spapr_xive.h"
>  #include "hw/pci/msi.h"
> =20
>  #include "hw/pci/pci.h"
> @@ -202,6 +204,35 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
>      }
>  }
> =20
> +static sPAPRXive *spapr_spapr_xive_create(sPAPRMachineState *spapr, int =
nr_irqs,
> +                               int nr_servers, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_new(TYPE_SPAPR_XIVE);
> +    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abort);
> +    object_property_add_const_link(obj, "ics", OBJECT(spapr->ics),
> +                                   &error_abort);
> +    object_property_set_int(obj, nr_irqs, "nr-irqs",  &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +    object_property_set_int(obj, nr_servers, "nr-targets", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +
> +    return SPAPR_XIVE(obj);
> +error:
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>                                    int smt_threads)
>  {
> @@ -1093,7 +1124,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      }
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, XICS_IRQS_=
SPAPR);
> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt,
> +                                    XICS_IRQS_SPAPR + xics_max_server_nu=
mber());
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> @@ -2140,6 +2172,16 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>      g_free(type);
>  }
> =20
> +/*
> + * Only POWER9 Processor chips support the XIVE interrupt controller
> + */
> +static bool ppc_support_xive(MachineState *machine)
> +{
> +   PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(first_cpu);
> +
> +   return pcc->pvr_match(pcc, CPU_POWERPC_POWER9_BASE);
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void ppc_spapr_init(MachineState *machine)
>  {
> @@ -2237,7 +2279,8 @@ static void ppc_spapr_init(MachineState *machine)
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
>      /* Set up Interrupt Controller before we create the VCPUs */
> -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> +    xics_system_init(machine, XICS_IRQS_SPAPR + xics_max_server_number(),
> +                     &error_fatal);

Has this hunk leaked from another patch?  AFAICT it only affects XICS
with what you have so far, which doesn't seem like what you want.

>      /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
>      spapr->ov5 =3D spapr_ovec_new();
> @@ -2274,6 +2317,22 @@ static void ppc_spapr_init(MachineState *machine)
> =20
>      spapr_init_cpus(spapr);
> =20
> +    /* Set up XIVE. CAS will choose whether the guest runs in XICS
> +     * (legacy mode) or XIVE Exploitation mode
> +     *
> +     * We don't have KVM support yet, so check for irqchip=3Don
> +     */
> +    if (ppc_support_xive(machine)) {
> +        if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
> +            error_report("kernel_irqchip requested. no XIVE support");
> +        } else {
> +            spapr->xive =3D spapr_spapr_xive_create(spapr,
> +                               XICS_IRQS_SPAPR + xics_max_server_number(=
),
> +                               xics_max_server_number(),
> +                               &error_fatal);
> +        }
> +    }
> +
>      if (kvm_enabled()) {
>          /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel devices */
>          kvmppc_enable_logical_ci_hcalls();
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a705c17..6cd5ab73c5dc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> +typedef struct sPAPRXive sPAPRXive;
> =20
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> @@ -127,6 +128,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      const char *icp_type;
> +    sPAPRXive  *xive;
>  };
> =20
>  #define H_SUCCESS         0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ngiTnHdmUEG79yp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA13oACgkQbDjKyiDZ
s5Jk4hAAxODgWJ7fe/dhymAeFMZlToE0v5hlafRIbQmHTxYa1BpwCb7TYZrR4ynw
TBcmfImkYuhG68bC5tmYtXVGWTAbvVvBhqGKjqT/opL3FaywWe1qjPiQxJC9mkGd
OaGbN5dOx0hXg4nWbOpbhMSs9tKGeRp87xzN8Q1zIIFPP8XgszeptMNOMFPEUtcX
404Fd1F3Wu2UDRoJADgVQbjhqEuZorR/4dfxXhKGKZKelZH2JJ11Alx4pbkV/Y/9
nbFr3kc/aQ6a13xS9KNvsFd/3LFWaSixrT+UhTqekZowbpTv4H02WUGh/2yqPYoa
ud4+3itgmZWLZ7lCzkX/PYtv4pTxguX1PgLkbmnIAjjsXNGF8VjJYPPNUltyJ19x
pqU4z4vmMNXocK1ckE7M7rClA4jCyPJoOG4Ah1MDlGfumlmJAK1tUuh2LiGTZtpj
0umb2CgoPSCHGxOTdVNm827blHiiMrWIpzlAe2W1zxZR0ZdhqGb8cCXP9dDaYFtd
VVehfdWHOubZzvzA3PrDEvGn8S0e1LMapnoz87AkAuU6Dsnd5b6ua07/a8FTxKPm
izlJOSQDOz0wV+m9loVpjWHfN4uBdtqOVV+9ElfibRTnkbxsxgcYh9cX7ioYAmTc
OUJLyx3LAW4Ok6vGhCPxrrsLHhMnrt6aUDD7iO7rqcJyJCfdHZ8=
=ty9k
-----END PGP SIGNATURE-----

--ngiTnHdmUEG79yp6--
