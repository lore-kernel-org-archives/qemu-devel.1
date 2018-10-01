Received: from eggs.gnu.org ([2001:4830:134:3::10]:37036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70dW-0000g4-Kj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70dJ-0003Yn-Bc
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 12:01:26 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-4-vsementsov@virtuozzo.com>
	<6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
	<9e53e78b-a0ef-9486-1036-3737ba8cad11@virtuozzo.com>
	<cb8d01ad-0ef9-a11e-1706-f32d505de1b9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <519cc1dd-1a2f-eb83-b682-c412fcfe6867@virtuozzo.com>
Date: Mon, 1 Oct 2018 19:00:53 +0300
MIME-Version: 1.0
In-Reply-To: <cb8d01ad-0ef9-a11e-1706-f32d505de1b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: split out reading normal
 clusters from qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

01.10.2018 18:39, Max Reitz wrote:
> On 01.10.18 17:14, Vladimir Sementsov-Ogievskiy wrote:
>> 27.09.2018 20:35, Max Reitz wrote:
>>> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>>> Memory allocation may become less efficient for encrypted case. It's a
>>>> payment for further asynchronous scheme.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>   block/qcow2.c | 114 ++++++++++++++++++++++++++++++++--------------------------
>>>>   1 file changed, 64 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 65e3ca00e2..5e7f2ee318 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1808,6 +1808,67 @@ out:
>>>>       return ret;
>>>>   }
>>>>   
>>>> +static coroutine_fn int qcow2_co_preadv_normal(BlockDriverState *bs,
>>>> +                                               uint64_t file_cluster_offset,
>>>> +                                               uint64_t offset,
>>>> +                                               uint64_t bytes,
>>>> +                                               QEMUIOVector *qiov,
>>>> +                                               uint64_t qiov_offset)
>>>> +{
>>>> +    int ret;
>>>> +    BDRVQcow2State *s = bs->opaque;
>>>> +    void *crypt_buf = NULL;
>>>> +    QEMUIOVector hd_qiov;
>>>> +    int offset_in_cluster = offset_into_cluster(s, offset);
>>>> +
>>>> +    if ((file_cluster_offset & 511) != 0) {
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>> +    qemu_iovec_init(&hd_qiov, qiov->niov);
>>> So you're not just re-allocating the bounce buffer for every single
>>> call, but also this I/O vector.  Hm.
>>>
>>>> +    if (bs->encrypted) {
>>>> +        assert(s->crypto);
>>>> +        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
>>>> +
>>>> +        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
>>> 1. Why did you remove the comment?
>>>
>>> 2. The check for whether crypt_buf was successfully allocated is missing.
>>>
>>> 3. Do you have any benchmarks for encrypted images?  Having to allocate
>>> the bounce buffer for potentially every single cluster sounds rather bad
>>> to me.
>> Hmm, no excuses. 1- Will fix, 2 - will fix, 3 - will fix or at least
>> test the performance.
>>
>>>> +        qemu_iovec_add(&hd_qiov, crypt_buf, bytes);
>>>> +    } else {
>>>> +        qemu_iovec_concat(&hd_qiov, qiov, qiov_offset, bytes);
>>> qcow2_co_preadv() continues to do this as well.  That's superfluous now.
>> hd_qiov is local here.. or what do you mean?
> qcow2_co_preadv() continues to have its own hd_qiov and appends qiov to
> it (just like here), but it's unused for normal clusters.  So it doesn't
> have to do that for normal clusters.

ah, yes, understand. Will think how to properly handle it.

>
>>>> +    }
>>>> +
>>>> +    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
>>>> +    ret = bdrv_co_preadv(bs->file,
>>>> +                         file_cluster_offset + offset_in_cluster,
>>>> +                         bytes, &hd_qiov, 0);
>>>> +    if (ret < 0) {
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    if (bs->encrypted) {
>>>> +        assert(s->crypto);
>>>> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
>>>> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
>>>> +        if (qcrypto_block_decrypt(s->crypto,
>>>> +                                  (s->crypt_physical_offset ?
>>>> +                                   file_cluster_offset + offset_in_cluster :
>>>> +                                   offset),
>>>> +                                  crypt_buf,
>>>> +                                  bytes,
>>>> +                                  NULL) < 0) {
>>> What's the reason against decrypting this in-place in qiov so we could
>>> save the bounce buffer?  We allow offsets in clusters, so why can't we
>>> just call this function once per involved I/O vector entry?
>> Isn't it unsafe to do decryption in guest buffers?
> I don't know.  Why would it be?  Because...
>
>>> Max
>>>
>>>> +            ret = -EIO;
>>>> +            goto out;
>>>> +        }
>>>> +        qemu_iovec_from_buf(qiov, qiov_offset, crypt_buf, bytes);
> ...we're putting the decrypted content there anyway.
>
> The only issue I see is that the guest may see encrypted content for a
> short duration.  Hm.  Maybe we don't want that.  In which case it
> probably has to stay as it is.

Yes, I mean exactly this thing.

>
> Max
>


-- 
Best regards,
Vladimir
