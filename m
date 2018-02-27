Received: from eggs.gnu.org ([2001:4830:134:3::10]:41927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqZwE-00047o-27
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqZwC-0002ro-QS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 02:44:38 -0500
Date: Tue, 27 Feb 2018 15:44:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180227074413.GB21035@lemon.usersys.redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122220806.22154-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/16] block/mirror: Convert to
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/22 23:07, Max Reitz wrote:
> @@ -101,7 +105,7 @@ static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
>      }
>  }
>  
> -static void mirror_iteration_done(MirrorOp *op, int ret)
> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
>  {
>      MirrorBlockJob *s = op->s;
>      struct iovec *iov;

I think we want s/qemu_coroutine_enter/aio_co_wake/ in mirror_iteration_done().
As an AIO callback before, this didn't matter, but now we are in an terminating
coroutine, so it is pointless to defer the termination, or even risky in that we
are in a aio_context_acquire/release section, but have already decremented
s->in_flight, which is fishy.

> @@ -138,9 +142,8 @@ static void mirror_iteration_done(MirrorOp *op, int ret)
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
> @@ -157,9 +160,8 @@ static void mirror_write_complete(void *opaque, int ret)
>      aio_context_release(blk_get_aio_context(s->common.blk));
>  }
>  
> -static void mirror_read_complete(void *opaque, int ret)
> +static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
>  {
> -    MirrorOp *op = opaque;
>      MirrorBlockJob *s = op->s;
>  
>      aio_context_acquire(blk_get_aio_context(s->common.blk));
> @@ -174,8 +176,11 @@ static void mirror_read_complete(void *opaque, int ret)
>  
>          mirror_iteration_done(op, ret);
>      } else {
> -        blk_aio_pwritev(s->target, op->offset, &op->qiov,
> -                        0, mirror_write_complete, op);
> +        int ret;

s/ret/ret2/ or drop the definition?
because ret is already the paramter of the function.

> +
> +        ret = blk_co_pwritev(s->target, op->offset,
> +                             op->qiov.size, &op->qiov, 0);
> +        mirror_write_complete(op, ret);
>      }
>      aio_context_release(blk_get_aio_context(s->common.blk));
>  }

<snip>

> +static void coroutine_fn mirror_co_discard(void *opaque)
> +{
> +    MirrorOp *op = opaque;
> +    int ret;
> +
> +    op->s->in_flight++;
> +    op->s->bytes_in_flight += op->bytes;
> +    *op->bytes_handled = op->bytes;
> +
> +    ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes);
> +    mirror_write_complete(op, ret);
>  }
>  
>  static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
>                                 unsigned bytes, MirrorMethod mirror_method)

Doesn't mirror_perform need coroutine_fn annotation too?

>  {

Fam
