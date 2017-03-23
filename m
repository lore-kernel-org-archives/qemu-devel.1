Received: from eggs.gnu.org ([2001:4830:134:3::10]:46023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEw-0001to-HM
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEv-0005po-04
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:46 -0400
Date: Thu, 23 Mar 2017 15:16:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041612.GI19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-6-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-6-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] ppc/pnv: create the ICP and ICS
 objects under the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:09PM +0100, C=E9dric Le Goater wrote:
> Like this is done for the sPAPR machine, we use a simple array under
> the PowerNV machine to store the Interrupt Control Presenters (ICP)
> objects, one for each vCPU. This array is indexed by 'cpu_index' of
> the CPUState but the users will provide a core PIR number. The mapping
> is done in the icp_get() handler of the machine and is transparent to
> XICS.

I note that you don't actually seem to be setting the cpu's icp backlink.

> We use a list to hold the different Interrupt Control Sources (ICS)
> objects, as PowerNV needs to handle multiple sources: for PCI-E and
> for the Processor Service Interface (PSI).

This is reasonable for now, but I wonder if we could use the fact we
know the platform architecture to avoid having an explicit ics list.
IIUC there's one ICS per chip (are there some extras as well?), so we
could just iterate through the existing chip array, and check each
one's ICS.

>=20
> Finally, to interface with the XICS layer which manipulates the ICP
> and ICS objects, we extend the PowerNV machine with an XICSFabric
> interface and its associated handlers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v1:
>=20
>  - handled pir-to-cpu_index mapping under icp_get=20
>  - removed ics_eio handler
>  - changed ICP name indexing
>  - removed sysbus parenting of the ICP object
>=20
>  hw/ppc/pnv.c          | 102 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h  |   4 ++
>  include/hw/ppc/xics.h |   1 +
>  3 files changed, 107 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3fa722af82e6..6ff01c3b84d5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -33,7 +33,10 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/cutils.h"
>  #include "qapi/visitor.h"
> +#include "monitor/monitor.h"
> +#include "hw/intc/intc.h"
> =20
> +#include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> =20
>  #include "hw/isa/isa.h"
> @@ -417,6 +420,26 @@ static void ppc_powernv_init(MachineState *machine)
>          machine->cpu_model =3D "POWER8";
>      }
> =20
> +    /* Create the Interrupt Control Presenters before the vCPUs */
> +    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
> +    pnv->icps =3D g_new0(PnvICPState, pnv->nr_servers);
> +    for (i =3D 0; i < pnv->nr_servers; i++) {
> +        PnvICPState *icp =3D &pnv->icps[i];
> +        char name[32];
> +
> +        /* TODO: fix ICP object name to be in sync with the core name */
> +        snprintf(name, sizeof(name), "icp[%d]", i);
> +        object_initialize(icp, sizeof(*icp), TYPE_PNV_ICP);
> +        object_property_add_child(OBJECT(pnv), name, OBJECT(icp),
> +                                  &error_fatal);
> +        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(pnv),
> +                                       &error_fatal);
> +        object_property_set_bool(OBJECT(icp), true, "realized", &error_f=
atal);
> +    }
> +
> +    /* and the list of Interrupt Control Sources */
> +    QLIST_INIT(&pnv->ics);
> +
>      /* Create the processor chips */
>      chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_=
model);
>      if (!object_class_by_name(chip_typename)) {
> @@ -743,6 +766,58 @@ static void pnv_get_num_chips(Object *obj, Visitor *=
v, const char *name,
>      visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp);
>  }
> =20
> +static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    ICSState *ics;
> +
> +    QLIST_FOREACH(ics, &pnv->ics, list) {
> +        if (ics_valid_irq(ics, irq)) {
> +            return ics;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void pnv_ics_resend(XICSFabric *xi)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    ICSState *ics;
> +
> +    QLIST_FOREACH(ics, &pnv->ics, list) {
> +        ics_resend(ics);
> +    }
> +}
> +
> +static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
> +
> +        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> +
> +    if (!cpu) {
> +        return NULL;
> +    }
> +
> +    assert(cpu->parent_obj.cpu_index < pnv->nr_servers);
> +    return ICP(&pnv->icps[cpu->parent_obj.cpu_index]);
> +}
> +
>  static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -784,9 +859,27 @@ static void powernv_machine_class_props_init(ObjectC=
lass *oc)
>                                NULL);
>  }
> =20
> +static void pnv_pic_print_info(InterruptStatsProvider *obj,
> +                               Monitor *mon)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
> +    ICSState *ics;
> +    int i;
> +
> +    for (i =3D 0; i < pnv->nr_servers; i++) {
> +        icp_pic_print_info(ICP(&pnv->icps[i]), mon);
> +    }
> +
> +    QLIST_FOREACH(ics, &pnv->ics, list) {
> +        ics_pic_print_info(ics, mon);
> +    }
> +}
> +
>  static void powernv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> +    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D ppc_powernv_init;
> @@ -797,6 +890,10 @@ static void powernv_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      mc->default_ram_size =3D 1 * G_BYTE;
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_resend =3D pnv_ics_resend;
> +    ispc->print_info =3D pnv_pic_print_info;
> =20
>      powernv_machine_class_props_init(oc);
>  }
> @@ -807,6 +904,11 @@ static const TypeInfo powernv_machine_info =3D {
>      .instance_size =3D sizeof(PnvMachineState),
>      .instance_init =3D powernv_machine_initfn,
>      .class_init    =3D powernv_machine_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_XICS_FABRIC },
> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { },
> +    },
>  };
> =20
>  static void powernv_machine_register_types(void)
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index df98a72006e4..d6ef04771aff 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -22,6 +22,7 @@
>  #include "hw/boards.h"
>  #include "hw/sysbus.h"
>  #include "hw/ppc/pnv_lpc.h"
> +#include "hw/ppc/xics.h"
> =20
>  #define TYPE_PNV_CHIP "powernv-chip"
>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
> @@ -114,6 +115,9 @@ typedef struct PnvMachineState {
>      PnvChip      **chips;
> =20
>      ISABus       *isa_bus;
> +    PnvICPState  *icps;
> +    uint32_t     nr_servers;
> +    QLIST_HEAD(, ICSState) ics;
>  } PnvMachineState;
> =20
>  #define PNV_FDT_ADDR          0x01000000
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index cfcf7ecece69..4b100869003c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -128,6 +128,7 @@ struct ICSState {
>      qemu_irq *qirqs;
>      ICSIRQState *irqs;
>      XICSFabric *xics;
> +    QLIST_ENTRY(ICSState) list;
>  };
> =20
>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00wMAAoJEGw4ysog2bOSF5gP/3RuAuImeC960CPfopJjv2lS
yPjUiIS64gvSfn8scz7gXTq5Pwtef3hGdfvjhbyc4+shINEBBZmJ+lyIhU0Nqc5M
xXudo88LKT2AvT7zt4/diWzQedOL7xDd4o3l7NsX052bihJ1jz7O1+7kmVsfvUlM
38Cs8vB/mgf+vhUr5nXB+Z45ciDPqIsuFLEcSEmsIpXtjKU8YvfWCFeCLU6oWmLB
0iIeobCluGedv5JTg7px9mFVopQdZGAx5joTetjNMJHzvrtTRJy77tWCIZ7DDpxs
Pz7+Sz7VIUPE4euUOAZ+9vWIazLTFuU/V+N+bJQ3xEPWJIXTHg/Nn6C7eV5uGnsL
9DAsAUjhyCB5ppG92fvTZbtuhFdfC/4D7Snf7gfgYew0RSdYbISPtzD5GzX6ox9B
rZ7q5zBMdOJvTla8uE+fXPiihg9k7//t80zLxMHw1pPiKJt7fYzJppxxZnN03pAG
nlTI05iMVqKZzbjBucoM+NkrQY8HqglFg9QF2+K71lYZ9jXxe+NmOiVfvDiOk6J0
QtGSprt6uileuh9BPrVbNKoc7unCYpp8nlK/MqzspAUbpjM0CJQwGsqTXZKAwH6n
dNWpqxnkWBlpZBpHyZm0WokxH5lsd35gvhbfqTxnVa7tCM7wSeNHNWtxvCp19UTh
TTrPzrPZkFpuUCZom0PP
=kzqt
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
