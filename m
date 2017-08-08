Received: from eggs.gnu.org ([2001:4830:134:3::10]:44684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1df6pC-0000iX-CJ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1df6p9-0004mM-7c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1df6p8-0004lv-UX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:53:39 -0400
Date: Tue, 8 Aug 2017 18:53:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170808184619-mutt-send-email-mst@kernel.org>
References: <1501964994-5257-1-git-send-email-zuban32s@gmail.com>
	<1501964994-5257-4-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501964994-5257-4-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] pci: enable RedHat PCI bridges to
 reserve additional buses on PCI init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

On Sat, Aug 05, 2017 at 11:29:54PM +0300, Aleksandr Bezzubikov wrote:
> In case of Red Hat Generic PCIE Root Port reserve additional buses,
> which number is provided in a vendor-specific capability.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/fw/pciinit.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  src/hw/pci_ids.h |  3 +++
>  2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 864954f..d241d66 100644
> --- a/src/fw/pciinit.c
> +++ b/src/fw/pciinit.c
> @@ -15,6 +15,7 @@
>  #include "hw/pcidevice.h" // pci_probe_devices
>  #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
>  #include "hw/pci_regs.h" // PCI_COMMAND
> +#include "fw/dev-pci.h" // qemu_pci_cap
>  #include "list.h" // struct hlist_node
>  #include "malloc.h" // free
>  #include "output.h" // dprintf
> @@ -578,9 +579,42 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
>          pci_bios_init_bus_rec(secbus, pci_bus);
>  
>          if (subbus != *pci_bus) {
> +            u8 res_bus = 0;
> +            if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
> +                    pci_config_readw(bdf, PCI_DEVICE_ID) ==
> +                            PCI_DEVICE_ID_REDHAT_ROOT_PORT) {
> +                u8 cap;
> +                do {
> +                    cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
> +                } while (cap &&
> +                         pci_config_readb(bdf, cap + PCI_CAP_REDHAT_TYPE) !=
> +                                REDHAT_CAP_TYPE_QEMU);
> +                if (cap) {
> +                    u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
> +                    if (cap_len != QEMU_PCI_CAP_SIZE) {
> +                        dprintf(1, "PCI: QEMU cap length %d is invalid\n",
> +                                cap_len);

I would do cap_len < QEMU_PCI_CAP_SIZE here - this way you can extend
the capability without breaking things.

> +                    } else {
> +                        u32 tmp_res_bus = pci_config_readl(bdf,
> +                                                   cap + QEMU_PCI_CAP_BUS_RES);
> +                        if (tmp_res_bus != (u32)-1) {
> +                            res_bus = tmp_res_bus & 0xFF;
> +                            if ((u8)(res_bus + secbus) < secbus ||
> +                                (u8)(res_bus + secbus) < res_bus) {
> +                                dprintf(1, "PCI: bus_reserve value %d is invalid\n",
> +                                        res_bus);
> +                                res_bus = 0;
> +                            }
> +                        }
> +                    }
> +                }
> +                res_bus = (*pci_bus > secbus + res_bus) ? *pci_bus
> +                                                      : secbus + res_bus;
> +            }
>              dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
> -                    subbus, *pci_bus);
> -            subbus = *pci_bus;
> +                    subbus, res_bus);
> +            subbus = res_bus;
> +            *pci_bus = res_bus;
>          } else {
>              dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
>          }
> @@ -951,11 +985,38 @@ pci_region_map_one_entry(struct pci_region_entry *entry, u64 addr)
>  
>      u16 bdf = entry->dev->bdf;
>      u64 limit = addr + entry->size - 1;
> +
> +    if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
> +            pci_config_readw(bdf, PCI_DEVICE_ID) ==
> +                    PCI_DEVICE_ID_REDHAT_ROOT_PORT) {
> +        u8 cap;
> +        do {
> +            cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
> +        } while (cap &&
> +                 pci_config_readb(bdf, cap + PCI_CAP_REDHAT_TYPE) !=
> +                        REDHAT_CAP_TYPE_QEMU);
> +        if (cap) {
> +            u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
> +            if (cap_len != QEMU_PCI_CAP_SIZE) {
> +                dprintf(1, "PCI: QEMU cap length %d is invalid\n",
> +                        cap_len);

Same here.

> +            } else {
> +                u32 offset = cap + QEMU_PCI_CAP_LIMITS_OFFSET + entry->type * 8;

what is this doing exactly? type is an enum so it's a trick. I'd rather
have an inline with a switch. Use it for bus as well.

> +                u64 tmp_limit = (pci_config_readl(bdf, offset) |
> +                            (u64)pci_config_readl(bdf, offset + 4) << 32);
> +                if (tmp_limit != (u64)-1) {
> +                    tmp_limit += addr - 1;
> +                    limit = (limit > tmp_limit) ? limit : tmp_limit;
> +                }
> +            }
> +        }
> +    }
> +
>      if (entry->type == PCI_REGION_TYPE_IO) {
>          pci_config_writeb(bdf, PCI_IO_BASE, addr >> PCI_IO_SHIFT);
> -        pci_config_writew(bdf, PCI_IO_BASE_UPPER16, 0);
> +        pci_config_writew(bdf, PCI_IO_BASE_UPPER16, limit >> 16);
>          pci_config_writeb(bdf, PCI_IO_LIMIT, limit >> PCI_IO_SHIFT);
> -        pci_config_writew(bdf, PCI_IO_LIMIT_UPPER16, 0);
> +        pci_config_writew(bdf, PCI_IO_LIMIT_UPPER16, limit >> 16);
>      }
>      if (entry->type == PCI_REGION_TYPE_MEM) {
>          pci_config_writew(bdf, PCI_MEMORY_BASE, addr >> PCI_MEMORY_SHIFT);
> diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
> index 4ac73b4..38fa2ca 100644
> --- a/src/hw/pci_ids.h
> +++ b/src/hw/pci_ids.h
> @@ -2263,6 +2263,9 @@
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
>  #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
>  
> +#define PCI_VENDOR_ID_REDHAT		0x1b36
> +#define PCI_DEVICE_ID_REDHAT_ROOT_PORT	0x000C
> +
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> -- 
> 2.7.4
