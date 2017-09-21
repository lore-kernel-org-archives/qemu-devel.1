Received: from eggs.gnu.org ([2001:4830:134:3::10]:47626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duqRA-0003Gx-Sc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duqR7-0006YO-Oe
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:37:56 -0400
Date: Thu, 21 Sep 2017 11:35:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170921013548.GB4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org>
	<20170919084406.GX27153@umbus>
	<5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <5d9394e6-0e3f-7824-dd23-04107eb22582@kaod.org>
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


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 02:26:32PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 10:44 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:32PM +0200, C=E9dric Le Goater wrote:
> >> Like for XICS, the XIVE interface for the guest is described in the
> >> device tree under the "interrupt-controller" node. A couple of new
> >> properties are specific to XIVE :
> >>
> >>  - "reg"
> >>
> >>    contains the base address and size of the thread interrupt
> >>    managnement areas (TIMA), also called rings, for the User level and
> >>    for the Guest OS level. Only the Guest OS level is taken into
> >>    account today.
> >>
> >>  - "ibm,xive-eq-sizes"
> >>
> >>    the size of the event queues. One cell per size supported, contains
> >>    log2 of size, in ascending order.
> >>
> >>  - "ibm,xive-lisn-ranges"
> >>
> >>    the interrupt numbers ranges assigned to the guest. These are
> >>    allocated using a simple bitmap.
> >>
> >> and also under the root node :
> >>
> >>  - "ibm,plat-res-int-priorities"
> >>
> >>    contains a list of priorities that the hypervisor has reserved for
> >>    its own use. Simulate ranges as defined by the PowerVM Hypervisor.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive_hcall.c  | 54 ++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/spapr_xive.h |  1 +
> >>  2 files changed, 55 insertions(+)
> >>
> >> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> >> index 4c77b65683de..7b19ea6373dd 100644
> >> --- a/hw/intc/spapr_xive_hcall.c
> >> +++ b/hw/intc/spapr_xive_hcall.c
> >> @@ -874,3 +874,57 @@ void spapr_xive_hcall_init(sPAPRMachineState *spa=
pr)
> >>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> >>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >>  }
> >> +
> >> +void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle)
> >> +{
> >> +    int node;
> >> +    uint64_t timas[2 * 2];
> >> +    uint32_t lisn_ranges[] =3D {
> >> +        cpu_to_be32(xive->nr_irqs - xive->nr_targets + xive->ics->off=
set),
> >> +        cpu_to_be32(xive->nr_targets),
> >> +    };
> >> +    uint32_t eq_sizes[] =3D {
> >> +        cpu_to_be32(12), /* 4K */
> >> +        cpu_to_be32(16), /* 64K */
> >> +        cpu_to_be32(21), /* 2M */
> >> +        cpu_to_be32(24), /* 16M */
> >> +    };
> >> +
> >> +    /* Use some ranges to exercise the Linux driver, which should
> >> +     * result in Linux choosing priority 6. This is not strictly
> >> +     * necessary
> >> +     */
> >> +    uint32_t reserved_priorities[] =3D {
> >> +        cpu_to_be32(1),  /* start */
> >> +        cpu_to_be32(2),  /* count */
> >> +        cpu_to_be32(7),  /* start */
> >> +        cpu_to_be32(0xf8),  /* count */
> >> +    };
> >> +    int i;
> >> +
> >> +    /* Thread Interrupt Management Areas : User and OS */
> >> +    for (i =3D 0; i < 2; i++) {
> >> +        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive->=
tm_shift));
> >> +        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
> >> +    }
> >> +
> >> +    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
> >> +
> >> +    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controller"=
));
> >=20
> > Shouldn't need this - SLOF will figure it out from the node name above.
>=20
> It is in the specs. phyp has it. we might as well keep it.

You misunderstand.  SLOF will *create* the name property based on the
node name.  Adding it here has *no effect*.

> >> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> >> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> >> +
> >> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"=
));
> >> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> >> +                     sizeof(eq_sizes)));
> >> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> >> +                     sizeof(lisn_ranges)));
> >=20
> > I note this doesn't have the interrupt-controller or #interrupt-cells
> > properties.  So what acts as the interrupt parent for all the devices
> > in the tree with XIVE?
>=20
> these properties are not in the specs anymore for the interrupt-controller
> node and I don't think Linux makes use of them (even for XICS). So=20
> it just works fine.

Um.. what!?  Are you saying that the PAPR XIVE spec completely broke
how interrupt specifiers have worked in the device tree since forever?

And I'm pretty sure Linux does make use of them.  Without
#interrupt-cells, there's no way it can properly interpret the
interrupts properties in the device nodes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnDF3EACgkQbDjKyiDZ
s5I1rRAAk+mKLyPAuR+e52Zfgp2PgdN20CF2Oox4nITz67StZZ1dW/AwzdebZIeS
RgRlQ+4LlvhaKlCTuNVU1BNCiaihtTiaUvqpcrZi8k2foosnNN6UlnEyCWu69Xh4
S+2lN/gUYoDi3EmiV4w561dK3lGJuBLHehxuaS+ko6WKsgxR7PrTl0adGvdLdT9p
NKS7xz3N0k4Iq2XWiuLL9gw177DcnDJv/9prkXIuKLRwCcP8n9VekdQO0l28QHVK
/DD6S+0zoCmqwIcYeRz2+LMT9EMoE8bYmBZCjwxTd187E52nrIgmC9ecgxNTt0oy
CQw1vgZ5JbuHWXKKmzSiPWLxtiN3ahlnNFZ5C0WjRjdNMqj+3VENRxkYO5vFGQEC
Qo1EZZv/xLFF1afPuRuz97ChNiQ8hMWk4AJXIMk+C3X3OyuhuV1d3q3odoX627lF
nCEWn9RwQZzpAZPq/n2FuKCPrga9BMCz+pM5NZ8V6y/vUrAgmRLwDHCxyB3wgb2p
/3kXhA0tyHIc+hpvcUXBMDvLM9OPreBbx0Re459b1pDGUiGYWXxe72gjpjBr7Id0
Bp3GG0w048MicMCSoZcTUut502VfAcsAtPebHh+DzZJWXHPrYE4HFAEuw5/9WIel
Oxy5CQVsQpqXrfTwxYCHavgFo7yYoVBxi2xF+xiXlNiXgYK/Ukw=
=Rnsb
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
