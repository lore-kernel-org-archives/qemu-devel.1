Received: from eggs.gnu.org ([2001:4830:134:3::10]:38185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0POm-0004TP-SZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0POl-00009M-UU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:30:44 -0400
References: <20180323164254.26487-2-pbonzini@redhat.com>
	<39eabba4-ce6d-8b5b-f3a8-78dde910ec2e@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e60b1a9e-e5e4-e6ad-ac3c-2b3276c54ffc@redhat.com>
Date: Mon, 26 Mar 2018 12:30:33 +0200
MIME-Version: 1.0
In-Reply-To: <39eabba4-ce6d-8b5b-f3a8-78dde910ec2e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: simplify code around releasing
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 26/03/2018 12:24, Vladimir Sementsov-Ogievskiy wrote:
> 23.03.2018 19:42, Paolo Bonzini wrote:
>> QLIST_REMOVE does not require walking the list, and once the "bitmap"
>> argument is removed from bdrv_do_release_matching_dirty_bitmap_locked
>> the code simplifies a lot and it is worth inlining everything in the
>> callers of bdrv_do_release_matching_dirty_bitmap.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 block/dirty-bitmap.c | 81
>> +++++++++++++++++++---------------------------------
>> =C2=A0 1 file changed, 30 insertions(+), 51 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 13bb5066a4..c0fb49bf7b 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -250,48 +250,15 @@ void
>> bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
>> =C2=A0 }
>> =C2=A0 =C2=A0 /* Called within bdrv_dirty_bitmap_lock..unlock */
>=20
> Worth adding "Called with BQL taken" to the comment?

Yes, good idea.

>> +static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)

> worth adding "Called with BQL taken." to the comment?
> bdrv_release_named_dirty_bitmaps functions has it.
>=20
>> =C2=A0 void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs=
)

This is pre-existing, but it's also a good idea.

Paolo

>> -=C2=A0=C2=A0=C2=A0 bdrv_do_release_matching_dirty_bitmap(bs, NULL,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> bdrv_dirty_bitmap_get_persistance);
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bm, *next;
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_lock(bs);
>> +=C2=A0=C2=A0=C2=A0 QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, n=
ext) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_get_=
persistance(bm)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_release_dirty_bitmap_locked(bm);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_unlock(bs);
>> =C2=A0 }
>> =C2=A0 =C2=A0 /**
>=20
> anyway,
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
