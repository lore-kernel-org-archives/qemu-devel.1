Received: from eggs.gnu.org ([209.51.188.92]:58591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwvpf-0005Oa-85
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gwvpe-00077L-2s
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gwvpc-00070f-1G
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 16:24:37 -0500
Date: Thu, 21 Feb 2019 14:24:18 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190221142418.3c0c0f35@w520.home>
In-Reply-To: <319460b483f566dd57487eb3dd340ed4c10aa53c.1550768238.git-series.knut.omang@oracle.com>
References: <cover.d43586f3445599e8b534a3df8aa0606daf054836.1550768238.git-series.knut.omang@oracle.com>
	<319460b483f566dd57487eb3dd340ed4c10aa53c.1550768238.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/2] gen_pcie_root_port: Add ACS (Access
 Control Services) capability
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

On Thu, 21 Feb 2019 19:13:23 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> Claim ACS support in the generic PCIe root port to allow
> passthrough of individual functions of a device to different
> guests (in a nested virt.setting) with VFIO.
> Without this patch, all functions of a device, such as all VFs of
> an SR/IOV device, will end up in the same IOMMU group.
> A similar situation occurs on Windows with Hyper-V.
> 
> In the single function device case, it also has a small cosmetic
> benefit in that the root port itself is not grouped with
> the device. VFIO handles that situation in that binding rules
> only apply to endpoints, so it does not limit passthrough in
> those cases.
> 
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 4 ++++
>  hw/pci-bridge/pcie_root_port.c     | 4 ++++
>  include/hw/pci/pcie_port.h         | 1 +
>  3 files changed, 9 insertions(+)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 9766edb..26bda73 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -20,6 +20,9 @@
>          OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
>  
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> +#define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> +        (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> +
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  
>  typedef struct GenPCIERootPort {
> @@ -149,6 +152,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>      rpc->interrupts_init = gen_rp_interrupts_init;
>      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
>      rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> +    rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
>  }
>  
>  static const TypeInfo gen_rp_dev_info = {
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 34ad767..e94d918 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -47,6 +47,7 @@ static void rp_reset(DeviceState *qdev)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> +    pcie_acs_reset(d);
>      pcie_aer_root_reset(d);
>      pci_bridge_reset(qdev);
>      pci_bridge_disable_base_limit(d);
> @@ -106,6 +107,9 @@ static void rp_realize(PCIDevice *d, Error **errp)
>      pcie_aer_root_init(d);
>      rp_aer_vector_update(d);
>  
> +    if (rpc->acs_offset) {
> +        pcie_acs_init(d, rpc->acs_offset);
> +    }
>      return;
>  
>  err:
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index df242a0..09586f4 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -78,6 +78,7 @@ typedef struct PCIERootPortClass {
>      int exp_offset;
>      int aer_offset;
>      int ssvid_offset;
> +    int acs_offset;    /* If nonzero, optional ACS capability offset */
>      int ssid;
>  } PCIERootPortClass;
>  
