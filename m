Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctPVZ-0000l8-5h
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctPVX-0007GJ-2S
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:08:17 -0400
Date: Thu, 30 Mar 2017 12:55:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170330015520.GF21068@umbus.fritz.box>
References: <1490686352-24017-1-git-send-email-clg@kaod.org>
	<1490686352-24017-6-git-send-email-clg@kaod.org>
	<20170329051845.GZ21068@umbus.fritz.box>
	<2ff53243-d4ca-7a98-8aa2-aefc8343f495@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="twlwrnvElrG9k/1g"
Content-Disposition: inline
In-Reply-To: <2ff53243-d4ca-7a98-8aa2-aefc8343f495@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] ppc/pnv: create the ICP and ICS
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


--twlwrnvElrG9k/1g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 10:13:59AM +0200, C=E9dric Le Goater wrote:
> On 03/29/2017 07:18 AM, David Gibson wrote:
> > On Tue, Mar 28, 2017 at 09:32:29AM +0200, C=E9dric Le Goater wrote:
> >> Like this is done for the sPAPR machine, we use a simple array under
> >> the PowerNV machine to store the Interrupt Control Presenters (ICP)
> >> objects, one for each vCPU. This array is indexed by 'cpu_index' of
> >> the CPUState but the users will provide a core PIR number. The mapping
> >> is done in the icp_get() handler of the machine and is transparent to
> >> XICS.
> >>
> >> The Interrupt Control Sources (ICS), Processor Service Interface and
> >> PCI-E interface models, will be introduced in subsequent patches. For
> >> now, we have none, so we just prepare ground with place holders.
> >>
> >> Finally, to interface with the XICS layer which manipulates the ICP
> >> and ICS objects, we extend the PowerNV machine with an XICSFabric
> >> interface and its associated handlers.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>
> >>  Changes since v2:
> >>
> >>  - removed the list of ICS. The handlers will iterate on the chips to
> >>    use the available ICS.
> >>
> >>  Changes since v1:
> >>
> >>  - handled pir-to-cpu_index mapping under icp_get=20
> >>  - removed ics_eio handler
> >>  - changed ICP name indexing
> >>  - removed sysbus parenting of the ICP object
> >>
> >>  hw/ppc/pnv.c         | 96 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/pnv.h |  3 ++
> >>  2 files changed, 99 insertions(+)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 3fa722af82e6..e441b8ac1cad 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -33,7 +33,10 @@
> >>  #include "exec/address-spaces.h"
> >>  #include "qemu/cutils.h"
> >>  #include "qapi/visitor.h"
> >> +#include "monitor/monitor.h"
> >> +#include "hw/intc/intc.h"
> >> =20
> >> +#include "hw/ppc/xics.h"
> >>  #include "hw/ppc/pnv_xscom.h"
> >> =20
> >>  #include "hw/isa/isa.h"
> >> @@ -417,6 +420,23 @@ static void ppc_powernv_init(MachineState *machin=
e)
> >>          machine->cpu_model =3D "POWER8";
> >>      }
> >> =20
> >> +    /* Create the Interrupt Control Presenters before the vCPUs */
> >> +    pnv->nr_servers =3D pnv->num_chips * smp_cores * smp_threads;
> >> +    pnv->icps =3D g_new0(PnvICPState, pnv->nr_servers);
> >> +    for (i =3D 0; i < pnv->nr_servers; i++) {
> >> +        PnvICPState *icp =3D &pnv->icps[i];
> >> +        char name[32];
> >> +
> >> +        /* TODO: fix ICP object name to be in sync with the core name=
 */
> >> +        snprintf(name, sizeof(name), "icp[%d]", i);
> >=20
> > It may end up being the same value, but since the qom name is exposed
> > to the outside, it would be better to have it be the PIR, rather than
> > the cpu_index.
>=20
> The problem is that the ICPState objects are created before the PnvChip
> objects. The PnvChip sanitizes the core layout in terms HW id and then=20
> creates the PnvCore objects. The core creates a PowerPCCPU object per=20
> thread and, in the realize function, uses the XICSFabric to look for
> a matching ICP to link the CPU with.=20
>=20
> So it is a little complex to do what you ask for ...
>=20
> What would really simplify the code, would be to allocate a TYPE_PNV_ICP
> object when the PowerPCCPU object is realized and store it under the=20
> 'icp/intc' backlink. The XICSFabric handler icp_get() would not need=20
> the 'icps' array anymore.=20
>=20
> How's that proposal ?

Sounds workable.  You could do that from the core realize function,
couldn't you?

>=20
> >> +        object_initialize(icp, sizeof(*icp), TYPE_PNV_ICP);
> >> +        object_property_add_child(OBJECT(pnv), name, OBJECT(icp),
> >> +                                  &error_fatal);
> >> +        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(pn=
v),
> >> +                                       &error_fatal);
> >> +        object_property_set_bool(OBJECT(icp), true, "realized", &erro=
r_fatal);
> >> +    }
> >> +
> >>      /* Create the processor chips */
> >>      chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->c=
pu_model);
> >>      if (!object_class_by_name(chip_typename)) {
> >> @@ -737,6 +757,71 @@ static const TypeInfo pnv_chip_info =3D {
> >>      .abstract      =3D true,
> >>  };
> >> =20
> >> +static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> >> +{
> >> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < pnv->num_chips; i++) {
> >> +        /* place holder */
> >> +    }
> >> +    return NULL;
> >> +}
> >> +
> >> +static void pnv_ics_resend(XICSFabric *xi)
> >> +{
> >> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < pnv->num_chips; i++) {
> >> +        /* place holder */
> >> +    }
> >> +}
> >=20
> > Seems like the above two functions belong in a later patch.
>=20
> OK. I guess we can add these handlers in the next patchset introducing PS=
I.=20
> I will check that the tests still run because the XICS layer uses the=20
> XICSFabric handlers blindly without any checks.

