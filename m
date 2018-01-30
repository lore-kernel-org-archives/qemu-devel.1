Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egWp8-0003BT-Mv
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egWp7-0004F8-6d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:23:46 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
	<7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
Date: Tue, 30 Jan 2018 17:23:30 +0300
MIME-Version: 1.0
In-Reply-To: <7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
 empty COW areas
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



On 29/1/2018 11:28 PM, Max Reitz wrote:
> On 2018-01-18 18:49, Anton Nefedov wrote:
>> If COW areas of the newly allocated clusters are zeroes on the backing image,
>> efficient bdrv_write_zeroes(flags=BDRV_REQ_ALLOCATE) can be used on the whole
>> cluster instead of writing explicit zero buffers later in perform_cow().
>>
>> iotest 060:
>> write to the discarded cluster does not trigger COW anymore.
>> Use a backing image instead.
>>
>> iotest 066:
>> cluster-alignment areas that were not really COWed are now detected
>> as zeroes, hence the initial write has to be exactly the same size for
>> the maps to match
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   qapi/block-core.json       |  4 ++-
>>   block/qcow2.h              |  6 +++++
>>   block/qcow2-cluster.c      |  2 +-
>>   block/qcow2.c              | 66 ++++++++++++++++++++++++++++++++++++++++++++--
>>   block/trace-events         |  1 +
>>   tests/qemu-iotests/060     | 26 +++++++++++-------
>>   tests/qemu-iotests/060.out |  5 +++-
>>   tests/qemu-iotests/066     |  2 +-
>>   tests/qemu-iotests/066.out |  4 +--
>>   9 files changed, 98 insertions(+), 18 deletions(-)
> 
> [...]
> 
>> @@ -1875,6 +1880,52 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
>>       return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
>>   }
>>   
>> +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
>> +{
>> +    return is_zero(bs, m->offset + m->cow_start.offset,
>> +                   m->cow_start.nb_bytes) &&
>> +           is_zero(bs, m->offset + m->cow_end.offset, m->cow_end.nb_bytes);
>> +}
>> +
>> +static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    QCowL2Meta *m;
>> +
>> +    for (m = l2meta; m != NULL; m = m->next) {
>> +        int ret;
>> +
>> +        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
>> +            continue;
>> +        }
>> +
>> +        if (bs->encrypted) {
>> +            continue;
>> +        }
> 
> Not sure if the compiler optimizes this anyway, but I'd pull this out of
> the loop.
> 

An imprint of the following patches (which were dropped from this
series) - preallocation ahead of image EOF, which takes action
regardless of image encryption.

But I'll leave the check outside the loop until it's needed
there.


> Maybe you could put all of the conditions under which this function can
> actually do something at its beginning: That is, we can't do anything if
> the BDS is encrypted or if bs->file does not support BDRV_REQ_ALLOCATE
> (and then you just call this function unconditionally in
> qcow2_co_pwritev()).
> 

Done.

>> +        if (!is_zero_cow(bs, m)) {
>> +            continue;
>> +        }
> 
> Is this really efficient?  I remember someone complaining about
> bdrv_co_block_status() being kind of slow on some filesystems, so
> there'd be a tradeoff depending on how it compares to just reading up to
> two clusters from the backing file -- especially considering that the OS
> can query the same information just as quickly, and thus the only
> overhead the read should have is a memset() (assuming the OS is clever).
> 
> So basically my question is whether it would be better to just skip this
> if we have any backing file at all and only do this optimization if
> there is none.
> 

So what we trade between is
(read+write) vs (lseek+fallocate or lseek+read+write).

Indeed if it comes to lseek the profit is smaller, and we're probably
unlikely to find a hole anyway.

Maybe it's good enough to cover these cases:
  1. no backing
  2. beyond bdrv_getlength() in backing
  3. unallocated in backing qcow2 (covers 'beyond bdrv_getlength()
                                           in backing->file')

1 & 2 are easy to check;
3: if that's not too hacky maybe we can do the bdrv_is_allocated() check
for qcow2 exclusively and if there is raw (or any other format) backing
image - do the COW

>> +
>> +        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
>> +        /* instead of writing zero COW buffers,
>> +           efficiently zero out the whole clusters */
>> +        ret = bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
>> +                                    m->nb_clusters * s->cluster_size,
>> +                                    BDRV_REQ_ALLOCATE);
>> +        if (ret < 0) {
>> +            if (ret != -ENOTSUP && ret != -EAGAIN) {
>> +                return ret;
>> +            }
>> +            continue;
>> +        }
>> +
>> +        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clusters);
>> +        m->skip_cow = true;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                            uint64_t bytes, QEMUIOVector *qiov,
>>                                            int flags)
> 
> [...]
> 
>> diff --git a/block/trace-events b/block/trace-events
>> index 11c8d5f..c9fa596 100644
>> --- a/block/trace-events
>> +++ b/block/trace-events
>> @@ -61,6 +61,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
>>   qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
>>   qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
>>   qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%" PRIx64 " count %d"
>> +qcow2_skip_cow(void* co, uint64_t offset, int nb_clusters) "co %p offset 0x%" PRIx64 " nb_clusters %d"
> 
> Nit: Should be "void *co" to match the rest.
> 

apparently checkpatch.pl doesn't cover events files :) thanks, done

>>   
>>   # block/qcow2-cluster.c
>>   qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
> 
> [...]
> 
>> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
>> index 8638217..3c216a1 100755
>> --- a/tests/qemu-iotests/066
>> +++ b/tests/qemu-iotests/066
>> @@ -71,7 +71,7 @@ echo
>>   _make_test_img $IMG_SIZE
>>   
>>   # Create data clusters (not aligned to an L2 table)
>> -$QEMU_IO -c 'write -P 42 1M 256k' "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "write -P 42 $(((1024 + 32) * 1024)) 192k" "$TEST_IMG" | _filter_qemu_io
> 
> The comment should probably be updated to note that we don't write head
> and tail because we want them to stay zero, so the mapping information
> matches.
> 
> Max
> 

Done.

>>   orig_map=$($QEMU_IMG map --output=json "$TEST_IMG")
>>   
>>   # Convert the data clusters to preallocated zero clusters
> 
