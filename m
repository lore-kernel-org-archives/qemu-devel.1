Received: from eggs.gnu.org ([209.51.188.92]:46963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBfYv-0005Jf-2M
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBfYt-0002de-4K
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:04:16 -0400
Date: Wed, 3 Apr 2019 15:03:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190403130354.GA6108@localhost.localdomain>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403030526.12258-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] block: Fix BDRV_BLOCK_RAW status to
 honor alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>

Am 03.04.2019 um 05:05 hat Eric Blake geschrieben:
> Previous patches mentioned how the blkdebug filter driver demonstrates
> a bug present in our NBD server; the bug is also present with the raw
> format driver when probing occurs. Basically, if we specify a
> particular alignment > 1, but defer the actual block status to the
> underlying file, and the underlying file has a smaller alignment, then
> the use of BDRV_BLOCK_RAW to defer to the underlying file can end up
> with status split at an alignment unacceptable to our layer.  Many
> callers don't care, but NBD does - it is a violation of the NBD
> protocol to send status or read results split on an unaligned boundary
> (we've taught our client to be tolerant of such violations because of
> qemu 3.1; but we still need to fix our server for the sake of other
> stricter clients).
> 
> This patch lays the groundwork - it adjusts bdrv_block_status to
> ensure that any time one layer defers to another via BDRV_BLOCK_RAW,
> the deferral is either truncated down to an aligned boundary, or
> multiple sub-aligned requests are coalesced into a single
> representative answer (using an implicit hole beyond EOF as
> needed). Iotest 241 exposes the effect (when format probing occurred,
> we don't want block status to subdivide the initial sector, and thus
> not any other sector either). Similarly, iotest 221 is a good
> candidate to amend to specifically track the effects; a change to a
> hole at EOF is not visible if an upper layer does not want alignment
> smaller than 512. However, this patch alone is not a complete fix - it
> is still possible to have an active layer with large alignment
> constraints backed by another layer with smaller constraints; so the
> next patch will complete the task.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c                 | 108 +++++++++++++++++++++++++++++++++++--
>  tests/qemu-iotests/221     |  10 ++++
>  tests/qemu-iotests/221.out |   6 +++
>  tests/qemu-iotests/241.out |   3 +-
>  4 files changed, 122 insertions(+), 5 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index dfc153b8d82..936877d3745 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2021,6 +2021,97 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
>      return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>  }
> 
> +static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
> +                                             bool want_zero,
> +                                             int64_t offset, int64_t bytes,
> +                                             int64_t *pnum, int64_t *map,
> +                                             BlockDriverState **file);
> +
> +/*
> + * Returns an aligned allocation status of the specified sectors.
> + * Wrapper around bdrv_co_block_status() which requires the initial
> + * offset and count to be aligned, and guarantees the result will also
> + * be aligned (even if it requires piecing together multiple
> + * sub-aligned queries into an appropriate coalesced answer).
> + */

I think this comment should specify the result of the operation when the
aligned region consists of multiple subregions with different status.
Probably something like this:

- BDRV_BLOCK_DATA is set if the flag is set for at least one subregion
- BDRV_BLOCK_ZERO is set if the flag is set for all subregions
- BDRV_BLOCK_OFFSET_VALID is set if the flag is set for all subregions,
  the provided offsets are contiguous and file is the same for all
  subregions.
- BDRV_BLOCK_ALLOCATED is never set here (the caller sets it)
- BDRV_BLOCK_EOF is set if the last subregion sets it; assert that it's
  not set for any other subregion
- BDRV_BLOCK_RAW is never set

- *map is only set if BDRV_BLOCK_OFFSET_VALID is set. It contains
  the offset of the first subregion then.

