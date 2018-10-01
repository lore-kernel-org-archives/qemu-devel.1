Received: from eggs.gnu.org ([2001:4830:134:3::10]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70Yr-0006hx-N7
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70Yq-0007Z8-Ro
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:56:41 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-2-vsementsov@virtuozzo.com>
	<8e1cc18c-307f-99b1-5892-713ebd17a15f@redhat.com>
	<43277786-b6b9-e18c-b0ca-064ff7c9c0c9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1d14336b-e740-53fc-1f9f-f51c9e3d85c0@virtuozzo.com>
Date: Mon, 1 Oct 2018 18:56:26 +0300
MIME-Version: 1.0
In-Reply-To: <43277786-b6b9-e18c-b0ca-064ff7c9c0c9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/7] qcow2: move qemu_co_mutex_lock below
 decryption procedure
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

27.09.2018 20:02, Max Reitz wrote:
> On 27.09.18 18:58, Max Reitz wrote:
>> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>> From: "Denis V. Lunev" <den@openvz.org>
>>>
>>> We are not working with a shared state data in the decruption code and
> (*decryption)
>
>>> thus this operation is safe. On the other hand this significantly
>>> reduces the scope of the lock.
>> Sure, but does it have any effect?  This is a coroutine lock and I don't
>> see any yield points besides the bdrv_co_preadv() that was executed
>> outside of the lock anyway.
> I think it makes sense to move the qemu_co_mutex_lock() down below the
> decryption, as the commit title suggests.  Because then we can decrypt
> while another coroutine that uses the lock is blocking.
>
> But I don't see the point of moving the qemu_co_mutex_unlock() up.
> (That is non-trivial movement because it means I'd have to find out
> whether anything that could modify the cluster offset is serialized by
> the generic block layer.  Or, well, not really, because there is no
> yield point, so it doesn't actually matter.  But it doesn't give us any
> benefit either, I think.)
>
> Max

It don't make any performance benefit, but it allows to split part about 
normal cluster reading to separate function.

Hmm, in future we can do decryption in threads (like compress threads) 
and it should improve performance.

>
>> Max
>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> ---
>>>   block/qcow2.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index ec9e6238a0..41def07c67 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1880,9 +1880,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>               break;
>>>   
>>>           case QCOW2_CLUSTER_NORMAL:
>>> +            qemu_co_mutex_unlock(&s->lock);
>>> +
>>>               if ((cluster_offset & 511) != 0) {
>>>                   ret = -EIO;
>>> -                goto fail;
>>> +                goto fail_nolock;
>>>               }
>>>   
>>>               if (bs->encrypted) {
>>> @@ -1899,7 +1901,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>                                               * s->cluster_size);
>>>                       if (cluster_data == NULL) {
>>>                           ret = -ENOMEM;
>>> -                        goto fail;
>>> +                        goto fail_nolock;
>>>                       }
>>>                   }
>>>   
>>> @@ -1909,13 +1911,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>               }
>>>   
>>>               BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
>>> -            qemu_co_mutex_unlock(&s->lock);
>>>               ret = bdrv_co_preadv(bs->file,
>>>                                    cluster_offset + offset_in_cluster,
>>>                                    cur_bytes, &hd_qiov, 0);
>>> -            qemu_co_mutex_lock(&s->lock);
>>>               if (ret < 0) {
>>> -                goto fail;
>>> +                goto fail_nolock;
>>>               }
>>>               if (bs->encrypted) {
>>>                   assert(s->crypto);
>>> @@ -1929,10 +1929,11 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>                                             cur_bytes,
>>>                                             NULL) < 0) {
>>>                       ret = -EIO;
>>> -                    goto fail;
>>> +                    goto fail_nolock;
>>>                   }
>>>                   qemu_iovec_from_buf(qiov, bytes_done, cluster_data, cur_bytes);
>>>               }
>>> +            qemu_co_mutex_lock(&s->lock);
>>>               break;
>>>   
>>>           default:
>>> @@ -1950,6 +1951,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>>   fail:
>>>       qemu_co_mutex_unlock(&s->lock);
>>>   
>>> +fail_nolock:
>>>       qemu_iovec_destroy(&hd_qiov);
>>>       qemu_vfree(cluster_data);
>>>   
>>>
>>
>


-- 
Best regards,
Vladimir
