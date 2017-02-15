Received: from eggs.gnu.org ([2001:4830:134:3::10]:60428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce3Or-0005D0-4n
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce3Op-0007dc-Rs
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:29:53 -0500
Date: Wed, 15 Feb 2017 18:29:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215172941.GK4935@noname.redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-10-git-send-email-kwolf@redhat.com>
	<0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <0867a10b-b21f-da63-fb82-b1dd5cd38386@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/41] block: Default
 .bdrv_child_perm() for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2017 um 18:11 hat Max Reitz geschrieben:
> On 13.02.2017 18:22, Kevin Wolf wrote:
> > Almost all format drivers have the same characteristics as far as
> > permissions are concerned: They have one or more children for storing
> > their own data and, more importantly, metadata (can be written to and
> > grow even without external write requests, must be protected against
> > other writers and present consistent data) and optionally a backing file
> > (this is just data, so like for a filter, it only depends on what the
> > parent nodes need).
> >=20
> > This provides a default implementation that can be shared by most of
> > our format drivers.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c                   | 37 +++++++++++++++++++++++++++++++++++++
> >  include/block/block_int.h |  8 ++++++++
> >  2 files changed, 45 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index 290768d..8e99bb5 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1459,6 +1459,43 @@ void bdrv_filter_default_perms(BlockDriverState =
*bs, BdrvChild *c,
> >                 (c->shared_perm & DEFAULT_PERM_UNCHANGED);
> >  }
> > =20
> > +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> > +                               const BdrvChildRole *role,
> > +                               uint64_t perm, uint64_t shared,
> > +                               uint64_t *nperm, uint64_t *nshared)
> > +{
> > +    bool backing =3D (role =3D=3D &child_backing);
> > +    assert(role =3D=3D &child_backing || role =3D=3D &child_file);
> > +
> > +    if (!backing) {
> > +        /* Apart from the modifications below, the same permissions are
> > +         * forwarded and left alone as for filters */
> > +        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &s=
hared);
> > +
> > +        /* Format drivers may touch metadata even if the guest doesn't=
 write */
> > +        if (!bdrv_is_read_only(bs)) {
> > +            perm |=3D BLK_PERM_WRITE | BLK_PERM_RESIZE;
> > +        }
> > +
> > +        /* bs->file always needs to be consistent because of the metad=
ata. We
> > +         * can never allow other users to resize or write to it. */
> > +        perm |=3D BLK_PERM_CONSISTENT_READ;
> > +        shared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> > +    } else {
> > +        /* We want consistent read from backing files if the parent ne=
eds it.
> > +         * No other operations are performed on backing files. */
> > +        perm &=3D BLK_PERM_CONSISTENT_READ;
> > +
> > +        /* If the parent can deal with changing data, we're okay with a
> > +         * writable backing file. */
>=20
> Are we OK with a resizable backing file, too? I'm not sure, actually.
> Maybe we should just forbid it and hope nobody asks for it.

That's pretty much the same thought that I had, so unless I'm mistaken,
this is exactly what the patch implements.

I can't think of a reason why resizing a backing file would hurt as long
as the parent allows writes to the backing file (though we might have to
audit that no driver caches the backing file size), but then I can't
think of a reason either why anyone would want to do this.

If we ever find out that there is a good reason, we can still change it.

=2E..

Hm, scratch that. I guess a commit block job with a smaller backing file
is enough... Good thing that I neglected to get the RESIZE permission
for s->base there. :-)

Kevin

> Max
>=20
> > +        shared &=3D BLK_PERM_WRITE;
> > +        shared |=3D BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
> > +                  BLK_PERM_WRITE_UNCHANGED;
> > +    }
> > +
> > +    *nperm =3D perm;
> > +    *nshared =3D shared;
> > +}
> > =20
> >  static void bdrv_replace_child(BdrvChild *child, BlockDriverState *new=
_bs)
> >  {
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 2d74f92..46f51a6 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -885,6 +885,14 @@ void bdrv_filter_default_perms(BlockDriverState *b=
s, BdrvChild *c,
> >                                 uint64_t perm, uint64_t shared,
> >                                 uint64_t *nperm, uint64_t *nshared);
> > =20
> > +/* Default implementation for BlockDriver.bdrv_child_perm() that can b=
e used by
> > + * (non-raw) image formats: Like above for bs->backing, but for bs->fi=
le it
> > + * requires WRITE | RESIZE for read-write images, always requires
> > + * CONSISTENT_READ and doesn't share WRITE. */
> > +void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> > +                               const BdrvChildRole *role,
> > +                               uint64_t perm, uint64_t shared,
> > +                               uint64_t *nperm, uint64_t *nshared);
> > =20
> >  const char *bdrv_get_parent_name(const BlockDriverState *bs);
> >  void blk_dev_change_media_cb(BlockBackend *blk, bool load);
> >=20
>=20
>=20




--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYpJAFAAoJEH8JsnLIjy/WIbMP/iWi7pZB+luVwZIIsuQBjfga
a1A97qugZCBpZKqhSyyHpKKKueTocfPZSlQ/f4JS/zFIs8RJQ/YTd7pfPjIkOvPQ
OFw2+gH/A4ri95ur4TR0BVpzIc7b2vcJL35yp7js+YxtA+JxvfOV8GyXe8Y7/JAM
J3fe3f1IMHqSwTShIqSrTi1DNw03eoK/rJDP05Wz4iTIkepmm/Bal6Rt2g1zGmWz
+Y96my1JTFyJVLbCgIgSXDi+jOcI/9/+KrfBQ0qQ7S+gpHmTy3i4aLsvEVapi/Ju
mL52hRTihzDpehq/WgCL+nH0IhRT/wJ6WnjZ0cSpH75PwFg0VMH8+G3XqkusgBQO
UPfnNW6g3s7aswh2QmRANl7Pd3VG0il/vNLq6iDHgiqPotTMFFyWWYzEyglUusez
/fuP010kU7/Zff8SRhOl+9HswndeJfZne0MP3pH50wsFOUCEXad1syo0oteWd5+z
d2WCdYled6Y0OXcmA1v2tS/aAnhOstB56VQSFOXpgIGv7TwPiO90hf7ztxMcSXMM
mGpWZRue9LpW1EB1AfvMN18ttjFmrMn6PfHh64TSJMncIWWYA6/CSZC4pu44qUEQ
EyO+oELaeyInTNvuywGQ0Gr8PUsVDEfMKGY/owm8kfrKP/FS7Yn3Xcn6xsnPWuHl
iYSFspu8rdFVCLwbytg8
=XkBl
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
