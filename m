Received: from eggs.gnu.org ([2001:4830:134:3::10]:35126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lMJ-0005k0-TU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7lMG-0005zX-Qd
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:18:03 -0400
Date: Mon, 8 May 2017 12:17:57 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508161757.GA22428@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
	<20170505103658.GB11350@stefanha-x1.localdomain>
	<ca446302-518f-63bc-9022-5b2f7182cb1a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <ca446302-518f-63bc-9022-5b2f7182cb1a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: protect
 modification of dirty bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 12:47:35PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 05/05/2017 12:36, Stefan Hajnoczi wrote:
> > On Thu, Apr 20, 2017 at 02:00:57PM +0200, Paolo Bonzini wrote:
> >> @@ -410,6 +442,18 @@ int bdrv_get_dirty(BlockDriverState *bs, BdrvDirt=
yBitmap *bitmap,
> >>      }
> >>  }
> >> =20
> >> +int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> >> +                   int64_t sector)
> >=20
> > Is it a good idea to offer an unlocked bdrv_get_dirty() API?  It
> > encourages non-atomic access to the bitmap, e.g.
> >=20
> >   if (bdrv_get_dirty()) {
> >       ...do something outside the lock...
> >       bdrv_reset_dirty_bitmap();
> >   }
> >=20
> > The unlocked API should be test-and-set/clear instead so that callers
> > automatically avoid race conditions.
>=20
> I'm not sure it's possible to implement atomic test and clear for
> HBitmap.  But I can look into removing unlocked bdrv_get_dirty, the only
> user is block migration.

Removing unlocked bdrv_get_dirty() is good.

Stefan

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEJo1AAoJEJykq7OBq3PIGD4H/RJwQmR34X3VAn9o27F/lbtN
SJDwQ5H/ewytAWfgXpUjJ+ket4fYIakW9QxniZDbcck8lpn62cr8xVO/i7aDLu9+
mG4cdMwp5TKpIVYCNUM7P365suFlOrE4lYUsw0IRi3yfCv9mnufXpatWAVxHBmer
HOv7N7AhH0q4cPjgocAEKwnOqr/ipGDkzwz7mbiqzKDzjxcgqK8/mkVvqFrz2Ano
orOt7ZAbL7HgwLdCAEY1lTAJUWSa4em54d4mjCuPGmQmK9Cfnx1JtUE40/zDfFBy
ADMcv2xzt56TM1DYWmvE0T5/DLdQS4JfftDEpzX863QsW1xa1odxAsMIUgGq/BM=
=xFIH
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
