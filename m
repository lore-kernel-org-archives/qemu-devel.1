Received: from eggs.gnu.org ([2001:4830:134:3::10]:33278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKC8-0001B1-DH
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyKC5-0001Ev-8k
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:33:04 -0400
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
	<20180319090223.23336-3-vsementsov@virtuozzo.com>
	<49811577-7ac5-6c39-b19e-3ec56313bc65@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <98726d27-567f-a749-97b5-f43def8df3a9@virtuozzo.com>
Date: Tue, 20 Mar 2018 19:32:44 +0300
MIME-Version: 1.0
In-Reply-To: <49811577-7ac5-6c39-b19e-3ec56313bc65@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

20.03.2018 16:44, Max Reitz wrote:
> On 2018-03-19 10:02, Vladimir Sementsov-Ogievskiy wrote:
>> Consider migration with shared storage. Persistent bitmaps are stored
>> on bdrv_inactivate. Then, on destination
>> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
>> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
>> are already loaded on destination start. In this case we should call
>> qcow2_reopen_bitmaps_rw instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 7472af6931..6219666d4a 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1480,7 +1480,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>           s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>>       }
>>   
>> -    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>> +    if (bdrv_has_readonly_bitmaps(bs)) {
> So if there are any read-only bitmaps, we'll skip
> qcow2_load_dirty_bitmaps() altogether.  That doesn't seem so bad because
> qcow2_load_dirty_bitmaps() seems to assume no bitmaps have been loaded yet.
>
> But if that's the case, shouldn't we skip that function if any bitmap
> has been loaded already, RO or R/W?  (And we can call
> qcow2_reopen_bitmaps_rw_hint() even if there aren't any RO bitmaps, it
> just won't do anything then.)
>
> This doesn't make this patch really wrong, I'm just wondering whether it
> can do better.  (To add to that, I don't even know whether there is a
> case where qcow2_do_open() would be called with any R/W bitmaps already
> present.)
>
> Max

hm reasonable. So, we don't know about such cases, it's better to don't 
allow them.

>
>> +        if (!bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>> +            bool header_updated = false;
>> +            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
>> +            update_header = update_header && !header_updated;
>> +        }
>> +    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>>           update_header = false;
>>       }
>>       if (local_err != NULL) {
>>


-- 
Best regards,
Vladimir
