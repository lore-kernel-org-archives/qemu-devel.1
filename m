Received: from eggs.gnu.org ([2001:4830:134:3::10]:48439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOQLC-0006fW-Cb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOQLB-0001OZ-DF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:22:18 -0400
Date: Thu, 31 May 2018 12:22:08 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180531162208.GB11303@localhost.localdomain>
References: <20180531004323.4611-1-jsnow@redhat.com>
	<20180531004323.4611-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531004323.4611-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] ahci: fix PxCI register
 race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, May 30, 2018 at 08:43:22PM -0400, John Snow wrote:
> AHCI presently signals completion prior to the PxCI register being
> cleared to indicate completion. If a guest driver attempts to issue
> a new command in its IRQ handler, it might be surprised to learn there
> is still a command pending.
> 
> In the case of Windows 10's boot driver, it will actually poll the IRQ
> register hoping to find out when the command is done running -- which
> will never happen, as there isn't a command running.
> 
> Fix this: clear PxCI in ahci_cmd_done and not in the asynchronous BH.
> Because it now runs synchronously, we don't need to check if the command
> is actually done by spying on the ATA registers. We know it's done.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b7a6f68790..a9558e45e7 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -532,13 +532,6 @@ static void ahci_check_cmd_bh(void *opaque)
>      qemu_bh_delete(ad->check_bh);
>      ad->check_bh = NULL;
>  
> -    if ((ad->busy_slot != -1) &&
> -        !(ad->port.ifs[0].status & (BUSY_STAT|DRQ_STAT))) {
> -        /* no longer busy */
> -        ad->port_regs.cmd_issue &= ~(1 << ad->busy_slot);
> -        ad->busy_slot = -1;
> -    }
> -
>      check_cmd(ad->hba, ad->port_no);
>  }
>  
> @@ -1425,6 +1418,12 @@ static void ahci_cmd_done(IDEDMA *dma)
>  
>      trace_ahci_cmd_done(ad->hba, ad->port_no);
>  
> +    /* no longer busy */
> +    if (ad->busy_slot != -1) {
> +        ad->port_regs.cmd_issue &= ~(1 << ad->busy_slot);
> +        ad->busy_slot = -1;
> +    }
> +
>      /* update d2h status */
>      ahci_write_fis_d2h(ad);
>  
> -- 
> 2.14.3
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
