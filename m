Received: from eggs.gnu.org ([2001:4830:134:3::10]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gUpsM-0000C8-DF
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gUpsH-0004JD-9d
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:23:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gUpsG-0004Iq-To
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:23:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id m22so231947wml.3
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 01:23:12 -0800 (PST)
References: <20181116190211.17622-1-remy.noel@blade-group.com>
	<20181116190211.17622-3-remy.noel@blade-group.com>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <b7b35303-6043-6830-3b55-2129eb69e2bc@blade-group.com>
Date: Thu, 6 Dec 2018 10:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181116190211.17622-3-remy.noel@blade-group.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] util/aio-posix: Use RCU for handler insertion.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

I did some tests and noticed the second and third patch to incur some 
performance loss (on a scenario using virtio device)

I will therefore resubmit just the first patch alone.

On 11/16/18 8:02 PM, remy.noel@blade-group.com wrote:
> From: Remy Noel <remy.noel@blade-group.com>
>
> get rid of the delete attribute.
>
> We still need to get rid of the context list lock.
>
> Signed-off-by: Remy Noel <remy.noel@blade-group.com>
> ---
>   util/aio-posix.c | 75 ++++++++++++++++++++++--------------------------
>   util/aio-win32.c | 43 ++++++++++-----------------
>   2 files changed, 49 insertions(+), 69 deletions(-)
>
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index b34d97292a..83db3f65f4 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -16,6 +16,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu-common.h"
>   #include "block/block.h"
> +#include "qemu/rcu.h"
>   #include "qemu/rcu_queue.h"
>   #include "qemu/sockets.h"
>   #include "qemu/cutils.h"
> @@ -26,13 +27,14 @@
>   
>   struct AioHandler
>   {
> +    struct rcu_head rcu;
> +
>       GPollFD pfd;
>       IOHandler *io_read;
>       IOHandler *io_write;
>       AioPollFn *io_poll;
>       IOHandler *io_poll_begin;
>       IOHandler *io_poll_end;
> -    int deleted;
>       void *opaque;
>       bool is_external;
>       QLIST_ENTRY(AioHandler) node;
> @@ -65,19 +67,25 @@ static bool aio_epoll_try_enable(AioContext *ctx)
>   {
>       AioHandler *node;
>       struct epoll_event event;
> +    int r = 0;
> +
>   
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> -        int r;
> -        if (node->deleted || !node->pfd.events) {
> +        if (!node->pfd.events) {
>               continue;
>           }
>           event.events = epoll_events_from_pfd(node->pfd.events);
>           event.data.ptr = node;
>           r = epoll_ctl(ctx->epollfd, EPOLL_CTL_ADD, node->pfd.fd, &event);
>           if (r) {
> -            return false;
> +            break;
>           }
>       }
> +    rcu_read_unlock();
> +    if (r) {
> +        return false;
> +    }
>       ctx->epoll_enabled = true;
>       return true;
>   }
> @@ -193,14 +201,13 @@ static AioHandler *find_aio_handler(AioContext *ctx, int fd)
>   
>       QLIST_FOREACH(node, &ctx->aio_handlers, node) {
>           if (node->pfd.fd == fd)
> -            if (!node->deleted)
> -                return node;
> +            return node;
>       }
>   
>       return NULL;
>   }
>   
> -static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
> +static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
>   {
>       /* If the GSource is in the process of being destroyed then
>        * g_source_remove_poll() causes an assertion failure.  Skip
> @@ -210,19 +217,7 @@ static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
>       if (!g_source_is_destroyed(&ctx->source)) {
>           g_source_remove_poll(&ctx->source, &node->pfd);
>       }
> -
> -    /* If a read is in progress, just mark the node as deleted */
> -    if (qemu_lockcnt_count(&ctx->list_lock)) {
> -        node->deleted = 1;
> -        node->pfd.revents = 0;
> -        return false;
> -    }
> -    /* Otherwise, delete it for real.  We can't just mark it as
> -     * deleted because deleted nodes are only cleaned up while
> -     * no one is walking the handlers list.
> -     */
> -    QLIST_REMOVE(node, node);
> -    return true;
> +    QLIST_REMOVE_RCU(node, node);
>   }
>   
>   void aio_set_fd_handler(AioContext *ctx,
> @@ -249,7 +244,8 @@ void aio_set_fd_handler(AioContext *ctx,
>               qemu_lockcnt_unlock(&ctx->list_lock);
>               return;
>           }
> -        deleted = aio_remove_fd_handler(ctx, node);
> +        aio_remove_fd_handler(ctx, node);
> +        deleted = true;
>           poll_disable_change = -!node->io_poll;
>       } else {
>           poll_disable_change = !io_poll - (node && !node->io_poll);
> @@ -269,7 +265,8 @@ void aio_set_fd_handler(AioContext *ctx,
>           if (is_new) {
>               new_node->pfd.fd = fd;
>           } else {
> -            deleted = aio_remove_fd_handler(ctx, node);
> +            aio_remove_fd_handler(ctx, node);
> +            deleted = true;
>               new_node->pfd = node->pfd;
>           }
>           g_source_add_poll(&ctx->source, &new_node->pfd);
> @@ -296,7 +293,7 @@ void aio_set_fd_handler(AioContext *ctx,
>       aio_notify(ctx);
>   
>       if (deleted) {
> -        g_free(node);
> +        g_free_rcu(node, rcu);
>       }
>   }
>   
> @@ -345,13 +342,10 @@ static void poll_set_started(AioContext *ctx, bool started)
>       ctx->poll_started = started;
>   
>       qemu_lockcnt_inc(&ctx->list_lock);
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
>           IOHandler *fn;
>   
> -        if (node->deleted) {
> -            continue;
> -        }
> -
>           if (started) {
>               fn = node->io_poll_begin;
>           } else {
> @@ -362,6 +356,7 @@ static void poll_set_started(AioContext *ctx, bool started)
>               fn(node->opaque);
>           }
>       }
> +    rcu_read_unlock();
>       qemu_lockcnt_dec(&ctx->list_lock);
>   }
>   
> @@ -385,6 +380,7 @@ bool aio_pending(AioContext *ctx)
>        */
>       qemu_lockcnt_inc(&ctx->list_lock);
>   
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
>           int revents;
>   
> @@ -400,6 +396,7 @@ bool aio_pending(AioContext *ctx)
>               break;
>           }
>       }
> +    rcu_read_unlock();
>       qemu_lockcnt_dec(&ctx->list_lock);
>   
>       return result;
> @@ -410,14 +407,14 @@ static bool aio_dispatch_handlers(AioContext *ctx)
>       AioHandler *node, *tmp;
>       bool progress = false;
>   
> +    rcu_read_lock();
>       QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
>           int revents;
>   
>           revents = node->pfd.revents & node->pfd.events;
>           node->pfd.revents = 0;
>   
> -        if (!node->deleted &&
> -            (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) &&
> +        if ((revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) &&
>               aio_node_check(ctx, node->is_external) &&
>               node->io_read) {
>               node->io_read(node->opaque);
> @@ -427,22 +424,14 @@ static bool aio_dispatch_handlers(AioContext *ctx)
>                   progress = true;
>               }
>           }
> -        if (!node->deleted &&
> -            (revents & (G_IO_OUT | G_IO_ERR)) &&
> +        if ((revents & (G_IO_OUT | G_IO_ERR)) &&
>               aio_node_check(ctx, node->is_external) &&
>               node->io_write) {
>               node->io_write(node->opaque);
>               progress = true;
>           }
> -
> -        if (node->deleted) {
> -            if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
> -                QLIST_REMOVE(node, node);
> -                g_free(node);
> -                qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
> -            }
> -        }
>       }
> +    rcu_read_unlock();
>   
>       return progress;
>   }
> @@ -508,8 +497,9 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
>       bool progress = false;
>       AioHandler *node;
>   
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> -        if (!node->deleted && node->io_poll &&
> +        if (node->io_poll &&
>               aio_node_check(ctx, node->is_external) &&
>               node->io_poll(node->opaque)) {
>               *timeout = 0;
> @@ -520,6 +510,7 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
>   
>           /* Caller handles freeing deleted nodes.  Don't do it here. */
>       }
> +    rcu_read_unlock();
>   
>       return progress;
>   }
> @@ -637,12 +628,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
>           /* fill pollfds */
>   
>           if (!aio_epoll_enabled(ctx)) {
> +            rcu_read_lock();
>               QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> -                if (!node->deleted && node->pfd.events
> +                if (node->pfd.events
>                       && aio_node_check(ctx, node->is_external)) {
>                       add_pollfd(node);
>                   }
>               }
> +            rcu_read_unlock();
>           }
>   
>           /* wait until next event */
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index 00e38cdd9f..d7c694e5ac 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -29,7 +29,6 @@ struct AioHandler {
>       IOHandler *io_write;
>       EventNotifierHandler *io_notify;
>       GPollFD pfd;
> -    int deleted;
>       void *opaque;
>       bool is_external;
>       QLIST_ENTRY(AioHandler) node;
> @@ -37,18 +36,8 @@ struct AioHandler {
>   
>   static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
>   {
> -    /* If aio_poll is in progress, just mark the node as deleted */
> -    if (qemu_lockcnt_count(&ctx->list_lock)) {
> -        node->deleted = 1;
> -        node->pfd.revents = 0;
> -    } else {
> -        /* Otherwise, delete it for real.  We can't just mark it as
> -         * deleted because deleted nodes are only cleaned up after
> -         * releasing the list_lock.
> -         */
> -        QLIST_REMOVE(node, node);
> -        g_free(node);
> -    }
> +    QLIST_REMOVE_RCU(node, node);
> +    g_free_rcu(node);
>   }
>   
>   void aio_set_fd_handler(AioContext *ctx,
> @@ -64,7 +53,7 @@ void aio_set_fd_handler(AioContext *ctx,
>   
>       qemu_lockcnt_lock(&ctx->list_lock);
>       QLIST_FOREACH(node, &ctx->aio_handlers, node) {
> -        if (node->pfd.fd == fd && !node->deleted) {
> +        if (node->pfd.fd == fd) {
>               break;
>           }
>       }
> @@ -136,7 +125,7 @@ void aio_set_event_notifier(AioContext *ctx,
>   
>       qemu_lockcnt_lock(&ctx->list_lock);
>       QLIST_FOREACH(node, &ctx->aio_handlers, node) {
> -        if (node->e == e && !node->deleted) {
> +        if (node->e == e) {
>               break;
>           }
>       }
> @@ -188,6 +177,7 @@ bool aio_prepare(AioContext *ctx)
>        * called while we're walking.
>        */
>       qemu_lockcnt_inc(&ctx->list_lock);
> +    rcu_read_lock();
>   
>       /* fill fd sets */
>       FD_ZERO(&rfds);
> @@ -215,7 +205,7 @@ bool aio_prepare(AioContext *ctx)
>               }
>           }
>       }
> -
> +    rcu_read_unlock();
>       qemu_lockcnt_dec(&ctx->list_lock);
>       return have_select_revents;
>   }
> @@ -230,6 +220,7 @@ bool aio_pending(AioContext *ctx)
>        * called while we're walking.
>        */
>       qemu_lockcnt_inc(&ctx->list_lock);
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
>           if (node->pfd.revents && node->io_notify) {
>               result = true;
> @@ -246,6 +237,7 @@ bool aio_pending(AioContext *ctx)
>           }
>       }
>   
> +    rcu_read_unlock();
>       qemu_lockcnt_dec(&ctx->list_lock);
>       return result;
>   }
> @@ -256,6 +248,7 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
>       bool progress = false;
>       AioHandler *tmp;
>   
> +    rcu_read_lock();
>       /*
>        * We have to walk very carefully in case aio_set_fd_handler is
>        * called while we're walking.
> @@ -263,8 +256,7 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
>       QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
>           int revents = node->pfd.revents;
>   
> -        if (!node->deleted &&
> -            (revents || event_notifier_get_handle(node->e) == event) &&
> +        if ((revents || event_notifier_get_handle(node->e) == event) &&
>               node->io_notify) {
>               node->pfd.revents = 0;
>               node->io_notify(node->e);
> @@ -275,8 +267,7 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
>               }
>           }
>   
> -        if (!node->deleted &&
> -            (node->io_read || node->io_write)) {
> +        if ((node->io_read || node->io_write)) {
>               node->pfd.revents = 0;
>               if ((revents & G_IO_IN) && node->io_read) {
>                   node->io_read(node->opaque);
> @@ -297,14 +288,8 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
>               }
>           }
>   
> -        if (node->deleted) {
> -            if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
> -                QLIST_REMOVE(node, node);
> -                g_free(node);
> -                qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
> -            }
> -        }
>       }
> +    rcu_read_unlock();
>   
>       return progress;
>   }
> @@ -344,12 +329,14 @@ bool aio_poll(AioContext *ctx, bool blocking)
>   
>       /* fill fd sets */
>       count = 0;
> +    rcu_read_lock();
>       QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> -        if (!node->deleted && node->io_notify
> +        if (node->io_notify
>               && aio_node_check(ctx, node->is_external)) {
>               events[count++] = event_notifier_get_handle(node->e);
>           }
>       }
> +    rcu_read_unlock();
>   
>       first = true;
>   
