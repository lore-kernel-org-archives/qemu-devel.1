Received: from eggs.gnu.org ([209.51.188.92]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gvmSA-0000J7-Lf
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gvmS9-0006gN-Ow
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:11:38 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-5-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e7acbc6-9e05-abd0-852b-5c76ce084dff@redhat.com>
Date: Mon, 18 Feb 2019 18:11:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/12] io: Make qio_channel_yield()
 interruptible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 18/02/19 17:18, Kevin Wolf wrote:
> Similar to how qemu_co_sleep_ns() allows to be preempted by an external
> coroutine entry, allow reentering qio_channel_yield() early.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/io/channel.h |  9 ++++++---
>  io/channel.c         | 10 ++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index da2f138200..59460cb1ec 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -739,10 +739,13 @@ void qio_channel_detach_aio_context(QIOChannel *ioc);
>   * addition, no two coroutine can be waiting on the same condition
>   * and channel at the same time.
>   *
> - * This must only be called from coroutine context
> + * This must only be called from coroutine context. It is safe to
> + * reenter the coroutine externally while it is waiting; in this
> + * case the function will return even if @condition is not yet
> + * available.
>   */
> -void qio_channel_yield(QIOChannel *ioc,
> -                       GIOCondition condition);
> +void coroutine_fn qio_channel_yield(QIOChannel *ioc,
> +                                    GIOCondition condition);
>  
>  /**
>   * qio_channel_wait:
> diff --git a/io/channel.c b/io/channel.c
> index 8dd0684f5d..303376e08d 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -469,6 +469,16 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
>      }
>      qio_channel_set_aio_fd_handlers(ioc);
>      qemu_coroutine_yield();
> +
> +    /* Allow interrupting the operation by reentering the coroutine other than
> +     * through the aio_fd_handlers. */
> +    if (condition == G_IO_IN && ioc->read_coroutine) {
> +        ioc->read_coroutine = NULL;
> +        qio_channel_set_aio_fd_handlers(ioc);
> +    } else if (condition == G_IO_OUT && ioc->write_coroutine) {
> +        ioc->write_coroutine = NULL;
> +        qio_channel_set_aio_fd_handlers(ioc);
> +    }
>  }
>  
>  
> 

Perhaps it's a bit cleaner to remove the ioc->..._coroutine assignments,
and the call to qio_channel_set_aio_fd_handlers, from
qio_channel_restart_read and qio_channel_restart_write.

Paolo
