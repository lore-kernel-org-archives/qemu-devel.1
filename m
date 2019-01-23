Received: from eggs.gnu.org ([209.51.188.92]:38733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmNpZ-0001cb-GZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmNpY-0002zf-Dt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:04:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gmNpW-0002sd-Hr
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:04:54 -0500
Date: Wed, 23 Jan 2019 12:04:22 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190123120422.36273dd1@w520.home>
In-Reply-To: <b6e8edb21e6cc5f616383cb733c2d5f75d89953e.1548266832.git-series.knut.omang@oracle.com>
References: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
	<b6e8edb21e6cc5f616383cb733c2d5f75d89953e.1548266832.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] pcie: Add a simple PCIe ACS (Access
 Control Services) helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tal Attaly <talat@mellanox.com>, Elijah Shakkour <elijahs@mellanox.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, 23 Jan 2019 19:27:59 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> Add a helper function to add PCIe capability for Access Control Services (ACS)
> ACS support in the associated root port is a prerequisite to be able to do useful
> passthrough with VFIO without Alex Williamson's pcie_acs_override kernel patch.

Define "useful".  We can certainly still assign single function PFs to
an L2 guest, or multi-function so long as all the functions are
assigned.  I won't deny that it's problematic, but it's a virtual
topology that can be adjusted, so I think this is overstating things a
bit.

> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  hw/pci/pcie.c              | 14 ++++++++++++++
>  include/hw/pci/pcie.h      |  1 +
>  include/hw/pci/pcie_regs.h |  4 ++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 230478f..18feff5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -906,3 +906,17 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
>  
>      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
>  }
> +
> +/* Add an ACS (Access Control Services) capability */
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz)
> +{
> +    int ectrl_words = (egress_ctrl_vec_sz + 31) & ~31;
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER,
> +                        offset, PCI_ACS_SIZEOF + ectrl_words);

The egress control vector is only valid if the egress control
capability is enabled, which is not set below, so this just seems to
waste config space and introduces a meaningless function arg.

> +    pci_set_word(dev->config + offset + PCI_ACS_CAP,
> +                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);

Some of these bits are only valid for downstream ports, it would
violate the spec to set them on and endpoint.

> +    pci_set_word(dev->config + offset + PCI_ACS_CTRL,
> +                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);

The default values of the control register bits is zero, so we
shouldn't be setting it here and we should have a reset hook to clear
it.

> +    /* Make CTRL register writable */
> +    memset(dev->wmask + offset + PCI_ACS_CTRL, 0xff, 2);
> +}
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 5b82a0d..c2da148 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -129,6 +129,7 @@ void pcie_add_capability(PCIDevice *dev,
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>  
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
>  
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index ad4e780..5e7409c 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
>                                           PCI_ERR_COR_INTERNAL |         \
>                                           PCI_ERR_COR_HL_OVERFLOW)
>  
> +/* ACS */
> +#define PCI_ACS_VER			0x2
> +#define PCI_ACS_SIZEOF                  8
> +
>  #endif /* QEMU_PCIE_REGS_H */
