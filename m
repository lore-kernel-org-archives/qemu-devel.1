Received: from eggs.gnu.org ([2001:4830:134:3::10]:33645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDpp-00027j-D7
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzDm8-0006CS-1O
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 00:26:13 -0400
Date: Mon, 10 Sep 2018 13:49:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910034909.GA24181@umbus.fritz.box>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: hpoussin@reactos.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 08, 2018 at 10:08:17AM +0100, Mark Cave-Ayland wrote:
11;rgb:ffff/ffff/ffff> According to the PReP specification section 6.1.6 "S=
ystem Interrupt
> Assignments", all PCI interrupts are routed via IRQ 15.
>=20
> In the case of the 40p machine this isn't quite true in that it has a rou=
ting
> quirk: the LSI SCSI device is always routed to IRQ 13. At least Linux and
> NetBSD compare the model name presented by the firmware to "IBM PPS Model
> 6015", and if it matches will active this quirk.
>=20
> There is also a slight issue in that whilst the legacy PReP machine is st=
ill
> present in the codebase, the old IRQ routing must still be preserved. Thi=
s is
> done by introducing a new "is-legacy-prep" qdev property to the raven PCI=
 host
> bridge which preserves the old routing for -M prep until that code is fin=
ally
> removed.
>=20
> In order for guest OSs to make use of the fixed IRQ routing, the model na=
me
> in the residual data must be changed in OpenBIOS using the diff
> below:

I've merged patches 1 & 2.  I don't think 3 has the right approach,
detailed comments there.

>=20
> diff --git a/arch/ppc/qemu/context.c b/arch/ppc/qemu/context.c
> index 06e0122..5815895 100644
> --- a/arch/ppc/qemu/context.c
> +++ b/arch/ppc/qemu/context.c
> @@ -111,7 +111,7 @@ static void *
>  residual_build(uint32_t memsize, uint32_t load_base, uint32_t load_size)
>  {
>      residual_t *res;
> -    const unsigned char model[] =3D "Qemu\0PPC\0";
> +    const unsigned char model[] =3D "IBM PPS Model 6015\0";
>      int i;
> =20
>      res =3D malloc(sizeof(residual_t));
>=20
> With the above OpenBIOS patch applied as well as this patchset, it is now
> possible to boot the sandalfoot zImage all the way through to a working
> userspace when using OpenBIOS.
>=20
> (Note: this patchset requires the changes in my previous patchset "scsi:
> replace lsi53c895a_create() and lsi53c810_create() functions)
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Based-on: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
>=20
> Mark Cave-Ayland (3):
>   raven: some minor IRQ-related tidy-ups
>   40p: use OR gate to wire up raven PCI interrupts
>   40p: add fixed IRQ routing for LSI SCSI device
>=20
>  hw/pci-host/prep.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  hw/ppc/prep.c      | 12 ++++++----
>  2 files changed, 66 insertions(+), 13 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluV6bUACgkQbDjKyiDZ
s5J2yw/9GxYGnA6dpZFLGho5kwX9EDRu7A2wFNWAGR6BpczQBpEBgHCMXu3MY2BQ
i3nJykB6Ey9+pBRKeWQIgFAmkCgDUMgwVNyUunkUrjplptMyNxgTV9y+RulECogB
ROx1KgixCQzorsc40nhaUHM+akzy+MJCxt5CgIqkNrrtXgMfmw5BEUTsef00QwVF
XTSsNxKk7ijV4PB/UeRE9XFNqrQEeSwFLcfT54jZqBPicX8ng7gUhVMIffEzT2Nj
NXUQZxwer6+AbLHtg1DrdbFA3EO9kw8iPMvVXxSYwAid0mtodL5ZFkOW73G8ZG53
fk9nC1MlBUgRyv6PdxwCGKosT2OSxLB8ZmPa1jpQ/psL1g9WU/K2A2yWtIrvcgHh
LKHAfrGrXue5A1tTQT8Ox3LcLFiChY5EtBfz1HFkWE7XyvKFOWIHKIn2C+lFU2r/
TTKjB9BwXKPpu7bKa3dqzpXVcpIGePAsCRHAuLIzUW50AeiNpZwC8XkCDU/uWbHg
DiGBjWyTDmjLsWcYwyfSQCdDCBcE3cFqgU8znvSME+3JUURYg6ncGo2kRrJhYDPK
ogTcTQ0QgUZzt9pQcaSWdx/66TXxM+59hBE4ENHkZTtt4Yo++CYR2lkV8RftFp8P
payciHiUhe7N2AXzV07kCakjYu++c4kryHZtcqAP7h94BaguUsw=
=9X2C
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
