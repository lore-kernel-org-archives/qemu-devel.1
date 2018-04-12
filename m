Received: from eggs.gnu.org ([2001:4830:134:3::10]:34501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Xq7-0004pY-58
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Xq6-0000Nw-80
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:44:19 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-17-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <953945a0-91e4-aca7-b39d-057b9234cf60@redhat.com>
Date: Thu, 12 Apr 2018 10:43:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] block: Allow AIO_WAIT_WHILE with
 NULL ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 11/04/2018 18:39, Kevin Wolf wrote:
> bdrv_drain_all() wants to have a single polling loop for draining the
> in-flight requests of all nodes. This means that the AIO_WAIT_WHILE()
> condition relies on activity in multiple AioContexts, which is polled
> from the mainloop context. We must therefore call AIO_WAIT_WHILE() from
> the mainloop thread and use the AioWait notification mechanism.
> 
> Just randomly picking the AioContext of any non-mainloop thread would
> work, but instead of bothering to find such a context in the caller, we
> can just as well accept NULL for ctx.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio-wait.h | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> index 783d3678dd..c85a62f798 100644
> --- a/include/block/aio-wait.h
> +++ b/include/block/aio-wait.h
> @@ -57,7 +57,8 @@ typedef struct {
>  /**
>   * AIO_WAIT_WHILE:
>   * @wait: the aio wait object
> - * @ctx: the aio context
> + * @ctx: the aio context, or NULL if multiple aio contexts (for which the
> + *       caller does not hold a lock) are involved in the polling condition.
>   * @cond: wait while this conditional expression is true
>   *
>   * Wait while a condition is true.  Use this to implement synchronous
> @@ -75,7 +76,7 @@ typedef struct {
>      bool waited_ = false;                                          \
>      AioWait *wait_ = (wait);                                       \
>      AioContext *ctx_ = (ctx);                                      \
> -    if (in_aio_context_home_thread(ctx_)) {                        \
> +    if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
>          while ((cond)) {                                           \
>              aio_poll(ctx_, true);                                  \
>              waited_ = true;                                        \
> @@ -86,9 +87,13 @@ typedef struct {
>          /* Increment wait_->num_waiters before evaluating cond. */ \
>          atomic_inc(&wait_->num_waiters);                           \
>          while ((cond)) {                                           \
> -            aio_context_release(ctx_);                             \
> +            if (ctx_) {                                            \
> +                aio_context_release(ctx_);                         \
> +            }                                                      \
>              aio_poll(qemu_get_aio_context(), true);                \
> -            aio_context_acquire(ctx_);                             \
> +            if (ctx_) {                                            \
> +                aio_context_acquire(ctx_);                         \
> +            }                                                      \
>              waited_ = true;                                        \
>          }                                                          \
>          atomic_dec(&wait_->num_waiters);                           \
> 

Looks good.

Paolo
