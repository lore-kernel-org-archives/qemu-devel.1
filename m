Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBH-0004aY-9d
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBF-0008Ms-R9
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:03 -0500
Date: Thu, 29 Nov 2018 15:09:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129040917.GF14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-28-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
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


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=E9dric Le Goater wrote:
> This will be used to remove the MMIO regions of the POWER9 XIVE
> interrupt controller when the sPAPR machine is reseted.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Since the code looks sane.

Hoever, I think using memory_region_set_enabled() would be a better
idea for our purposes than actually adding/deleting the subregion.

> ---
>  include/hw/sysbus.h |  1 +
>  hw/core/sysbus.c    | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 0b59a3b8d605..bc641984b5da 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -92,6 +92,7 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, in=
t n);
>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
>  void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>                               int priority);
> +void sysbus_mmio_unmap(SysBusDevice *dev, int n);
>  void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
>                     MemoryRegion *mem);
>  MemoryRegion *sysbus_address_space(SysBusDevice *dev);
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 7ac36ad3e707..09f202167dcb 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -153,6 +153,16 @@ static void sysbus_mmio_map_common(SysBusDevice *dev=
, int n, hwaddr addr,
>      }
>  }
> =20
> +void sysbus_mmio_unmap(SysBusDevice *dev, int n)
> +{
> +    assert(n >=3D 0 && n < dev->num_mmio);
> +
> +    if (dev->mmio[n].addr !=3D (hwaddr)-1) {
> +        memory_region_del_subregion(get_system_memory(), dev->mmio[n].me=
mory);
> +        dev->mmio[n].addr =3D (hwaddr)-1;
> +    }
> +}
> +
>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
>  {
>      sysbus_mmio_map_common(dev, n, addr, false, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/Zm0ACgkQbDjKyiDZ
s5JngRAAy87/u4NsR4agsZ0Rr7FkA9YaUJ5XeiKePVA9UM0CzaesSHjStlYiW96w
5/s6G2il3P2RALCqYucystYrGtG+5UNvr0MpqG4dKV6lFCbYKu6Qpb8c5s8VQh4S
XWwuOl9TlvxcfICkLKTTcvIbIG2QrbUC0KyKnIC4IfniuqCNP480mzqiram9/B/h
NeBnHaDFqB7d8LPh5M4ouhaPB/7lllJ+GcFUSRq64nxRqMggNbu3UVH0H0uKaVPP
/EM/ghg/f+KaII8AcPvpRZ3Se2BoOc2wBwSuXzVz/xVbwuF+0BNb3W1bbk4FF6fH
h2NGP/NawqrVq5seohxkM8Hu2nq20/69IlPlXc10cEo7wmiX9Ao/gDs0goRtk+zF
e+dSp60qmfUUpY8Oh7LVNKcvDtW/sYaw3qjWteXc4F69wjH8w1BjF+K3E3vec2Ca
19PzdvaT5xeH/3WBEu5N3xe3dzklIZCa7PHqmG9Jw/eTTFxdmDGvfTJKTEPSNmzZ
2oY3O7AmVhXgbqYaNbd5pTRhvzpfUV5wXTERqwS/XeZMBd6kx6NKffQGib/D9dCJ
UDFnYjHC4qR2ikFerh36MmwGvnbCjf5Araf939bAH58je6IGcmgjnbgCUmx2dvaU
bxpiNi+O90en0G/SL0FS6FOB0a4WztheIe6GetAdDFTQphdpfsE=
=5ANP
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
