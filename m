Received: from eggs.gnu.org ([2001:4830:134:3::10]:40152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dEB4M-0001qZ-MD
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dEB4J-0004zZ-GE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:58:02 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com
	([40.107.0.97]:64688
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dEB4I-0004v0-OZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 04:57:59 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20170526081147.GC7211@noname.str.redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <2f0f5f9a-23b3-5f67-7675-ecdfe15cc187@virtuozzo.com>
Date: Fri, 26 May 2017 11:57:48 +0300
MIME-Version: 1.0
In-Reply-To: <20170526081147.GC7211@noname.str.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, "Denis V. Lunev" <den@openvz.org>

On 05/26/2017 11:11 AM, Kevin Wolf wrote:
> Am 19.05.2017 um 11:34 hat Anton Nefedov geschrieben:
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
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> I don't think this is the right approach. You end up with two
> write operations: One write_zeroes and then one data write. If the
> backend actually supports efficient zero writes, write_zeroes won't
> necessarily allocate space, but writing data will definitely split
> the already existing allocation. If anything, we need a new
> bdrv_allocate() or something that would call fallocate() instead of
> abusing write_zeroes.
great idea. Very nice then.

> It seems much clearer to me that simply unifying the three write
> requests into a single one is an improvement. And it's easy to do, I
> even had a patch once to do this. The reason that I didn't send it was
> that it seemed to conflict with the data cache approach
These changes help a lot on 2 patterns:
- writing 4Kb into the middle of the block. The bigger the block size,
  more we gain
- sequential write, which is not sector aligned and comes in 2 requests:
  we perform allocation, which should be significantly faster than actual
  write and after that both parts of the write can be executed in parallel.
At my opinion both cases are frequent and important.

But OK, the code should be improved, you are absolutely right here.

>>  block/qcow2.c | 32 +++++++++++++++++++++++++++++++-
>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>
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
> No. This is what you bypass:
>
> * All sanity checks that the block layer does
>
> * bdrv_inc/dec_in_flight(), which is required for drain to work
>   correctly. Not doing this will cause crashes.
>
> * tracked_request_begin/end(), mark_request_serialising() and
>   wait_serialising_requests(), which are required for serialising
>   requests to work correctly
>
> * Ensuring correct request alignment for file. This means that e.g.
>   qcow2 with cluster size 512 on a host with a 4k native disk will
>   break.
>
> * blkdebug events
>
> * before_write_notifiers. Not calling these will cause corrupted backups
>   if someone backups file.
>
> * Dirty bitmap updates
>
> * Updating write_gen, wr_highest_offset and total_sectors
>
> * Ensuring that bl.max_pwrite_zeroes and bl.pwrite_zeroes_alignment are
>   respected
>
> And these are just the obvious things. I'm sure I missed some.
>

You seems right. I have not though about that from this angle.

>> +        if (ret != 0) {
>> +            continue;
>> +        }
>> +
>> +        file->total_sectors = MAX(file->total_sectors,
>> +                                  (m->alloc_offset + bytes) / BDRV_SECTOR_SIZE);
> You only compensate for part of a single item in the list above, by
> duplicating code with block/io.c. This is not how to do things.
>
> As I said above, I think you don't really want write_zeroes anyway, but
> if you wanted a write_zeroes "but only if it's efficient" (which I'm not
> sure is a good thing to want), then a better way might be introducing a
> new request flag.
>
>> +    }
>> +}
>> +
>>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                           uint64_t bytes, QEMUIOVector *qiov,
>>                                           int flags)
> Kevin

Thank you for review and ideas ;)

Den
