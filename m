Received: from eggs.gnu.org ([2001:4830:134:3::10]:37414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cg2PG-000400-EO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cg2PF-0006Yr-JS
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:50:30 -0500
Date: Mon, 20 Feb 2017 23:50:21 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170221045021.GN19045@localhost.localdomain>
References: <20170221034336.10097-1-jazeltq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221034336.10097-1-jazeltq@gmail.com>
Subject: Re: [Qemu-devel] [RFC v6] RBD: Add support readv,writev for rbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jazeltq@gmail.com
Cc: jdurgin@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

On Tue, Feb 21, 2017 at 11:43:36AM +0800, jazeltq@gmail.com wrote:
> From: tianqing <tianqing@unitedstack.com>
> 
> Rbd can do readv and writev directly, so wo do not need to transform
> iov to buf or vice versa any more.
> 
> Signed-off-by: tianqing <tianqing@unitedstack.com>
> ---
>  block/rbd.c | 79 ++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 


[...]

>      case RBD_AIO_WRITE:
> -        r = rbd_aio_write(s->image, off, size, buf, c);
> +        if(!LIBRBD_USE_IOVEC)
> +            r = rbd_aio_write(s->image, off, size, rcb->buf, c);
> +        else
> +            r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
>          break;
>      case RBD_AIO_READ:
> -        r = rbd_aio_read(s->image, off, size, buf, c);
> +        if(!LIBRBD_USE_IOVEC)
> +            r = rbd_aio_read(s->image, off, size, rcb->buf, c);
> +        else
> +            r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);

These will need to stay #ifdef's since they are new symbols.

>          break;
>      case RBD_AIO_DISCARD:
>          r = rbd_aio_discard_wrapper(s->image, off, size, c);
> @@ -712,14 +740,15 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      if (r < 0) {
>          goto failed_completion;
>      }
> -
>      return &acb->common;
>  
>  failed_completion:
>      rbd_aio_release(c);
>  failed:
>      g_free(rcb);
> -    qemu_vfree(acb->bounce);
> +    if(!LIBRBD_USE_IOVEC)
> +        qemu_vfree(acb->bounce);
> +
>      qemu_aio_unref(acb);
>      return NULL;
>  }
> -- 
> 2.10.2
>

(Also code formatting as pointed out by patchew)
