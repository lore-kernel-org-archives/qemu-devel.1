Received: from eggs.gnu.org ([2001:4830:134:3::10]:44944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpot-0003BU-JV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPpos-0007ya-OK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:42:15 -0400
Date: Tue, 27 Jun 2017 13:42:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627124205.GE8555@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
	<20170626160118.ig22l4rkswq7lfhy@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <20170626160118.ig22l4rkswq7lfhy@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 07:01:18PM +0300, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
> > > +static BlockDriver bdrv_throttle =3D {
> > > +    .format_name                        =3D   "throttle",
> > > +    .protocol_name                      =3D   "throttle",
> > > +    .instance_size                      =3D   sizeof(ThrottleGroupMe=
mber),
> > > +
> > > +    .bdrv_file_open                     =3D   throttle_open,
> > > +    .bdrv_close                         =3D   throttle_close,
> > > +    .bdrv_co_flush                      =3D   throttle_co_flush,
> > > +
> > > +    .bdrv_child_perm                    =3D   bdrv_filter_default_pe=
rms,
> > > +
> > > +    .bdrv_getlength                     =3D   throttle_getlength,
> > > +
> > > +    .bdrv_co_preadv                     =3D   throttle_co_preadv,
> > > +    .bdrv_co_pwritev                    =3D   throttle_co_pwritev,
> > > +
> > > +    .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zer=
oes,
> > > +    .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
> > > +
> > > +    .bdrv_recurse_is_first_non_filter   =3D   bdrv_recurse_is_first_=
non_filter,
> > > +
> > > +    .bdrv_attach_aio_context            =3D   throttle_attach_aio_co=
ntext,
> > > +    .bdrv_detach_aio_context            =3D   throttle_detach_aio_co=
ntext,
> > > +
> > > +    .bdrv_reopen_prepare                =3D   throttle_reopen_prepar=
e,
> > > +    .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
> > > +    .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
> > > +
> > > +    .is_filter                          =3D   true,
> > > +};
> >=20
> > Missing:
> > bdrv_co_get_block_status()
> > bdrv_truncate()
> > bdrv_get_info()
> > bdrv_probe_blocksizes()
> > bdrv_probe_geometry()
> > bdrv_media_changed()
> > bdrv_eject()
> > bdrv_lock_medium()
> > bdrv_co_ioctl()
> >=20
> > See block/raw-format.c.
> >=20
> > I think most of these could be modified in block.c or block/io.c to
> > automatically call bs->file's function if drv doesn't implement them.
> > This way all block drivers would transparently pass them through by
> > default and block/raw-format.c code could be eliminated.
>=20
> Are these truly necessary? Because other filter drivers (ie quorum,
> blkverify) don't implement them.

Both quorum and blkverify are rarely used.  This explains why the issue
hasn't been found yet.

These are the callbacks I identified which do not automatically forward
to bs->file.  Therefore the throttle driver will break these features
when bs->file supports them.

That's why I suggest forwarding to bs->file in block.c.  Then individual
drivers do not have to implement these callbacks just to forward to
bs->file.  And if the driver wishes to prohibit a feature, it can
implement the callback and return -ENOTSUP.

You can send this fix as a separate patch series, independent of the
throttle driver.  Once it has been merged the throttle driver will gain
support for these features.

Stefan

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUlKdAAoJEJykq7OBq3PIp2EH/26f/FWDHs2JcWCwV2J3XSJF
yvcj++6nerezRwu0En6F+nO4ANQX1zACwg2FQGZt4ia+EgJhcEDSFYhjE8qgdn4O
Fp9O6BVNmELacIXFn/6u8tAztec3BmfHmHIMkCc1M5+NNomn7Dwp4poVoyQQBnV7
Zp9rbgMHMBj0n2wWkQ6VEvdX1u22BRmxwYxJZCx2W4vepKNPFWv76aHO+es4jnop
SCYAgitF0d1obWhTx4oO7TexS61ps0u4VGawZ6bqG5j9lG1nk60a/vnjXsD9aw5e
A698niW22DpFi6LvE8V3kWvVZhmfbBGvSgKXmEc6I8wnF0NrZ8HW8asCUSgrcJw=
=EYjS
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
