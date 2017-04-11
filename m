Received: from eggs.gnu.org ([2001:4830:134:3::10]:36581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxsvO-0004x6-CF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxsvL-0008Ck-6y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:21:26 -0400
Date: Tue, 11 Apr 2017 20:19:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411101934.GE12900@umbus.fritz.box>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
	<1491832618-27536-3-git-send-email-clg@kaod.org>
	<20170411024041.GW27571@umbus>
	<9b557996-5268-b95b-c6ae-9fe5b6191191@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <9b557996-5268-b95b-c6ae-9fe5b6191191@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] ppc/pnv: enable only one LPC bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 09:06:16AM +0200, C=E9dric Le Goater wrote:
> On 04/11/2017 04:40 AM, David Gibson wrote:
> > On Mon, Apr 10, 2017 at 03:56:52PM +0200, C=E9dric Le Goater wrote:
> >> The firmware (skiboot) chooses the default LPC bus of a multichip
> >> systems using a "primary" property. The LPC bus of chip 0 should be
> >> the only connected in the system. Let's advertise it in the device
> >> tree.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  Changes since v1:
> >>
> >>  - the device tree is populated for all LPC busses of the system but
> >>    only the one on chip 0 has the "primary" property.
> >>
> >>  hw/ppc/pnv.c             |  2 ++
> >>  hw/ppc/pnv_lpc.c         | 23 ++++++++++++++---------
> >>  include/hw/ppc/pnv_lpc.h |  2 ++
> >>  3 files changed, 18 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 27589b91d1cf..7d742b6e34e1 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -765,6 +765,8 @@ static void pnv_chip_realize(DeviceState *dev, Err=
or **errp)
> >>      g_free(typename);
> >> =20
> >>      /* Create LPC controller */
> >> +    object_property_set_int(OBJECT(&chip->lpc), chip->chip_id, "chip-=
id",
> >> +                            &error_fatal);
> >>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
> >>                               &error_fatal);
> >>      pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xsco=
m_regs);
> >> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> >> index baee366d386a..13d7a695678d 100644
> >> --- a/hw/ppc/pnv_lpc.c
> >> +++ b/hw/ppc/pnv_lpc.c
> >> @@ -92,14 +92,6 @@ enum {
> >>  #define LPC_HC_REGS_OPB_SIZE    0x00001000
> >> =20
> >> =20
> >> -/*
> >> - * TODO: the "primary" cell should only be added on chip 0. This is
> >> - * how skiboot chooses the default LPC controller on multichip
> >> - * systems.
> >> - *
> >> - * It would be easly done if we can change the populate() interface to
> >> - * replace the PnvXScomInterface parameter by a PnvChip one
> >> - */
> >>  static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xs=
com_offset)
> >>  {
> >>      const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
> >> @@ -110,6 +102,7 @@ static int pnv_lpc_populate(PnvXScomInterface *dev=
, void *fdt, int xscom_offset)
> >>          cpu_to_be32(lpc_pcba),
> >>          cpu_to_be32(PNV_XSCOM_LPC_SIZE)
> >>      };
> >> +    PnvLpcController *lpc =3D PNV_LPC(dev);
> >> =20
> >>      name =3D g_strdup_printf("isa@%x", lpc_pcba);
> >>      offset =3D fdt_add_subnode(fdt, xscom_offset, name);
> >> @@ -119,7 +112,13 @@ static int pnv_lpc_populate(PnvXScomInterface *de=
v, void *fdt, int xscom_offset)
> >>      _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> >>      _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
> >>      _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
> >> -    _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
> >> +
> >> +    /* The firmware (skiboot) chooses the default LPC bus of the
> >> +     * system using a "primary" property.
> >> +     */
> >> +    if (lpc->chip_id =3D=3D 0x0) {
> >> +        _FDT((fdt_setprop(fdt, offset, "primary", NULL, 0)));
> >> +    }
> >=20
> > So, the choice of primary bus is really a machine level thing, rather
> > than chip level.
> >=20
> > So I think it would make more sense for the machine to poke the
> > 'primary' property into the device tree afterwards, rather than adding
> > it initially within the chip/LPC code.  That will then avoid having to
> > pass the chip-id property into the LPC.
>=20
> ok. I will see how I can do that. I think that I will change=20
> pnv_xscom_populate() to return the xscom offset in the device
> tree. From this node, I can look for the ISA bus and add the=20
> "primary" property if this is chip 0.

I wouldn't even bother storing the offset, which may not be safe
anyway.  You can just look it up again by path from the machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7K2zAAoJEGw4ysog2bOSM9QP/jwxE9qnlNmVOHDCv2UsQIl0
zctf5mMqQqQ5ykSun64qMGm6lrkkEDtS8eCipyeHv16SFEEg8UcM2jZNZI2vJu2s
0iITMbDoVrCwc6tbkZA3yEjOkyanL+KJG50rP+emKn8mdWHSXZmp4jZakb0i7C3D
ntIiYAL8kimrLOLUaKUgldH3Ok8jv2S8DZp+/w1m3uzl00VM2GnJPIeLGfvdrDVO
uCpYGGrL7I6ouhvmtAcxCzo4jGWDqVNFAG/m6ocXIwIpAO+RQMFBIAJjXeQPVOui
k51e2aUjswCh7T03YrP1zoVr5Z4fsn1AKzP3Ru7QxaDR6uxyOakhet0EbloKck4V
hR7asgE4BF0J3nrB7lHd4xtlG757Kin+6yjrCflb622cZf9WRs5JXsXhVVfzivAK
B9t/qP474lRyLUi+WB+bDdGdywDCkivWygd3ze9IMlwFSIBuWKYzFU1R5jWefP4O
VgziswWLKTsnvE9z/5ekwcSAHrkYnS7TSev/tvuY2++ckCBbr/mvx6SrprIVbVXK
oF8UQJWMx+vVJV9NWyn1YzIJjBu+3WyF6+ZNrQXN7cJWApwhFf3fMHcNUSF3MAYt
gtW29cXyiR7e07dYmI2ZqrElfIXqQpDnd6Rxlzd1G3lCpYT/lJ6d8hfIvogBzwOq
/4VGHN4FhKh4g4gIA6Fo
=FOEx
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
