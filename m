Received: from eggs.gnu.org ([2001:4830:134:3::10]:37334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQfiR-0006kv-EB
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQfiQ-0000GE-Ak
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:07:03 -0400
Date: Thu, 29 Jun 2017 23:06:13 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170629200613.u7cu3gr4uakqtgc4@postretch>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<20170629111824.GC4618@noname.redhat.com>
	<20170629120741.lkjam3jrlse6jxq2@postretch>
	<20170629135749.GD4618@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bppj665x3rrjvdz"
Content-Disposition: inline
In-Reply-To: <20170629135749.GD4618@noname.redhat.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--2bppj665x3rrjvdz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 03:57:49PM +0200, Kevin Wolf wrote:
>Am 29.06.2017 um 14:07 hat Manos Pitsidianakis geschrieben:
>> On Thu, Jun 29, 2017 at 01:18:24PM +0200, Kevin Wolf wrote:
>> >Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
>> >>bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
>> >>bdrv_open_common(). In the latter, failure cleanup in is in its caller,
>> >>bdrv_open_inherit(), which unrefs the bs->file of the failed driver op=
en
>> >>if it exists. Let's check for this in bdrv_new_open_driver() as well.
>> >>
>> >>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> >>---
>> >> block.c | 3 +++
>> >> 1 file changed, 3 insertions(+)
>> >>
>> >>diff --git a/block.c b/block.c
>> >>index 694396281b..aeacd520e0 100644
>> >>--- a/block.c
>> >>+++ b/block.c
>> >>@@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriv=
er *drv, const char *node_name,
>> >>
>> >>     ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags, =
errp);
>> >>     if (ret < 0) {
>> >>+        if (bs->file !=3D NULL) {
>> >>+            bdrv_unref_child(bs, bs->file);
>> >>+        }
>> >>         QDECREF(bs->explicit_options);
>> >>         QDECREF(bs->options);
>> >>         bdrv_unref(bs);
>> >
>> >I think we should set bs->file =3D NULL here to remove the dangling
>> >pointer. I think it is never accessed anyway because of the
>> >bs->drv =3D NULL in the error path of bdrv_open_driver(), but better sa=
fe
>> >than sorry.
>>
>> You can't see it in the diff but after bdrv_unref(bs),
>> bdrv_new_open_driver returns NULL so there won't be any access to bs
>> anyway. And since bs is destroyed by bdrv_unref (its refcount is 1),
>> there's not really a point in setting bs->file =3D NULL.
>
>Yes, but bdrv_unref() doesn't have to expect inconsistent BDSes. It
>doesn't access bs->file currently when bs->drv =3D=3D NULL, but that's more
>by luck than by design.
>
>> >But what would you think about avoiding the code duplication and just
>> >moving the bdrv_unref_child() call from bdrv_open_inherit() down to
>> >bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
>> >covered?
>>
>> The result would be the same, but this will cover future callers of
>> bdrv_open_driver. Should I submit a v2?
>
>I would prefer this, yes.

Perhaps it would be better to destroy bs at failure in bdrv_open_driver=20
and not leave it to the caller which takes care of bdrv_close and=20
unrefing bs->file anyway (Also bs->children). Setting bs->drv to NULL at=20
failure in bdrv_open_driver means some things won't be executed in=20
bdrv_close when the bs is destroyed eventually as well, so that fixes=20
another mistake.

--2bppj665x3rrjvdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllVXbUACgkQc2J8L2kN
9xC09A//WpytOvqo6C4plFi1Qh4WMwY2d3EB6TuQB9GPOcQP4Z5sag6ecTdZCm8C
ZhYQpFwjmtHMKmaF6nIL+8gse2YDu8awTjvh2//qfa7GcUQn1u2v9fqQhSmh9V5r
YSHqAz7Wd3SVQSjdnh6Ik/CmfehAx1q+1duUynsl89PiuOZbDZLveCvUdnbdBHoC
OIjghUGSGsMTqqHxyKGLeQvlPg00q77aIJAh4rGgbz5C476Y0CvsmRMIhWFCc92x
kUS66b7bH2AJCm3bHzwl74ti0IGzAvLHI+ZO8vlSA3p+tlV5+4i6CaNSGYBtwTTS
oPOwdzUq16AcIo4dPKjmQR51xGT9fjYnRZ6Mj1xlKI3ZdP1XuYTFsKwdDpZl7/6H
v/ybq045e5U1cSOJ18OZWDC9FVpYf0gHOhp56CVBWvfVF5IA3ifUyzCrhP+V9v+v
PXl9ytcSrCPQo3sL1PMV3wXjllacV7+hY5nzp+EGPyjvnwG6qjE2E6BoSSZciFPt
xkN6WhU+tAQ5LoqpBYJT8w+pBlkw/M/BlIi4m2iko4ab1suwzeUirnr1gpj8cD5e
f1v2zBfh4EhE3ogP1bFJP9UsiphdXrH8xbnzhyF+fYn0T/XqKFf+14BFJnk26WPv
eJsQz0N0rwuGMpQPEb7WyZKQVr+JSfBXKeY6Nepk890nUtP2Qdo=
=UwVQ
-----END PGP SIGNATURE-----

--2bppj665x3rrjvdz--
