Received: from eggs.gnu.org ([2001:4830:134:3::10]:55700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpLAW-0006cQ-Nq
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpLAR-0002u0-Me
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:14:00 -0400
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
	<20170825132028.6184-7-el13635@mail.ntua.gr>
	<20170905161643.GO4633@localhost.localdomain>
	<20170905190621.GQ4633@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a861d95e-553c-4797-486c-2601c2b6e17b@redhat.com>
Date: Tue, 5 Sep 2017 16:13:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170905190621.GQ4633@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bpmcpxdlAb3ScTIeXchpPDPKcDEO8MoCb"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 6/6] qemu-iotests: add 184
 for throttle filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bpmcpxdlAb3ScTIeXchpPDPKcDEO8MoCb
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <a861d95e-553c-4797-486c-2601c2b6e17b@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 6/6] qemu-iotests: add 184
 for throttle filter driver
References: <20170825132028.6184-1-el13635@mail.ntua.gr>
 <20170825132028.6184-7-el13635@mail.ntua.gr>
 <20170905161643.GO4633@localhost.localdomain>
 <20170905190621.GQ4633@localhost.localdomain>
In-Reply-To: <20170905190621.GQ4633@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 02:06 PM, Kevin Wolf wrote:
> Am 05.09.2017 um 18:16 hat Kevin Wolf geschrieben:
>> Am 25.08.2017 um 15:20 hat Manos Pitsidianakis geschrieben:
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>>
>> Does this test actually (still) pass for you? I can't see that it's
>> related to any recent change in master, but this is the diff that I ge=
t.
>>
>> I can update the reference output while applying, but obviously if it'=
s
>> currently passing for you, it will fail after I "fix" it.
>=20
> For the record, we discussed this on IRC. The test works correctly on
> master, but on my block branch there is a conflict with "block: pass
> bdrv_* methods to bs->file by default in block filters".
>=20
> The correct action is to merge this throttle driver series after the
> conflicting patch because throttle doesn't implement .bdrv_get_info and=

> needs the forwarding that the other patch implements.
>=20
> I updated the test output accordingly and applied the series to my bloc=
k
> branch.

Could you also squash this in to 5/6? (as long as we're intentionally
basing throttle on top of defaults, then we should use the right default
instead of duplicating things)

diff --git i/block/throttle.c w/block/throttle.c
index 7b33613372..5bca76300f 100644
--- i/block/throttle.c
+++ w/block/throttle.c
@@ -197,19 +197,6 @@ static bool
throttle_recurse_is_first_non_filter(BlockDriverState *bs,
     return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
 }

-static int64_t coroutine_fn
throttle_co_get_block_status(BlockDriverState *bs,
-                                                         int64_t
sector_num,
-                                                         int nb_sectors,=

-                                                         int *pnum,
-
BlockDriverState **file)
-{
-    assert(bs->file && bs->file->bs);
-    *pnum =3D nb_sectors;
-    *file =3D bs->file->bs;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
-}
-
 static BlockDriver bdrv_throttle =3D {
     .format_name                        =3D   "throttle",
     .protocol_name                      =3D   "throttle",
@@ -237,7 +224,7 @@ static BlockDriver bdrv_throttle =3D {
     .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
     .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
     .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
-    .bdrv_co_get_block_status           =3D   throttle_co_get_block_stat=
us,
+    .bdrv_co_get_block_status           =3D
bdrv_co_get_block_status_from_file,

     .is_filter                          =3D   true,
 };


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bpmcpxdlAb3ScTIeXchpPDPKcDEO8MoCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvE4MACgkQp6FrSiUn
Q2qtiwgAk7BFR599pketfeEqD41JwP0LOqz5jsGw5POJcz9rQtBz3ZnmzrKAzHk8
Y6bEoQgzFwTm9xNOuiZkCbpWj5Ei3F/0nNjjLGe7qMOZyJDVKRn9kP8BnBhS19cv
U19X3Sgc+QAu70l0+6pXSJ3uZWclvQVy0JXAmA9+o/L/pRBv0xqZ5xmFbqRDtV+6
lm9ho0CLlMrkgUbZzVP55uXFX1KcGo3VjCZlQ8g4Lro7tGb1PZ9mnk1JBvNrn3ys
5+HTZEeF3zQN464iNdCdZYhMCqJKGGJ3TqoiUf+g2xkZhBwpVfk65BBEbbF7W1uJ
16OgDYSb1+UAFCeYO1eIcVz3jSXvFA==
=hwGo
-----END PGP SIGNATURE-----

--bpmcpxdlAb3ScTIeXchpPDPKcDEO8MoCb--
