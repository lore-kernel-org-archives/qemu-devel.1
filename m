Received: from eggs.gnu.org ([2001:4830:134:3::10]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT0xT-0000Di-HD
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fT0xS-0001sL-Lb
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:16:47 -0400
Date: Wed, 13 Jun 2018 10:16:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180613081637.GB4356@dhcp-200-186.str.redhat.com>
References: <20180613074552.15656-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613074552.15656-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Reset s->nr_queues upon open failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org

Am 13.06.2018 um 09:45 hat Fam Zheng geschrieben:
> It is wrong to leave this field as 1, as nvme_close() called in the
> error handling code in nvme_file_open() will use it and try to free
> s->queues again.
> 
> Clear the fields to avoid double-free.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/nvme.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 6f71122bf5..7bdeb0ffce 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -666,6 +666,8 @@ fail_queue:
>      nvme_free_queue_pair(bs, s->queues[0]);
>  fail:
>      g_free(s->queues);
> +    s->queues = NULL;
> +    s->nr_queues = 0;
>      if (s->regs) {
>          qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
>      }

Hm... Basically all the cleanup is duplicated. It's not only
nvme_free_queue_pair(), but also qemu_vfio_pci_unmap_bar() and
qemu_vfio_close(). Are we sure it's intended to call them twice?

Maybe nvme_init() shouldn't clean up any of this and rely on the
later nvme_close() call to do that?

I also notice that the error handling code in nvme_init() has a
g_free(s->queues) and event_notifier_cleanup(&s->irq_notifier), which
nvme_close() doesn't. Are these leaks in nvme_close()?

Kevin
