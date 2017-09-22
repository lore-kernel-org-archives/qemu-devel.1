Received: from eggs.gnu.org ([2001:4830:134:3::10]:37845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzr-0004i9-DT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzo-0007Dh-6O
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:51 -0400
Date: Fri, 22 Sep 2017 20:54:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922105433.GM4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org>
	<20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
	<20170921013548.GB4998@umbus.fritz.box>
	<50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iUV/lbBrmPtUT9dM"
Content-Disposition: inline
In-Reply-To: <50588b22-8081-c353-9d83-70cf29a4daa4@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree
 support
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


--iUV/lbBrmPtUT9dM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 01:21:10PM +0200, C=E9dric Le Goater wrote:
> On 09/21/2017 03:35 AM, David Gibson wrote:
> > On Wed, Sep 20, 2017 at 02:26:32PM +0200, C=E9dric Le Goater wrote:
> >> On 09/19/2017 10:44 AM, David Gibson wrote:
> >>> On Mon, Sep 11, 2017 at 07:12:32PM +0200, C=E9dric Le Goater wrote:
> >>>> Like for XICS, the XIVE interface for the guest is described in the
> >>>> device tree under the "interrupt-controller" node. A couple of new
> >>>> properties are specific to XIVE :
> >>>>
> >>>>  - "reg"
> >>>>
> >>>>    contains the base address and size of the thread interrupt
> >>>>    managnement areas (TIMA), also called rings, for the User level a=
nd
> >>>>    for the Guest OS level. Only the Guest OS level is taken into
> >>>>    account today.
> >>>>
> >>>>  - "ibm,xive-eq-sizes"
> >>>>
> >>>>    the size of the event queues. One cell per size supported, contai=
ns
> >>>>    log2 of size, in ascending order.
> >>>>
> >>>>  - "ibm,xive-lisn-ranges"
> >>>>
> >>>>    the interrupt numbers ranges assigned to the guest. These are
> >>>>    allocated using a simple bitmap.
> >>>>
> >>>> and also under the root node :
> >>>>
> >>>>  - "ibm,plat-res-int-priorities"
> >>>>
> >>>>    contains a list of priorities that the hypervisor has reserved for
> >>>>    its own use. Simulate ranges as defined by the PowerVM Hypervisor.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/spapr_xive_hcall.c  | 54 ++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  include/hw/ppc/spapr_xive.h |  1 +
> >>>>  2 files changed, 55 insertions(+)
> >>>>
> >>>> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> >>>> index 4c77b65683de..7b19ea6373dd 100644
> >>>> --- a/hw/intc/spapr_xive_hcall.c
> >>>> +++ b/hw/intc/spapr_xive_hcall.c
> >>>> @@ -874,3 +874,57 @@ void spapr_xive_hcall_init(sPAPRMachineState *s=
papr)
> >>>>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> >>>>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >>>>  }
> >>>> +
> >>>> +void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phand=
le)
> >>>> +{
> >>>> +    int node;
> >>>> +    uint64_t timas[2 * 2];
> >>>> +    uint32_t lisn_ranges[] =3D {
> >>>> +        cpu_to_be32(xive->nr_irqs - xive->nr_targets + xive->ics->o=
ffset),
> >>>> +        cpu_to_be32(xive->nr_targets),
> >>>> +    };
> >>>> +    uint32_t eq_sizes[] =3D {
> >>>> +        cpu_to_be32(12), /* 4K */
> >>>> +        cpu_to_be32(16), /* 64K */
> >>>> +        cpu_to_be32(21), /* 2M */
> >>>> +        cpu_to_be32(24), /* 16M */
> >>>> +    };
> >>>> +
> >>>> +    /* Use some ranges to exercise the Linux driver, which should
> >>>> +     * result in Linux choosing priority 6. This is not strictly
> >>>> +     * necessary
> >>>> +     */
> >>>> +    uint32_t reserved_priorities[] =3D {
> >>>> +        cpu_to_be32(1),  /* start */
> >>>> +        cpu_to_be32(2),  /* count */
> >>>> +        cpu_to_be32(7),  /* start */
> >>>> +        cpu_to_be32(0xf8),  /* count */
> >>>> +    };
> >>>> +    int i;
> >>>> +
> >>>> +    /* Thread Interrupt Management Areas : User and OS */
> >>>> +    for (i =3D 0; i < 2; i++) {
> >>>> +        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive=
->tm_shift));
> >>>> +        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
> >>>> +    }
> >>>> +
> >>>> +    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
> >>>> +
> >>>> +    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controlle=
r"));
> >>>
> >>> Shouldn't need this - SLOF will figure it out from the node name abov=
e.
> >>
> >> It is in the specs. phyp has it. we might as well keep it.
> >=20
> > You misunderstand.  SLOF will *create* the name property based on the
> > node name.  Adding it here has *no effect*.
>=20
> ok. I was not ware of that. I will remove it then.

