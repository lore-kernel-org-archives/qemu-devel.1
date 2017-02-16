Received: from eggs.gnu.org ([2001:4830:134:3::10]:43885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceOLo-0004mV-ON
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceOLn-0006Y2-GF
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:52:08 -0500
Date: Thu, 16 Feb 2017 10:51:59 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170216155159.GE8801@localhost.localdomain>
References: <20170216084318.11122-1-jazeltq@gmail.com>
	<20170216090002.12511-1-jazeltq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216090002.12511-1-jazeltq@gmail.com>
Subject: Re: [Qemu-devel] [RFC v5] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jazeltq@gmail.com
Cc: jdurgin@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, eblake@redhat.com, tianqing <tianqing@unitedstack.com>

On Thu, Feb 16, 2017 at 05:00:02PM +0800, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
> 
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
> 
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---
>  block/rbd.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index a57b3e3..75ae1d6 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -47,7 +47,7 @@
>   */
>  
>  /* rbd_aio_discard added in 0.1.2 */
> -#if LIBRBD_VERSION_CODE >= LIBRBD_VERSION(0, 1, 2)
> +#if LIBRBD_VERSION_CODE >= LIBRBD_VERSION(12, 0, 0)
>  #define LIBRBD_SUPPORTS_DISCARD
>  #else
>  #undef LIBRBD_SUPPORTS_DISCARD
> @@ -73,7 +73,12 @@ typedef struct RBDAIOCB {
>      BlockAIOCB common;
>      int64_t ret;
>      QEMUIOVector *qiov;
> +/* Note:
> + * The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h.
> + */

I understand that since this feature relies on new symbols in the library,
the ifdef can't be entirely avoided.  However, there are a few changes that
can make the code much more readable, and greatly reduce the use of ifdefs
through the code.


For instance, you could have helper constants:

#ifdef LIBRBD_SUPPORTS_IOVEC
#define LIBRBD_USE_IOVEC    1
#else
#define LIBRBD_USE_IOVEC    0
#endif

Now that can be used for a more natural code, with minimal ifdefs.  The
compiler optimizations should still remove the code, as well.


A helper function for memset will also keep things simpler:

static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
{
    if (LIBRBD_USE_IOVEC) {
        RBDAIOCB *acb = rcb->acb;
        iov_memset(acb->qiov->iov, acb->qiov->niov, offs, 0,
                   acb->qiov->size - offs);
    } else {
        memset(rcb->buf + offs, 0, rcb->size - offs);
    }
}
            


> +#ifndef LIBRBD_SUPPORTS_IOVEC
>      char *bounce;
> +#endif

This conditional can go away (see [1]).

>      RBDAIOCmd cmd;
>      int error;
>      struct BDRVRBDState *s;
> @@ -83,7 +88,9 @@ typedef struct RADOSCB {
>      RBDAIOCB *acb;
>      struct BDRVRBDState *s;
>      int64_t size;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>      char *buf;
> +#endif

As can this.

>      int64_t ret;
>  } RADOSCB;
>  
> @@ -426,11 +433,21 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>          }
>      } else {
>          if (r < 0) {
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>              memset(rcb->buf, 0, rcb->size);
> +#else
> +            iov_memset(acb->qiov->iov, acb->qiov->niov, 0, 0, acb->qiov->size);
> +#endif

This just becomes:

qemu_rbd_memset(rcb, 0);

>              acb->ret = r;
>              acb->error = 1;
>          } else if (r < rcb->size) {
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>              memset(rcb->buf + r, 0, rcb->size - r);
> +#else
> +            iov_memset(acb->qiov->iov, acb->qiov->niov,
> +                       r, 0, acb->qiov->size - r);
> +#endif
> +

Same here:

qemu_rbd_memset(rcb, r);


>              if (!acb->error) {
>                  acb->ret = rcb->size;
>              }
> @@ -441,10 +458,12 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>  
>      g_free(rcb);
>  
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>      if (acb->cmd == RBD_AIO_READ) {
>          qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
>      }
>      qemu_vfree(acb->bounce);
> +#endif

[1]

Instead of a conditional, you can now use the constant with an if statement:

if (!LIBRBD_USE_IOVEC) {
      if (acb->cmd == RBD_AIO_READ) {
          qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
      }
      qemu_vfree(acb->bounce);
}


>      acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
>  
>      qemu_aio_unref(acb);
> @@ -655,8 +674,10 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      RBDAIOCB *acb;
>      RADOSCB *rcb = NULL;
>      rbd_completion_t c;
> -    char *buf;
>      int r;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
> +    char *buf = NULL;
> +#endif

This variable can completely go away with some code re-arrangement (below)

>  
>      BDRVRBDState *s = bs->opaque;
>
> @@ -664,6 +685,8 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      acb->cmd = cmd;
>      acb->qiov = qiov;
>      assert(!qiov || qiov->size == size);

[2]

Allocate rcb here

> +#ifndef LIBRBD_SUPPORTS_IOVEC
> +

You can use if(!LIBRBD_USE_IOVEC) here then.

>      if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
>          acb->bounce = NULL;
>      } else {
> @@ -672,19 +695,21 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>              goto failed;
>          }
>      }
> -    acb->ret = 0;
> -    acb->error = 0;
> -    acb->s = s;
> -
>      if (cmd == RBD_AIO_WRITE) {
>          qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
>      }
> -
>      buf = acb->bounce;

This can just become rcb->buf = acb->bounce

> +#endif

> +    acb->ret = 0;
> +    acb->error = 0;
> +    acb->s = s;
>  
>      rcb = g_new(RADOSCB, 1);

Move this to [2]

> +
>      rcb->acb = acb;
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>      rcb->buf = buf;
> +#endif

These 3 lines can then go away

>      rcb->s = acb->s;
>      rcb->size = size;
>      r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
> @@ -694,10 +719,18 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>  
>      switch (cmd) {
>      case RBD_AIO_WRITE:
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>          r = rbd_aio_write(s->image, off, size, buf, c);

If you use rcb->buf here, that allows buf to go away completely.

> +#else
> +        r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
> +#endif
>          break;
>      case RBD_AIO_READ:
> +#ifndef LIBRBD_SUPPORTS_IOVEC
>          r = rbd_aio_read(s->image, off, size, buf, c);

Same

> +#else
> +        r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
> +#endif
>          break;
>      case RBD_AIO_DISCARD:
>          r = rbd_aio_discard_wrapper(s->image, off, size, c);
> @@ -719,7 +752,9 @@ failed_completion:
>      rbd_aio_release(c);
>  failed:
>      g_free(rcb);
> +#ifndef LIBRBD_SUPPORTS_IOVEC

And use the if(!LIBRBD_USE_IOVEC) here too.

>      qemu_vfree(acb->bounce);
> +#endif
>      qemu_aio_unref(acb);
>      return NULL;
>  }
> -- 
> 2.10.2
> 

-Jeff
