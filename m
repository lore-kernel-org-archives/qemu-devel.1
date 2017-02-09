Received: from eggs.gnu.org ([2001:4830:134:3::10]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0007bw-Ia
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepk-0006wq-FR
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:47 -0500
Date: Thu, 9 Feb 2017 12:53:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209015352.GO17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<900ea185630c17f315c4984b2a595b2d3fba7c9a.1486436186.git.sam.bobroff@au1.ibm.com>
	<981353e3-1ca7-6fcb-ef5e-86b9a335b6ed@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Content-Disposition: inline
In-Reply-To: <981353e3-1ca7-6fcb-ef5e-86b9a335b6ed@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 1/9] spapr: fix off-by-one
 error in spapr_ovec_populate_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--p/1JFEOz/hVXxMAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:47:53PM +0100, Thomas Huth wrote:
> On 07.02.2017 03:56, Sam Bobroff wrote:
> > The last byte of the option vector was missing due to an off-by-one
> > error. Without this fix, client architecture support negotiation will
> > fail because the last byte of option vector 5, which contains the MMU
> > support, will be missed.
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> >  hw/ppc/spapr_ovec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> > index 4f4c090a29..18dbc4a9ac 100644
> > --- a/hw/ppc/spapr_ovec.c
> > +++ b/hw/ppc/spapr_ovec.c
> > @@ -251,7 +251,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offse=
t,
> >          }
> >      }
> > =20
> > -    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len);
> > +    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len + 1);
> >  }
>=20
> It took a while 'til I understood the encoding / length calculation of
> the property here, but I think you're right. According to LoPAPR the
> total length of the property is n+2 where n is the value of the first
> byte. Since n is vec_len-1 in the QEMU code, vec_len+1 is the right
> value for the property length.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

This is a correct fix regardless of the rest of the series, so I've
applied it to ppc-for-2.9.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm8uuAAoJEGw4ysog2bOSbjIP/jiUH3btzco1T/5d9rUz03Ly
CPVYGv4eDCHgYj8ckstXI62iBI0xbLanxDAXEZD4VCuTFGRNKEdapYAKhaxfM48Q
6lmzl2R5Iye0YTB2VWwPVr1AidLXWlR3RFrmL7lRsaRnaSF0Y8QpaQZEN4T8HstN
Xhx/RnHaDKquJZ5f+Wd4idfs0PKuXLPFhiioKIJEkv5qdk7Hspuigtl2hBfuNIPS
9HGFmCRiW7Gi3Po7lXUI+AXO4qwcYRjXn51/KF3V3O5d+yyekfF/VeuaGgpoa2fD
osjRMB9eNGWeqOpYHDFB3u4DbILnNmAR0xxhOu1fc8grkCSKlGlYQiz8SnuaInRr
ECSqkVGiS1BNEWAFCVNj946rkxyoKHVb8Q1HhuP3+6PMQodi8epwwiwr1y3gHUWD
Z7u1E/0l8zGhEhUsUQpUmmYLJiQwHCJkIbzonAbMtc9VtxIzVGQpO3B7SIvgyXnO
AIvALl7dPL7druYBGK49Fx1YlejxLiWtqKs9aUImhgizC9iWDX5d7qkTaN0469vS
I5EDX6mSMVrgwuGzuu/CWNUwFHSAGKBB3Lnf8hO1TvW0JXhT89fxTOMEtQA/x09/
jaCZ7FlFZRQf1ml0LAsiHAq4HBKBFyv6kJ2X8WW/ubA9ioTXu/WioWYwNpPot7VE
Q4lF4SvKYa7Agrs2RHSS
=zJRm
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--
