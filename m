Received: from eggs.gnu.org ([209.51.188.92]:53012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtzyn-0008Cm-Dp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtzyl-0000gO-Tm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:13:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gtzyk-0000UH-TX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:13:55 -0500
Date: Wed, 13 Feb 2019 12:13:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190213121346.384ebbab@w520.home>
In-Reply-To: <3df33b2bd332259dc548751b3c3c5eaa297428b0.1550050121.git-series.knut.omang@oracle.com>
References: <cover.cc19031e8d42f0196630e60c9016d57d8a46e676.1550050121.git-series.knut.omang@oracle.com>
	<3df33b2bd332259dc548751b3c3c5eaa297428b0.1550050121.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] pcie: Add a simple PCIe ACS (Access
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

On Wed, 13 Feb 2019 10:29:58 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> Add a helper function to add PCIe capability for Access Control Services (ACS)

This is redundant to the commit title.

> ACS support in the associated root port is needed to pass
> through individual functions of a device to different VMs with VFIO
> without Alex Williamson's pcie_acs_override kernel patch or similar
> in the guest.

This is overly subtle, to work backwards that individual functions
(plural!) of a device (singular!) must imply a multifunction endpoint
in the same hierarchy split to different L2 VMs.  Perhaps I only
finally realized this subtly on v4.

> Single function devices, or multifunction devices
> that all goes to the same VM works fine even without ACS, as VFIO
> will avoid putting the root port itself into the IOMMU group
> even without ACS support in the port.

Also confusing and incorrectly states that a) VFIO is responsible for
IOMMU grouping, it's not, and b) that the root port would not be
included in such a group, it would.  The latter was I thought the
impetus for this series.

> Multifunction endpoints may also implement an ACS capability,
> only on function 0, and with more limited features.

"only on function 0" is incorrect, each function of a multifunction
device should (not must) implement an ACS capability if any of them do.

Can't we just say something like:

"Implementing an ACS capability on downstream ports and multifuction
endpoints indicates isolation and IOMMU visibility to a finer
granularity thereby creating smaller IOMMU groups in the guest and thus
more flexibility in assigning endpoints to guest userspace or an L2
guest."

(I avoided including SR-IOV with multifunction since that's not
implemented here)

> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  hw/pci/pcie.c              | 39 +++++++++++++++++++++++++++++++++++++++-
>  include/hw/pci/pcie.h      |  6 ++++++-
>  include/hw/pci/pcie_regs.h |  4 ++++-
>  3 files changed, 49 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 230478f..6e87994 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -906,3 +906,42 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
>  
>      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
>  }
> +
> +/* ACS (Access Control Services) */
> +void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> +{
> +    bool is_pcie_slot = !!object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);

Perhaps we should be using pci_is_express_downstream_port().

> +    uint16_t cap_bits = 0;
> +
> +    /*
> +     * For endpoints, only multifunction devices may have an
> +     * ACS capability, and only on function 0:

Incorrect

> +     */
> +    assert(is_pcie_slot ||
> +           ((dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) &&
> +            PCI_FUNC(dev->devfn)));

The second test should be:

((dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) ||
 PCI_FUNC(dev->devfn))

If the function number is non-zero, then it's clearly a multifunction
device, the multifunction capability is only required on function
zero.  Just as in my previous example, an ACS capability can only
describe/control the DMA flow of the function implementing it, nothing
in the spec that I can see imposes function zero's DMA flow on the
other functions.

There's also a gap here that function zero can set the multifunction
capability, but there may be no secondary devices defined.  Not that
we necessarily need to resolve this, but it's a nuance of allowing
arbitrary multifunction configurations as QEMU does.

> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER, offset,
> +                        PCI_ACS_SIZEOF);
> +    dev->exp.acs_cap = offset;
> +
> +    if (is_pcie_slot) {
> +        /*
> +         * Endpoints may also implement ACS, and optionally RR and CR,
> +         * if they want to support p2p, but only slots may
> +         * implement SV, TB or UF:

Careful using "may" with spec references.

"Downstream ports must implement SV, TB, RR, CR, and UF (with caveats
on the latter three that we ignore for simplicity).  Endpoints may also
implement a subset of ACS capabilities, but these are optional if the
endpoint does not support peer-to-peer between functions and thus
omitted here."

> +         */
> +        cap_bits =
> +            PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF;

PCI_ACS_DT has similar "must be implemented" requirements to RR, RC,
and UF, why is it not included?  For all of these "caveat" ones there
are conditions which can make it optional for root ports, but required
for switch downstream ports, so it seems reasonable that we include
both since that's what our is_pci_slot() test covers.  Thanks,

Alex

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
