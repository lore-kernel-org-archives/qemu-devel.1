Received: from eggs.gnu.org ([209.51.188.92]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwDbW-0000V5-UG
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gwDRS-000169-QN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:00:43 -0500
References: <20190213233618.22484-1-jsnow@redhat.com>
	<20190213233618.22484-3-jsnow@redhat.com>
	<c79e69af-6d00-074a-fc02-5f0808048f4d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c2188cb6-31fe-28e2-647d-42ae2f12212a@redhat.com>
Date: Tue, 19 Feb 2019 17:00:15 -0500
MIME-Version: 1.0
In-Reply-To: <c79e69af-6d00-074a-fc02-5f0808048f4d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] block/dirty-bitmap: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/18/19 1:13 PM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:36, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/dirty-bitmap.c         | 15 +++++++++++++
>>   block/qcow2-bitmap.c         | 42 ++++++++++++++++++-----------------
>>   blockdev.c                   | 43 ++++++++++++++++++++++++++++++++++++
>>   include/block/dirty-bitmap.h |  1 +
>>   4 files changed, 81 insertions(+), 20 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index b1879d7fbd..06d8ee0d79 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -589,6 +589,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
>>           *out = backup;
>>       }
>>       bdrv_dirty_bitmap_unlock(bitmap);
>> +    bdrv_dirty_bitmap_set_inconsistent(bitmap, false);
>>   }
>>   
>>   void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
>> @@ -776,6 +777,13 @@ bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
>>       return hbitmap_next_dirty_area(bitmap->bitmap, offset, bytes);
>>   }
>>   
>> +void bdrv_dirty_bitmap_add_inconsistent_hint(Error **errp)
>> +{
>> +    error_append_hint(errp, "Try block-dirty-bitmap-clear to mark this "
>> +                      "bitmap consistent again, or block-dirty-bitmap-remove "
>> +                      "to delete it.");
> 
> bitmaps created by libvirt (or somebody) are related to some checkpoint. And their name is
> probably (Eric?) related to this checkpoint too. So, clear will never make them consistent..
> Only clear :)
> 
> So, I don't like idea of clearing in-use bitmaps.
> 
>> +}
>> +
>>   void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>>                                HBitmap **backup, Error **errp)
>>   {
>> @@ -798,6 +806,13 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>>           goto out;
>>       }
>>   
>> +    if (bdrv_dirty_bitmap_inconsistent(dest)) {
>> +        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used as"
>> +                   " a merge target", dest->name);
>> +        bdrv_dirty_bitmap_add_inconsistent_hint(errp);
>> +        goto out;
>> +    }
> 
> I think, we need common predicate which will combine busy and inconsistent, as almost in all cases
> we need both to be false to do any operation.
> 
> bdrv_dirty_bitmap_usable() ? :)
> 
> and pass errp to this helper.
> 
> Actually, we already need it, to fill errp, which we almost always fill in the same manner.
> 
>> +
>>       if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
>>           error_setg(errp, "Bitmaps are incompatible and can't be merged");
>>           goto out;
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 3ee524da4b..9bd8bc417f 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
> 
> hmm, I also think we should report our deprecated status as locked for inconsistent bitmaps..
> 
> 

Though we're trying to deprecate the field altogether, I *could* add a
special status flag that makes it unambiguous. This will catch the
attention of anyone using the old API.

--js
