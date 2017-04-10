Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5L-00026Z-NH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5K-0002Of-Dd
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:55 -0400
Date: Mon, 10 Apr 2017 15:41:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410054125.GQ27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-19-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-19-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 18/21] pci: Use the new
 pci_can_add_device() to enforce devfn_min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:43PM +0200, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This adds a devfn_max field to PCIBus and adds a pci_can_add_device()
> function which, if no "addr" (aka devfn) is specified, will tell whether
> there is any slot free between devfn_min and devfn_max.
>=20
> When devfn_max is 0 (default), it will be ignored (no constraints).
>=20
> This will be used by some PCI root complex implementations that support
> only one direct child to avoid having qemu put dumb devices at different
> slot numbers.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [clg: updated for qemu-2.9 ]
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/pci/pci.c             | 22 ++++++++++++++++++++++
>  include/hw/pci/pci_bus.h |  1 +
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b1c01a..817ad14ed987 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -143,6 +143,27 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
>      return NUMA_NODE_UNASSIGNED;
>  }
> =20
> +static bool pci_can_add_device(BusState *bus, QemuOpts *opts)
> +{
> +    unsigned int devfn, max;
> +    PCIBus *pbus =3D PCI_BUS(bus);
> +
> +    /* If address is specified, say yes and let it fail if that doesn't =
work */
> +    if (qemu_opt_get(opts, "addr") !=3D NULL) {

Ah, so these are options for the device to add, not for the bus.  I'm
not entirely sure that device options are standardized enough to do
this safely.

Could you use an initialized, but not realized, device pointer instead?


> +        return true;
> +    }
> +    max =3D ARRAY_SIZE(pbus->devices);
> +    if (pbus->devfn_max && pbus->devfn_max < max) {
> +        max =3D pbus->devfn_max;
> +    }
> +    for (devfn =3D pbus->devfn_min ; devfn < max; devfn +=3D PCI_FUNC_MA=
X) {
> +        if (!pbus->devices[devfn]) {
> +            break;
> +        }
> +    }
> +    return devfn < max;
> +}
> +
>  static void pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k =3D BUS_CLASS(klass);
> @@ -154,6 +175,7 @@ static void pci_bus_class_init(ObjectClass *klass, vo=
id *data)
>      k->realize =3D pci_bus_realize;
>      k->unrealize =3D pci_bus_unrealize;
>      k->reset =3D pcibus_reset;
> +    k->can_add_device =3D pci_can_add_device;
> =20
>      pbc->is_root =3D pcibus_is_root;
>      pbc->bus_num =3D pcibus_num;
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 5484a9b5c573..05c9dd22a8fa 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -23,6 +23,7 @@ struct PCIBus {
>      PCIIOMMUFunc iommu_fn;
>      void *iommu_opaque;
>      uint8_t devfn_min;
> +    uint8_t devfn_max;
>      pci_set_irq_fn set_irq;
>      pci_map_irq_fn map_irq;
>      pci_route_irq_fn route_intx_to_irq;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xsFAAoJEGw4ysog2bOSX/IQAL97Nu/HKBdRdZ4pp6kY7akh
cps3K1DqY8adUzfN4e9oJacQ4wYs2spnWnqXZsseD4EygIqEXPi7oMCzgGntuXcV
Ul056xhtuWVTi9qrQEG+y9KkJFdLPKzL/8kYV4ZdrHp7YIypqIIAUl/1O47t77T5
esBz6yELNlpm8RQv5Ibwi0Ur30c+QQU/R3IR1R0ziuxr9zu8HV3Q3uCserY8u+sy
LMa6CfKi+s+FpYmZ/gxrBuWg2cge3Ee/4DsznHk2nYB730vIVdgf/ZA/kOupAX2Y
XvDrtHsZzFbBRmrm/hHwttqvY2tyXpNWUDkfhH9gqTusoy/nrQa5yWXg/34/Zsof
Xipe0lGMJJFyqu0mKTb2mZSAmgq3E/8C30/26yDFWGjdG/yMpuvx7jbTZY8R3EGW
oHsam8q1pxx506DktLJ/DLnxVyJCcgwWYsAkAIZpa4BTFCXq+Vb9mjYlT9QOyjIB
9zarWT5Y4qbZuQgMb4QE90hSRonVp+j/SI1nZvNxJwmWJAa26H9YSl9lQ2LQZEk7
rpeA5wCnzBWBLUU3ByOr9mfW9Dvr5RwMK1BcTLNPgoVm96eqaWPS0j0JE1zquOep
sju+w0a0M4L3qwuL31CXSEhJ7NamMIQpyQ0D+JWJ0MEh+wo/caInt2iK4Gsm07MH
5O26LQ4l8z5aBy7rMxKv
=iyKq
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
