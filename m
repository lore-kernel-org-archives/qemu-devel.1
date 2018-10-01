Received: from eggs.gnu.org ([2001:4830:134:3::10]:33133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70Lt-0001ti-Vt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70Ls-0007AO-P1
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:43:17 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-6-vsementsov@virtuozzo.com>
	<5c871ce7-2cab-f897-0b06-cbc05b9ffe97@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20249828-f5fd-e2d8-6253-e4a0a48800ff@virtuozzo.com>
Date: Mon, 1 Oct 2018 18:43:03 +0300
MIME-Version: 1.0
In-Reply-To: <5c871ce7-2cab-f897-0b06-cbc05b9ffe97@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 5/7] qcow2: refactor qcow2_co_pwritev:
 split out qcow2_co_do_pwritev
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

28.09.2018 17:23, Max Reitz wrote:
> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>> Split out block which will be reused in async scheme.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 138 ++++++++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 86 insertions(+), 52 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index a0df8d4e50..4d669432d1 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2210,6 +2210,85 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
>>       return false;
>>   }
>>   
>> +/* qcow2_co_do_pwritev
>> + * Called without s->lock unlocked
>> + * hd_qiov - temp qiov for any use. It is initialized so it is empty and
>> + *           support adding up to qiov->niov + 2 elements
>> + * l2meta  - if not NULL, qcow2_co_do_pwritev() will consume it. Caller must not
>> + *           use it somehow after qcow2_co_do_pwritev() call
>> + */
>> +static coroutine_fn int qcow2_co_do_pwritev(BlockDriverState *bs,
>> +                                            uint64_t file_cluster_offset,
>> +                                            uint64_t offset,
>> +                                            uint64_t bytes,
>> +                                            QEMUIOVector *qiov,
>> +                                            uint64_t qiov_offset,
>> +                                            QCowL2Meta *l2meta)
>> +{
>> +    int ret;
>> +    BDRVQcow2State *s = bs->opaque;
>> +    void *crypt_buf = NULL;
>> +    QEMUIOVector hd_qiov;
>> +    int offset_in_cluster = offset_into_cluster(s, offset);
>> +
>> +    qemu_iovec_reset(&hd_qiov);
> This shouldn't be here.
>
>> +    qemu_iovec_init(&hd_qiov, qiov->niov);
>> +
>> +    if (bs->encrypted) {
>> +        assert(s->crypto);
>> +        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
>> +        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
>> +        qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
>> +
>> +        if (qcrypto_block_encrypt(s->crypto,
>> +                                  (s->crypt_physical_offset ?
>> +                                   file_cluster_offset + offset_in_cluster :
>> +                                   offset),
>> +                                  crypt_buf,
>> +                                  bytes, NULL) < 0) {
> Same question as in the read case: Can't we make do without the bounce
> buffer?

I think, we should not modify guest buffers..

>
>> +            ret = -EIO;
>> +            goto fail;
>> +        }
>> +
>> +        qemu_iovec_add(&hd_qiov, crypt_buf, bytes);
>> +    } else {
>> +        qemu_iovec_concat(&hd_qiov, qiov, qiov_offset, bytes);
>> +    }
>> +
>> +    /* If we need to do COW, check if it's possible to merge the
>> +     * writing of the guest data together with that of the COW regions.
>> +     * If it's not possible (or not necessary) then write the
>> +     * guest data now. */
>> +    if (!merge_cow(offset, bytes, &hd_qiov, l2meta)) {
>> +        BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
>> +        trace_qcow2_writev_data(qemu_coroutine_self(),
>> +                                file_cluster_offset + offset_in_cluster);
>> +        ret = bdrv_co_pwritev(bs->file,
>> +                              file_cluster_offset + offset_in_cluster,
>> +                              bytes, &hd_qiov, 0);
>> +        if (ret < 0) {
>> +            qemu_co_mutex_lock(&s->lock);
>> +            goto fail;
>> +        }
>> +    }
>> +
>> +    qemu_co_mutex_lock(&s->lock);
> It looks a bit weird to only do some of the lock handling in this
> function.  I don't quite like it, but as long as you keep it around the
> qcow2_handle_l2meta(), I won't object.
>
> A problem is that currently you don't keep it around
> qcow2_handle_l2meta().  Before going to the fail label, one has to
> manually lock the mutex (which you don't do in one of the above error
> paths, but that's fallout from patch 2).  Maybe it would be nicer with a
> separate label that does the lock.
>
> Like:
>
>      ...
>      ret = qcow2_handle_l2meta(bs, &l2meta, true);
>      goto done_locked;
>
> fail_unlocked:
>      qemu_co_mutex_lock(&s->lock)
> done_locked:
>      qcow2_handle_l2meta(bs, &l2meta, false);
>      ...

ok

>
>> +
>> +    ret = qcow2_handle_l2meta(bs, &l2meta, true);
>> +    if (ret) {
>> +        goto fail;
>> +    }
>> +
>> +fail:
>> +    qcow2_handle_l2meta(bs, &l2meta, false);
>> +    qemu_co_mutex_unlock(&s->lock);
>> +
>> +    qemu_vfree(crypt_buf);
>> +    qemu_iovec_destroy(&hd_qiov);
>> +
>> +    return ret;
>> +}
>> +
>>   static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                            uint64_t bytes, QEMUIOVector *qiov,
>>                                            int flags)
>> @@ -2262,63 +2341,16 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>   
>>           qemu_co_mutex_unlock(&s->lock);
>>   
>> -        qemu_iovec_reset(&hd_qiov);
>> -        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, cur_bytes);
>>   
>> -        if (bs->encrypted) {
>> -            assert(s->crypto);
>> -            if (!cluster_data) {
>> -                cluster_data = qemu_try_blockalign(bs->file->bs,
>> -                                                   QCOW_MAX_CRYPT_CLUSTERS
>> -                                                   * s->cluster_size);
>> -                if (cluster_data == NULL) {
>> -                    ret = -ENOMEM;
>> -                    goto fail;
>> -                }
>> -            }
>> -
>> -            assert(hd_qiov.size <=
>> -                   QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
>> -            qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
>> -
>> -            if (qcrypto_block_encrypt(s->crypto,
>> -                                      (s->crypt_physical_offset ?
>> -                                       cluster_offset + offset_in_cluster :
>> -                                       offset),
>> -                                      cluster_data,
>> -                                      cur_bytes, NULL) < 0) {
>> -                ret = -EIO;
>> -                goto fail;
>> -            }
>> -
>> -            qemu_iovec_reset(&hd_qiov);
>> -            qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
>> -        }
>> -
>> -        /* If we need to do COW, check if it's possible to merge the
>> -         * writing of the guest data together with that of the COW regions.
>> -         * If it's not possible (or not necessary) then write the
>> -         * guest data now. */
>> -        if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
>> -            BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
>> -            trace_qcow2_writev_data(qemu_coroutine_self(),
>> -                                    cluster_offset + offset_in_cluster);
>> -            ret = bdrv_co_pwritev(bs->file,
>> -                                  cluster_offset + offset_in_cluster,
>> -                                  cur_bytes, &hd_qiov, 0);
>> -            if (ret < 0) {
>> -                qemu_co_mutex_lock(&s->lock);
>> -                goto fail;
>> -            }
>> +        ret = qcow2_co_do_pwritev(bs, cluster_offset, offset, cur_bytes,
>> +                                  qiov, bytes_done, l2meta);
>> +        l2meta = NULL; /* l2meta is consumed by qcow2_co_do_pwritev() */
>> +        if (ret < 0) {
>> +            goto fail_nometa;
>>           }
>>   
>>           qemu_co_mutex_lock(&s->lock);
>>   
>> -        ret = qcow2_handle_l2meta(bs, &l2meta, true);
>> -        if (ret) {
>> -            goto fail;
>> -        }
>> -
>>           bytes -= cur_bytes;
>>           offset += cur_bytes;
>>           bytes_done += cur_bytes;
>> @@ -2331,6 +2363,8 @@ fail:
>>   
>>       qemu_co_mutex_unlock(&s->lock);
>>   
>> +fail_nometa:
>> +
> I'd remove the blank line (because we usually don't have blank lines
> below labels).
>
>>       qemu_iovec_destroy(&hd_qiov);
>>       qemu_vfree(cluster_data);
> cluster_data and hd_qiov are unused now.
>
> Max
>
>>       trace_qcow2_writev_done_req(qemu_coroutine_self(), ret);
>>
>


-- 
Best regards,
Vladimir