Historical aside: in traditional OF there aren't "node names" as such.
Each node has a 'name' and 'reg' property and the "node name"
displayed in listings is formed from those as name@unit-address - with
the tricky catch being that unit-address is encoded from 'reg' in a
bus specific manner (using what's essentially a method attached to the
parent node).

Obviously that's awkward in the flat tree world, since we can't have
methods.  So instead nodes have a real string name built into the
structure including both the name and unit address components.  'name'
properties are generally omitted and derived from that name.  'reg'
should match according to the bus's encoding conventions, but the
number of things that can actually verify that is relatively small.

> >>>> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe")=
);
> >>>> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> >>>> +
> >>>> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivp=
e"));
> >>>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> >>>> +                     sizeof(eq_sizes)));
> >>>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> >>>> +                     sizeof(lisn_ranges)));
> >>>
> >>> I note this doesn't have the interrupt-controller or #interrupt-cells
> >>> properties.  So what acts as the interrupt parent for all the devices
> >>> in the tree with XIVE?
> >>
> >> these properties are not in the specs anymore for the interrupt-contro=
ller
> >> node and I don't think Linux makes use of them (even for XICS). So=20
> >> it just works fine.
> >=20
> > Um.. what!?  Are you saying that the PAPR XIVE spec completely broke
> > how interrupt specifiers have worked in the device tree since forever?
>=20
> Let me be more precise. I am saying that the interrupt-controller=20
> and #interrupt-cells properties are not needed under the main interrupt=
=20
> controller node. They can be removed from the tree and the Linux guest=20
> kernel will boot perfectly well.
>  =20
> These properties still are needed under the sub nodes like :
>=20
> /proc/device-tree/vdevice/interrupt-controller
> /proc/device-tree/event-sources/interrupt-controller

Um.  This still makes no sense.  In order to have a common interrupt
space, those nodes must have an interrupt-parent pointing somewhere -
the top level interrupt controller, which needs interrupt-controller
and #interrupt-cells properties.  Note that that will be the "source"
side of the intc.  There could also be a presentation side of the
intc, which wouldn't need those properties.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iUV/lbBrmPtUT9dM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE6+cACgkQbDjKyiDZ
s5K2ng/8DDR3Saky0JKTEl4xO/I3/sc9TS+6HrBljcArtrfBZUsFT/EHq5IyFFtC
8Ap5Czl05t4Fkj4kr7/u3swTuWydOl6vZfP0EFyttv6uxhNnKQgevtmvDPMQwHBy
zxJpyXUiv82zRuoWeLWDVhoZppJlPBLLboIRE1oKSHH7RpHDxBfzFIty6h3ArYu+
Vd2YZL9Gp+GdRblWsRUBWjB8ovxKz3ztLCTuxENW1HFTqX0fuX//GSXru1LfWTBf
rqZSF0YJPbpDiYo0MjD9Ya+odFVpTpkhJNmG/fZR9PnKeDYzZw2pC56BLh9YK/u1
vLsHSrmo2oxpS0Lqij7QFq51jBQuYvnhn+VDMMqZAJ4l8mMa09KI/HvrJ7OxmSrE
jwVwRFY+kXOyDCf7Y13JwjozEIneinxZ8+px2sfKXk0rXW0o55iPCXMrS75LR1+C
x+WdROcPBMEHrmR2gUBdtIEYYH0CuoY7lDmDapZ6l1hV43ivJcOM5GbrtrvOepx5
yes0YErPntY43ILR6EewmtHN3EpwtLUKg1dkQSHg2R1m5IAwSGPtKAzCNvkdudtX
P2FC3ePSRUs8k3ull4ptX52JoA+8x8yulr+Cj/cfmbrmMFNi+0jK9rwPPfWhb8d5
9Zi5zxaK6aG81YdRgnau9joN6LFD628NQ7mgsDLq9ulQ4309+xI=
=T2SF
-----END PGP SIGNATURE-----

--iUV/lbBrmPtUT9dM--
