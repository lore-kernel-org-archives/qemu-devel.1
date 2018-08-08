Received: from eggs.gnu.org ([2001:4830:134:3::10]:45878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnPpw-0005NL-Od
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnPpv-0004Z1-Pf
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:53:20 -0400
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-4-lbloch@janustech.com>
	<w514lg5t08m.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <8f932c50-ee95-0db0-6c0d-1076b86106cd@janustech.com>
Date: Wed, 8 Aug 2018 17:52:54 +0300
MIME-Version: 1.0
In-Reply-To: <w514lg5t08m.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Resize the cache upon image
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 08/08/2018 05:13 PM, Alberto Garcia wrote:
> On Wed 08 Aug 2018 09:10:49 AM CEST, Leonid Bloch wrote:
>> The caches are now recalculated upon image resizing. This is done
>> because the new default behavior of assigning a sufficient L2 cache to
>> cover the entire image implies that the cache will still be sufficient
>> after an image resizing.
> 
> This is related to what I mentioned in the previous patch. The default
> behavior doesn't make the cache try to cover the entire image (or at
> least it doesn't *extend* the cache, which is what I understand from
> this paragraph). What it does is *reduce* the cache if the smaller
> version is enough for the entire image.

But it doesn't say that it extends the cache. It says that it *adapts* 
the cache to the image size, and therefore it should be resized when the 
image is resized. At least I understand it this way. That said, I'd 
mention the limit there, instead of just "sufficient".

> 
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   block/qcow2.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 98cb96aaca..f60cb92169 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3639,6 +3639,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>           }
>>       }
>>   
>> +    bs->total_sectors = offset / BDRV_SECTOR_SIZE;
>> +
>>       /* write updated header.size */
>>       offset = cpu_to_be64(offset);
>>       ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
>> @@ -3649,6 +3651,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>       }
>>   
>>       s->l1_vm_state_index = new_l1_size;
> 
> You could add an empty line here for readability.

Yes, definitely, I will. Thanks.

> 
>> +    /* Update cache sizes */
>> +    QDict *options = qdict_clone_shallow(bs->options);
> 
> C99 allows variable declarations in the middle of a block, but we're
> still doing it at the beginning (I don't know if there's a good reason
> for this?).

I did it for readability, and I didn't see a style directive for this. 
But if the style requires it - no problem. :)

> 
> Otherwise the patch looks good to me. Thanks!

Thanks!

Leonid.

> 
> Berto
> 
