Received: from eggs.gnu.org ([2001:4830:134:3::10]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQR-0000AB-Pj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQO-0004Vz-SA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:15 -0400
Date: Tue, 14 Mar 2017 16:45:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314054519.GJ12564@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-4-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <1488970371-8865-4-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/8] ppc/pnv: create the ICP and
 ICS objects under the machine
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


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 11:52:46AM +0100, C=E9dric Le Goater wrote:
> Like this is done for the sPAPR machine, we use a simple array under
> the PowerNV machine to store the Interrupt Control Presenters (ICP)
> objects, one for each vCPU. This array is indexed by 'cpu_index' of
> the CPUState.
>=20
> We use a list to hold the different Interrupt Control Sources (ICS)
> objects, as PowerNV needs to handle multiple sources: for PCI-E and
> for the Processor Service Interface (PSI).
>=20
> Finally, to interface with the XICS layer which manipulates the ICP
> and ICS objects, we extend the PowerNV machine with an XICSFabric
> interface and its associated handlers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c          | 89 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h  |  4 +++
>  include/hw/ppc/xics.h |  1 +
>  3 files changed, 94 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 09f0d22defb8..461d3535e99c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -32,6 +32,8 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/cutils.h"
>  #include "qapi/visitor.h"
> +#include "monitor/monitor.h"
> +#include "hw/intc/intc.h"
> =20
>  #include "hw/ppc/pnv_xscom.h"
> =20
> @@ -416,6 +418,23 @@ static void ppc_powernv_init(MachineState *machine)
>          machine->cpu_model =3D "POWER8";
>      }
> =20
> +    /* Create the Interrupt Control Presenters before the vCPUs */
> +    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
> +    pnv->icps =3D g_new0(ICPState, pnv->nr_servers);
> +    for (i =3D 0; i < pnv->nr_servers; i++) {
> +        ICPState *icp =3D &pnv->icps[i];
> +        object_initialize(icp, sizeof(*icp), TYPE_ICP);
> +        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());

Your fixup for the PAPR case suggests this is not the right approach
to the device initialization.

> +        object_property_add_child(OBJECT(pnv), "icp[*]", OBJECT(icp),
> +                                  &error_fatal);

This isn't an urgent problem, but I dislike using the icp[*]
behaviour as a rule (it's fixed now, but it just to be you could
easily get O(n^3) behaviour using it).  In this case you already have
a handle on a specific id for the object.

As well as being a bit less expensive, using an explicit index means
that the exposed QOM address will definitely match an otherwise
meaningful id, rather than just lining up by accident if all the
orders remain the same.

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
> @@ -742,6 +761,48 @@ static void pnv_get_num_chips(Object *obj, Visitor *=
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
> +static void pnv_ics_eoi(XICSFabric *xi, int irq)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    ICSState *ics;
> +
> +    QLIST_FOREACH(ics, &pnv->ics, list) {
> +        if (ics_valid_irq(ics, irq)) {

Unless something is badly wrong, this should only return true for
exactly one iteration through the loop.  Which makes this equivalent
to ics_get() followed by ics_eoi().

> +            ics_eoi(ics, irq);
> +        }
> +    }
> +}
> +
> +static ICPState *pnv_icp_get(XICSFabric *xi, int server)
> +{
> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +
> +    return (server < pnv->nr_servers) ? &pnv->icps[server] : NULL;
> +}
> +
>  static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -783,9 +844,27 @@ static void powernv_machine_class_props_init(ObjectC=
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
> +        icp_pic_print_info(&pnv->icps[i], mon);
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
> @@ -796,6 +875,11 @@ static void powernv_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      mc->default_ram_size =3D 1 * G_BYTE;
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_eoi =3D pnv_ics_eoi;
> +    xic->ics_resend =3D pnv_ics_resend;
> +    ispc->print_info =3D pnv_pic_print_info;
> =20
>      powernv_machine_class_props_init(oc);
>  }
> @@ -806,6 +890,11 @@ static const TypeInfo powernv_machine_info =3D {
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
> index df98a72006e4..6a0b004cea93 100644
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
> +    ICPState     *icps;
> +    uint32_t     nr_servers;
> +    QLIST_HEAD(, ICSState) ics;
>  } PnvMachineState;
> =20
>  #define PNV_FDT_ADDR          0x01000000
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 00b003b2392d..c2032cac55f6 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -115,6 +115,7 @@ struct ICSState {
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

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx4NvAAoJEGw4ysog2bOSy1UQAMgjd6SxuDk/l/GIDPf/QH+m
r+iyDyfJc53gqApCHBzz8+z/P5AlVfszceAziBoRvg+M/jr4JUxNaM55nlRNc28A
Kj2Yvl+g4dw3zq9YSH//f9xqr7PmefprEdMBE285ptsYlXzvifpz2tGGMJxo9wJ0
SllHcYckldPEbJ+aECZlHNtIyID25H+WcMVIBL6pwa9Uai8TFvzCRzQ/V9gpirc0
8kNybYxZ4iVMEJigkD7c5dlKiup11DNq7xsDwCSlg1B97lr3O8nvNyPh/2XH1kZY
GA1IGYdCw4YWzQ6jNFi7ZBPzexpzdmxPNDdcCLBU+nJdFJj1QdMlikQ7/wAKvqZn
yv5AcMXQ5k07ryYRLk+TwFfglD5yl9h9ujUP2bY/Ed2ON+olmkOj0rsCTS2LXg0M
j3ci4PCb8TddoIL9gXm13aURn8D/lFcnllIS5Toxnd+sa36iIYN1M+TwGvyyn4Nb
x9+ZxICNfhgCoo+hJMTCoG+vMRxZtTYqspvVRf8vJnGTuI/mMAaxP8dodBVVYo1i
zfFUGNInIGKp3zEsiX3T+iGBaENqypmKiqWFwnzLoFhmtHYR2eL+GG2CIp/Jdam2
8uJO/1lblXVtQJNKKYq/qU7GyHNH2EqZO70zkITehpjrTd3X9ci0IhyH26J2bm9v
dbxEobzAD7J+i4Y+2Y/K
=9oLp
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
