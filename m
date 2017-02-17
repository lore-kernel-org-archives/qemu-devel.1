Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqDU-0002mh-1e
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ceqDT-0005ei-1Z
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:37:24 -0500
Date: Fri, 17 Feb 2017 16:37:15 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170217213715.GJ19045@localhost.localdomain>
References: <1487349541-10201-1-git-send-email-pl@kamp.de>
	<1487349541-10201-3-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487349541-10201-3-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nfs: try to avoid the bounce
 buffer in pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Fri, Feb 17, 2017 at 05:39:01PM +0100, Peter Lieven wrote:
> if the passed qiov contains exactly one iov we can
> pass the buffer directly.
> 
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index ab5dcc2..bb4b75f 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -295,20 +295,27 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
>      NFSClient *client = bs->opaque;
>      NFSRPC task;
>      char *buf = NULL;
> +    bool my_buffer = false;

g_free() is a nop if buf is NULL, so there is no need for the my_buffer
variable & check.

>  
>      nfs_co_init_task(bs, &task);
>  
> -    buf = g_try_malloc(bytes);
> -    if (bytes && buf == NULL) {
> -        return -ENOMEM;
> +    if (iov->niov != 1) {
> +        buf = g_try_malloc(bytes);
> +        if (bytes && buf == NULL) {
> +            return -ENOMEM;
> +        }
> +        qemu_iovec_to_buf(iov, 0, buf, bytes);
> +        my_buffer = true;
> +    } else {
> +        buf = iov->iov[0].iov_base;
>      }
>  
> -    qemu_iovec_to_buf(iov, 0, buf, bytes);
> -
>      if (nfs_pwrite_async(client->context, client->fh,
>                           offset, bytes, buf,
>                           nfs_co_generic_cb, &task) != 0) {
> -        g_free(buf);
> +        if (my_buffer) {
> +            g_free(buf);
> +        }
>          return -ENOMEM;
>      }
>  
> @@ -317,7 +324,9 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
>          qemu_coroutine_yield();
>      }
>  
> -    g_free(buf);
> +    if (my_buffer) {
> +        g_free(buf);
> +    }
>  
>      if (task.ret != bytes) {
>          return task.ret < 0 ? task.ret : -EIO;
> -- 
> 1.9.1
> 
