Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLtr3-00083l-Cl
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLtr2-00019P-Gr
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:16:45 -0400
References: <20180521063516.5479-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <677208b5-586b-354a-5fd4-67468152510e@redhat.com>
Date: Thu, 24 May 2018 19:16:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180521063516.5479-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvme: Make nvme_init error handling code
 more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 21/05/2018 08:35, Fam Zheng wrote:
> Coverity doesn't like the tests under fail label (report CID 1385847).
> Reset the fields so the clean up order is more apparent.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/nvme.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 6f71122bf5..8239b920c8 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -560,6 +560,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      qemu_co_queue_init(&s->dma_flush_queue);
>      s->nsid = namespace;
>      s->aio_context = bdrv_get_aio_context(bs);
> +
> +    /* Fields we've not touched should be zero-initialized by block layer
> +     * already, but reset them anyway to make the error handling code easier to
> +     * reason. */
> +    s->regs = NULL;
> +    s->vfio = NULL;
> +
>      ret = event_notifier_init(&s->irq_notifier, 0);
>      if (ret) {
>          error_setg(errp, "Failed to init event notifier");
> 

I think we should just mark it as a false positive or do something like

fail_regs:
    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
fail_vfio:
    qemu_vfio_close(s->vfio);
fail:
    g_free(s->queues);
    event_notifier_cleanup(&s->irq_notifier);
    return ret;

even though it's a larger patch.

Paolo
