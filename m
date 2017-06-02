Received: from eggs.gnu.org ([2001:4830:134:3::10]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGmJz-00017n-N0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGmJy-0004lF-Cq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:08:55 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-2-git-send-email-anton.nefedov@virtuozzo.com>
	<998632ec-09c0-4365-e965-9ee7b780931f@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <aff9b749-b5e1-8497-9d6a-142eb1c051e6@virtuozzo.com>
Date: Fri, 2 Jun 2017 16:08:17 +0300
MIME-Version: 1.0
In-Reply-To: <998632ec-09c0-4365-e965-9ee7b780931f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] block: introduce
 BDRV_REQ_ALLOCATE flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org



On 06/01/2017 10:07 PM, Eric Blake wrote:
> On 06/01/2017 10:14 AM, Anton Nefedov wrote:
>> The flag is supposed to indicate that the region of the disk image has
>> to be sufficiently allocated so it reads as zeroes. The call with the flag
>> set has to return -ENOTSUP if allocation cannot be done efficiently
>> (i.e. without falling back to writing actual buffers)
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/io.c            | 19 ++++++++++++++++---
>>   block/trace-events    |  1 +
>>   include/block/block.h |  6 +++++-
>>   3 files changed, 22 insertions(+), 4 deletions(-)
> 
> You may want to 'git config diff.orderFile /path/to/file' (with a
> suitably populated file) so that .h files come first in your diffs, as
> that can aid reviewers.  At one point, there was a thread about adding
> such a file to qemu.git proper for everyone to share, although it seems
> to have stalled.
> 

Thanks, will do

>>
>> diff --git a/block/io.c b/block/io.c
>> index ed31810..d47efa9 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1272,7 +1272,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>>               assert(!bs->supported_zero_flags);
>>           }
>>   
>> -        if (ret == -ENOTSUP) {
>> +        if (ret == -ENOTSUP && !(flags & BDRV_REQ_ALLOCATE)) {
> 
> I'd feel MUCH better if you first fixed the conditional just above this
> point to ensure that if the caller requests BDRV_REQ_ALLOCATE that we do
> not call bdrv->bdrv_co_pwrite_zeroes() unless bs->supported_zero_flags
> also mentions this bit.
> 
> Remember, the existing semantics of .bdrv_co_pwrite_zeroes() merely
> state that we must return -ENOTSUP unless we can guarantee that we read
> back as zeroes, but puts no timing constraints on it.  A driver that has
> not been retrofitted to understand the BDRV_REQ_ALLOCATE flag will
> therefore risk taking too long.  Using bs->supported_zero_flags as your
> gate is what will let you avoid calling into a driver that has not been
> audited for fitting the new contract.
> 

Absolutely; I have even added that check but must have lost that at some
point.
Meant to add that much earlier though, to bdrv_co_pwrite_zeroes()

>>               /* Fall back to bounce buffer if write zeroes is unsupported */
>>               BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
>>   
>> @@ -1355,8 +1355,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>>       ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
>>   
>>       if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
>> -        !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
>> -        qemu_iovec_is_zero(qiov)) {
>> +        !(flags & BDRV_REQ_ZERO_WRITE) && !(flags & BDRV_REQ_ALLOCATE) &&
>> +        drv->bdrv_co_pwrite_zeroes && qemu_iovec_is_zero(qiov)) {
>>           flags |= BDRV_REQ_ZERO_WRITE;
>>           if (bs->detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP) {
>>               flags |= BDRV_REQ_MAY_UNMAP;
>> @@ -1436,6 +1436,9 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
>>   
>>       assert(flags & BDRV_REQ_ZERO_WRITE);
>>       if (head_padding_bytes || tail_padding_bytes) {
>> +        if (flags & BDRV_REQ_ALLOCATE) {
>> +            return -ENOTSUP;
>> +        }
> 
> Can we assert that BDRV_REQ_ALLOCATE will only be supplied by a caller
> that is already using aligned values?  Or is that too strict?
> 

as I understand the top driver should not care much about the child
driver alignment preferences? that's what the common bdrv_* interface is
there for

>>           buf = qemu_blockalign(bs, align);
>>           iov = (struct iovec) {
>>               .iov_base   = buf,
>> @@ -1534,6 +1537,11 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>>           return ret;
>>       }
>>   
>> +    if (qiov && flags & BDRV_REQ_ALLOCATE) {
>> +        /* allocation request with qiov provided doesn't make much sense */
>> +        return -ENOTSUP;
> 
> Should this be an assertion (bug in the program for mixing things that
> don't make sense) rather than just a runtime error return?
> 

incline to agree here

>> +    }
>> +
>>       bdrv_inc_in_flight(bs);
>>       /*
>>        * Align write if necessary by performing a read-modify-write cycle.
>> @@ -1665,6 +1673,11 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
>>   {
>>       trace_bdrv_co_pwrite_zeroes(child->bs, offset, count, flags);
>>   
>> +    if (flags & BDRV_REQ_MAY_UNMAP && flags & BDRV_REQ_ALLOCATE) {
>> +        /* nonsense */
>> +        return -ENOTSUP;
>> +    }
> 
> Ditto.
> 

yep

>> +
>>       if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
>>           flags &= ~BDRV_REQ_MAY_UNMAP;
>>       }
>> diff --git a/block/trace-events b/block/trace-events
>> index 9a71c7f..a15c2cc 100644
>> --- a/block/trace-events
>> +++ b/block/trace-events
>> @@ -15,6 +15,7 @@ bdrv_aio_writev(void *bs, int64_t sector_num, int nb_sectors, void *opaque) "bs
>>   bdrv_co_readv(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
>>   bdrv_co_writev(void *bs, int64_t sector_num, int nb_sector) "bs %p sector_num %"PRId64" nb_sectors %d"
>>   bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags %#x"
>> +bdrv_co_allocate(void *bs, int64_t offset, int count) "bs %p offset %"PRId64" count %d"
>>   bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, unsigned int cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %u"
>>   
>>   # block/stream.c
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 9b355e9..53a357c 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -65,9 +65,13 @@ typedef enum {
>>       BDRV_REQ_NO_SERIALISING     = 0x8,
>>       BDRV_REQ_FUA                = 0x10,
>>       BDRV_REQ_WRITE_COMPRESSED   = 0x20,
>> +    /* BDRV_REQ_ALLOCATE is used to indicate that the driver is to
>> +     * efficiently allocate the space so it reads as zeroes or return an error
>> +     */
>> +    BDRV_REQ_ALLOCATE           = 0x40,
> 
> Doesn't match how the other flags are documented, but any documentation
> is better than none.
> 

Will fix

> Missing mention of the new flag in the documentation for
> supported_zero_flags.
> 

Done.

>>   
>>       /* Mask of valid flags */
>> -    BDRV_REQ_MASK               = 0x3f,
>> +    BDRV_REQ_MASK               = 0x7f,
>>   } BdrvRequestFlags;
>>   
>>   typedef struct BlockSizes {
>>
> 
/Anton
