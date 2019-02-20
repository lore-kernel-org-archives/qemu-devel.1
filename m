Received: from eggs.gnu.org ([209.51.188.92]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbX-0005d4-9L
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbK-0003YV-7B
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:18 -0500
Date: Wed, 20 Feb 2019 14:28:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032855.GM9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059671912.1466090.10891589403973703473.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dnd11iroZwpv/0M5"
Content-Disposition: inline
In-Reply-To: <155059671912.1466090.10891589403973703473.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 13/17] spapr_pci: provide node start
 offset via spapr_populate_pci_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--dnd11iroZwpv/0M5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:39PM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> PHB hotplug re-uses PHB device tree generation code and passes
> it to a guest via RTAS. Doing this requires knowledge of where
> exactly in the device tree the node describing the PHB begins.
>=20
> Provide this via a new optional pointer that can be used to
> store the PHB node's start offset.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr.c              |    2 +-
>  hw/ppc/spapr_pci.c          |    5 ++++-
>  include/hw/pci-host/spapr.h |    2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fcda17709066..76b3c15d5952 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1312,7 +1312,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr)
> =20
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
>          ret =3D spapr_populate_pci_dt(phb, PHANDLE_INTC, fdt,
> -                                    spapr->irq->nr_msis);
> +                                    spapr->irq->nr_msis, NULL);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ede928b0bff3..a0e17694396a 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2153,7 +2153,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
>  }
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
> -                          uint32_t nr_msis)
> +                          uint32_t nr_msis, int *node_offset)
>  {
>      int bus_off, i, j, ret;
>      gchar *nodename;
> @@ -2208,6 +2208,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t intc_phandle, void *fdt,
>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
>      _FDT(bus_off =3D fdt_add_subnode(fdt, 0, nodename));
>      g_free(nodename);
> +    if (node_offset) {
> +        *node_offset =3D bus_off;
> +    }
> =20
>      /* Write PHB properties */
>      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 4b0443f4cfe4..ab0e3a0a6f72 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -113,7 +113,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct sPAP=
RPHBState *phb, int pin)
>  }
> =20
>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
> -                          uint32_t nr_msis);
> +                          uint32_t nr_msis, int *node_offset);
> =20
>  void spapr_pci_rtas_init(void);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dnd11iroZwpv/0M5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyXYACgkQbDjKyiDZ
s5Id5w/41Z5hnjSVZjxzq+Zo559wqpQoNlfh+1OD4spkNx00pjRHvxFR1wG5V8CI
yfrjVNsTMKgPIO4IHCX68tUBU2wxVEGsqVVkRyA1wF42XvQuvz9xi2KDQonDc2Gg
fI7Sz1HZSGUDnqCjl/g9qOh5Q4QOW2ZGTX6TuLp6haRqyMPpl5O7UNrCiai7QkJk
HEG8Z1ZllZ+AHpY0DN2vE+WKmgPsvGdjEoXh3OuxczO/xA262JJiQUyOfuMVJFUZ
ePIIcvz5gjq0PoHWc1GniydwWadLldOLaqQimNSAggsUUloP3WisQZwDgh5cHlJE
N+KgojzxBDc0ZjtHlBtN4cJte5GikJWZRexaL/mB37CtSK9eyYcrozHTY07+ag5N
uj8kpiysgG8anqs0L4ply/MsIDbB1zbQvT4e0bkuILV+hqOoWUc7xv5fyPfU5zLL
WqDDW+MnTQ/EL9eybzpoIydMDcxdhWf582hR3cZmDInfW//EAzwzkLUaQB1dlh3D
Vsyu8mu1YwIbEhnObc72Rl5rrXNpS39vPleOWvlj9TW8crQ91Nj9YA5+VvPgE9+t
0stDVJ7UrjAAFlLZxjq9WTJDB6FeC01+TIRXM8g8mlbjTPAZVUaEYtw0KCfU9S2N
fHly+RJQoTeE7XcMSvDdgoD0o5W9w40/ypxjGoBut0jsnu97tw==
=Mx7O
-----END PGP SIGNATURE-----

--dnd11iroZwpv/0M5--
