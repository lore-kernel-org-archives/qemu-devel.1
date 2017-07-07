Received: from eggs.gnu.org ([2001:4830:134:3::10]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dTPyK-0004sa-Ad
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dTPyJ-0005Jw-5X
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:54:48 -0400
Date: Fri, 7 Jul 2017 12:53:55 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170707095355.upel5lfe6lay666c@postretch>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<20170629111824.GC4618@noname.redhat.com>
	<20170629120741.lkjam3jrlse6jxq2@postretch>
	<20170629135749.GD4618@noname.redhat.com>
	<20170629200613.u7cu3gr4uakqtgc4@postretch>
	<20170707092815.GB5027@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nkneqfxl4zrwsevk"
Content-Disposition: inline
In-Reply-To: <20170707092815.GB5027@noname.redhat.com>
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


--nkneqfxl4zrwsevk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 11:28:15AM +0200, Kevin Wolf wrote:
>Am 29.06.2017 um 22:06 hat Manos Pitsidianakis geschrieben:
>> On Thu, Jun 29, 2017 at 03:57:49PM +0200, Kevin Wolf wrote:
>> >Am 29.06.2017 um 14:07 hat Manos Pitsidianakis geschrieben:
>> >>On Thu, Jun 29, 2017 at 01:18:24PM +0200, Kevin Wolf wrote:
>> >>>Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
>> >>>>bdrv_open_driver() is called in two places, bdrv_new_open_driver() a=
nd
>> >>>>bdrv_open_common(). In the latter, failure cleanup in is in its call=
er,
>> >>>>bdrv_open_inherit(), which unrefs the bs->file of the failed driver =
open
>> >>>>if it exists. Let's check for this in bdrv_new_open_driver() as well.
>> >>>>
>> >>>>Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> >>>>---
>> >>>> block.c | 3 +++
>> >>>> 1 file changed, 3 insertions(+)
>> >>>>
>> >>>>diff --git a/block.c b/block.c
>> >>>>index 694396281b..aeacd520e0 100644
>> >>>>--- a/block.c
>> >>>>+++ b/block.c
>> >>>>@@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDr=
iver *drv, const char *node_name,
>> >>>>
>> >>>>     ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags=
, errp);
>> >>>>     if (ret < 0) {
>> >>>>+        if (bs->file !=3D NULL) {
>> >>>>+            bdrv_unref_child(bs, bs->file);
>> >>>>+        }
>> >>>>         QDECREF(bs->explicit_options);
>> >>>>         QDECREF(bs->options);
>> >>>>         bdrv_unref(bs);
>> >>>
>> >>>I think we should set bs->file =3D NULL here to remove the dangling
>> >>>pointer. I think it is never accessed anyway because of the
>> >>>bs->drv =3D NULL in the error path of bdrv_open_driver(), but better =
safe
>> >>>than sorry.
>> >>
>> >>You can't see it in the diff but after bdrv_unref(bs),
>> >>bdrv_new_open_driver returns NULL so there won't be any access to bs
>> >>anyway. And since bs is destroyed by bdrv_unref (its refcount is 1),
>> >>there's not really a point in setting bs->file =3D NULL.
>> >
>> >Yes, but bdrv_unref() doesn't have to expect inconsistent BDSes. It
>> >doesn't access bs->file currently when bs->drv =3D=3D NULL, but that's =
more
>> >by luck than by design.
>> >
>> >>>But what would you think about avoiding the code duplication and just
>> >>>moving the bdrv_unref_child() call from bdrv_open_inherit() down to
>> >>>bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
>> >>>covered?
>> >>
>> >>The result would be the same, but this will cover future callers of
>> >>bdrv_open_driver. Should I submit a v2?
>> >
>> >I would prefer this, yes.
>>
>> Perhaps it would be better to destroy bs at failure in
>> bdrv_open_driver and not leave it to the caller which takes care of
>> bdrv_close and unrefing bs->file anyway (Also bs->children). Setting
>> bs->drv to NULL at failure in bdrv_open_driver means some things
>> won't be executed in bdrv_close when the bs is destroyed eventually
>> as well, so that fixes another mistake.
>
>Oh, didn't I reply here yet? Your suggestion sounds good to me.

I ended up sending a v2 some days ago, and instead just not setting=20
bs->drv to NULL unless open failed which I think is cleaner.

https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg00019.html

The open's ret value is stored in a boolean, but probably would be=20
better to goto a specific open_fail label. If you think the change is ok=20
I will resend it.

--nkneqfxl4zrwsevk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllfWjMACgkQc2J8L2kN
9xACrw/9EZpykTRkVJCtz7NLUVR+Z+RyYOEfli4o08iCCCBS3eS14nJ9YuTtQY+9
9dkPS4+fJ/rA99frsBEL5CY5l5EZgJTkTrOcjl29GsZO+O9EYYx8ce1acDwz7eE1
onjMhdQ1d2zIq77j4NdC44b9Bg3Ro73MEAglfM9RObBHb/HDInj38WMfm8u1w/FC
5Ri7CEEI/KzpkjXPnmMYfJa4f7GmbV9mKvyaG1U6gj2T/DO4BDgwynvJs/cpEYBT
WWnwArtuvUOf0lqPPEK7NZJZxKwZxlVBoToNYoep4fREpjLOfanQQQmvCvKWQwgY
vj1z/0eSTxo236f4RkaiYWqOfAGMHE3rD7iqOCVMl05Ivk1/139aV13hVEb1hzya
PZZkQp2w0+10bMRZFo5I1xuqdXATregXWtStds/dicZrw2FLYSojhU3Gs9JIzG86
OISpSfHEUEaFpIHsLxX+X0yUrWOHLQWs7eSfyVbFjfEpcCEWHh7Y8lx2hFH/xN11
II4eYlsWVcf61Z2tbwjIMzlE0b5I4mvRhr/mPKwdaVVXuUN+fVwtXEPW/1RsUQeF
4xN43rB93BLnEAftANG5vYurSnq3WIAjtIxoSIirs7N6M6E7wpgg3+Ltl7XxgAY9
SqN/ZScARPh39j+trw9qEglvrj2Noo3N90jNNYgWRz1gaQQCix4=
=Effz
-----END PGP SIGNATURE-----

--nkneqfxl4zrwsevk--
