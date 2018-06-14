Received: from eggs.gnu.org ([2001:4830:134:3::10]:47112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTU5N-0006Yx-IF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTU5M-0003WF-FP
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:22:53 -0400
Date: Thu, 14 Jun 2018 17:22:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614152239.GJ8564@localhost.localdomain>
References: <20180613181823.13618-1-mreitz@redhat.com>
	<20180613181823.13618-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613181823.13618-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/14] block/mirror: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

Am 13.06.2018 um 20:18 hat Max Reitz geschrieben:
> In order to talk to the source BDS (and maybe in the future to the
> target BDS as well) directly, we need to convert our existing AIO
> requests into coroutine I/O requests.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/mirror.c | 152 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 90 insertions(+), 62 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index f5e240611b..47122482ff 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -78,6 +78,10 @@ typedef struct MirrorOp {
>      QEMUIOVector qiov;
>      int64_t offset;
>      uint64_t bytes;
> +
> +    /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
> +     * mirror_co_discard() before yielding for the first time */
> +    int64_t *bytes_handled;

Should we at least document that this becomes invalid after the
MirrorOp coroutine has yielded for the first time because it points to a
stack variable of the caller which returns then?

>  } MirrorOp;
>  
>  typedef enum MirrorMethod {
> @@ -99,7 +103,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
>      }
>  }
>  
> -static void mirror_iteration_done(MirrorOp *op, int ret)
> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
>  {
>      MirrorBlockJob *s = op->s;
>      struct iovec *iov;
> @@ -136,9 +140,8 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
>      }
>  }
>  
> -static void mirror_write_complete(void *opaque, int ret)
> +static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
>  {
> -    MirrorOp *op = opaque;
>      MirrorBlockJob *s = op->s;
>  
>      aio_context_acquire(blk_get_aio_context(s->common.blk));
> @@ -155,9 +158,8 @@ static void mirror_write_complete(void *opaque, int ret)
>      aio_context_release(blk_get_aio_context(s->common.blk));
>  }

One of the effects of this conversion is that we hold the AioContext
lock for s->common.blk recursively multiple times. I don't think
anything calls drain in such sections (which would hang), so it's
probably okay, but it could turn out to be a trap in the long run.

> -static void mirror_read_complete(void *opaque, int ret)
> +static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>  {
> -    MirrorOp *op = opaque;
>      MirrorBlockJob *s = op->s;
>  
>      aio_context_acquire(blk_get_aio_context(s->common.blk));
> @@ -172,8 +174,9 @@ static void mirror_read_complete(void *opaque, int ret)
>  
>          mirror_iteration_done(op, ret);
>      } else {
> -        blk_aio_pwritev(s->target, op->offset, &op->qiov,
> -                        0, mirror_write_complete, op);
> +        ret = blk_co_pwritev(s->target, op->offset,
> +                             op->qiov.size, &op->qiov, 0);
> +        mirror_write_complete(op, ret);
>      }
>      aio_context_release(blk_get_aio_context(s->common.blk));
>  }
> @@ -230,60 +233,57 @@ static inline void mirror_wait_for_io(MirrorBlockJob *s)
>      s->waiting_for_io = false;
>  }
>  
> -/* Submit async read while handling COW.
> - * Returns: The number of bytes copied after and including offset,
> - *          excluding any bytes copied prior to offset due to alignment.
> - *          This will be @bytes if no alignment is necessary, or
> - *          (new_end - offset) if tail is rounded up or down due to
> - *          alignment or buffer limit.
> +/* Perform a mirror copy operation.
> + *
> + * *op->bytes_handled is set to the number of bytes copied after and
> + * including offset, excluding any bytes copied prior to offset due
> + * to alignment.  This will be op->bytes if no alignment is necessary,
> + * or (new_end - op->offset) if the tail is rounded up or down due to
> + * alignment or buffer limit.
>   */
> -static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
> -                               uint64_t bytes)
> +static void coroutine_fn mirror_co_read(void *opaque)
>  {
> +    MirrorOp *op = opaque;
> +    MirrorBlockJob *s = op->s;
>      BlockBackend *source = s->common.blk;
>      int nb_chunks;
>      uint64_t ret;
> -    MirrorOp *op;
>      uint64_t max_bytes;
>  
>      max_bytes = s->granularity * s->max_iov;
>  
>      /* We can only handle as much as buf_size at a time. */
> -    bytes = MIN(s->buf_size, MIN(max_bytes, bytes));
> -    assert(bytes);
> -    assert(bytes < BDRV_REQUEST_MAX_BYTES);
> -    ret = bytes;
> +    op->bytes = MIN(s->buf_size, MIN(max_bytes, op->bytes));
> +    assert(op->bytes);
> +    assert(op->bytes < BDRV_REQUEST_MAX_BYTES);
> +    *op->bytes_handled = op->bytes;
>  
>      if (s->cow_bitmap) {
> -        ret += mirror_cow_align(s, &offset, &bytes);
> +        *op->bytes_handled += mirror_cow_align(s, &op->offset, &op->bytes);
>      }

Actually, if we factor out this block, call it from mirror_perform() and
only assert the conditions here, we could get completely rid of that
peculiar op->bytes_handled.

Kevin
