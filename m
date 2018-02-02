Received: from eggs.gnu.org ([208.118.235.92]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eheQF-0003ja-5E
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ehePA-0007lM-17
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:42:43 -0500
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
	<ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <919e1755-e3d1-939b-2157-6d3b5896ea3a@virtuozzo.com>
Date: Fri, 2 Feb 2018 19:29:45 +0300
MIME-Version: 1.0
In-Reply-To: <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

02.02.2018 19:18, Eric Blake wrote:
> On 02/02/2018 10:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> To maintain load/store disabled bitmap there is new approach:
>>
>>   - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>>   - store enabled bitmaps as "auto" to qcow2
>>   - store disabled bitmaps without "auto" flag to qcow2
>>   - on qcow2 open load "auto" bitmaps as enabled and others
>>     as disabled (except in_use bitmaps)
>>
>> Also, adjust iotests 165 and 176 appropriately.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> +++ b/qemu-doc.texi
>> @@ -2749,6 +2749,13 @@ used and it will be removed with no replacement.
>>   The ``convert -s snapshot_id_or_name'' argument is obsoleted
>>   by the ``convert -l snapshot_param'' argument instead.
>>   
>> +@section QEMU Machine Protocol (QMP) commands
>> +
>> +@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
>> +
>> +"autoload" parameter is now ignored. All bitmaps are automatically loaded
>> +from qcow2 image.
> Won't later patches be adding the ability to enable/disable bitmaps,
> which then affects whether they are autoloaded?  So we don't forget to
> revisit this text in that patch, a better wording might be:
>
> The "autoload" parameter is ignored; all enabled persistent dirty
> bitmaps are automatically loaded from a qcow2 image, regardless of the
> initial setting requested in this parameter.


hmm.. no. all bitmaps are loaded, even disabled ones. Before this patch 
there is
no way to have disabled bitmap in qemu (by loading or by creating).
After the patch, we have a theoretical way of creating such bitmap in 
qcow2 image, then
it will be loaded as disabled.

Also, we can store bitmap with persistent=true and autoload=false before 
this patch, and there is no way
to load this bitmap before this patch, but after this patch it will be 
loaded as disabled.


>
>
>> @@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
>>   }
>>   
>>   /* Called with BQL taken. */
>> -void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload)
>> -{
>> -    qemu_mutex_lock(bitmap->mutex);
>> -    bitmap->autoload = autoload;
>> -    qemu_mutex_unlock(bitmap->mutex);
>> -}
>> -
>> -bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
>> -{
>> -    return bitmap->autoload;
>> -}
> Will later patches be reintroducing these functions for learning which
> bitmaps are enabled/disabled?  But I'm okay with deleting them in this
> patch, even if that is more churn.
>

no, actually the aim of the patch is to drop buggy relation between 
autoload qmp parameter
and auto qcow2 flag (which is more like "enabled" then "autoload"). Look 
at "Reasoning" in head
letter for details.

-- 
Best regards,
Vladimir
