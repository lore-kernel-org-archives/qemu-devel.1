Received: from eggs.gnu.org ([2001:4830:134:3::10]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpT5A-0000Ub-K2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpT59-0004MR-Su
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:45:32 -0400
Date: Tue, 14 Aug 2018 14:45:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180814064519.GI7549@lemon.usersys.redhat.com>
References: <20180814062739.19640-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814062739.19640-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] nvme: correct locking around completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 08/14 08:27, Paolo Bonzini wrote:
> nvme_poll_queues is already protected by q->lock, and
> AIO callbacks are invoked outside the AioContext lock.
> So remove the acquire/release pair in nvme_handle_event.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nvme.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 6f71122bf5..42116907ed 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -489,10 +489,8 @@ static void nvme_handle_event(EventNotifier *n)
>      BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
>  
>      trace_nvme_handle_event(s);
> -    aio_context_acquire(s->aio_context);
>      event_notifier_test_and_clear(n);
>      nvme_poll_queues(s);
> -    aio_context_release(s->aio_context);
>  }
>  
>  static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> -- 
> 2.17.1
> 

This patch and the other

    [PATCH v2] nvme: simplify code around completion

only differ in subject. Which one to ignore? :)

Fam
