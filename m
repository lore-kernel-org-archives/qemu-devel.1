Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQYEl-0004Ez-Mt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQYEk-0005CY-M4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:07:55 -0400
Date: Thu, 29 Jun 2017 15:07:41 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170629120741.lkjam3jrlse6jxq2@postretch>
References: <20170629060300.29869-1-el13635@mail.ntua.gr>
	<20170629111824.GC4618@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mh7qhk5fdpvup3o5"
Content-Disposition: inline
In-Reply-To: <20170629111824.GC4618@noname.redhat.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--mh7qhk5fdpvup3o5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 01:18:24PM +0200, Kevin Wolf wrote:
>Am 29.06.2017 um 08:03 hat Manos Pitsidianakis geschrieben:
>> bdrv_open_driver() is called in two places, bdrv_new_open_driver() and
>> bdrv_open_common(). In the latter, failure cleanup in is in its caller,
>> bdrv_open_inherit(), which unrefs the bs->file of the failed driver open
>> if it exists. Let's check for this in bdrv_new_open_driver() as well.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 694396281b..aeacd520e0 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1165,6 +1165,9 @@ BlockDriverState *bdrv_new_open_driver(BlockDriver=
 *drv, const char *node_name,
>>
>>      ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags, er=
rp);
>>      if (ret < 0) {
>> +        if (bs->file !=3D NULL) {
>> +            bdrv_unref_child(bs, bs->file);
>> +        }
>>          QDECREF(bs->explicit_options);
>>          QDECREF(bs->options);
>>          bdrv_unref(bs);
>
>I think we should set bs->file =3D NULL here to remove the dangling
>pointer. I think it is never accessed anyway because of the
>bs->drv =3D NULL in the error path of bdrv_open_driver(), but better safe
>than sorry.

You can't see it in the diff but after bdrv_unref(bs),=20
bdrv_new_open_driver returns NULL so there won't be any access to bs=20
anyway. And since bs is destroyed by bdrv_unref (its refcount is 1),=20
there's not really a point in setting bs->file =3D NULL.

>But what would you think about avoiding the code duplication and just
>moving the bdrv_unref_child() call from bdrv_open_inherit() down to
>bdrv_open_driver(), so that bdrv_new_open_driver() is automatically
>covered?

The result would be the same, but this will cover future callers of=20
bdrv_open_driver. Should I submit a v2?
>
>And later we can maybe move it into the individual .bdrv_open
>implementations where it really belongs (whoever creates something is
>responsible for cleaning it up in error cases).

freeing bs->file was recently removed from individual '.bdrv_open's=20
since bdrv_open_inherit takes care of it=20
(de234897b60e034ba94b307fc289e2dc692c9251). I think this is simpler=20
since a driver could neglect to free their bs->file whereas this is a=20
catchall solution.

>Kevin
>

--mh7qhk5fdpvup3o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllU7Y0ACgkQc2J8L2kN
9xCCXQ//a9IWu7UYB2S0OUclxClk7FK9CSn6aVHIw/o2Pend5X5afeDHDX89TLQ/
Po8cX9NbPf1CvibPVt7A3dbh0CW3BMOq1TyClUjeEGOQ6nU5MZKXRmJWH6yRID/y
e/vfRSr0t/LHP4+MMLXmTNKiTfw73Ey9DP9VC1EaG66LhgIz9zYWyBpO/qAsHtGC
2u6VyAS0cEetbjArwDviRBf2a0u4rdJuG9fp65zbyJRwvMFs6HhMCyzAVKH8JwGi
c7je6ozFh0OaRCETr/QP3kKq6rEivH9V8gGS685q9rJNWwbCpyBRFFXX/9tTXQgL
Dw5HMogahV5ZyQkc8dgxxnpDXpVFmXFKW0QcyXJK55g2JZG9sKbNFsGundGwlBmW
ZR+Eobpk6RE4s+8YMrw/ghPBVC6NH9QrmNMSHACZvScZbZs+xzQlrGOV+MSIxlEi
9MIhM7J7H/JaJBZLFbLUf/c6+RG6YqMNiSkyznoAqgFjOhwRErA65VQWBTzqj8hZ
KeIdOkdq8+B9yzegqw6GXairAlwsjXvQaBZcNaMqvCgXmKdP/U17JhihGG8sGE+N
5jPB0E4mtHG8jdMis+MFW8enEXxrcGWRWWzrYm/urK4oog/6kD7vmeQgmXeCJ9jd
2KOZJbpE4foQZZYjjv47/IUu66Ld8c4b748SY9d5ieS1lhqbwMA=
=yp/W
-----END PGP SIGNATURE-----

--mh7qhk5fdpvup3o5--
