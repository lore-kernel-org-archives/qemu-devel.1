Received: from eggs.gnu.org ([2001:4830:134:3::10]:53780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hikarupsp@gmail.com>) id 1eSHnm-0004AI-Ch
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hikarupsp@gmail.com>) id 1eSHnl-00046g-9D
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 02:31:30 -0500
MIME-Version: 1.0
In-Reply-To: <1513573243-29022-1-git-send-email-hikarupsp@gmail.com>
References: <1513573243-29022-1-git-send-email-hikarupsp@gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Fri, 22 Dec 2017 16:31:11 +0900
Message-ID: <CAD-w0GB+KZK_=7HZhXfarfNEFF_Y992=wc8XZ=CX6FTC107zfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/block: Fix pin-based interrupt
 behaviour of NVMe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hikaru Nishida <hikarupsp@gmail.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

ping
http://patchwork.ozlabs.org/patch/849786/

2017-12-18 14:00 GMT+09:00 Hikaru Nishida <hikarupsp@gmail.com>:
> Pin-based interrupt of NVMe controller did not work properly
> because using an obsolated function pci_irq_pulse().
> To fix this, change to use pci_irq_assert() / pci_irq_deassert()
> instead of pci_irq_pulse().
>
> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
> ---
>  hw/block/nvme.c | 39 ++++++++++++++++++++++++++++++++++-----
>  hw/block/nvme.h |  1 +
>  2 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 441e21e..2d164fc 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -82,13 +82,40 @@ static uint8_t nvme_sq_empty(NvmeSQueue *sq)
>      return sq->head == sq->tail;
>  }
>
> -static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
> +static void nvme_irq_check(NvmeCtrl *n)
> +{
> +    if (msix_enabled(&(n->parent_obj))) {
> +        return;
> +    }
> +    if (~n->bar.intms & n->irq_status) {
> +        pci_irq_assert(&n->parent_obj);
> +    } else {
> +        pci_irq_deassert(&n->parent_obj);
> +    }
> +}
> +
> +static void nvme_irq_assert(NvmeCtrl *n, NvmeCQueue *cq)
>  {
>      if (cq->irq_enabled) {
>          if (msix_enabled(&(n->parent_obj))) {
>              msix_notify(&(n->parent_obj), cq->vector);
>          } else {
> -            pci_irq_pulse(&n->parent_obj);
> +            assert(cq->cqid < 64);
> +            n->irq_status |= 1 << cq->cqid;
> +            nvme_irq_check(n);
> +        }
> +    }
> +}
> +
> +static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
> +{
> +    if (cq->irq_enabled) {
> +        if (msix_enabled(&(n->parent_obj))) {
> +            return;
> +        } else {
> +            assert(cq->cqid < 64);
> +            n->irq_status &= ~(1 << cq->cqid);
> +            nvme_irq_check(n);
>          }
>      }
>  }
> @@ -220,7 +247,7 @@ static void nvme_post_cqes(void *opaque)
>              sizeof(req->cqe));
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
> -    nvme_isr_notify(n, cq);
> +    nvme_irq_assert(n, cq);
>  }
>
>  static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
> @@ -753,10 +780,12 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
>      case 0xc:
>          n->bar.intms |= data & 0xffffffff;
>          n->bar.intmc = n->bar.intms;
> +        nvme_irq_check(n);
>          break;
>      case 0x10:
>          n->bar.intms &= ~(data & 0xffffffff);
>          n->bar.intmc = n->bar.intms;
> +        nvme_irq_check(n);
>          break;
>      case 0x14:
>          /* Windows first sends data, then sends enable bit */
> @@ -851,8 +880,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>              timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
>          }
>
> -        if (cq->tail != cq->head) {
> -            nvme_isr_notify(n, cq);
> +        if (cq->tail == cq->head) {
> +            nvme_irq_deassert(n, cq);
>          }
>      } else {
>          uint16_t new_tail = val & 0xffff;
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 6aab338..7b62dad 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -775,6 +775,7 @@ typedef struct NvmeCtrl {
>      uint32_t    cmbsz;
>      uint32_t    cmbloc;
>      uint8_t     *cmbuf;
> +    uint64_t    irq_status;
>
>      char            *serial;
>      NvmeNamespace   *namespaces;
> --
> 2.7.4
>
