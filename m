Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d1OmN-00047n-EW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d1OmM-0005FT-89
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 22:58:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170420100045.GB4747@noname.redhat.com>
References: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
	<20170420100045.GB4747@noname.redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 21 Apr 2017 10:58:36 +0800
Message-ID: <CAOGPPbcWmuysTJzuYS9vA2m6QBBmTnP9PLC-qXdU0u83hvj6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-img: use blk_co_pwrite_zeroes for
 zero sectors when compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 20, 2017 at 6:00 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 20.04.2017 um 10:38 hat jemmy858585@gmail.com geschrieben:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> when the buffer is zero, blk_co_pwrite_zeroes is more effectively than
>> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces
>> the time when converts the qcow2 image with lots of zero.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> Good catch, using blk_co_pwrite_zeroes() makes sense even for compressed
> images.
>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index b220cf7..0256539 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1675,13 +1675,20 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>>               * write if the buffer is completely zeroed and we're allowed to
>>               * keep the target sparse. */
>>              if (s->compressed) {
>> -                if (s->has_zero_init && s->min_sparse &&
>> -                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
>> -                {
>> -                    assert(!s->target_has_backing);
>> -                    break;
>> +                if (buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)) {
>> +                    if (s->has_zero_init && s->min_sparse) {
>> +                        assert(!s->target_has_backing);
>> +                        break;
>> +                    } else {
>> +                        ret = blk_co_pwrite_zeroes(s->target,
>> +                                           sector_num << BDRV_SECTOR_BITS,
>> +                                           n << BDRV_SECTOR_BITS, 0);
>> +                        if (ret < 0) {
>> +                            return ret;
>> +                        }
>> +                        break;
>> +                    }
>>                  }
>
> If s->min_sparse == 0, we may neither skip the write not use
> blk_co_pwrite_zeroes(), because this requires actual full allocation
> with explicit zero sectors.
>
> Of course, if you fix this, what you end up with here is a duplicate of
> the code path for non-compressed images. The remaining difference seems
> to be the BDRV_REQ_WRITE_COMPRESSED flag and buffer_is_zero() vs.
> is_allocated_sectors_min() (because uncompressed clusters can be written
> partially, but compressed clusters can't).

I have a try to unify the code.

I don't understand why use  is_allocated_sectors_min when don't compressed.
the s->min_sparse is 8 default, which is smaller than cluster_sectors.

if a cluster which data is  8 sector zero and 8 sector non-zero
repeated, it will call
blk_co_pwritev and blk_co_pwrite_zeroes many times for a cluster.

why not compare the zero by cluster_sectors size?

>
> So I suppose that instead of just fixing the above bug, we could actually
> mostly unify the two code paths, if you want to have a try at it.
>
> Kevin
