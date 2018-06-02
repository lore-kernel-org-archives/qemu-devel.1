Received: from eggs.gnu.org ([2001:4830:134:3::10]:56925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuLg-0005vR-LY
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOuLf-0002RP-KU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 20:24:48 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-3-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <70b2ae2a-491f-211f-7f94-ca1b355054fa@redhat.com>
Date: Fri, 1 Jun 2018 20:24:41 -0400
MIME-Version: 1.0
In-Reply-To: <20180417153945.20737-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] ide: push end_transfer_func out of
 start_transfer callback, rename callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
> Now that end_transfer_func is a tail call in ahci_start_transfer,
> formalize the fact that the callback (of which ahci_start_transfer is
> the sole implementation) takes care of the transfer too: rename it to
> pio_transfer and, if it is present, call the end_transfer_func as soon
> as it returns.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/ahci.c             | 15 +++++++--------
>  hw/ide/core.c             |  8 +++++---
>  hw/ide/trace-events       |  2 +-
>  include/hw/ide/internal.h |  2 +-
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 45ce195fb8..10bcc65308 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1280,8 +1280,8 @@ out:
>      return 0;
>  }
>  
> -/* DMA dev <-> ram */
> -static void ahci_start_transfer(IDEDMA *dma)
> +/* Transfer PIO data between RAM and device */
> +static void ahci_pio_transfer(IDEDMA *dma)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>      IDEState *s = &ad->port.ifs[0];
> @@ -1304,9 +1304,9 @@ static void ahci_start_transfer(IDEDMA *dma)
>          has_sglist = 1;
>      }
>  
> -    trace_ahci_start_transfer(ad->hba, ad->port_no, is_write ? "writ" : "read",
> -                              size, is_atapi ? "atapi" : "ata",
> -                              has_sglist ? "" : "o");
> +    trace_ahci_pio_transfer(ad->hba, ad->port_no, is_write ? "writ" : "read",
> +                            size, is_atapi ? "atapi" : "ata",
> +                            has_sglist ? "" : "o");
>  
>      if (has_sglist && size) {
>          if (is_write) {
> @@ -1319,12 +1319,11 @@ static void ahci_start_transfer(IDEDMA *dma)
>      /* Update number of transferred bytes, destroy sglist */
>      dma_buf_commit(s, size);
>      fis_len = le32_to_cpu(ad->cur_cmd->status);
> +
>  out:
>      /* declare that we processed everything */
>      s->data_ptr = s->data_end;
>      ahci_write_fis_pio(ad, fis_len);
> -
> -    s->end_transfer_func(s);
>  }
>  
>  static void ahci_start_dma(IDEDMA *dma, IDEState *s,
> @@ -1440,7 +1439,7 @@ static const IDEDMAOps ahci_dma_ops = {
>      .start_dma = ahci_start_dma,
>      .restart = ahci_restart,
>      .restart_dma = ahci_restart_dma,
> -    .start_transfer = ahci_start_transfer,
> +    .pio_transfer = ahci_pio_transfer,
>      .prepare_buf = ahci_dma_prepare_buf,
>      .commit_buf = ahci_commit_buf,
>      .rw_buf = ahci_dma_rw_buf,
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 866c659498..7932b7c069 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -527,16 +527,18 @@ static void ide_clear_retry(IDEState *s)
>  void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
>                          EndTransferFunc *end_transfer_func)
>  {
> -    s->end_transfer_func = end_transfer_func;
>      s->data_ptr = buf;
>      s->data_end = buf + size;
>      ide_set_retry(s);
>      if (!(s->status & ERR_STAT)) {
>          s->status |= DRQ_STAT;
>      }
> -    if (s->bus->dma->ops->start_transfer) {
> -        s->bus->dma->ops->start_transfer(s->bus->dma);
> +    if (!s->bus->dma->ops->pio_transfer) {
> +        s->end_transfer_func = end_transfer_func;
> +        return;
>      }
> +    s->bus->dma->ops->pio_transfer(s->bus->dma);
> +    end_transfer_func(s);

Does not setting s->end_transfer_func mess with some of our dumb hacks
in e.g. ide_restart_bh or ide_is_pio_out?
