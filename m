Received: from eggs.gnu.org ([2001:4830:134:3::10]:51475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0LuS-0005kO-VZ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0LuR-0008G4-4o
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:19:28 -0400
Date: Thu, 13 Sep 2018 15:19:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913071917.GN2526@lemon.usersys.redhat.com>
References: <20180912171040.1732-1-pbonzini@redhat.com>
	<20180912171040.1732-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912171040.1732-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] aio-posix: do skip system call if
 ctx->notifier polling succeeds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, stefanha@redhat.com

On Wed, 09/12 19:10, Paolo Bonzini wrote:
> Commit 70232b5253 ("aio-posix: Don't count ctx->notifier as progress when
> 2018-08-15), by not reporting progress, causes aio_poll to execute the
> system call when polling succeeds because of ctx->notifier.  This introduces
> latency before the call to aio_bh_poll() and negates the advantages of
> polling, unfortunately.
> 
> The fix builds on the previous patch, separating the effect of polling on
> the timeout from the progress reported to aio_poll().  ctx->notifier
> does zero the timeout, causing the caller to skip the system call,
> but it does not report progress, so that the bug fix of commit 70232b5253
> still stands.
> 
> Fixes: 70232b5253a3c4e03ed1ac47ef9246a8ac66c6fa
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/aio-posix.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 21d8987179..efa79b9e62 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -498,10 +498,11 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
>      QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
>          if (!node->deleted && node->io_poll &&
>              aio_node_check(ctx, node->is_external) &&
> -            node->io_poll(node->opaque) &&
> -            node->opaque != &ctx->notifier) {
> +            node->io_poll(node->opaque)) {
>              *timeout = 0;
> -            progress = true;
> +            if (node->opaque != &ctx->notifier) {
> +                progress = true;
> +            }
>          }
>  
>          /* Caller handles freeing deleted nodes.  Don't do it here. */
> -- 
> 2.17.1
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
