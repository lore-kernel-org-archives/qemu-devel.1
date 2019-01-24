Received: from eggs.gnu.org ([209.51.188.92]:37723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmit9-0000nH-RL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gmit5-00073G-L9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gmit3-000714-K7
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:33:59 -0500
Date: Thu, 24 Jan 2019 10:33:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190124103353.569de985@w520.home>
In-Reply-To: <b9ae6eabc2a87fb27e969c9d095263f4a097b740.1548323393.git-series.knut.omang@oracle.com>
References: <cover.4fe3faa2cc295ab1e178284b738e33b940ab9312.1548323393.git-series.knut.omang@oracle.com>
	<b9ae6eabc2a87fb27e969c9d095263f4a097b740.1548323393.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] gen_pcie_root_port: Add ACS (Access
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, Tal Attaly <talat@mellanox.com>

On Thu, 24 Jan 2019 11:12:53 +0100
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
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 2 ++
>  hw/pci-bridge/pcie_root_port.c     | 4 ++++
>  include/hw/pci/pcie_port.h         | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 9766edb..b5a5ecc 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -20,6 +20,7 @@
>          OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
>  
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> +#define GEN_PCIE_ROOT_PORT_ACS_OFFSET           0x148

So you prefer that everyone passing through here decode these to figure
out that ACS_OFFSET is (AER_OFFSET + ERR_SIZEOF) since my comment on v1
was ignored?

>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  
>  typedef struct GenPCIERootPort {
> @@ -149,6 +150,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>      rpc->interrupts_init = gen_rp_interrupts_init;
>      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
>      rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> +    rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
>  }
>  
>  static const TypeInfo gen_rp_dev_info = {
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 34ad767..a0b4cf7 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -47,6 +47,7 @@ static void rp_reset(DeviceState *qdev)
>      pcie_cap_deverr_reset(d);
>      pcie_cap_slot_reset(d);
>      pcie_cap_arifwd_reset(d);
> +    pcie_cap_acs_reset(d);

Only the generic root port initializes acs_offset to enable an ACS
capability, but all members of the device class call the reset function
which does no checking that an ACS capability exists.  We've just
corrupted config space for the device.

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
