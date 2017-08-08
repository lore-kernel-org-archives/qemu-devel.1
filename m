Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexwB-0007Ow-28
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexw5-0007lg-U0
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:19 -0400
Date: Tue, 8 Aug 2017 16:16:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170808061636.GB25081@umbus.fritz.box>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
	<150212670348.12227.5534815630591997333.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <150212670348.12227.5534815630591997333.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.10 PATCH 3/3] spapr: error out if PHB fails
 to setup PCI DRCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 07:25:03PM +0200, Greg Kurz wrote:
> It is currently possible to start QEMU with two PHBs without using the
> index property:
>=20
> -device spapr-pci-host-bridge,id=3Dpci1,\
>                               buid=3D0x800000020000001,\
>                               liobn=3D0x80000100,\
>                               liobn64=3D0x80000101,\
>                               mem_win_addr=3D0x200100000000,\
>                               mem64_win_addr=3D0x220000000000,\
>                               io_win_addr=3D0x200000010000 \
> -device spapr-pci-host-bridge,id=3Dpci2,\
>                               buid=3D0x800000020000002,\
>                               liobn=3D0x80000200,\
>                               liobn64=3D0x80000201,\
>                               mem_win_addr=3D0x200180000000,\
>                               mem64_win_addr=3D0x230000000000,\
>                               io_win_addr=3D0x200000020000 \
>=20
> Each PHB has its index property equal to -1. As a consequence, each PHB
> will want to create PCI DRCs with the same ids:
>=20
>     /* allocate connectors for child PCI devices */
>     if (sphb->dr_enabled) {
>         for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
>             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
>                                    (sphb->index << 16) | i);
>         }
>     }
>=20
> When DRC objects are added to the composition tree, an alias using the
> DRC id is created in the "/dr-connector" path. But DRC ids are supposed
> to be globally unique and the alias creation fails, leaving the DRC
> object unrealized, which isn't expected by the rest of the DR logic.
>=20
> This has the effect of silently turning-off PCI hotplug support (ie, PCI
> hotplug no longer works on any PHB and no error message is printed).
>=20
> This bug always existed and would even cause a non-fatal error to be
> reported on the console (until recent commit bf26ae32a92a). This patch
> causes the error message to be printed again and QEMU to exit.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Given that the bug isn't a regression, I'm a bit disinclined to merge
patches 2&3 this late in 2.10.

It just seems bogus to have all this code to (supposedly) allow
bridges without an index, but then have it error out if there's more
than one of them.

I think skip straight to the real fix of making index madatory in 2.11.

> ---
>  hw/ppc/spapr_pci.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 4b7882e3613d..4a1e6c5f697c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1731,9 +1731,16 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
> =20
>      /* allocate connectors for child PCI devices */
>      if (sphb->dr_enabled) {
> +        Error *local_err =3D NULL;
> +
>          for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
>              spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> -                                   (sphb->index << 16) | i, NULL);
> +                                   (sphb->index << 16) | i, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                error_prepend(errp, "Failed to create DRC: ");
> +                return;
> +            }
>          }
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmJV0QACgkQbDjKyiDZ
s5IX9RAA5Ne8BrlEsGqVjj3taOsQrAxtVXkbBpRw7qEvqVA1oDCBSuDZx1ha4xgc
1bWy49RWyndvfSzyXRjBgRr+BHapuYAvBwnCFclRl97JoSmcuU0UQBvtoJ+xSPbF
02JC6JT7DwOOh1UKpZaUObgBNijW38xXV0khMd0/bZplmioMtvEDMdNUSEqBh4I2
ps4Y4nmUlJbq1q6Uc1kPsIblkn0WvthM28GUyDDnbRiN+rbTRvEaQbwJntmTDWPL
bJwL1ABsH9+oWN+4QfkxUjqhUL5eUBrS9MFyocb44rUwBlfPUJMVXmdMsbxJMyKw
hLzGa9iMz1Hb1uKApHddK26u72pDSH9lGWXDubf1Lvc4MugP15xA3ox/d8Dim0rT
vLyf5nmqIBZessBJ1Ji7VnxM41XliJK/Qq5efHhN2acTKYVvMTl95dTbesyOa2g/
gYhiHfIGWeLUBubGy6HdNGU2B2CsyfjDHot3AJqNb7NDWHDeuSqaMsz0ivTwIYLt
Qxwaz8vqBpu0103GmGdWNjc/uwrkjnaY5zk4IFiv9ftCD6viTTxATm2rSRboXwLx
qzpVGVo9bV+ZC4T+FIiva4Lnhm5fbMD+9LAcP6YFdXPdWDJbJDJmg4lLUONpuDUq
bSq3Zza8bKynNXAGBZ/dUDIZOtp0c/xcaVDiWzE8bwiwHrbtpDI=
=WK1W
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