Well, sure, but the whole XICS isn't going to work without real
implementations of the ICS callbacks, so I don't see that it matters.

> =20
> >> +
> >> +static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
> >> +{
> >> +    CPUState *cs;
> >> +
> >> +    CPU_FOREACH(cs) {
> >> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> +        CPUPPCState *env =3D &cpu->env;
> >> +
> >> +        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> >> +            return cpu;
> >> +        }
> >> +    }
> >> +
> >> +    return NULL;
> >> +}
> >> +
> >> +static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
> >> +{
> >> +    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> >> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> >> +
> >> +    if (!cpu) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    assert(cpu->parent_obj.cpu_index < pnv->nr_servers);
> >> +    return ICP(&pnv->icps[cpu->parent_obj.cpu_index]);
> >=20
> > Should use CPU() instead of parent_obj here.
>=20
> OK. I might just remove the array though.
>=20
> Thanks,
>=20
> C.
>=20
>=20
> >> +}
> >> +
> >> +static void pnv_pic_print_info(InterruptStatsProvider *obj,
> >> +                               Monitor *mon)
> >> +{
> >> +    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < pnv->nr_servers; i++) {
> >> +        icp_pic_print_info(ICP(&pnv->icps[i]), mon);
> >> +    }
> >> +
> >> +    for (i =3D 0; i < pnv->num_chips; i++) {
> >> +        /* place holder */
> >> +    }
> >> +}
> >> +
> >>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *na=
me,
> >>                                void *opaque, Error **errp)
> >>  {
> >> @@ -787,6 +872,8 @@ static void powernv_machine_class_props_init(Objec=
tClass *oc)
> >>  static void powernv_machine_class_init(ObjectClass *oc, void *data)
> >>  {
> >>      MachineClass *mc =3D MACHINE_CLASS(oc);
> >> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> >> +    InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CL=
ASS(oc);
> >> =20
> >>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
> >>      mc->init =3D ppc_powernv_init;
> >> @@ -797,6 +884,10 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
> >>      mc->no_parallel =3D 1;
> >>      mc->default_boot_order =3D NULL;
> >>      mc->default_ram_size =3D 1 * G_BYTE;
> >> +    xic->icp_get =3D pnv_icp_get;
> >> +    xic->ics_get =3D pnv_ics_get;
> >> +    xic->ics_resend =3D pnv_ics_resend;
> >> +    ispc->print_info =3D pnv_pic_print_info;
> >> =20
> >>      powernv_machine_class_props_init(oc);
> >>  }
> >> @@ -807,6 +898,11 @@ static const TypeInfo powernv_machine_info =3D {
> >>      .instance_size =3D sizeof(PnvMachineState),
> >>      .instance_init =3D powernv_machine_initfn,
> >>      .class_init    =3D powernv_machine_class_init,
> >> +    .interfaces =3D (InterfaceInfo[]) {
> >> +        { TYPE_XICS_FABRIC },
> >> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> >> +        { },
> >> +    },
> >>  };
> >> =20
> >>  static void powernv_machine_register_types(void)
> >> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> >> index df98a72006e4..1ca197d2ec83 100644
> >> --- a/include/hw/ppc/pnv.h
> >> +++ b/include/hw/ppc/pnv.h
> >> @@ -22,6 +22,7 @@
> >>  #include "hw/boards.h"
> >>  #include "hw/sysbus.h"
> >>  #include "hw/ppc/pnv_lpc.h"
> >> +#include "hw/ppc/xics.h"
> >> =20
> >>  #define TYPE_PNV_CHIP "powernv-chip"
> >>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
> >> @@ -114,6 +115,8 @@ typedef struct PnvMachineState {
> >>      PnvChip      **chips;
> >> =20
> >>      ISABus       *isa_bus;
> >> +    PnvICPState  *icps;
> >> +    uint32_t     nr_servers;
> >>  } PnvMachineState;
> >> =20
> >>  #define PNV_FDT_ADDR          0x01000000
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--twlwrnvElrG9k/1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY3GV+AAoJEGw4ysog2bOSmRYP/jQIHHWOAJrUBJqXeAaRAkQo
Z5X1RnwMhmMnifTZfd/q7tdVEerX4WQHJwYSeJWtMmHHCJAdzdE44fWPmzUmVxyQ
r2b/2HZd71Yo3jLGj2f1L+nyujGHyIYaXmFx1emqn/0HSkNrk/MlNurjkTJszlhh
+QEjVfTBo/ldGrDOt5Py7HsKb50W/NH9P7Bv6KjVy1XcxmGoT/SDt3qx7A4TpCZN
MQIuDi8QnW+SAvHTtZMgfPNhmvU9M3LjdIsKmBvNcM0WInFwKhCoX4oHtkT04utn
1Ofh6pBntawa52SvZAan+BVGxPodItAUDvtstvJoP/MgrgdGsRZ57Th/jvfwQNGj
wfsT4fS+vv3tpqQ2wmVcgg9O2GQhMsP2RYJnsbsZBG2uxcDGx/14KN0vVwbrGZvj
FC5B8g8YhYFX+yDXlnQerOb/UWqbTNwvIZGTUy1ObRvw+xaCofrIYXW+sFIi4+zd
CqLWTQZhI6YmOE5fHeXKkm4AcdUbn8fhrNMu/3h5Bhqji1KqtaUThuyxVRbGFFZ4
8Y7zuryuePkrg7ppfgl9EdIE8zMMSm9yHd0oRZf8hlT4A8575DKzf0F5Wd6fxlBm
9UJ3I+otUUznTz2UGwkqxuV12nxRclnmU0r6oMnI0grqQ1rkzc2r5iKFKiKd2vnA
KjmP9hZdL5ez+AHCSXsm
=09Wc
-----END PGP SIGNATURE-----

--twlwrnvElrG9k/1g--
