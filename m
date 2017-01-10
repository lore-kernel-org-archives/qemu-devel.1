Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmn7-0003tn-1t
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmn2-0000uV-4n
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQmn1-0000uJ-VM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:08:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 374FB31B31F
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:08:00 +0000 (UTC)
Date: Tue, 10 Jan 2017 05:07:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110050750-mutt-send-email-mst@kernel.org>
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
	<1483559838-8797-5-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483559838-8797-5-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/virtio: fix Power Management
 Control Register for PCI Express virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com

On Wed, Jan 04, 2017 at 09:57:18PM +0200, Marcel Apfelbaum wrote:
> Make Power Management State flag writable to conform
> with the PCI Express spec.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Same comment as previously.

> ---
>  hw/virtio/virtio-pci.c | 5 +++++
>  include/hw/pci/pcie.h  | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 66a5bf3..7a98078 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1796,12 +1796,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>          pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF);
>          assert(pos > 0);
> +        pci_dev->exp.pm_cap = pos;
>  
>          /*
>           * Indicates that this function complies with revision 1.2 of the
>           * PCI Power Management Interface Specification.
>           */
>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
> +        pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> +                     PCI_PM_CTRL_STATE_MASK);
>          /* Init error enabling flags */
>          pcie_cap_deverr_init(pci_dev);
>          /* Init Link Control Register */
> @@ -1846,6 +1849,8 @@ static void virtio_pci_reset(DeviceState *qdev)
>      if (pci_is_express(dev)) {
>          pcie_cap_deverr_reset(dev);
>          pcie_cap_lnkctl_reset(dev);
> +
> +        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
>      }
>  }
>  
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 7d6611a..7c9c573 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -63,6 +63,8 @@ typedef enum {
>  struct PCIExpressDevice {
>      /* Offset of express capability in config space */
>      uint8_t exp_cap;
> +    /* Offset of Power Management capability in config space */
> +    uint8_t pm_cap;
>  
>      /* SLOT */
>      bool hpev_notified; /* Logical AND of conditions for hot plug event.
> -- 
> 2.5.5
