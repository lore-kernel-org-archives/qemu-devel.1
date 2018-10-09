Received: from eggs.gnu.org ([2001:4830:134:3::10]:60238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xon-0002xJ-1S
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xod-00087k-Fn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:37:15 -0400
References: <20180814062739.19640-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <46af1836-e70a-185e-7312-e26fa57d1e2a@redhat.com>
Date: Tue, 9 Oct 2018 15:37:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180814062739.19640-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] nvme: correct locking
 around completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org



On 08/14/2018 02:27 AM, Paolo Bonzini wrote:
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
> 

This is over a month old (and seemingly didn't land); do we still want it?
