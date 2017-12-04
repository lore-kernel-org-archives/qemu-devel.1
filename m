Received: from eggs.gnu.org ([2001:4830:134:3::10]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHf-000668-Du
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHe-0000YV-2y
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:27 -0500
Date: Mon, 4 Dec 2017 18:49:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204074953.GS2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-21-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+d/sD+4Memv8CeGA"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-21-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 20/25] spapr: add device tree support for
 the XIVE interrupt mode
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


--+d/sD+4Memv8CeGA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:50PM +0100, C=E9dric Le Goater wrote:
> The XIVE interface for the guest is described in the device tree under
> the "interrupt-controller" node. A couple of new properties are
> specific to XIVE :
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
> When the XIVE interrupt mode is activated after the CAS negotiation,
> the machine will perform a reboot to rebuild the device tree.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_hcall.c  | 50 +++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr.c              |  7 ++++++-
>  hw/ppc/spapr_hcall.c        |  6 ++++++
>  include/hw/ppc/spapr_xive.h |  2 ++
>  4 files changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> index 676fe0e2d5c7..60c6c9f4be8f 100644
> --- a/hw/intc/spapr_xive_hcall.c
> +++ b/hw/intc/spapr_xive_hcall.c
> @@ -883,3 +883,53 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> +
> +void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers,
> +                         void *fdt, uint32_t phandle)

Call it spapr_dt_xive() please, I'm trying to standardize on that
pattern for functions creating DT pieces.

> +{
> +    sPAPRXive *xive =3D spapr->xive;
> +    int node;
> +    uint64_t timas[2 * 2];
> +    uint32_t lisn_ranges[] =3D {
> +        cpu_to_be32(0),
> +        cpu_to_be32(nr_servers),
> +    };
> +    uint32_t eq_sizes[] =3D {
> +        cpu_to_be32(12), /* 4K */
> +        cpu_to_be32(16), /* 64K */
> +        cpu_to_be32(21), /* 2M */
> +        cpu_to_be32(24), /* 16M */
> +    };
> +    uint32_t plat_res_int_priorities[ARRAY_SIZE(reserved_priorities)];
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(plat_res_int_priorities); i++) {
> +        plat_res_int_priorities[i] =3D cpu_to_be32(reserved_priorities[i=
]);
> +    }
> +
> +    /* Thread Interrupt Management Areas : User and OS */
> +    for (i =3D 0; i < 2; i++) {
> +        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive->tm_=
shift));
> +        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
> +    }
> +
> +    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));

You need a unit address here matching the reg property.

> +
> +    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controller"));

You don't need to set name properties explicitly for flattened trees.

> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> +                     sizeof(eq_sizes)));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> +                     sizeof(lisn_ranges)));
> +
> +    /* For SLOF */
> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +
> +    /* top properties */
> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> +                     plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
> +}
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8b15c0b500d0..3a62369883cc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1127,7 +1127,12 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> +    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
> +    } else {
> +        /* Populate device tree for XIVE */
> +        spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHANDL=
E_XICP);
> +    }
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index be22a6b2895f..e2a1665beee9 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1646,6 +1646,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
>                                            ov5_updates) !=3D 0);
>      }
> +
> +    /* We need to rebuild the device tree for XIVE, generate a reset */
> +    if (!spapr->cas_reboot) {
> +        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT);
> +    }
> +
>      spapr_ovec_cleanup(ov5_updates);
> =20
>      if (spapr->cas_reboot) {
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 3f822220647f..f6d4bf26e06a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -82,5 +82,7 @@ void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, =
Monitor *mon);
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> +void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers, void =
*fdt,
> +                         uint32_t phandle);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+d/sD+4Memv8CeGA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok/h8ACgkQbDjKyiDZ
s5LGcQ//eD42RTbN+T6yNZskR/133zAqfeBt22GzFZNYQAx9qz4GopHJS29vKEyJ
afqc/ksquoeAamxrrOWmyzz3M9LbUzqXCw8MCvRUbx+vyYV/vyqxLW81Y0t9McJ2
2y+ThfpZXQlEIH4NSHL2Fz3flfMXGCUuRK/aE4VdP5JJw6L/9qx6VczILYQEnHzG
p73Nko16x6/aM9OV39OeaQvFwVynO1c2YKgjNx7+12H56syWaawSVt+aj5kcbF4U
498uoe4Ai02Hb5KlABreXaAwHLBaOMYCT6q6LmFxZhTvCXa+hKXS8YmYUH5CCY1+
qx5MTCkcu6koeQfIXC7CDEkDQ4ii05ENhRoXD0QdMt4JI5RuSYmQmtanDpFplmVD
E8bAcvcrMC29vb7aISAv+vRBR9S9tBD5ijWuKc4JRvqlBIbBTrrZWNEK0EcDBDCf
OkDxq/jaQkipiLuziVGGDqff2yxIE/bnvBeQgZaTUuYwQ3LmVAtH/g0sDK8LfVm9
jm7nDyWaoU1faxsIGgokIhgmrKiy47DtzwzSIFqO4+GwGci6PVrcUUAdWEO15S+y
i1fIkI6gqT2kiEyisFgIHBg+KccAJap+8BT4OaR3TQbKO34QrxiIRwlpdh7OXZwu
JySE5QFd6xkY1wRDnxVbBggBKgRrD6g9SVQ200gH45wghVZGSOA=
=ulhJ
-----END PGP SIGNATURE-----

--+d/sD+4Memv8CeGA--
