Received: from eggs.gnu.org ([2001:4830:134:3::10]:34363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fhZkU-0008KO-UW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fhZkT-0004jg-Qr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:15:34 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-3-mreitz@redhat.com>
	<b9375698-49bd-cb9a-432a-94f139d49ec7@tuxera.com>
	<8e2c8248-908a-7ca0-2236-e8ebe8985b5c@redhat.com>
From: Ari Sundholm <ari@tuxera.com>
Message-ID: <39af7f39-db2d-5c86-6ee6-359745f108b8@tuxera.com>
Date: Mon, 23 Jul 2018 15:15:19 +0300
MIME-Version: 1.0
In-Reply-To: <8e2c8248-908a-7ca0-2236-e8ebe8985b5c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 07/22/2018 12:14 AM, Max Reitz wrote:
> On 2018-07-19 14:47, Ari Sundholm wrote:
>> Hi!
>>
>> On 06/28/2018 03:07 AM, Max Reitz wrote:
>>> bdrv_refresh_filename() should invoke itself recursively on all
>>> children, not just on file.
>>>
>>> With that change, we can remove the manual invocations in blkverify,
>>> quorum, commit, and mirror.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 9 +++++----
>>>  =C2=A0 block/blkverify.c | 3 ---
>>>  =C2=A0 block/commit.c=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 block/mirror.c=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 block/quorum.c=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 5 files changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block.c b/block.c
>>> index e418c97423..52247062d5 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -5174,16 +5174,17 @@ static bool append_open_options(QDict *d,
>>> BlockDriverState *bs)
>>>  =C2=A0 void bdrv_refresh_filename(BlockDriverState *bs)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *opts;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!drv) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 /* This BDS's file name will most probabl=
y depend on its file's
>>> name, so
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * refresh that first */
>>> -=C2=A0=C2=A0=C2=A0 if (bs->file) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs-=
>file->bs);
>>> +=C2=A0=C2=A0=C2=A0 /* This BDS's file name may depend on any of its =
children's file
>>> names, so
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * refresh those first */
>>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs->children, next) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(chi=
ld->bs);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv->bdrv_refresh_filename=
) {
>>> diff --git a/block/blkverify.c b/block/blkverify.c
>>> index da97ee5927..4a18baaf20 100644
>>> --- a/block/blkverify.c
>>> +++ b/block/blkverify.c
>>> @@ -285,9 +285,6 @@ static void
>>> blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVBlkverifyState *s =3D bs->opaque;
>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 /* bs->file->bs has already been refreshe=
d */
>>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(s->test_file->bs);
>>> -
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->file->bs->full_open_options
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 && s->test_fi=
le->bs->full_open_options)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> diff --git a/block/commit.c b/block/commit.c
>>> index e1814d9693..26db55d800 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>> @@ -234,7 +234,6 @@ static int coroutine_fn
>>> bdrv_commit_top_preadv(BlockDriverState *bs,
>>>  =C2=A0 =C2=A0 static void bdrv_commit_top_refresh_filename(BlockDriv=
erState *bs,
>>> QDict *opts)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->backing->bs);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs=
->exact_filename),
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bs->backing->bs->filename);
>>>  =C2=A0 }
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 61bd9f3cf1..2f5ccae2b1 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -1421,7 +1421,6 @@ static void
>>> bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_=
set_backing_hd */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(bs->backing->bs);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pstrcpy(bs->exact_filename, sizeof(bs=
->exact_filename),
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bs->backing->bs->filename);
>>>  =C2=A0 }
>>> diff --git a/block/quorum.c b/block/quorum.c
>>> index 9152da8c58..03388590f3 100644
>>> --- a/block/quorum.c
>>> +++ b/block/quorum.c
>>> @@ -1080,7 +1080,6 @@ static void
>>> quorum_refresh_filename(BlockDriverState *bs, QDict *options)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->num_child=
ren; i++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_filename(s->=
children[i]->bs);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->child=
ren[i]->bs->full_open_options) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>> Should blklogwrites not also receive the same treatment?
>=20
> Probably, but how could I have known before blklogwrites was in? :-)
>=20

Sorry about that. I realized my mistake soon after sending my message. :)

My excuse is that the threaded view in my Thunderbird showed the series=20
among new ones (due to a recent "ping" message in the thread), and I=20
didn't immediately notice from the timestamps that the series itself had=20
been sent much earlier.

Best regards,
Ari Sundholm
ari@tuxera.com
