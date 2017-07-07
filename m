Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTPYo-00085o-FX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTPYn-0008Fj-De
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:28:26 -0400
Date: Fri, 7 Jul 2017 11:28:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170707092815.GB5027@noname.redhat.com>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<20170629111824.GC4618@noname.redhat.com>
	<20170629120741.lkjam3jrlse6jxq2@postretch>
	<20170629135749.GD4618@noname.redhat.com>
	<20170629200613.u7cu3gr4uakqtgc4@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20170629200613.u7cu3gr4uakqtgc4@postretch>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.06.2017 um 22:06 hat Manos Pitsidianakis geschrieben:
> On Thu, Jun 29, 2017 at 03:57:49PM +0200, Kevin Wolf wrote:
> >Am 29.06.2017 um 14:07 hat Manos Pitsidianakis geschrieben:
> >>On Thu, Jun 29, 2017 at 01:18:24PM +0200, Kevin Wolf wrote:
> >>>Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
> >>>>bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
> >>>>bdrv_open_common(). In the latter, failure cleanup in is in its calle=
r,
> >>>>bdrv_open_inherit(), which unrefs the bs->file of the failed driver o=
pen
> >>>>if it exists. Let's check for this in bdrv_new_open_driver() as well.
> >>>>
> >>>>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> >>>>---
> >>>> block.c | 3 +++
> >>>> 1 file changed, 3 insertions(+)
> >>>>
> >>>>diff --git a/block.c b/block.c
> >>>>index 694396281b..aeacd520e0 100644
> >>>>--- a/block.c
> >>>>+++ b/block.c
> >>>>@@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDri=
ver *drv, const char *node_name,
> >>>>
> >>>>     ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags,=
 errp);
> >>>>     if (ret < 0) {
> >>>>+        if (bs->file !=3D NULL) {
> >>>>+            bdrv_unref_child(bs, bs->file);
> >>>>+        }
> >>>>         QDECREF(bs->explicit_options);
> >>>>         QDECREF(bs->options);
> >>>>         bdrv_unref(bs);
> >>>
> >>>I think we should set bs->file =3D NULL here to remove the dangling
> >>>pointer. I think it is never accessed anyway because of the
> >>>bs->drv =3D NULL in the error path of bdrv_open_driver(), but better s=
afe
> >>>than sorry.
> >>
> >>You can't see it in the diff but after bdrv_unref(bs),
> >>bdrv_new_open_driver returns NULL so there won't be any access to bs
> >>anyway. And since bs is destroyed by bdrv_unref (its refcount is 1),
> >>there's not really a point in setting bs->file =3D NULL.
> >
> >Yes, but bdrv_unref() doesn't have to expect inconsistent BDSes. It
> >doesn't access bs->file currently when bs->drv =3D=3D NULL, but that's m=
ore
> >by luck than by design.
> >
> >>>But what would you think about avoiding the code duplication and just
> >>>moving the bdrv_unref_child() call from bdrv_open_inherit() down to
> >>>bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
> >>>covered?
> >>
> >>The result would be the same, but this will cover future callers of
> >>bdrv_open_driver. Should I submit a v2?
> >
> >I would prefer this, yes.
>=20
> Perhaps it would be better to destroy bs at failure in
> bdrv_open_driver and not leave it to the caller which takes care of
> bdrv_close and unrefing bs->file anyway (Also bs->children). Setting
> bs->drv to NULL at failure in bdrv_open_driver means some things
> won't be executed in bdrv_close when the bs is destroyed eventually
> as well, so that fixes another mistake.

Oh, didn't I reply here yet? Your suggestion sounds good to me.

Kevin

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZX1QuAAoJEH8JsnLIjy/W0DkP/01xKNA4QBHevc0Lhr0D6+/e
9lcuQU9Qzym8v/EZ4YYKvE0l/qzdbw4S9dO+9/uJVUClMTntj/Ty0eMOqssXvXPt
D5Qg0F5FzQPlZXqBPcvOKnu0kER7xLRm81h+f1Oz5RB0HvwiToWMYP3Ve2FxFEFl
WD9yzj9/uavZWkqKHGciafGFsNkpUY/t7SNKHdE25j+oE47CKXIsZDvGBcrNMGrj
dZ+o14t4HyiIRvlTtw7R/pTkngsixbIOvF/HZPhRqJaOHgdUZeUDJOwNPmtq13wM
fH9wBT0buDAcZzuvnDAealb0GixJFOJkt+M5mvyMBih1TbJlV2QQdVhtbvip3uXE
lHylNQoWvMEV/Jo8gCSD7jQWvpq+ABXnAtaH7NyJNLxxEoG+/GyqaKqPWAnDwEyP
dtp/nZ/KePGTB+YrSXlZ/HycAbc58a02z4JwwIVFbdXKMGWeTGIMOMZg/g8GurN8
DCAjxsobW9e6hQzRw/vzslWOHW+vAPUEroNlKedIb3Bw2YjrRcykVLpKpqiOvQJz
G5ZkDUTDmR0fv/H7B7xtG4DvHPolH2C4mHWfj2w+ZXm5TinytIqWvkA0o1ZJlZX/
du1k14IbbDD/j0vwiX1sFXKIGt9Rj+jZpolW5VrAjeexuha1QkHxrQ8P9fKgsndy
790vARnLh9GiApuOKoiJ
=IBQo
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
