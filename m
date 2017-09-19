Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtb-0001KQ-R1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtY-00030A-0v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:51 -0400
Date: Tue, 19 Sep 2017 18:44:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919084406.GX27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-19-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ca23f2aBZR6YDKM9"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-19-clg@kaod.org>
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


--Ca23f2aBZR6YDKM9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:32PM +0200, C=E9dric Le Goater wrote:
> Like for XICS, the XIVE interface for the guest is described in the
> device tree under the "interrupt-controller" node. A couple of new
> properties are specific to XIVE :
>=20
>  - "reg"
>=20
>    contains the base address and size of the thread interrupt
>    managnement areas (TIMA), also called rings, for the User level and
>    for the Guest OS level. Only the Guest OS level is taken into
>    account today.
>=20
>  - "ibm,xive-eq-sizes"
>=20
>    the size of the event queues. One cell per size supported, contains
>    log2 of size, in ascending order.
>=20
>  - "ibm,xive-lisn-ranges"
>=20
>    the interrupt numbers ranges assigned to the guest. These are
>    allocated using a simple bitmap.
>=20
> and also under the root node :
>=20
>  - "ibm,plat-res-int-priorities"
>=20
>    contains a list of priorities that the hypervisor has reserved for
>    its own use. Simulate ranges as defined by the PowerVM Hypervisor.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_hcall.c  | 54 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr_xive.h |  1 +
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> index 4c77b65683de..7b19ea6373dd 100644
> --- a/hw/intc/spapr_xive_hcall.c
> +++ b/hw/intc/spapr_xive_hcall.c
> @@ -874,3 +874,57 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> +
> +void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle)
> +{
> +    int node;
> +    uint64_t timas[2 * 2];
> +    uint32_t lisn_ranges[] =3D {
> +        cpu_to_be32(xive->nr_irqs - xive->nr_targets + xive->ics->offset=
),
> +        cpu_to_be32(xive->nr_targets),
> +    };
> +    uint32_t eq_sizes[] =3D {
> +        cpu_to_be32(12), /* 4K */
> +        cpu_to_be32(16), /* 64K */
> +        cpu_to_be32(21), /* 2M */
> +        cpu_to_be32(24), /* 16M */
> +    };
> +
> +    /* Use some ranges to exercise the Linux driver, which should
> +     * result in Linux choosing priority 6. This is not strictly
> +     * necessary
> +     */
> +    uint32_t reserved_priorities[] =3D {
> +        cpu_to_be32(1),  /* start */
> +        cpu_to_be32(2),  /* count */
> +        cpu_to_be32(7),  /* start */
> +        cpu_to_be32(0xf8),  /* count */
> +    };
> +    int i;
> +
> +    /* Thread Interrupt Management Areas : User and OS */
> +    for (i =3D 0; i < 2; i++) {
> +        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive->tm_=
shift));
> +        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
> +    }
> +
> +    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controller"));

Shouldn't need this - SLOF will figure it out from the node name above.

> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> +                     sizeof(eq_sizes)));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> +                     sizeof(lisn_ranges)));

I note this doesn't have the interrupt-controller or #interrupt-cells
properties.  So what acts as the interrupt parent for all the devices
in the tree with XIVE?

> +    /* For SLOF */
> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +
> +    /* top properties */
> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> +                     reserved_priorities, sizeof(reserved_priorities)));
> +}
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index ae5ff89533c0..0a156f2d8591 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -69,5 +69,6 @@ struct sPAPRXive {
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> +void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ca23f2aBZR6YDKM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA2NYACgkQbDjKyiDZ
s5K0DxAAl4WJV8GMx3GiI446B7Vy3llVQ9N6QiJwLc7xaC1Jjt6GxUA4EXE3Df7L
wVhoqwJc20oaKs7jO6gBB+L6Yr4ehro6F988V+nzoJRNUKPR4T2q0KD6wMS4YB5J
OZgJCUioEiqY7mew+6ePselxDwa931kmflu3qvRXwtmtqeBd9MnNybrK7SMSkUkP
aNwPPhd1dMq4cc4HNaAm1eVmFbwIFQTLYqKEdKalwaxikvU6iI34wYTXUkdBd5+k
N0D7ASu9VhPhEUmLFr8V4Ze6ZIX65AuDyDxpPGVjM9SlnSzH0jx4zO4qseZqJ/P5
dNoVm7YWfu/wDF8KBCRAE5OcZc331cyWGqYcP6GJjB9H6czIbfaRJ5PZ1ReAXeUt
BTJgYfzZFjiQx6p/urlg+y8wSzXr01DmXu7YTD2ujpp4znw7NCOkCyFV0TPgp0NU
356JXKYXnz38xMDj+tu0oDeIvV0jHdsHPP6zEMHG40LciJr4GArJKRp3YoAalwsR
4oXcwNXUDBzYV/TkejldO2JyFnAvkeo5Oxp9eelOcM+NMib7MemAA6/GWPIcR4bG
+LUHTw/hXsPXKFbVayu9qHdAwk4PMqAl/9NH4XRpkxQ6mm2wh1Hrv2xEw3IFR2ET
1CDe08ZnNU4yuekJyRtCCq+nAo/GSFQECq8T+RkxBZu5c4sykrU=
=ogG8
-----END PGP SIGNATURE-----

--Ca23f2aBZR6YDKM9--
