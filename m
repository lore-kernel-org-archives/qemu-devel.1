Received: from eggs.gnu.org ([2001:4830:134:3::10]:57184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5BU-0002ej-2r
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5BQ-0005Sv-UA
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:28:52 -0400
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com
	([104.47.1.133]:49574
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dD5BQ-0005N9-BP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:28:48 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <761233e8-026d-732c-4527-a744b16eba3e@virtuozzo.com>
Date: Tue, 23 May 2017 11:28:39 +0300
MIME-Version: 1.0
In-Reply-To: <f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com



On 05/22/2017 10:00 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> Currently each single write operation can result in 3 write operations
>> if guest offsets are not cluster aligned. One write is performed for the
>> real payload and two for COW-ed areas. Thus the data possibly lays
>> non-contiguously on the host filesystem. This will reduce further
>> sequential read performance significantly.
>>
>> The patch allocates the space in the file with cluster granularity,
>> ensuring
>>   1. better host offset locality
>>   2. less space allocation operations
>>      (which can be expensive on distributed storages)
>
> s/storages/storage/
>

Done.

>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>  block/qcow2.c | 32 +++++++++++++++++++++++++++++++-
>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>
>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index a8d61f0..2e6a0ec 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1575,6 +1575,32 @@ fail:
>>      return ret;
>>  }
>>
>> +static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    BlockDriverState *file = bs->file->bs;
>> +    QCowL2Meta *m;
>> +    int ret;
>> +
>> +    for (m = l2meta; m != NULL; m = m->next) {
>> +        uint64_t bytes = m->nb_clusters << s->cluster_bits;
>> +
>> +        if (m->cow_start.nb_bytes == 0 && m->cow_end.nb_bytes == 0) {
>> +            continue;
>> +        }
>> +
>> +        /* try to alloc host space in one chunk for better locality */
>> +        ret = file->drv->bdrv_co_pwrite_zeroes(file, m->alloc_offset, bytes, 0);
>
> Are we guaranteed that this is a fast operation?  (That is, it either
> results in a hole or an error, and doesn't waste time tediously writing
> actual zeroes)
>

well, block_int.h reads:

/*
* Efficiently zero a region of the disk image. Typically an image format
* would use a compact metadata representation to implement this. This
* function pointer may be NULL or return -ENOSUP and .bdrv_co_writev()
* will be called instead.
*/
int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
int64_t offset, int count, BdrvRequestFlags flags);


(and that's why the driver function is used directly, bypassing the 
'safe' bdrv interface that would try to write zeroes no matter the cost)

As far as I checked the drivers mostly follow the idea

>> +
>> +        if (ret != 0) {
>> +            continue;
>> +        }
>
> Supposing we are using a file system that doesn't support holes, then
> ret will not be zero, and we ended up not allocating anything after all.
>  Is that a problem that we are just blindly continuing the loop as our
> reaction to the error?
>
> /reads further
>
> I guess not - you aren't reacting to any error call, but merely using
> the side effect that an allocation happened for speed when it worked,
> and ignoring failure (you get the old behavior of the write() now
> causing the allocation) when it didn't.
>

yes, exactly

>> +
>> +        file->total_sectors = MAX(file->total_sectors,
>> +                                  (m->alloc_offset + bytes) / BDRV_SECTOR_SIZE);
>> +    }
>> +}
>> +
>>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                           uint64_t bytes, QEMUIOVector *qiov,
>>                                           int flags)
>> @@ -1656,8 +1682,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>          if (ret < 0) {
>>              goto fail;
>>          }
>> -
>>          qemu_co_mutex_unlock(&s->lock);
>> +
>> +        if (bs->file->bs->drv->bdrv_co_pwrite_zeroes != NULL) {
>> +            handle_alloc_space(bs, l2meta);
>> +        }
>
> Is it really a good idea to be modifying the underlying protocol image
> outside of the mutex?
>

as far as I understand, qcow2 usually modifies the underlying image
outside of the mutex? I guess it's qcow2 metadata that we wouldn't want
to touch unlocked

> At any rate, it looks like your patch is doing a best-effort write
> zeroes as an attempt to trigger consecutive allocation of the entire
> cluster in the underlying protocol right after a cluster has been
> allocated at the qcow2 format layer.  Which means there are more
> syscalls now than there were previously, but now when we do three
> write() calls at offsets B, A, C, those three calls are into file space
> that was allocated earlier by the write zeroes, rather than fresh calls
> into unallocated space that is likely to trigger up to three disjoint
> allocations.
>
> As a discussion point, wouldn't we achieve the same effect of less
> fragmentation if we instead collect our data into a bounce buffer, and
> only then do a single write() (or more likely, a writev() where the iov
> is set up to reconstruct a single buffer on the syscall, but where the
> source data is still at different offsets)?  We'd be avoiding the extra
> syscalls of pre-allocating the cluster, and while our write() call is
> still causing allocations, at least it is now one cluster-aligned
> write() rather than three sub-cluster out-of-order write()s.
>

I think yes we would achieve the same effect of less fragmentation;
but pre-zeroing also makes the following patch possible (to skip COW if 
there is no backing data)

I have follow-up patches which merge initial data and COW padding into a
single writev(). After those it should become reasonable to skip
cluster pre-zeroing (for cases when there is backing data).

/Anton
