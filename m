Received: from eggs.gnu.org ([2001:4830:134:3::10]:47351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAE-0006CL-Hq
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAD-0003KE-7f
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:02 -0400
Date: Mon, 4 Jun 2018 10:41:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604004101.GC4251@umbus>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
	<20180506142005.19580-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20180506142005.19580-5-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 4/4] uninorth: remove token register from
 uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 03:20:05PM +0100, Mark Cave-Ayland wrote:
> >From observation of various OS sources it can be seen that the token reg=
ister
> introduced in 4e46dcdbd3 "PPC: Newworld: Add uninorth token register" is =
not
> required, since the only register currently implemented is the uninorth h=
ardware
> version which is read-only.
>=20
> Remove the token register implementation and instead return the uninorth
> version corresponding to the hardware.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/pci-host/uninorth.c         | 11 +++++------
>  include/hw/pci-host/uninorth.h |  4 +++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index a658f9230a..abebfaf755 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -524,19 +524,18 @@ static void unin_write(void *opaque, hwaddr addr, u=
int64_t value,
>                         unsigned size)
>  {
>      trace_unin_write(addr, value);
> -    if (addr =3D=3D 0x0) {
> -        *(int *)opaque =3D value;
> -    }
>  }
> =20
>  static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      uint32_t value;
> =20
> -    value =3D 0;
>      switch (addr) {
>      case 0:
> -        value =3D *(int *)opaque;
> +        value =3D UNINORTH_VERSION_10A;
> +        break;
> +    default:
> +        value =3D 0;
>      }
> =20
>      trace_unin_read(addr, value);
> @@ -559,7 +558,7 @@ static void unin_init(Object *obj)
>      UNINState *s =3D UNI_NORTH(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> =20
> -    memory_region_init_io(&s->mem, obj, &unin_ops, &s->token, "unin", 0x=
1000);
> +    memory_region_init_io(&s->mem, obj, &unin_ops, s, "unin", 0x1000);
> =20
>      sysbus_init_mmio(sbd, &s->mem);
>  }
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
> index f6654bad9b..2a1cf9f284 100644
> --- a/include/hw/pci-host/uninorth.h
> +++ b/include/hw/pci-host/uninorth.h
> @@ -29,6 +29,9 @@
> =20
>  #include "hw/ppc/openpic.h"
> =20
> +/* UniNorth version */
> +#define UNINORTH_VERSION_10A    0x7
> +
>  #define TYPE_UNI_NORTH_PCI_HOST_BRIDGE "uni-north-pci-pcihost"
>  #define TYPE_UNI_NORTH_AGP_HOST_BRIDGE "uni-north-agp-pcihost"
>  #define TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE "uni-north-internal-pci-=
pcihost"
> @@ -57,7 +60,6 @@ typedef struct UNINState {
>      SysBusDevice parent_obj;
> =20
>      MemoryRegion mem;
> -    int token[1];
>  } UNINState;
> =20
>  #define TYPE_UNI_NORTH "uni-north"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUip0ACgkQbDjKyiDZ
s5JQbBAA5me4l7TYIi3KjhiOst8nNVfVBlw5EcCpsXVEY2+pz7lBXr4CKGc+SBd1
1SJbhM6VxOPBU0m9dtoSW8pfDaLvLmp0AupX27VSG9jm16RrFPNJmw1kWWEMxcXM
tLefuGKJggt1lQ7BmGDMX19OP/a51Eb6r8/dYP2rxApFiNlmKdrtijZE8ye5S5+n
CN3nfPkkgMZLe+jAzb6AHvOYg4oCwD56lPbg9vLXdmaSyDEyLu13ETWyH8Nz7gfH
l3q9zmN808rbejPAyMC8Fmbn/eAsqrhZF++pF/SPW9YDyHz+Qxq4kZED4HiKEYO9
XYd7zelHQSdReL+PS87TXKjvn39CjHM/KtgloN/rilQIHvHi565K4eb5CFoZaKJu
RjaL2Wu4YwGzXKmD+rK4fHAayaXjzONRYdBCtLXIbrr3vYwEx/nD2sQ99m3YVcu2
g0WRuYxwDw/XyO8AL2k1iyWisuOS6wNdGXxT1AszWcvb2QvjGGbpB1OxKZKjntkg
RTDELh1ma506IZke9DINIHiJ7J0lVOq780d07VU/HtTnq/tBs6V3b1VOdNlAG2Mw
lESbRzSM8N8+XY8i6WMmPHTuL8ej6uGgTmKviHrxDjhRTeYaalAPQYnB9wGYqtTy
DNlSLeDBvIHoWOL32cywEgdn1CUvdwCMRGSeTkB0vI4zeiX8wfw=
=h3P7
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
