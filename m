Received: from eggs.gnu.org ([2001:4830:134:3::10]:56613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d3ZiH-0000Bl-Tq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d3ZiG-0002Oe-RV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:03:25 -0400
MIME-Version: 1.0
In-Reply-To: <e2c5132f-abd5-131d-c65b-b6fbdaa7b9bb@redhat.com>
References: <1492768654-11053-1-git-send-email-lidongchen@tencent.com>
	<e2c5132f-abd5-131d-c65b-b6fbdaa7b9bb@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 27 Apr 2017 11:03:23 +0800
Message-ID: <CAOGPPbdKFPWyoOHBJ3BMQROcwhZBovZ8dSvbfYdXN1NAZT8+Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 27, 2017 at 4:25 AM, Max Reitz <mreitz@redhat.com> wrote:
> On 21.04.2017 11:57, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> when the buffer is zero, blk_co_pwrite_zeroes is more effectively than
>
> s/when/When/, s/effectively/effective/
>
>> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces
>
> s/this/This/, s/reduces/reduce/
>
>> the time when converts the qcow2 image with lots of zero.
>
> s/when converts the qcow2 image/for converting qcow2 images/,
> s/zero/zero data/
>
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>> v2 changelog:
>>     unify the compressed and non-compressed code paths
>> ---
>>  qemu-img.c | 41 +++++++++++------------------------------
>>  1 file changed, 11 insertions(+), 30 deletions(-)
>
> Functionally, looks good to me. Just some stylistic nit picks:
>
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b220cf7..60c9adf 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1661,6 +1661,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>>
>>      while (nb_sectors > 0) {
>>          int n = nb_sectors;
>> +        BdrvRequestFlags flags = s->compressed ? BDRV_REQ_WRITE_COMPRESSED : 0;
>> +
>>          switch (status) {
>>          case BLK_BACKING_FILE:
>>              /* If we have a backing file, leave clusters unallocated that are
>> @@ -1670,43 +1672,21 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>>              break;
>>
>>          case BLK_DATA:
>> -            /* We must always write compressed clusters as a whole, so don't
>> -             * try to find zeroed parts in the buffer. We can only save the
>> -             * write if the buffer is completely zeroed and we're allowed to
>> -             * keep the target sparse. */
>> -            if (s->compressed) {
>> -                if (s->has_zero_init && s->min_sparse &&
>> -                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
>> -                {
>> -                    assert(!s->target_has_backing);
>> -                    break;
>> -                }
>> -
>> -                iov.iov_base = buf;
>> -                iov.iov_len = n << BDRV_SECTOR_BITS;
>> -                qemu_iovec_init_external(&qiov, &iov, 1);
>> -
>> -                ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
>> -                                     n << BDRV_SECTOR_BITS, &qiov,
>> -                                     BDRV_REQ_WRITE_COMPRESSED);
>> -                if (ret < 0) {
>> -                    return ret;
>> -                }
>> -                break;
>> -            }
>> -
>> -            /* If there is real non-zero data or we're told to keep the target
>> -             * fully allocated (-S 0), we must write it. Otherwise we can treat
>> +            /* If we're told to keep the target fully allocated (-S 0) or there
>> +             * is real non-zero data, we must write it. Otherwise we can treat
>>               * it as zero sectors. */
>
> I think we should still mention why there is a difference depending on
> s->compressed. Maybe like this:
>
> /* If we're told to keep the target fully allocated (-S 0) or there
>  * is real non-zero data, we must write it. Otherwise we can treat
>  * it as zero sectors.
>  * Compressed clusters need to be written as a whole, so in that
>  * case we can only save the write if the buffer is completely
>  * zeroed. */
>
>>              if (!s->min_sparse ||
>> -                is_allocated_sectors_min(buf, n, &n, s->min_sparse))
>> -            {
>> +                (!s->compressed &&
>> +                 is_allocated_sectors_min(buf, n, &n, s->min_sparse)) ||
>> +                (s->compressed &&
>> +                 !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))) {
>> +
>
> This newline is a bit weird. Normally we don't have newlines at the
> start of a block.
>
> If you (like me) think there should be a visual separation between the
> if condition and the block, I'd suggest keeping the opening brace { on
> its own line (as it is now).
>
Thanks for your review.

> Max
>
>>                  iov.iov_base = buf;
>>                  iov.iov_len = n << BDRV_SECTOR_BITS;
>>                  qemu_iovec_init_external(&qiov, &iov, 1);
>>
>>                  ret = blk_co_pwritev(s->target, sector_num << BDRV_SECTOR_BITS,
>> -                                     n << BDRV_SECTOR_BITS, &qiov, 0);
>> +                                     n << BDRV_SECTOR_BITS, &qiov, flags);
>>                  if (ret < 0) {
>>                      return ret;
>>                  }
>> @@ -1716,6 +1696,7 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>>
>>          case BLK_ZERO:
>>              if (s->has_zero_init) {
>> +                assert(!s->target_has_backing);
>>                  break;
>>              }
>>              ret = blk_co_pwrite_zeroes(s->target,
>>
>
>
