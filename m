Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKZ-0007zo-Ld
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efKKY-0007Dh-HC
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:15 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:59417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1efKKX-0007AK-QD
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 01:51:14 -0500
Date: Sat, 27 Jan 2018 17:27:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180127062702.GE2099@umbus>
References: <20180126092029.20737-1-mark.cave-ayland@ilande.co.uk>
	<20180126092029.20737-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20180126092029.20737-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/3] uninorth: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 09:20:28AM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.12.

> ---
>  hw/pci-host/trace-events |  6 ++++++
>  hw/pci-host/uninorth.c   | 24 +++++-------------------
>  2 files changed, 11 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 5b8fcc228b..341a87a702 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -12,3 +12,9 @@ sabre_pci_config_write(uint64_t addr, uint64_t val) "ad=
dr 0x%"PRIx64" val 0x%"PR
>  sabre_pci_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val=
 0x%"PRIx64
>  sabre_pci_set_irq(int irq_num, int level) "set irq_in %d level %d"
>  sabre_pci_set_obio_irq(int irq_num, int level) "set irq %d level %d"
> +
> +# hw/pci-host/uninorth.c
> +unin_set_irq(int irq_num, int level) "setting INT %d =3D %d"
> +unin_get_config_reg(uint32_t reg, uint32_t addr, uint32_t retval) "conve=
rted config space accessor 0x%"PRIx32 "/0x%"PRIx32 " -> 0x%"PRIx32
> +unin_data_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0=
x%"PRIx64 " len %d val 0x%"PRIx64
> +unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%=
"PRIx64 " len %d val 0x%"PRIx64
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 5d8ccaa711..66991da975 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -26,16 +26,7 @@
>  #include "hw/ppc/mac.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
> -
> -/* debug UniNorth */
> -//#define DEBUG_UNIN
> -
> -#ifdef DEBUG_UNIN
> -#define UNIN_DPRINTF(fmt, ...)                                  \
> -    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define UNIN_DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
> =20
>  static const int unin_irq_line[] =3D { 0x1b, 0x1c, 0x1d, 0x1e };
> =20
> @@ -69,8 +60,7 @@ static void pci_unin_set_irq(void *opaque, int irq_num,=
 int level)
>  {
>      qemu_irq *pic =3D opaque;
> =20
> -    UNIN_DPRINTF("%s: setting INT %d =3D %d\n", __func__,
> -                 unin_irq_line[irq_num], level);
> +    trace_unin_set_irq(unin_irq_line[irq_num], level);
>      qemu_set_irq(pic[unin_irq_line[irq_num]], level);
>  }
> =20
> @@ -103,9 +93,7 @@ static uint32_t unin_get_config_reg(uint32_t reg, uint=
32_t addr)
>          retval |=3D func << 8;
>      }
> =20
> -
> -    UNIN_DPRINTF("Converted config space accessor %08x/%08x -> %08x\n",
> -                 reg, addr, retval);
> +    trace_unin_get_config_reg(reg, addr, retval);
> =20
>      return retval;
>  }
> @@ -115,8 +103,7 @@ static void unin_data_write(void *opaque, hwaddr addr,
>  {
>      UNINState *s =3D opaque;
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> -    UNIN_DPRINTF("write addr " TARGET_FMT_plx " len %d val %"PRIx64"\n",
> -                 addr, len, val);
> +    trace_unin_data_write(addr, len, val);
>      pci_data_write(phb->bus,
>                     unin_get_config_reg(phb->config_reg, addr),
>                     val, len);
> @@ -132,8 +119,7 @@ static uint64_t unin_data_read(void *opaque, hwaddr a=
ddr,
>      val =3D pci_data_read(phb->bus,
>                          unin_get_config_reg(phb->config_reg, addr),
>                          len);
> -    UNIN_DPRINTF("read addr " TARGET_FMT_plx " len %d val %x\n",
> -                 addr, len, val);
> +    trace_unin_data_read(addr, len, val);
>      return val;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpsG7YACgkQbDjKyiDZ
s5L5dxAArrrT2qa+ba48O9LbFLk57XkyxWthBegxvtTMu/n6B2nbapUVKlx4hx0Z
1/O8ijj7quoUZzPeOiU9OerGmXsgchUHDdpLvrdSY2u1I7GQRCRb+nt96Kq+oumn
a4wzYoPuE7d9TsngJY/67Y3DjdITRtT5S6x4mjtBuLpifIoRWmcVZti+l3qQC3+s
Ut57q8ZwLxHkwnnkXEb7+YdcNCbtT6az1/RNafMMVglecNkC9hvjjpspQtrWjrM+
/6eTEsS3BahlZFdAz0jnjwjAngPBCxSlCezaSCUI4W4P/j4la0mbiqWhL0pyd8gU
PgJKeWVPmlfuerwb9Y7sVXMr2Awm5nX1uLp+Hxf6NHhXQIgCyDkIqXTLNkOEL0iI
k8B2xOZd4sRqimKoW0IHD9tvtoweei9/U7GngSsvPQB+ZJd/zwxbbI+LRTuAXPyd
L1sbxilITilnFhOza/No7EImDEbvDYZ5ZcAmmC3nBEZXEq3SyZHULrFEBlW6/83N
XxNl4Z4KxVPDrHvro96H8XV+xFX2yaULYmb7/NlGH7MhVDguO+dkHipVZq5trxsD
w0KQlEBgu5EAKJds+wEDQmgGbzGGZhtx3xWaWw0imPSiUdBMpB34F1DMB6s0r2wn
arK20A4wBWNzwCTYAc57t+DS3ZAEf0HEYMnUXy8sYR1YU4hsoCE=
=5jFr
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
