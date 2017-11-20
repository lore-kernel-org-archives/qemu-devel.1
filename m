Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eGnbT-0007ou-Sm
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eGnbN-0002JZ-Nk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:03:19 -0500
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-2-git-send-email-anton.nefedov@virtuozzo.com>
	<20171120145311.GG4516@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <e40d3c39-e97d-b168-4573-f167dc6faa1e@virtuozzo.com>
Date: Mon, 20 Nov 2017 18:03:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171120145311.GG4516@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Pavel Butsykin <pbutsykin@virtuozzo.com>, mreitz@redhat.com, stefanha@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

On 11/20/2017 05:53 PM, Stefan Hajnoczi wrote:
> On Thu, Nov 16, 2017 at 07:54:55PM +0300, Anton Nefedov wrote:
>> From: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>
>> At the moment, qcow2_co_pwritev_compressed can process the requests size
>> less than or equal to one cluster. This patch added possibility to write
>> compressed data in the QCOW2 more than one cluster. The implementation
>> is simple, we just split large requests into separate clusters and write
>> using existing functionality.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>  block/qcow2.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 52 insertions(+), 21 deletions(-)
> Kevin: qcow2_alloc_compressed_cluster_offset() sets up an L2 table entry
> before doing the compressed data write.  Can the following scenario
> occur if there is another request racing with the compressed write?
>
> 1. Compressed cluster L2 table entry added to qcow2 in-memory cache
> 2. Another request forces cached L2 table to be written to disk
> 3. Power failure or crash before compressed data is written
>
> Now there is an L2 table entry pointing to garbage data.  This violates
> qcow2's data integrity model.
>
> I'm not sure if compressed writes are safe...  It may have been okay for
> qemu-img convert but the risk is increased when running a VM.
qemu-img is now multi-coroutine, thus the danger is exactly the same.

Den



>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index c276b24..f1e2759 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3332,11 +3332,9 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>>      return 0;
>>  }
>>  
>> -/* XXX: put compressed sectors first, then all the cluster aligned
>> -   tables to avoid losing bytes in alignment */
>>  static coroutine_fn int
>> -qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>> -                            uint64_t bytes, QEMUIOVector *qiov)
>> +qcow2_co_pwritev_cluster_compressed(BlockDriverState *bs, uint64_t offset,
>> +                                    uint64_t bytes, QEMUIOVector *qiov)
>>  {
>>      BDRVQcow2State *s = bs->opaque;
>>      QEMUIOVector hd_qiov;
>> @@ -3346,25 +3344,12 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>>      uint8_t *buf, *out_buf;
>>      int64_t cluster_offset;
>>  
>> -    if (bytes == 0) {
>> -        /* align end of file to a sector boundary to ease reading with
>> -           sector based I/Os */
>> -        cluster_offset = bdrv_getlength(bs->file->bs);
>> -        if (cluster_offset < 0) {
>> -            return cluster_offset;
>> -        }
>> -        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
>> -    }
>> -
>> -    if (offset_into_cluster(s, offset)) {
>> -        return -EINVAL;
>> -    }
>> +    assert(bytes <= s->cluster_size);
>> +    assert(!offset_into_cluster(s, offset));
>>  
>>      buf = qemu_blockalign(bs, s->cluster_size);
>> -    if (bytes != s->cluster_size) {
>> -        if (bytes > s->cluster_size ||
>> -            offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS)
>> -        {
>> +    if (bytes < s->cluster_size) {
>> +        if (offset + bytes != bs->total_sectors << BDRV_SECTOR_BITS) {
>>              qemu_vfree(buf);
>>              return -EINVAL;
>>          }
>> @@ -3444,6 +3429,52 @@ fail:
>>      return ret;
>>  }
>>  
>> +/* XXX: put compressed sectors first, then all the cluster aligned
>> +   tables to avoid losing bytes in alignment */
>> +static coroutine_fn int
>> +qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>> +                            uint64_t bytes, QEMUIOVector *qiov)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    QEMUIOVector hd_qiov;
>> +    uint64_t curr_off = 0;
>> +    int ret;
>> +
>> +    if (bytes == 0) {
>> +        /* align end of file to a sector boundary to ease reading with
>> +           sector based I/Os */
>> +        int64_t cluster_offset = bdrv_getlength(bs->file->bs);
>> +        if (cluster_offset < 0) {
>> +            return cluster_offset;
>> +        }
>> +        return bdrv_truncate(bs->file, cluster_offset, PREALLOC_MODE_OFF, NULL);
>> +    }
>> +
>> +    if (offset_into_cluster(s, offset)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    qemu_iovec_init(&hd_qiov, qiov->niov);
>> +    do {
>> +        uint32_t chunk_size;
>> +
>> +        qemu_iovec_reset(&hd_qiov);
>> +        chunk_size = MIN(bytes, s->cluster_size);
>> +        qemu_iovec_concat(&hd_qiov, qiov, curr_off, chunk_size);
>> +
>> +        ret = qcow2_co_pwritev_cluster_compressed(bs, offset + curr_off,
>> +                                                  chunk_size, &hd_qiov);
>> +        if (ret < 0) {
>> +            break;
>> +        }
>> +        curr_off += chunk_size;
>> +        bytes -= chunk_size;
>> +    } while (bytes);
>> +    qemu_iovec_destroy(&hd_qiov);
>> +
>> +    return ret;
>> +}
>> +
>>  static int make_completely_empty(BlockDriverState *bs)
>>  {
>>      BDRVQcow2State *s = bs->opaque;
>> -- 
>> 2.7.4
>>
>>
