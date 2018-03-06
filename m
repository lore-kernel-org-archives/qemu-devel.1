Received: from eggs.gnu.org ([2001:4830:134:3::10]:47372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etAMM-0002ra-ES
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etAME-0003Jr-NZ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:02:18 -0500
References: <20180306105354.15197-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e82e4716-fafb-2e46-c986-58b65a197dee@redhat.com>
Date: Tue, 6 Mar 2018 12:01:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180306105354.15197-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: make BDRV_POLL_WHILE() re-entrancy
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 06/03/2018 11:53, Stefan Hajnoczi wrote:
> Nested BDRV_POLL_WHILE() calls can occur.  Currently
> assert(!bs_->wakeup) will fail when this happens.
> 
> This patch converts bs->wakeup from bool to a counter.
> 
> Nesting works correctly because outer BDRV_POLL_WHILE() callers evaluate
> the condition again after the inner caller completes (invoking the inner
> caller counts as aio_poll() progress).
> 
> Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Fu Weiwei: Please retest and let us know if this fixes the assertion
> failure you hit.  Thanks!
> ---
>  include/block/block.h     | 7 +++----
>  include/block/block_int.h | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index fac401ba3e..990b97f0ad 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -385,9 +385,8 @@ void bdrv_drain_all(void);
>           * other I/O threads' AioContexts (see for example \
>           * block_job_defer_to_main_loop for how to do it). \
>           */                                                \
> -        assert(!bs_->wakeup);                              \
> -        /* Set bs->wakeup before evaluating cond.  */      \
> -        atomic_mb_set(&bs_->wakeup, true);                 \
> +        /* Increment bs->wakeup before evaluating cond. */ \
> +        atomic_inc(&bs_->wakeup);                          \
>          while (busy_) {                                    \
>              if ((cond)) {                                  \
>                  waited_ = busy_ = true;                    \
> @@ -399,7 +398,7 @@ void bdrv_drain_all(void);
>                  waited_ |= busy_;                          \
>              }                                              \
>          }                                                  \
> -        atomic_set(&bs_->wakeup, false);                   \
> +        atomic_dec(&bs_->wakeup);                          \
>      }                                                      \
>      waited_; })
>  
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 5ea63f8fa8..0f360c0ed5 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -712,7 +712,7 @@ struct BlockDriverState {
>      /* Internal to BDRV_POLL_WHILE and bdrv_wakeup.  Accessed with atomic
>       * ops.
>       */
> -    bool wakeup;
> +    unsigned wakeup;
>  
>      /* counter for nested bdrv_io_plug.
>       * Accessed with atomic ops.
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

At least, the assertion made it fail fast. :)

Paolo
