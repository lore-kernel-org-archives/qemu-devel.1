Received: from eggs.gnu.org ([2001:4830:134:3::10]:55228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1del9R-0005g5-3C
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1del9L-0002Yy-LM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1del9L-0002Yd-C3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:45:03 -0400
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-4-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e45c9a22-8a8c-491e-d353-e207b7bfa841@redhat.com>
Date: Mon, 7 Aug 2017 19:44:53 +0300
MIME-Version: 1.0
In-Reply-To: <1501964858-5159-4-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/5] hw/pci: introduce bridge-only
 vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, seabios@seabios.org

On 05/08/2017 23:27, Aleksandr Bezzubikov wrote:
> On PCI init PCI bridges may need some extra info about bus number,
> IO, memory and prefetchable memory to reserve. QEMU can provide this
> with a special vendor-specific PCI capability.
> 

Hi Aleksandr,

> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   hw/pci/pci_bridge.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/pci/pci_bridge.h | 21 +++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 720119b..889950d 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -408,6 +408,35 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
>       br->bus_name = bus_name;
>   }
>   
> +
> +int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
> +                              uint32_t bus_reserve, uint64_t io_reserve,
> +                              uint64_t non_pref_mem_reserve,
> +                              uint64_t pref_mem_reserve,
> +                              Error **errp)
> +{
> +    size_t cap_len = sizeof(PCIBridgeQemuCap);
> +    PCIBridgeQemuCap cap = {
> +            .len = cap_len,
> +            .type = REDHAT_PCI_CAP_QEMU_RESERVE,

I would change the type to:
    REDHAT_PCI_CAP_RESOURCE_RESERVE

QEMU is less important here (I think) than "resource".

> +            .bus_res = bus_reserve,
> +            .io = io_reserve,
> +            .mem = non_pref_mem_reserve,
> +            .mem_pref = pref_mem_reserve
> +    };
> +
> +    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
> +                                    cap_offset, cap_len, errp);
> +    if (offset < 0) {
> +        return offset;
> +    }
> +
> +    memcpy(dev->config + offset + PCI_CAP_FLAGS,
> +            (char *)&cap + PCI_CAP_FLAGS,
> +            cap_len - PCI_CAP_FLAGS);
> +    return 0;
> +}
> +
>   static const TypeInfo pci_bridge_type_info = {
>       .name = TYPE_PCI_BRIDGE,
>       .parent = TYPE_PCI_DEVICE,
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index ff7cbaa..be565f7 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -67,4 +67,25 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
>   #define  PCI_BRIDGE_CTL_DISCARD_STATUS	0x400	/* Discard timer status */
>   #define  PCI_BRIDGE_CTL_DISCARD_SERR	0x800	/* Discard timer SERR# enable */
>   
> +typedef struct PCIBridgeQemuCap {
> +    uint8_t id;     /* Standard PCI capability header field */
> +    uint8_t next;   /* Standard PCI capability header field */
> +    uint8_t len;    /* Standard PCI vendor-specific capability header field */
> +    uint8_t type;   /* Red Hat vendor-specific capability type.
> +                       Types are defined with REDHAT_PCI_CAP_ prefix */
> +
> +    uint32_t bus_res;   /* Minimum number of buses to reserve */
> +    uint64_t io;        /* IO space to reserve */
> +    uint64_t mem;       /* Non-prefetchable memory to reserve */
> +    uint64_t mem_pref;  /* Prefetchable memory to reserve */
> +} PCIBridgeQemuCap;
> +
> +#define REDHAT_PCI_CAP_QEMU_RESERVE     1
> +
> +int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
> +                              uint32_t bus_reserve, uint64_t io_reserve,
> +                              uint64_t non_pref_mem_reserve,
> +                              uint64_t pref_mem_reserve,
> +                              Error **errp);
> +
>   #endif /* QEMU_PCI_BRIDGE_H */
> 

With the name change, the layout looks good to me:

    Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
