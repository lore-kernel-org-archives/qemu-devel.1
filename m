Received: from eggs.gnu.org ([2001:4830:134:3::10]:60885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egV7y-000876-Ki
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egV7s-0001AE-Kj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:35:06 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
	<ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
Date: Tue, 30 Jan 2018 15:34:46 +0300
MIME-Version: 1.0
In-Reply-To: <ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com



On 29/1/2018 10:37 PM, Max Reitz wrote:
> On 2018-01-18 18:49, Anton Nefedov wrote:
>> The flag is supposed to indicate that the region of the disk image has
>> to be sufficiently allocated so it reads as zeroes.
>>
>> The call with the flag set must return -ENOTSUP if allocation cannot
>> be done efficiently.
>> This has to be made sure of by both
>>    - the drivers that support the flag
>>    - and the common block layer (so it will not fall back to any slowpath
>>      (like writing zero buffers) in case the driver does not support
>>      the flag).
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   include/block/block.h     |  6 +++++-
>>   include/block/block_int.h |  2 +-
>>   block/io.c                | 20 +++++++++++++++++---
>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 9b12774..3e31b89 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -65,9 +65,13 @@ typedef enum {
>>       BDRV_REQ_NO_SERIALISING     = 0x8,
>>       BDRV_REQ_FUA                = 0x10,
>>       BDRV_REQ_WRITE_COMPRESSED   = 0x20,
>> +    /* The BDRV_REQ_ALLOCATE flag is used to indicate that the driver has to
>> +     * efficiently allocate the space so it reads as zeroes, or return an error.
> 
> What happens if you specify this for a normal write operation that does
> not write zeroes?
> 
> (I suppose the answer is "don't do that", but that would need to be
> documented more clearly here.)
> 

I can't quite come up with what a regular write with ALLOCATE flag can
suppose to mean.

Will document that.

>> +     */
>> +    BDRV_REQ_ALLOCATE           = 0x40,
>>   
>>       /* Mask of valid flags */
>> -    BDRV_REQ_MASK               = 0x3f,
>> +    BDRV_REQ_MASK               = 0x7f,
>>   } BdrvRequestFlags;
>>   
>>   typedef struct BlockSizes {
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 29cafa4..b141710 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -632,7 +632,7 @@ struct BlockDriverState {
>>       /* Flags honored during pwrite (so far: BDRV_REQ_FUA) */
>>       unsigned int supported_write_flags;
>>       /* Flags honored during pwrite_zeroes (so far: BDRV_REQ_FUA,
>> -     * BDRV_REQ_MAY_UNMAP) */
>> +     * BDRV_REQ_MAY_UNMAP, BDRV_REQ_ALLOCATE) */
>>       unsigned int supported_zero_flags;
>>   
>>       /* the following member gives a name to every node on the bs graph. */
>> diff --git a/block/io.c b/block/io.c
>> index 7ea4023..cf2f84c 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1424,7 +1424,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>>               assert(!bs->supported_zero_flags);
>>           }
>>   
>> -        if (ret == -ENOTSUP) {
>> +        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
>>               /* Fall back to bounce buffer if write zeroes is unsupported */
>>               BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
>>   
>> @@ -1514,8 +1514,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>>       ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
>>   
>>       if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
>> -        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
>> -        qemu_iovec_is_zero(qiov)) {
>> +        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE) &&
>> +        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
> 
> Do we really need to add the BDRV_REQ_ALLOCATE check here?  If the
> caller specifies that flag, then we won't invalidate it by adding the
> BDRV_REQ_ZERO_WRITE flag (as long as we don't add BDRV_REQ_MAY_UNMAP).
> 

Now !(flags & BDRV_REQ_ALLOCATE) is always true here, as REQ_ALLOCATE
implies REQ_ZERO_WRITE.
But conceptually yes I think the check should only forbid setting
MAY_UNMAP.

Offtop: does REQ_ZERO_WRITE override REQ_WRITE_COMPRESSED in this
function? at least with !REQ_MAY_UNMAP it looks wrong

>>           flags |= BDRV_REQ_ZERO_WRITE;
>>           if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
>>               flags |= BDRV_REQ_MAY_UNMAP;
>> @@ -1593,6 +1593,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
>>   
>>       assert(flags & BDRV_REQ_ZERO_WRITE);
>>       if (head_padding_bytes || tail_padding_bytes) {
>> +        if (flags & BDRV_REQ_ALLOCATE) {
>> +            return -ENOTSUP;
>> +        }
>>           buf = qemu_blockalign(bs, align);
>>           iov = (struct iovec) {
>>               .iov_base   = buf,
>> @@ -1693,6 +1696,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>>           return ret;
>>       }
>>   
>> +    /* allocation request with qiov provided doesn't make much sense */
>> +    assert(!(qiov && (flags & BDRV_REQ_ALLOCATE)));
>> +
> 
> So I suppose the use of BDRV_REQ_ALLOCATE necessitates the use of
> BDRV_REQ_ZERO_WRITE?  That should be documented, then.
> 
> Max
> 

Yes, will document.

>>       bdrv_inc_in_flight(bs);
>>       /*
>>        * Align write if necessary by performing a read-modify-write cycle.
>> @@ -1822,6 +1828,14 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
>>   {
>>       trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
>>   
>> +    assert(!((flags & BDRV_REQ_MAY_UNMAP) && (flags & BDRV_REQ_ALLOCATE)));
>> +
>> +    if ((flags & BDRV_REQ_ALLOCATE) &&
>> +        !(child->bs->supported_zero_flags & BDRV_REQ_ALLOCATE))
>> +    {
>> +        return -ENOTSUP;
>> +    }
>> +
>>       if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
>>           flags &= ~BDRV_REQ_MAY_UNMAP;
>>       }
>>
> 
> 