- *file is also only set if BDRV_BLOCK_OFFSET_VALID is set. It contains
  the *file of the subregions, which must be the same for all of them
  (otherwise, we wouldn't have set BDRV_BLOCK_OFFSET_VALID).

- *pnum: The sum of all subregions

> +static int coroutine_fn bdrv_co_block_status_aligned(BlockDriverState *bs,
> +                                                     uint32_t align,
> +                                                     bool want_zero,
> +                                                     int64_t offset,
> +                                                     int64_t bytes,
> +                                                     int64_t *pnum,
> +                                                     int64_t *map,
> +                                                     BlockDriverState **file)
> +{
> +    int ret;
> +
> +    assert(is_power_of_2(align) && QEMU_IS_ALIGNED(offset | bytes, align));
> +    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    if (!*pnum) {
> +        assert(!bytes || ret & BDRV_BLOCK_EOF);
> +        return ret;
> +    }
> +    if (*pnum >= align) {
> +        if (!QEMU_IS_ALIGNED(*pnum, align)) {
> +            ret &= ~BDRV_BLOCK_EOF;
> +            *pnum = QEMU_ALIGN_DOWN(*pnum, align);
> +        }
> +        return ret;
> +    }

So we decide to just shorten the function if we can return at least some
*pnum > 0. This means that is most cases, this function will have to be
called twice, once for the aligned part, and again for the misaligned
rest.

We do save a little if the caller isn't actually interested in mapping
the whole image, but just in a specific range before the misaligned
part.

So it depends on the use case whether this is an optimisation or a
pessimisation.

> +    /* Merge in status for the rest of align */
> +    while (*pnum < align) {

Okay, in any case, I can see it's a simplification. :-)

> +        int ret2;
> +        int64_t pnum2;
> +        int64_t map2;
> +        BlockDriverState *file2;
> +
> +        ret2 = bdrv_co_block_status(bs, want_zero, offset + *pnum,
> +                                    align - *pnum, &pnum2,
> +                                    map ? &map2 : NULL, file ? &file2 : NULL);
> +        if (ret2 < 0) {
> +            return ret2;
> +        }
> +        if (ret2 & BDRV_BLOCK_EOF) {
> +            ret |= BDRV_BLOCK_EOF;
> +            if (!pnum2) {
> +                pnum2 = align - *pnum;
> +                ret2 |= BDRV_BLOCK_ZERO;
> +            }
> +        } else {
> +            assert(pnum2);
> +        }
> +        if (ret2 & BDRV_BLOCK_DATA) {
> +            ret |= BDRV_BLOCK_DATA;
> +        }
> +        if (!(ret2 & BDRV_BLOCK_ZERO)) {
> +            ret &= ~BDRV_BLOCK_ZERO;
> +        }
> +        if ((ret & BDRV_BLOCK_OFFSET_VALID) &&
> +            (!(ret2 & BDRV_BLOCK_OFFSET_VALID) ||
> +             (map && *map + *pnum != map2) || (file && *file != file2))) {
> +            ret &= ~BDRV_BLOCK_OFFSET_VALID;
> +            if (map) {
> +                *map = 0;
> +            }
> +            if (file) {
> +                *file = NULL;
> +            }
> +        }
> +        if (ret2 & BDRV_BLOCK_ALLOCATED) {
> +            ret |= BDRV_BLOCK_ALLOCATED;
> +        }

Hm, so if we have a region that consists of two subregion, one is
unallocated and the other one is a zero cluster. The result will be
DATA == false, ZERO == false, ALLOCATED == true. This looks a bit odd.

Did you check this case and come to the conclusion that it's okay? If
so, I think a comment would be good.

> +        if (ret2 & BDRV_BLOCK_RAW) {
> +            assert(ret & BDRV_BLOCK_RAW);
> +            assert(ret & BDRV_BLOCK_OFFSET_VALID);
> +        }

Doesn't RAW mean that we need to recurse rather than returning the flag?
Or actually, bdrv_co_block_status() shouldn't ever return the flag, so
can't we assert that it's clear?

> +        *pnum += pnum2;
> +    }
> +    return ret;
> +}

Kevin
