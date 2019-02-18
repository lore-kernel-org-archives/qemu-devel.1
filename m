Received: from eggs.gnu.org ([209.51.188.92]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpzW-0006JE-Kd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpzV-0005JM-DE
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:58:18 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-13-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8512108c-9716-dbfc-0075-2ec18f975bb9@redhat.com>
Date: Mon, 18 Feb 2019 14:58:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/12] aio-posix: Assert that aio_poll() is
 always called in home thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> aio_poll() has an existing assertion that the function is only called
> from the AioContext's home thread if blocking is allowed.
> 
> This is not enough, some handlers make assumptions about the thread they
> run in. Extend the assertion to non-blocking calls, too.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  util/aio-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 8640dfde9f..6fbfa7924f 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -613,6 +613,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
>      int64_t timeout;
>      int64_t start = 0;
>  
> +    assert(in_aio_context_home_thread(ctx));
> +
>      /* aio_notify can avoid the expensive event_notifier_set if
>       * everything (file descriptors, bottom halves, timers) will
>       * be re-evaluated before the next blocking poll().  This is
> @@ -621,7 +623,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * so disable the optimization now.
>       */
>      if (blocking) {
> -        assert(in_aio_context_home_thread(ctx));
>          atomic_add(&ctx->notify_me, 2);
>      }
>  
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
