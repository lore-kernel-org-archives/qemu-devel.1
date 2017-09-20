Received: from eggs.gnu.org ([2001:4830:134:3::10]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duYPR-0005aG-Ua
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duYPQ-0007AT-PY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:22:57 -0400
Date: Wed, 20 Sep 2017 08:22:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170920062244.GA4730@localhost.localdomain>
References: <20170918185819.5984-1-eblake@redhat.com>
	<20170918185819.5984-19-eblake@redhat.com>
	<20170919124424.GD3789@localhost.localdomain>
	<ef350240-dbe3-e91a-ac1c-734a0c5d24f1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <ef350240-dbe3-e91a-ac1c-734a0c5d24f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 18/20] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.09.2017 um 21:42 hat Eric Blake geschrieben:
> However...
>=20
> >> -    sbc =3D limit >> BDRV_SECTOR_BITS;
> >>      assert(DIV_ROUND_UP(bm_size, limit) =3D=3D tb_size);
> >>
> >> -    while ((sector =3D bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS)=
 >=3D 0) {
> >> -        uint64_t cluster =3D sector / sbc;
> >> +    while ((offset =3D bdrv_dirty_iter_next(dbi)) >=3D 0) {
> >> +        uint64_t cluster =3D offset / limit;
>=20
> bdrv_dirty_iter_next() returns the next dirty bit (which is not
> necessarily the first bit in the cluster).  For the purposes of
> serialization, we want to serialize the entire cluster in one go, even
> though we will be serializing 0 bits up until the first dirty bit.  So
> offset at this point may be unaligned,

Ok, this is the part that I was missing. It makes a lot more sense now.

Also, I think 'cluster' meaning bitmap clusters and not qcow2 clusters
here confused me a bit.

> > The part that I'm missing yet is why we need to do it. The bitmap
> > granularity is also the granularity of bdrv_dirty_iter_next(), so isn't
> > offset already aligned and we could even assert that instead of aligning
> > down? (As long we enforce our restriction, which we seem to do in
> > bitmap_list_load().)
>=20
> Sadly, a quick:
> [...]
> does NOT fail iotests 165, which appears to be the only test that
> actually hammers on qcow2 bitmaps (changing it to an 'assert(false)'
> only shows an effect on 165) - which means our test is NOT exercising
> all possible alignments.  And it's python-based, with lame output, which
> makes debugging it painful.  But never fear, for v9 I will improve the
> test to actually affect the bitmap at a point that would fail with my
> temporary assertion in place, and thus proving that we DO need to align
> down.  Note that test 165 is testing only a 1G image, but I just showed
> that 64k clusters with 64k granularity covers up to 32G of image space
> in one cluster of the bitmap, so the test is only covering one cluster
> of serialization in the first place, and as written, the test is
> dirtying byte 0, which explains why it happens to get an offset aligned
> to limit, even though that is not a valid assertion.

More tests are always welcome and a good argument for getting a series
merged. :-)

Kevin

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZwgk0AAoJEH8JsnLIjy/WijcP/RA6xrIrnqePJSTCClTtwabf
1SA294miyuFz7y2tRGjjWne23XDK2lT/Q1+YF9EAejqJhBvSHw7MyjTr9k24T19b
ClSL4zu0DaBFUw0zVCx3Aq14RzSoPMiNfod09S51T9fDBtSj0HNZrhu2r2p4esy9
jA8nRe167hrjwrfPa9n/FGw6RjmnqTMAwPawCdHY7Wa1rgbNhfeTt8ij0x+nDzlH
Xdqyr9DWrR6bJeWG0LKFBJhGPkHuxxNP3BUPp0hDE3Aww9iU/hAGynSZ8ys9h76c
8MAYTWszrLkIt0GVbPKT1BzGMq8RxOsqOQB2WARhgZrSq6chQ7qmTiVdA7VC9hK8
/C+shGiKch07mP/mTO907r39V4gN9hQTU+iWayvPjhd7Y0/KhRh21buYsRhHuMt8
769NrMKVAV1r3+WdAv86xwxeXMGwdeJwjpepxUxisAp2RuhVoMUIOY0MwmqWFTdK
m4XnHFyaDP75q+/OwX6jj6mnTa6KFM27/e5ocG/pD9ApDgDjX9tr3lLVc9BjiJ7s
iKi83ZHqiOSuOc9SGx1WaWn7Uy0znC3niG9j6CFrxyXaYbgyCXTqbFJ/9Gl7Qtve
H5G/NAgTmku6qdVxEPBlw69KpXOQYKDWLAX6Lg45W7whpmRZo290XrilfVbn6Pxf
N50+x13j/vKTdso9CR1Y
=9Slx
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
