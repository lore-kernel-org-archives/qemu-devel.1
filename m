Received: from eggs.gnu.org ([2001:4830:134:3::10]:43023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfqA7-0007AQ-2i
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cfqA6-000608-90
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:46:03 -0500
Date: Mon, 20 Feb 2017 16:45:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170220154554.GF4814@noname.redhat.com>
References: <20170220153012.GK21255@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20170220153012.GK21255@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] blockdev-add I/O throttling parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, berto@igalia.com


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.02.2017 um 16:30 hat Stefan Hajnoczi geschrieben:
> I/O throttling parameters are missing from blockdev-add.  Is this
> intentional?
>=20
> I can imagine two solutions that do not need these parameters in
> blockdev-add:
>=20
> 1. I/O throttling is implemented by a BlockDriver.  Users are expected
>    to create the BDS themselves.  This is a little awkward since
>    query-block *does* include the throttling parameters in its output
>    and we must preserve this behavior for existing users.
>=20
> 2. block_set_io_throttle must be used after blockdev-add.  Suboptimal
>    because issuing two commands is not atomic (use transaction?).
>=20
> Thoughts?

The existing I/O throttling code is working on BlockBackends, but
blockdev-add creates BlockDriverStates. So it can't possibly add
throttling parameters.

The currently recommended solution block_set_io_throttle. The other
option to control BB level thorttling would be to add qdev properties to
the block devices.

In the long term, I think going with 1. and moving throttling to the
block node level is the much nicer (and more flexible) option.

Kevin

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYqw8yAAoJEH8JsnLIjy/WdWwP/AyA4NopGMl49Y2wXAzM0BGh
KC7Bs/Q8Vx+lB3T4PwUayw5vplNN5PQi55R1VOQOXsNVjcIlfZ0zQ4FoxiVV09fn
B1ObUr89dmJB0QF+vWxWp5l59NwAaXwYmSxR1qJMFT8Gd4y64/0+O0anu8oM047e
NPHqOlQ44BhYyGk2tSfIlJd9uM5jKOv1iCy8p6N1FDZfH57/D9gS3gricMRkmJs8
FMNCxSrtdX26E4okScHu/PIS8+Dh+FbAaB6MdigJ4CTkBLRmLuM21jV/9FAOB2Pa
/YI/R81jh1YYnuKNr0Zw9MlE/Mfl5WDe8TC+foQNFW4NTzSwy25124b2BU/mkwJV
TmmF1vjHCI0SOdMeE18An7ma1b+2KGQrVco8m+rgbUC6jETLZFEpa2JvhGjHQFO7
5ZproaYPSrVVgQyuGa2RS38bAAQkPsIBzkx+TuePoxvA0lbDfUN006BVXlH/84hn
vMY+WmWO+8QQwTOenneYAII+BYI/nfQQczODAeo+QrZAdHyHz9z/litfyWI9ctT2
reOyNqRRvHUaTM8S2SnI/bJblB2c2LaU/cLGTNyiUR8J4OXR0Y3kZRgLkWooJniL
C5aNExqfFXJSFW4eTzT4+hJkWwUkrr2S7VqtnuVYbTRIGt04gjLNC6+nuUP2uHdy
zUr8jzrHtcKOg4MfigHe
=3/CI
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
