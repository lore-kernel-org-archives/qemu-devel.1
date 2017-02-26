Received: from eggs.gnu.org ([2001:4830:134:3::10]:52927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZM-00064I-7M
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci9ZL-0000E0-5O
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 19:53:40 -0500
Date: Mon, 27 Feb 2017 10:43:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170226234354.GH17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-5-git-send-email-clg@kaod.org>
	<20170223021531.GS12577@umbus.fritz.box>
	<eeec3567-d024-a09a-8a58-304a27c0bb95@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OdQvBiqfLsaeimeB"
Content-Disposition: inline
In-Reply-To: <eeec3567-d024-a09a-8a58-304a27c0bb95@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 04/22] ppc/xics: add an
 InterruptStatsProvider interface to ICS and ICP objects
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


--OdQvBiqfLsaeimeB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 11:52:01AM +0100, C=E9dric Le Goater wrote:
> On 02/23/2017 03:15 AM, David Gibson wrote:
> > On Thu, Feb 16, 2017 at 02:47:27PM +0100, C=E9dric Le Goater wrote:
> >> This is, again, to reduce the use of the list of ICS objects. Let's
> >> make each individual ICS and ICP object an InterruptStatsProvider and
> >> remove this same interface from XICSState.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I'm a little hesitant about this, because it means that getting the
> > interrupt stats information is now spread out over the qom tree,
> > whereas previously there was a single location to get a good summary
> > of the systems overall interrupt status.  The previous behaviour seems
> > like it would be more convenient for debugging.
> >=20
> > That said, I see the structural advantages of this split.  Hmm.. still
> > thinking..
>=20
> This is true. Another argument in favour of what you are saying=20
> is the order in which these are printed. See below. =20
>=20
> What we could do after the cleanup is to make the machine an=20
> InterruptStatsProvider to clarify things.

Right.  So "info pic" does at least iterate through all the providers,
but the semi-random order is pretty icky.  I think putting the stats
provider on the machine would be a better idea - I guess it should be
easy enough if the xics code provides a helper.

>=20
> Thanks,
>=20
> C.=20
>=20
>=20
> (qemu) info pic=20
> CPU 18 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 0 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 21 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 2 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 23 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 4 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 11 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 25 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 6 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 13 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 27 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 8 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 15 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 29 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 30 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 17 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 20 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 19 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 1 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> ICS 1000..13ff 0x10018f1ea40
>   1000 MSI ff 00
>   1001 MSI ff 00
>   1002 MSI ff 00
>   1003 MSI ff 00
>   1004 LSI ff 00
>   1005 LSI ff 00
>   1006 LSI ff 00
>   1007 LSI ff 00
>   1008 MSI ff 00
>   1009 MSI ff 00
>   100a MSI ff 00
>   100b MSI ff 00
>   100c MSI ff 00
> CPU 22 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 3 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 10 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 24 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 5 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 12 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 26 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 7 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 14 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 28 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 9 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 16 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
> CPU 31 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OdQvBiqfLsaeimeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs2g3AAoJEGw4ysog2bOSdGsP/il36xl0AIhm7zmQiyNt64VI
ln0QhOToegcSQT0niXuAHRpSoMld/hIbuHhJiE3V2KUMaob1XiIygIE4e/OYsrEA
vz96AZqNCW5cMjqdFqthHqAQ+9+izJVvOX8zQAS5MuXHgzeHmKQzzaUb8YM2Nwom
Rw4d8FGjPyZV9OwSq+ZoZOA3wvRmPRae/hYIW5aakwSZwtfvJow5KcQHaMWsRyA2
+xgIFdq4/e6lAtX+j0QD01yTGMZOg4nAO/IVcVcRu69XSZM5sQ7PQe6ux3iKlMfm
x8X8GPRZUv4h5yaCJElFmmrLgf5rW22ZjnTm50QoZyR8/jSisqlin2CmtpZ8TJSv
l1qYL+xLyKEakUuQ23Fwp4fl5SDAU0HxIoH6P5NQSvNFb+Z+FwoqbGNd4hFwjxc+
j3KxxIo3oDSqb+sLSLhvl1IrKAwicVcsBsGdoYf3naGFUDve+Z72VYF+D77mD6HU
LqKt9Ra8VKHxbVXkcQ9hhoa6w3rgbKPNa6qKbCaNF/w0l5h3soqb2KHq+AA8g2of
prwY2mJCiyuSAZsw8s/bARdxNcA7KgoVTzU7aDaVruimjFDGgI6AE2pGSyTQSdk/
pvMN7G+DrZI6XzrC697I9fgaVKvX7QjcnhQE1uOEnAr8evPsIqcygPx/rTQi7jqJ
ieB8qJ3CzuQRO8VBEAQo
=HRPS
-----END PGP SIGNATURE-----

--OdQvBiqfLsaeimeB--
