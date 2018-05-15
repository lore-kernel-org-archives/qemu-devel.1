Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgig-0008SD-Kj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgif-0003dH-ET
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:38:50 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-2-jsnow@redhat.com>
	<79bed3c8-e80e-5f51-5dfc-0d71b1ea66ca@virtuozzo.com>
	<1550da5e-d919-3a90-ff0f-1b764a32050c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d32d3c25-2713-9b3a-e6b3-01ab2a79d5bc@redhat.com>
Date: Tue, 15 May 2018 16:38:43 -0400
MIME-Version: 1.0
In-Reply-To: <1550da5e-d919-3a90-ff0f-1b764a32050c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 01/12] qcow2-bitmap: cache bm_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/14/2018 08:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.05.2018 14:55, Vladimir Sementsov-Ogievskiy wrote:
>> 12.05.2018 04:25, John Snow wrote:
>>> We don't need to re-read this list every time, exactly. We can keep
>>> it cached
>>> and delete our copy when we flush to disk.
>>
>> Why not simply delete cache only on close (unconditionally)? Why do we
>> need to remove it after flush?
>>
>> Actually, I think we need to remove it only in qcow2_inactive, after
>> storing persistent bitmaps.
>>
>>
>>>
>>> Because we don't try to flush bitmaps on close if there's nothing to
>>> flush,
>>> add a new conditional to delete the state anyway for a clean exit.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>> =C2=A0 block/qcow2-bitmap.c | 74
>>> ++++++++++++++++++++++++++++++++--------------------
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>>> =C2=A0 3 files changed, 50 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 6e93ec43e1..fb0a4f3ec4 100644
>>> --- a/block/qcow2-bitmap.c
>>> +++ b/block/qcow2-bitmap.c
>>> @@ -536,8 +536,7 @@ static uint32_t bitmap_list_count(Qcow2BitmapList
>>> *bm_list)
>>> =C2=A0=C2=A0 * Get bitmap list from qcow2 image. Actually reads bitma=
p directory,
>>> =C2=A0=C2=A0 * checks it and convert to bitmap list.
>>> =C2=A0=C2=A0 */
>>> -static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs,
>>> uint64_t offset,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint64_t size, Error **errp)
>>> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error
>>> **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> @@ -545,6 +544,8 @@ static Qcow2BitmapList
>>> *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapDirEntry *e;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nb_dir_entries =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapList *bm_list =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t offset =3D s->bitmap_directory_offset;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t size =3D s->bitmap_directory_size;
>>
>> Worth split this change as a refactoring patch (just remove extra
>> parameters)?
>>
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (size =3D=3D 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(err=
p, "Requested bitmap directory size is zero");
>>> @@ -636,6 +637,30 @@ fail:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> =C2=A0 }
>>> =C2=A0 +static Qcow2BitmapList *get_bitmap_list(BlockDriverState *bs,
>>> Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 Qcow2BitmapList *bm_list;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->bitmap_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (Qcow2BitmapList *=
)s->bitmap_list;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bm_list =3D bitmap_list_load(bs, errp);
>>> +=C2=A0=C2=A0=C2=A0 s->bitmap_list =3D bm_list;
>>> +=C2=A0=C2=A0=C2=A0 return bm_list;
>>> +}
>>> +
>>> +static void del_bitmap_list(BlockDriverState *bs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->bitmap_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_list_free(s->bitma=
p_list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bitmap_list =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>=20
> so, with this functions, we see, that list is always safely loaded
> through the cache. But we need also guarantee, that list is always save=
d
> through the cache. There are a lot of functions, which stores an
> abstract bitmap list, given as a parameter, but we want always store ou=
r
> cache..
>=20

Do you have an example?

These functions return a bitmap list:

bitmap_list_new()
bitmap_list_load(...);
get_bitmap_list(...);


bitmap_list_new creates a new bitmap_list, it's called by
bitmap_list_load and qcow2_store_persistent_dirty_bitmaps.

qcow2_store_persistent_dirty_bitmaps doesn't matter right now because we
drop the cache by the end of that function.

bitmap_list_load is only called by get_bitmap_list now, and
get_bitmap_list caches that bitmap list as s->bitmap_list.


I think any other function that takes a bitmap list must be getting it
from a location where it's cached -- except in store, which trashes it
anyway.

What I can do here is to make get_bitmap_list create a new bitmap list
if s->nb_bitmaps is zero, and remove the new call in store -- then we
can be really very confident that any bitmap list getting passed around
is definitely the cached one.
