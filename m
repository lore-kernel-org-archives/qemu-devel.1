Received: from eggs.gnu.org ([2001:4830:134:3::10]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQBC-0004PL-BI
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQBB-0005CG-Ck
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:39:34 -0400
Date: Mon, 13 Aug 2018 23:39:23 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180814033923.GC3254@localhost.localdomain>
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813022006.7216-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/17] mirror: Pull *_align_for_copy() from
 *_co_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Mon, Aug 13, 2018 at 04:19:52AM +0200, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/mirror.c | 54 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index c28b6159d5..34cb8293b2 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -305,42 +305,60 @@ static inline void coroutine_fn
>      mirror_co_wait_for_any_operation(s, false);
>  }
>  
> -/* Perform a mirror copy operation.
> +/*
> + * Restrict *bytes to how much we can actually handle, and align the
> + * [*offset, *bytes] range to clusters if COW is needed.
>   *
> - * *op->bytes_handled is set to the number of bytes copied after and
> + * *bytes_handled is set to the number of bytes copied after and
>   * including offset, excluding any bytes copied prior to offset due
> - * to alignment.  This will be op->bytes if no alignment is necessary,
> - * or (new_end - op->offset) if the tail is rounded up or down due to
> + * to alignment.  This will be *bytes if no alignment is necessary, or
> + * (new_end - *offset) if the tail is rounded up or down due to
>   * alignment or buffer limit.
>   */
> -static void coroutine_fn mirror_co_read(void *opaque)
> +static void mirror_align_for_copy(MirrorBlockJob *s,
> +                                  int64_t *offset, uint64_t *bytes,
> +                                  int64_t *bytes_handled)
>  {
> -    MirrorOp *op = opaque;
> -    MirrorBlockJob *s = op->s;
> -    int nb_chunks;
> -    uint64_t ret;
>      uint64_t max_bytes;
>  
>      max_bytes = s->granularity * s->max_iov;
>  
>      /* We can only handle as much as buf_size at a time. */
> -    op->bytes = MIN(s->buf_size, MIN(max_bytes, op->bytes));
> -    assert(op->bytes);
> -    assert(op->bytes < BDRV_REQUEST_MAX_BYTES);
> -    *op->bytes_handled = op->bytes;
> +    *bytes = MIN(s->buf_size, MIN(max_bytes, *bytes));
> +    assert(*bytes);
> +    assert(*bytes < BDRV_REQUEST_MAX_BYTES);
> +    *bytes_handled = *bytes;
>  
>      if (s->cow_bitmap) {
> -        *op->bytes_handled += mirror_cow_align(s, &op->offset, &op->bytes);
> +        *bytes_handled += mirror_cow_align(s, offset, bytes);
>      }
>      /* Cannot exceed BDRV_REQUEST_MAX_BYTES + INT_MAX */
> -    assert(*op->bytes_handled <= UINT_MAX);
> -    assert(op->bytes <= s->buf_size);
> +    assert(*bytes_handled <= UINT_MAX);
> +    assert(*bytes <= s->buf_size);
>      /* The offset is granularity-aligned because:
>       * 1) Caller passes in aligned values;
>       * 2) mirror_cow_align is used only when target cluster is larger. */
> -    assert(QEMU_IS_ALIGNED(op->offset, s->granularity));
> +    assert(QEMU_IS_ALIGNED(*offset, s->granularity));
>      /* The range is sector-aligned, since bdrv_getlength() rounds up. */
> -    assert(QEMU_IS_ALIGNED(op->bytes, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(*bytes, BDRV_SECTOR_SIZE));
> +}
> +
> +/* Perform a mirror copy operation.
> + *
> + * *op->bytes_handled is set to the number of bytes copied after and
> + * including offset, excluding any bytes copied prior to offset due
> + * to alignment.  This will be op->bytes if no alignment is necessary,
> + * or (new_end - op->offset) if the tail is rounded up or down due to
> + * alignment or buffer limit.
> + */
> +static void coroutine_fn mirror_co_read(void *opaque)
> +{
> +    MirrorOp *op = opaque;
> +    MirrorBlockJob *s = op->s;
> +    int nb_chunks;
> +    uint64_t ret;
> +
> +    mirror_align_for_copy(s, &op->offset, &op->bytes, op->bytes_handled);
>      nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
>  
>      while (s->buf_free_count < nb_chunks) {
> -- 
> 2.17.1
> 
