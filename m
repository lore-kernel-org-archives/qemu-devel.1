Received: from eggs.gnu.org ([209.51.188.92]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6bq-0005a9-Qi
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gt6bp-0005mm-Q3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:06:34 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gt6bp-0005mE-Cy
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:06:33 -0500
Received: by mail-wm1-x342.google.com with SMTP id f16so15145972wmh.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 00:06:33 -0800 (PST)
References: <cover.d651a232d750c6f53cbe8d483b665d638f7a0c0a.1549779509.git-series.knut.omang@oracle.com>
	<04c99e3c0b56dcbfe494f668bbe11777adbadba9.1549779509.git-series.knut.omang@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <4ad3f098-ded6-8ddb-4ae5-c2975a286245@gmail.com>
Date: Mon, 11 Feb 2019 10:07:01 +0200
MIME-Version: 1.0
In-Reply-To: <04c99e3c0b56dcbfe494f668bbe11777adbadba9.1549779509.git-series.knut.omang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 2/2] gen_pcie_root_port: Add ACS (Access
 Control Services) capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahsh@mellanox.com>, Tal Attaly <talat@mellanox.com>



On 2/10/19 8:53 AM, Knut Omang wrote:
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
>   hw/pci-bridge/gen_pcie_root_port.c | 4 ++++
>   hw/pci-bridge/pcie_root_port.c     | 4 ++++
>   include/hw/pci/pcie_port.h         | 1 +
>   3 files changed, 9 insertions(+)
>
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 9766edb..26bda73 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -20,6 +20,9 @@
>           OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
>   
>   #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> +#define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> +        (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> +
>   #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>   
>   typedef struct GenPCIERootPort {
> @@ -149,6 +152,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>       rpc->interrupts_init = gen_rp_interrupts_init;
>       rpc->interrupts_uninit = gen_rp_interrupts_uninit;
>       rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> +    rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
>   }
>   
>   static const TypeInfo gen_rp_dev_info = {
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 34ad767..a0b4cf7 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -47,6 +47,7 @@ static void rp_reset(DeviceState *qdev)
>       pcie_cap_deverr_reset(d);
>       pcie_cap_slot_reset(d);
>       pcie_cap_arifwd_reset(d);
> +    pcie_cap_acs_reset(d);
>       pcie_aer_root_reset(d);
>       pci_bridge_reset(qdev);
>       pci_bridge_disable_base_limit(d);
> @@ -106,6 +107,9 @@ static void rp_realize(PCIDevice *d, Error **errp)
>       pcie_aer_root_init(d);
>       rp_aer_vector_update(d);
>   
> +    if (rpc->acs_offset) {
> +        pcie_acs_init(d, rpc->acs_offset);
> +    }
>       return;
>   
>   err:
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index df242a0..09586f4 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -78,6 +78,7 @@ typedef struct PCIERootPortClass {
>       int exp_offset;
>       int aer_offset;
>       int ssvid_offset;
> +    int acs_offset;    /* If nonzero, optional ACS capability offset */
>       int ssid;
>   } PCIERootPortClass;
>   

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel
