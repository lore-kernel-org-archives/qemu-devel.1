Received: from eggs.gnu.org ([2001:4830:134:3::10]:45075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgzCs-00007s-67
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fgzCq-0008UO-Vk
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 17:14:26 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-3-mreitz@redhat.com>
	<b9375698-49bd-cb9a-432a-94f139d49ec7@tuxera.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e2c8248-908a-7ca0-2236-e8ebe8985b5c@redhat.com>
Date: Sat, 21 Jul 2018 23:14:16 +0200
MIME-Version: 1.0
In-Reply-To: <b9375698-49bd-cb9a-432a-94f139d49ec7@tuxera.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wI4fT7TkReW1bduApSuXWHLZSJ0YJNqqS"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 02/31] block: Use children
 list in bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wI4fT7TkReW1bduApSuXWHLZSJ0YJNqqS
From: Max Reitz <mreitz@redhat.com>
To: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8e2c8248-908a-7ca0-2236-e8ebe8985b5c@redhat.com>
Subject: Re: [Qemu-block] [PATCH v9 02/31] block: Use children list in
 bdrv_refresh_filename
References: <20180628000745.4477-1-mreitz@redhat.com>
 <20180628000745.4477-3-mreitz@redhat.com>
 <b9375698-49bd-cb9a-432a-94f139d49ec7@tuxera.com>
In-Reply-To: <b9375698-49bd-cb9a-432a-94f139d49ec7@tuxera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-19 14:47, Ari Sundholm wrote:
> Hi!
>=20
> On 06/28/2018 03:07 AM, Max Reitz wrote:
>> bdrv_refresh_filename() should invoke itself recursively on all
>> children, not just on file.
>>
>> With that change, we can remove the manual invocations in blkverify,
>> quorum, commit, and mirror.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 9 +++++----
>> =C2=A0 block/blkverify.c | 3 ---
>> =C2=A0 block/commit.c=C2=A0=C2=A0=C2=A0 | 1 -
>> =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0 | 1 -
>> =C2=A0 block/quorum.c=C2=A0=C2=A0=C2=A0 | 1 -
>> =C2=A0 5 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index e418c97423..52247062d5 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5174,16 +5174,17 @@ static bool append_open_options(QDict *d,
>> BlockDriverState *bs)
>> =C2=A0 void bdrv_refresh_filename(BlockDriverState *bs)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *opts;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!drv) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* This BDS's file name will most probably =
depend on its file's
>> name, so
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * refresh that first */
>> -=C2=A0=C2=A0=C2=A0 if (bs->file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->=
file->bs);
>> +=C2=A0=C2=A0=C2=A0 /* This BDS's file name may depend on any of its c=
hildren's file
>> names, so
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * refresh those first */
>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs->children, next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(chil=
d->bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv->bdrv_refresh_filename) =
{
>> diff --git a/block/blkverify.c b/block/blkverify.c
>> index da97ee5927..4a18baaf20 100644
>> --- a/block/blkverify.c
>> +++ b/block/blkverify.c
>> @@ -285,9 +285,6 @@ static void
>> blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVBlkverifyState *s =3D bs->opaque;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* bs->file->bs has already been refreshed =
*/
>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(s->test_file->bs);
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->file->bs->full_open_options
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->test_file=
->bs->full_open_options)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> diff --git a/block/commit.c b/block/commit.c
>> index e1814d9693..26db55d800 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -234,7 +234,6 @@ static int coroutine_fn
>> bdrv_commit_top_preadv(BlockDriverState *bs,
>> =C2=A0 =C2=A0 static void bdrv_commit_top_refresh_filename(BlockDriver=
State *bs,
>> QDict *opts)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->backing->bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs->=
exact_filename),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bs->backing->bs->filename);
>> =C2=A0 }
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 61bd9f3cf1..2f5ccae2b1 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1421,7 +1421,6 @@ static void
>> bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_se=
t_backing_hd */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->backing->bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs->=
exact_filename),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bs->backing->bs->filename);
>> =C2=A0 }
>> diff --git a/block/quorum.c b/block/quorum.c
>> index 9152da8c58..03388590f3 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -1080,7 +1080,6 @@ static void
>> quorum_refresh_filename(BlockDriverState *bs, QDict *options)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->num_childre=
n; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(s->c=
hildren[i]->bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->childre=
n[i]->bs->full_open_options) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20
> Should blklogwrites not also receive the same treatment?

Probably, but how could I have known before blklogwrites was in? :-)

Max


--wI4fT7TkReW1bduApSuXWHLZSJ0YJNqqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltToigACgkQ9AfbAGHV
z0CK7wf+MDYfps3pdjRD/UUTb54AkaApcveKtvk8UYtpL27jT0QaOTRaVUNBz94j
gIooeUJi+7odz+3FJn/+/klrfTBiE6en1ojEQBrYBXuuZiu3y27zLJ7ceY0SERN9
7uHQ+8P9X2jX0R30AzCVUpJk/DJEQ9NH6PIPI+4Kyr5f6QrN0+M8nNzb6ADPvGeC
1NRtOrWgn4Nf0xpJ3LkQO4Z67w5C45dzJgwlY3TxvChrY+o4RJ0jGqceynsykdDM
SXvg/b0LUa1ugHchUDgZ/29c4xhJTfU7JNQvfqn7rNCiri6i7dxt5SoSSwu18aDw
Kw/kk110z9ari55jAdVgrbSAHafoww==
=t1DC
-----END PGP SIGNATURE-----

--wI4fT7TkReW1bduApSuXWHLZSJ0YJNqqS--
