Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQZxS-0007ry-Jn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQZxP-0001cu-Iw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:58:10 -0400
Date: Thu, 29 Jun 2017 15:57:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170629135749.GD4618@noname.redhat.com>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<20170629111824.GC4618@noname.redhat.com>
	<20170629120741.lkjam3jrlse6jxq2@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20170629120741.lkjam3jrlse6jxq2@postretch>
Subject: Re: [Qemu-devel] [PATCH] block: fix bs->file leak in
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.06.2017 um 14:07 hat Manos Pitsidianakis geschrieben:
> On Thu, Jun 29, 2017 at 01:18:24PM +0200, Kevin Wolf wrote:
> >Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
> >>bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
> >>bdrv_open_common(). In the latter, failure cleanup in is in its caller,
> >>bdrv_open_inherit(), which unrefs the bs->file of the failed driver open
> >>if it exists. Let's check for this in bdrv_new_open_driver() as well.
> >>
> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >>---
> >> block.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >>diff --git a/block.c b/block.c
> >>index 694396281b..aeacd520e0 100644
> >>--- a/block.c
> >>+++ b/block.c
> >>@@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDrive=
r *drv, const char *node_name,
> >>
> >>     ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags, e=
rrp);
> >>     if (ret < 0) {
> >>+        if (bs->file !=3D NULL) {
> >>+            bdrv_unref_child(bs, bs->file);
> >>+        }
> >>         QDECREF(bs->explicit_options);
> >>         QDECREF(bs->options);
> >>         bdrv_unref(bs);
> >
> >I think we should set bs->file =3D NULL here to remove the dangling
> >pointer. I think it is never accessed anyway because of the
> >bs->drv =3D NULL in the error path of bdrv_open_driver(), but better safe
> >than sorry.
>=20
> You can't see it in the diff but after bdrv_unref(bs),
> bdrv_new_open_driver returns NULL so there won't be any access to bs
> anyway. And since bs is destroyed by bdrv_unref (its refcount is 1),
> there's not really a point in setting bs->file =3D NULL.

Yes, but bdrv_unref() doesn't have to expect inconsistent BDSes. It
doesn't access bs->file currently when bs->drv =3D=3D NULL, but that's more
by luck than by design.

> >But what would you think about avoiding the code duplication and just
> >moving the bdrv_unref_child() call from bdrv_open_inherit() down to
> >bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
> >covered?
>=20
> The result would be the same, but this will cover future callers of
> bdrv_open_driver. Should I submit a v2?

I would prefer this, yes.

> >And later we can maybe move it into the individual .bdrv_open
> >implementations where it really belongs (whoever creates something is
> >responsible for cleaning it up in error cases).
>=20
> freeing bs->file was recently removed from individual '.bdrv_open's
> since bdrv_open_inherit takes care of it
> (de234897b60e034ba94b307fc289e2dc692c9251). I think this is simpler
> since a driver could neglect to free their bs->file whereas this is
> a catchall solution.

That commit just changed an inconsistent situation where some drivers
did free it and other didn't. But we don't have to move it into the
drivers, it's just an option. As long as bs->file is special cased for
many other things, too, keeping it centrally might make sense.

Kevin

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZVQddAAoJEH8JsnLIjy/WEtQQAJRVCaQyoqJOTBTJf7M+9xn7
ZpmSD5v49TL30wr7Lu6WRuxBu4MKTjq98TjhkyUmG27EPC7JElwwHuImPyxJGp71
uG21ach503t1uTCk210mZesw03sOBJl3AvDQKwY+0PG+NVtgs+5RERtLa/S85anL
9B7UzTptRwC0HS/+UgfC+mXLWF6IZvu7yY6iiVS5284BnSLHbqllYPfDGF6JEt2T
Gt9uJddf9RGYzvvLdCbw0IICIOByJT9iEkX5WsNgfqRssgRqFbnGagnsYJt8F8jN
JjpeXSdTlA2fa+c71g5bblB9oUEARIjAnf5x3zt5FWpPIqjNBgMF+ZhKGDw0QpqH
xq3DwIqmhsjmh2SRnsGT1eycgG2dXMAzitpRmgXxQdYSNiml1VnXLSlbus/Walo6
fk/aab4bY3PkRZC85KBlmLYx9Kizz1Hkl1OIzgt91JPavNiRyGRbhJARWt3hpd4U
orp80ujdY9+BupsTJ2RW4rQtu9ydr1V5AFRY/wT4KWP8YVClfGMbNwEJjcb0xB1R
SrrS0Laix/YUHmv1tKO4K7w8QkMuGBCW0/m03C6ijDyK78Te+vVf/JjTc+Ch2Bq9
Grsw6blyGeI3cFrzXgBfZSbs8CIBWDWELmqGeEC5ZCZynUHSRoBzwJfDA7fCfVLd
8z72u2xJAWRMylJOIcAN
=/SJx
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
