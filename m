Received: from eggs.gnu.org ([2001:4830:134:3::10]:60547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dgqJ7-0006GQ-Da
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dgqJ4-0002kr-Au
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dgqJ4-0002kf-25
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:39:42 -0400
References: <1502407863-23182-1-git-send-email-zuban32s@gmail.com>
	<1502407863-23182-3-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a2303b82-455b-bc05-8505-6cdf81e69dee@redhat.com>
Date: Sun, 13 Aug 2017 13:39:34 +0300
MIME-Version: 1.0
In-Reply-To: <1502407863-23182-3-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/4] hw/pci: introduce bridge-only
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
Cc: mst@redhat.com, seabios@seabios.org

On 11/08/2017 2:31, Aleksandr Bezzubikov wrote:
> On PCI init PCI bridges may need some extra info about bus number,
> IO, memory and prefetchable memory to reserve. QEMU can provide this
> with a special vendor-specific PCI capability.
> 

Hi Aleksandr,

I only have a few very small comments, other than that
it looks OK to me.

> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>   hw/pci/pci_bridge.c         | 54 +++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci_bridge.h | 24 ++++++++++++++++++++
>   2 files changed, 78 insertions(+)
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 720119b..2495a51 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -408,6 +408,60 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
>       br->bus_name = bus_name;
>   }
>   
> +
> +int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset, > +                              uint32_t bus_reserve, uint64_t io_reserve,

Please pay attention to indentation, the above line should
be aligned with the above ("

> +                              uint32_t mem_non_pref_reserve,
> +                              uint32_t mem_pref_32_reserve,
> +                              uint64_t mem_pref_64_reserve,
> +                              Error **errp)
> +{
> +    if (mem_pref_32_reserve != (uint32_t)-1 &&
> +            mem_pref_64_reserve != (uint64_t) -1) {

Same here

> +        error_setg(errp,
> +                   "PCI resource reserve cap: PREF32 and PREF64 conflict");
> +        return -EINVAL;
> +    }
> +
> +    if (bus_reserve == (uint32_t)-1 &&
> +            io_reserve == (uint64_t)-1 &&
> +            mem_non_pref_reserve == (uint32_t)-1 &&
> +            mem_pref_32_reserve == (uint32_t)-1 &&
> +            mem_pref_64_reserve == (uint64_t)-1) {

and here (please go over all the file)

> +        return 0;
> +    }
> +
> +    size_t cap_len = sizeof(PCIBridgeQemuCap);
> +    PCIBridgeQemuCap cap = {
> +            .len = cap_len,
> +            .type = REDHAT_PCI_CAP_RESOURCE_RESERVE,
> +            .bus_res = bus_reserve,
> +            .io = io_reserve,
> +            .mem = mem_non_pref_reserve,
> +            .mem_pref_32 = (uint32_t)-1,
> +            .mem_pref_64 = (uint64_t)-1

Why not use the values of mem_pref_32_reserve and
mem_pref_64_reserve ? You already have checked they are
mutually exclusive.

> +    };
> +
> +    if (mem_pref_32_reserve != (uint32_t)-1 &&
> +            mem_pref_64_reserve == (uint64_t)-1) {
> +        cap.mem_pref_32 = mem_pref_32_reserve;
> +    } else if (mem_pref_32_reserve == (uint32_t)-1 &&
> +            mem_pref_64_reserve != (uint64_t)-1) {
> +        cap.mem_pref_64 = mem_pref_64_reserve;
> +    }

So it seems you don't need the above code at all, right?

With the above minor comments, please keep my R-b tag.
Thanks,
Marcel

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
> index ff7cbaa..2d8c635 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -67,4 +67,28 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
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
> +    uint32_t mem;       /* Non-prefetchable memory to reserve */
> +    /* This two fields are mutually exclusive */
> +    uint32_t mem_pref_32; /* Prefetchable memory to reserve (32-bit MMIO) */
> +    uint64_t mem_pref_64; /* Prefetchable memory to reserve (64-bit MMIO) */
> +} PCIBridgeQemuCap;
> +
> +#define REDHAT_PCI_CAP_RESOURCE_RESERVE 1
> +
> +int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
> +                              uint32_t bus_reserve, uint64_t io_reserve,
> +                              uint32_t mem_non_pref_reserve,
> +                              uint32_t mem_pref_32_reserve,
> +                              uint64_t mem_pref_64_reserve,
> +                              Error **errp);
> +
>   #endif /* QEMU_PCI_BRIDGE_H */
> 
