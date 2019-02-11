Received: from eggs.gnu.org ([209.51.188.92]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtKhQ-00057f-L3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtKhP-0002KD-6a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gtKhO-0002Ig-Qi
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:09:15 -0500
Date: Mon, 11 Feb 2019 16:09:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190211160910.2be92b59@w520.home>
In-Reply-To: <636bd37834daa1cc4c42462aeccd0de17aa370bf.1549779509.git-series.knut.omang@oracle.com>
References: <cover.d651a232d750c6f53cbe8d483b665d638f7a0c0a.1549779509.git-series.knut.omang@oracle.com>
	<636bd37834daa1cc4c42462aeccd0de17aa370bf.1549779509.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] pcie: Add a simple PCIe ACS (Access
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

On Sun, 10 Feb 2019 07:52:59 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> Add a helper function to add PCIe capability for Access Control Services (ACS)
> ACS support in the associated root port is a prerequisite to be able to do
> passthrough of individual functions of a device with VFIO
> without Alex Williamson's pcie_acs_override kernel patch or similar
> in the guest.

This is still incorrect, the ACS override patch is only required for
separating multifunction endpoints or multifunction root ports.  Single
function endpoints are assignable without ACS simply by placing them
downstream of a single function root port or directly on the root
complex.

> Endpoints may also implement an ACS capability, but with
> limited features.
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  hw/pci/pcie.c              | 29 +++++++++++++++++++++++++++++
>  include/hw/pci/pcie.h      |  6 ++++++
>  include/hw/pci/pcie_regs.h |  4 ++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 230478f..509632f 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -742,6 +742,14 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
>          PCI_EXP_DEVCTL2_ARI;
>  }
>  
> +/* Access Control Services (ACS) */
> +void pcie_cap_acs_reset(PCIDevice *dev)
> +{
> +    if (dev->exp.acs_cap) {
> +        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
> +    }
> +}
> +
>  /**************************************************************************
>   * pci express extended capability list management functions
>   * uint16_t ext_cap_id (16 bit)
> @@ -906,3 +914,24 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
>  
>      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
>  }
> +
> +/* ACS (Access Control Services) */
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> +{
> +    bool is_pcie_slot = !!object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
> +    uint16_t cap_bits = 0;
> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER, offset,
> +                        PCI_ACS_SIZEOF);
> +    dev->exp.acs_cap = offset;
> +
> +    if (is_pcie_slot) {
> +        /* Endpoints may also implement ACS, but these capabilities are */
> +        /* only valid for slots: */

Not quite, SV, TB, and UF must not be implemented by endpoints, but RR
and CR must be implemented by multifunction endpoints that support p2p
if they provide an ACS capability.  Linux therefore infers that if ACS
is supported by an endpoint and RR and CR are not implemented, the
device does not support p2p.  We could just say that nothing supports
p2p yet, but single function endpoints (except those implementing
SR-IOV) must not implement an ACS capability per the spec, which could
be difficult to exclude since the multifunction bit is handled
separately from the device model.

Also comment style:
https://git.qemu.org/?p=qemu.git;a=blob;f=CODING_STYLE;#l127

> +        cap_bits =
> +            PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF;
> +    }
> +
> +    pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
> +    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> +}
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 5b82a0d..4c40711 100644
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
> @@ -116,6 +119,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
>  void pcie_cap_flr_write_config(PCIDevice *dev,
>                             uint32_t addr, uint32_t val, int len);
>  
> +void pcie_cap_acs_reset(PCIDevice *dev);
> +
>  /* ARI forwarding capability and control */
>  void pcie_cap_arifwd_init(PCIDevice *dev);
>  void pcie_cap_arifwd_reset(PCIDevice *dev);
> @@ -129,6 +134,7 @@ void pcie_add_capability(PCIDevice *dev,
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
>  
>  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset);

nit, why aren't the reset and init declarations together?

>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
>  
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
