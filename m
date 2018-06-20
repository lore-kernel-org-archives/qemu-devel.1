Received: from eggs.gnu.org ([2001:4830:134:3::10]:48562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVmXW-0001qf-3N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVmXU-0007Md-Ht
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:26 -0400
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-4-jsnow@redhat.com>
	<f3332ec8-5370-fecc-b0ae-4834d0eb28b7@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8df85931-08ab-d89d-5e26-10f5054a9357@redhat.com>
Date: Wed, 20 Jun 2018 19:29:18 -0400
MIME-Version: 1.0
In-Reply-To: <f3332ec8-5370-fecc-b0ae-4834d0eb28b7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/10] qcow2/bitmap: cache bm_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/20/2018 09:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2018 05:06, John Snow wrote:
>> We don't need to re-read this list every time, exactly. We can keep it
>> cached
>> and delete our copy when we flush to disk.
>>
>> Because we don't try to flush bitmaps on close if there's nothing to
>> flush,
>> add a new conditional to delete the state anyway for a clean exit.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 block/qcow2-bitmap.c | 74
>> ++++++++++++++++++++++++++++++++++------------------
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
>> =C2=A0 3 files changed, 52 insertions(+), 26 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 85c1b5afe3..5ae9b17928 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -636,6 +636,34 @@ fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0 }
>> =C2=A0 +static Qcow2BitmapList *get_bitmap_list(BlockDriverState *bs, =
Error
>> **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> +=C2=A0=C2=A0=C2=A0 Qcow2BitmapList *bm_list;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (s->bitmap_list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (Qcow2BitmapList *)=
s->bitmap_list;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (s->nb_bitmaps) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bm_list =3D bitmap_list_lo=
ad(bs, errp);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bm_list =3D bitmap_list_ne=
w();
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 s->bitmap_list =3D bm_list;
>=20
> may be, we shouldn't cache it in inactive mode. However, I think we'll
> finally will not load bitmaps in inactive mode and drop the on
> inactivate, so it would not matter..
>=20

Do we not load bitmaps when BDRV_O_INACTIVE is set? it looks like we do?

(From your subsequent email):
>
> really, now it would be a problem: we can start in inactive mode, load
> nothing, and then we can't reload bitmaps; my fix in
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg03254.html
> will not work after this patch.
>

So we load nothing because when we opened up the image RO, saw IN_USE
bitmaps (or saw none at all) and decided not to load them. qcow2_do_open
however marks that it has "loaded the bitmaps."

Later, when we reopen RW, we have a cached bm_list that doesn't include
this bitmap, so we don't mark it as IN_USE again or update the header.

(Wait, if you are worried about the bitmap's data having been changed,
why do we not reload the bitmap data here too?)


Now, patch 06 changes the cache so that we load all bitmaps and not just
ones not IN_USE. On RW reload, I reject any such IN_USE bitmaps as a
reason to prohibit the RW reload. However, this is broken too, because I
will miss any new flags that exist on-disk, so this function should
never use the cached data.

I'm confused, though, the comment that calls reopen_bitmaps_rw_hint says:

"It's some kind of reopen. There are no known cases where we need to
reload bitmaps in such a situation, so it's safer to skip them.
Moreover, if we have some readonly bitmaps and we are reopening for rw
we should reopen bitmaps correspondingly."

Why do we assume that bitmap data cannot change while BDRV_O_INACTIVATE
is set? Is that not wrong?

> Hm, I've understood the following problem: cache becomes incorrect afte=
r
> failed update_ext_header_and_dir or update_ext_header_and_dir_in_place
> operations. (after failed qcow2_remove_persistent_dirty_bitmap or
> qcow2_reopen_bitmaps_rw_hint)
>=20
> And this comes from incomplete architecture after the patch:
> On the one hand, we work with one singleton bitmap_list, and loading
> part is refactored to do it safely. On the other hand, storing function=
s
> still have old behavior, they work with bitmap list like with their own
> local variable.

Yeah, I see it. Dropping the cache on such errors is fine.

>=20
> So, we have safe mechanism to read list through the cache. We need also
> safe mechanism to update list both in cache and in file.
>=20
> There are two possible variants:
>=20
> 1. drop cache after failed store
> 2. rollback cache after failed store
>=20
> 1 looks simpler..
>=20
> Also, we should drop cache on inactivate (we do this) and should not
> create cache in inactive mode, because the other process may change the
> image.
>=20
> Hm. may be, it is better to work with s->bitmap_list directly? In this
> case it will be more obvious that it is the cache, not local variable.
> And we will work with it like with other "parts of extension cache"
> s->nb_bitmaps, s->bitmap_directory_offset ...
>=20
> After the patch, functions update_ext_header_and_dir* becomes strange:
>=20
> 1. before the patch, they take external parameter - bm_list, and by thi=
s
> parameter they updated the file and cached s->nb_bitmaps, s->bitmap_*, =
..
> 2. after the patch, they take parameter (actually s->bitmap_list) of
> same nature like s->nb_bitmap, and update s->nb_bitmap from it.
>=20

Yeah, if we do decide that keeping a cache is the right thing, some of
the helper functions could be refactored or simplified a little to take
advantage of the new paradigm.

> Sorry for being late and for disordered stream of thoughts. Is this
> patch really needed for the whole series?
>=20

The nice part is to have bm_list with pointers that correlate directly
to the in-memory bitmaps.

I can load bm_list on demand later for the purposes of `qemu-img info`,
but I have to look up the in-memory bitmaps again too. It seemed simpler
to just preserve the data the first time we build it instead of
rebuilding it all the time.

I think that we'll eventually want a cache either way, but maybe I am
still underestimating how difficult it is to do correctly... I think I
need to understand inactivate/invalidate a little more carefully before
I trudge ahead here ...
