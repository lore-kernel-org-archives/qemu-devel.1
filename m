Received: from eggs.gnu.org ([2001:4830:134:3::10]:51361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgXQ-0005hX-IV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIgXP-00081l-Ht
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:27:12 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-2-jsnow@redhat.com>
	<79bed3c8-e80e-5f51-5dfc-0d71b1ea66ca@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <40caf9d3-a522-7fcf-2694-04aca2670790@redhat.com>
Date: Tue, 15 May 2018 16:27:02 -0400
MIME-Version: 1.0
In-Reply-To: <79bed3c8-e80e-5f51-5dfc-0d71b1ea66ca@virtuozzo.com>
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



On 05/14/2018 07:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2018 04:25, John Snow wrote:
>> We don't need to re-read this list every time, exactly. We can keep it
>> cached
>> and delete our copy when we flush to disk.
>=20
> Why not simply delete cache only on close (unconditionally)? Why do we
> need to remove it after flush?
>=20

I was being imprecise with my language again -- I'm doing it on
qcow2_inactivate, through qcow2_store_persistent_dirty_bitmaps.

I technically don't even need to destroy the cache *then*, I could just
do it unconditionally in qcow2_close.

I just felt it was "safer" to drop the cache after a store as a natural
point of synchronization, but it *should* be fine without.

> Actually, I think we need to remove it only in qcow2_inactive, after
> storing persistent bitmaps.
>=20

So would you prefer the unconditional drop on close, or a drop for every
inactivate? You still need a drop on close in that case, because we may
not call inactivate on close, and I am still trying to build the cache
for read only images, so to prevent leaks I need to clean that up.

>=20
>>
>> Because we don't try to flush bitmaps on close if there's nothing to
>> flush,
>> add a new conditional to delete the state anyway for a clean exit.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 block/qcow2-bitmap.c | 74
>> ++++++++++++++++++++++++++++++++--------------------
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>> =C2=A0 3 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 6e93ec43e1..fb0a4f3ec4 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -536,8 +536,7 @@ static uint32_t bitmap_list_count(Qcow2BitmapList
>> *bm_list)
>> =C2=A0=C2=A0 * Get bitmap list from qcow2 image. Actually reads bitmap=
 directory,
>> =C2=A0=C2=A0 * checks it and convert to bitmap list.
>> =C2=A0=C2=A0 */
>> -static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs,
>> uint64_t offset,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint64_t size, Error **errp)
>> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error
>> **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> @@ -545,6 +544,8 @@ static Qcow2BitmapList
>> *bitmap_list_load(BlockDriverState *bs, uint64_t offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapDirEntry *e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nb_dir_entries =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapList *bm_list =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 uint64_t offset =3D s->bitmap_directory_offset;
>> +=C2=A0=C2=A0=C2=A0 uint64_t size =3D s->bitmap_directory_size;
>=20
> Worth split this change as a refactoring patch (just remove extra
> parameters)?
>=20

Sure, this patch looks a little long.
