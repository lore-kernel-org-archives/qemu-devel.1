Received: from eggs.gnu.org ([209.51.188.92]:58563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwvpd-0005O8-TY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwvpb-00075E-Vv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwvpa-000739-Fv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:35 -0500
Date: Thu, 21 Feb 2019 14:24:20 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190221142420.4728d353@w520.home>
In-Reply-To: <07489975121696f5573b0a92baaf3486ef51e35d.1550768238.git-series.knut.omang@oracle.com>
References: <cover.d43586f3445599e8b534a3df8aa0606daf054836.1550768238.git-series.knut.omang@oracle.com>
	<07489975121696f5573b0a92baaf3486ef51e35d.1550768238.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/2] pcie: Add a simple PCIe ACS (Access
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahsh@mellanox.com>, Tal Attaly <talat@mellanox.com>

On Thu, 21 Feb 2019 19:13:22 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> Implementing an ACS capability on downstream ports and multifunction
> endpoints indicates isolation and IOMMU visibility to a finer
> granularity. This creates smaller IOMMU groups in the guest and thus
> more flexibility in assigning endpoints to guest userspace or an L2
> guest.
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  hw/pci/pcie.c              | 38 ++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h      |  6 ++++++
>  include/hw/pci/pcie_regs.h |  4 ++++
>  3 files changed, 48 insertions(+)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 230478f..09ebf11 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -906,3 +906,41 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
>  
>      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
>  }
> +
> +/* ACS (Access Control Services) */
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> +{
> +    bool is_downstream = pci_is_express_downstream_port(dev);
> +    uint16_t cap_bits = 0;
> +
> +    /* For endpoints, only multifunction devs may have an ACS capability: */
> +    assert(is_downstream ||
> +           (dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) ||
> +           PCI_FUNC(dev->devfn));
> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER, offset,
> +                        PCI_ACS_SIZEOF);
> +    dev->exp.acs_cap = offset;
> +
> +    if (is_downstream) {
> +        /*
> +         * Downstream ports must implement SV, TB, RR, CR, UF, and DT (with
> +         * caveats on the latter four that we ignore for simplicity).
> +         * Endpoints may also implement a subset of ACS capabilities,
> +         * but these are optional if the endpoint does not support
> +         * peer-to-peer between functions and thus omitted here.
> +         */
> +        cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +            PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
> +    }
> +
> +    pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
> +    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> +}
> +
> +void pcie_acs_reset(PCIDevice *dev)
> +{
> +    if (dev->exp.acs_cap) {
> +        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
> +    }
> +}
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 5b82a0d..e30334d 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -79,6 +79,9 @@ struct PCIExpressDevice {
>  
>      /* Offset of ATS capability in config space */
>      uint16_t ats_cap;
> +
> +    /* ACS */
> +    uint16_t acs_cap;
>  };
>  
>  #define COMPAT_PROP_PCP "power_controller_present"
> @@ -128,6 +131,9 @@ void pcie_add_capability(PCIDevice *dev,
>                           uint16_t offset, uint16_t size);
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>  
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset);
> +void pcie_acs_reset(PCIDevice *dev);
> +
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index ad4e780..1db86b0 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
>                                           PCI_ERR_COR_INTERNAL |         \
>                                           PCI_ERR_COR_HL_OVERFLOW)
>  
> +/* ACS */
> +#define PCI_ACS_VER                     0x1
> +#define PCI_ACS_SIZEOF                  8
> +
>  #endif /* QEMU_PCIE_REGS_H */
