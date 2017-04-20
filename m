Received: from eggs.gnu.org ([2001:4830:134:3::10]:60319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d18tT-0005qM-BW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d18tS-0002Ys-5O
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:00:55 -0400
Date: Thu, 20 Apr 2017 12:00:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170420100045.GB4747@noname.redhat.com>
References: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492677526-4739-1-git-send-email-lidongchen@tencent.com>
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
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Am 20.04.2017 um 10:38 hat jemmy858585@gmail.com geschrieben:
> From: Lidong Chen <lidongchen@tencent.com>
> 
> when the buffer is zero, blk_co_pwrite_zeroes is more effectively than
> blk_co_pwritev with BDRV_REQ_WRITE_COMPRESSED. this patch can reduces
> the time when converts the qcow2 image with lots of zero.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Good catch, using blk_co_pwrite_zeroes() makes sense even for compressed
images.

> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..0256539 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1675,13 +1675,20 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>               * write if the buffer is completely zeroed and we're allowed to
>               * keep the target sparse. */
>              if (s->compressed) {
> -                if (s->has_zero_init && s->min_sparse &&
> -                    buffer_is_zero(buf, n * BDRV_SECTOR_SIZE))
> -                {
> -                    assert(!s->target_has_backing);
> -                    break;
> +                if (buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)) {
> +                    if (s->has_zero_init && s->min_sparse) {
> +                        assert(!s->target_has_backing);
> +                        break;
> +                    } else {
> +                        ret = blk_co_pwrite_zeroes(s->target,
> +                                           sector_num << BDRV_SECTOR_BITS,
> +                                           n << BDRV_SECTOR_BITS, 0);
> +                        if (ret < 0) {
> +                            return ret;
> +                        }
> +                        break;
> +                    }
>                  }

If s->min_sparse == 0, we may neither skip the write not use
blk_co_pwrite_zeroes(), because this requires actual full allocation
with explicit zero sectors.

Of course, if you fix this, what you end up with here is a duplicate of
the code path for non-compressed images. The remaining difference seems
to be the BDRV_REQ_WRITE_COMPRESSED flag and buffer_is_zero() vs.
is_allocated_sectors_min() (because uncompressed clusters can be written
partially, but compressed clusters can't).

So I suppose that instead of just fixing the above bug, we could actually
mostly unify the two code paths, if you want to have a try at it.

Kevin
