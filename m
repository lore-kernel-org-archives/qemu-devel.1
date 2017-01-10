Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmmt-0003ky-OA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmmo-0000rZ-PV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQmmo-0000rL-Gl
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:07:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD6CF883B1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:07:46 +0000 (UTC)
Date: Tue, 10 Jan 2017 05:07:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110050714-mutt-send-email-mst@kernel.org>
References: <1483559838-8797-1-git-send-email-marcel@redhat.com>
	<1483559838-8797-4-git-send-email-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483559838-8797-4-git-send-email-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/virtio: fix Link Control Register
 for PCI Express virtio devices
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

On Wed, Jan 04, 2017 at 09:57:17PM +0200, Marcel Apfelbaum wrote:
> Make several Link Control Register flags writable to conform
> with the PCI Express spec.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Same comment as 2.

> ---
>  hw/pci/pcie.c          | 14 ++++++++++++++
>  hw/virtio/virtio-pci.c |  3 +++
>  include/hw/pci/pcie.h  |  3 +++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 62c1def..a596400 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -220,6 +220,20 @@ void pcie_cap_deverr_reset(PCIDevice *dev)
>                                   PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
>  }
>  
> +void pcie_cap_lnkctl_init(PCIDevice *dev)
> +{
> +    uint32_t pos = dev->exp.exp_cap;
> +    pci_long_test_and_set_mask(dev->wmask + pos + PCI_EXP_LNKCTL,
> +                               PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKCTL_ES);
> +}
> +
> +void pcie_cap_lnkctl_reset(PCIDevice *dev)
> +{
> +    uint8_t *lnkctl = dev->config + dev->exp.exp_cap + PCI_EXP_LNKCTL;
> +    pci_long_test_and_clear_mask(lnkctl,
> +                                 PCI_EXP_LNKCTL_CCC | PCI_EXP_LNKCTL_ES);
> +}
> +
>  static void hotplug_event_update_event_status(PCIDevice *dev)
>  {
>      uint32_t pos = dev->exp.exp_cap;
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index da2124f..66a5bf3 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1804,6 +1804,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>          /* Init error enabling flags */
>          pcie_cap_deverr_init(pci_dev);
> +        /* Init Link Control Register */
> +        pcie_cap_lnkctl_init(pci_dev);
>      } else {
>          /*
>           * make future invocations of pci_is_express() return false
> @@ -1843,6 +1845,7 @@ static void virtio_pci_reset(DeviceState *qdev)
>  
>      if (pci_is_express(dev)) {
>          pcie_cap_deverr_reset(dev);
> +        pcie_cap_lnkctl_reset(dev);
>      }
>  }
>  
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 056d25e..7d6611a 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -93,6 +93,9 @@ uint8_t pcie_cap_flags_get_vector(PCIDevice *dev);
>  void pcie_cap_deverr_init(PCIDevice *dev);
>  void pcie_cap_deverr_reset(PCIDevice *dev);
>  
> +void pcie_cap_lnkctl_init(PCIDevice *dev);
> +void pcie_cap_lnkctl_reset(PCIDevice *dev);
> +
>  void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
>  void pcie_cap_slot_reset(PCIDevice *dev);
>  void pcie_cap_slot_write_config(PCIDevice *dev,
> -- 
> 2.5.5
