Received: from eggs.gnu.org ([2001:4830:134:3::10]:52904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHf-000667-3I
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHe-0000YQ-25
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:27 -0500
Date: Mon, 4 Dec 2017 18:52:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204075208.GT2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-22-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X9hp/qFlD/MyfJCu"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-22-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 21/25] spapr: introduce a helper to map the
 XIVE memory regions
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


--X9hp/qFlD/MyfJCu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:51PM +0100, C=E9dric Le Goater wrote:
> When the XIVE interrupt mode is activated, the machine needs to expose
> to the guest the MMIO regions use by the controller :
>=20
>   - Event State Buffer (ESB)
>   - Thread Interrupt Management Area (TIMA)
>=20
> Migration will also need to reflect the current interrupt mode in use.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive_hcall.c  | 14 ++++++++++++++
>  hw/ppc/spapr.c              |  5 +++++
>  include/hw/ppc/spapr_xive.h |  1 +
>  3 files changed, 20 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
> index 60c6c9f4be8f..ba217144878e 100644
> --- a/hw/intc/spapr_xive_hcall.c
> +++ b/hw/intc/spapr_xive_hcall.c
> @@ -933,3 +933,17 @@ void spapr_xive_populate(sPAPRMachineState *spapr, i=
nt nr_servers,
>      _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
>                       plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
>  }
> +
> +void spapr_xive_mmio_map(sPAPRMachineState *spapr)
> +{
> +    sPAPRXive *xive =3D spapr->xive;
> +
> +    /* ESBs */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->esb_base);
> +
> +    /* Thread Management Interrupt Areas */
> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
> +     * region needs some rework in the handlers */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1,
> +                    xive->tm_base + (1 << xive->tm_shift));

You probably shouldn't be exposing the user TIMA in the DT if you're
only allowing the OS TIME to be mapped.

> +}
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3a62369883cc..734706c18cb3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1132,6 +1132,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
>      } else {
>          /* Populate device tree for XIVE */
>          spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHANDL=
E_XICP);
> +        spapr_xive_mmio_map(spapr);

This doesn't belong here, spapr_build_fdt() should _just_ build the
fdt, not have side effects on the actual device state.

>      }
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
> @@ -1613,6 +1614,10 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          }
>      }
> =20
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        spapr_xive_mmio_map(spapr);
> +    }
> +
>      return err;
>  }
> =20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index f6d4bf26e06a..88355f7eb643 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -84,5 +84,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers, void =
*fdt,
>                           uint32_t phandle);
> +void spapr_xive_mmio_map(sPAPRMachineState *spapr);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X9hp/qFlD/MyfJCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok/qgACgkQbDjKyiDZ
s5JNAA/7Bo8TOzSBjOu4BemhYEltuxNvmYVtOf0Zkk68b+Vftp3TSzLCz9oIJlpI
T//QdO1LCrkUkdBAixIwsdB6YSJVxfREAExgDfNsiEK+H24vSlkM52ayKcvlJvBQ
wChPfxgLQ5U9NcQia3smSivG7edqFCl9JmM//RwILMsPkVlgpqq6k7oVSmZRanNt
DkK2x5TxYX2en9OCahIiOng2tUM9d11ju7m47fG6dbc7KWO1dyczL37J7h7Eru2i
ZP38dUuyDSD/vcK1qpmAP6Dfoirxp8elRXiy+EbcR4T+670R51uMWaVvlBSfQSCD
xoWYmV6Qrt4K8eUvW4Oe2tF3+P+0OoXa70NeS7zYEu7YSkPYnkvKqneLEq7F7sye
dXVt3SsdVj+cSNx3bNDkSLm7BlrqV6Sf/MH3YVzgAcR/ctMmQbm7zMyLMRd6XhL/
gKYXyPan0wwlhZZsiFnOEntXLyt59Q8Su8yNRwuQEglSeAJfoYM8tDkTP/ApiumB
b1Y4dAaNhoIyIimfB8j2pU56JXMW66LZQW89ZUpsO9Qe8UuqcNP3Rjfwj5Z5n6KR
n+MgQZxE4kFhBi9eqsECD3A/eGFKy33Jgw6MqxxLKr/ovltNcHYpUsnmIuGQl1wP
51TxAH98/JOeK7F4RiBmKRItjNbA97Ww5rQDLa8bsKL6oqZ43eI=
=RJhl
-----END PGP SIGNATURE-----

--X9hp/qFlD/MyfJCu--
