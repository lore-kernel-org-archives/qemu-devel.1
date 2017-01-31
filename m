Received: from eggs.gnu.org ([2001:4830:134:3::10]:44208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBN-0003xR-5G
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYjBK-0007Un-2s
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 19:53:57 -0500
Date: Wed, 1 Feb 2017 09:16:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170131221628.GN14879@umbus.fritz.box>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
	<1485868446-10587-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline
In-Reply-To: <1485868446-10587-4-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 03/21] ppc: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 03:14:29PM +0200, Michael S. Tsirkin wrote:
> We are switching BUILD_BUG_ON to verify that it's parameter is a
> compile-time constant, and it turns out that some gcc versions
> (specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
> not smart enough to figure it out for expressions involving local
> variables. This is harmless but means that the check is ineffective for
> these platforms.  To fix, replace the variable with macros.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Ugh.. I pulled this into my tree already (I've been having trouble
with my test setup, which is why I haven't sent my own pullreq yet).
However, it needs a s/%u/%llu/ to compile correctly on some platforms.

> ---
>  hw/ppc/spapr.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a642e66..b81f2ac 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2630,8 +2630,8 @@ static void spapr_phb_placement(sPAPRMachineState *=
spapr, uint32_t index,
>       * 1TiB 64-bit MMIO windows for each PHB.
>       */
>      const uint64_t base_buid =3D 0x800000020000000ULL;
> -    const int max_phbs =3D
> -        (SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / SPAPR_PCI_MEM64_WIN_SIZE - =
1;
> +#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> +                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
>      int i;
> =20
>      /* Sanity check natural alignments */
> @@ -2640,12 +2640,14 @@ static void spapr_phb_placement(sPAPRMachineState=
 *spapr, uint32_t index,
>      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SI=
ZE) !=3D 0);
>      QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE)=
 !=3D 0);
>      /* Sanity check bounds */
> -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) > SPAPR_PCI_MEM=
32_WIN_SIZE);
> -    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) > SPAPR_PCI_=
MEM64_WIN_SIZE);
> +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
> +                      SPAPR_PCI_MEM32_WIN_SIZE);
> +    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
> +                      SPAPR_PCI_MEM64_WIN_SIZE);
> =20
> -    if (index >=3D max_phbs) {
> +    if (index >=3D SPAPR_MAX_PHBS) {
>          error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
> -                   max_phbs - 1);
> +                   SPAPR_MAX_PHBS - 1);
>          return;
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkQy6AAoJEGw4ysog2bOStb8P/0njHDlnWa720XgG54eGbk/i
FW6YYYnFs+6JL+C5Rkkgv1A3FedB4A4sBEKyrX6JtLy5v9CJfumm+Mx9xXUBLial
WK6V153ODlyd/j2P6924Z3jFgfEKoPBHg2gdY+rnNCL0vKqlN51DeQM+uB8qbGRy
nuljWVLQdnP1gHI+8xV45CT1uWw0Bzl9WYUJQtGTlaKkoeLcUrREZRUHj7dj+8Mx
xxzUdhlY0upuHDYj8gkz3xnlfsw2UFOhqbLxA4eqQm7aghwCsKPvUjn8CrgEAsO3
7ldrLa6iujFFdRTzexK741LIm53oj+MccO24jYM7fDpklJZwSuoXYTI3tUgi0J+8
GXXJ5e5LDhZZrggRMD1jaCI9ZOg/paHLU8b82zJsSqFypAeHtxSHAMzyesbYiQ44
F61eT/iJp72zv4GaWf4jumHtU5TqAHt6YZk4XUmmZE9jgqMcvspUHaZ24lId4M5B
8qMkrEzqDXksO45EKGbsMeZ4aump8+eM1BsGCZNFBEFKU7e9tD5EGQ5K7W9VXr0S
q6IbLrCECdsvO56iPouMMp1sXMChcRUyKxnVai1W6aMkguOMJlvWZnT0Z7W2XWqo
GQSGB8GOdesZLMSCMC0TUpBj6GLReaPQOfdGNMC2uIUssWd6wQrxmDIErrA3XNG0
pasNVCkJVyuk+QtlkCmf
=MaOd
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--
