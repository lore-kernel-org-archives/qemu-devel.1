Received: from eggs.gnu.org ([2001:4830:134:3::10]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dektc-0006oJ-Qq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dektX-0001zW-I9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dektX-0001zC-8m
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:28:43 -0400
References: <1501964994-5257-1-git-send-email-zuban32s@gmail.com>
	<1501964994-5257-4-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bcd8d8b3-536f-b67b-d7f8-9623cef9ae51@redhat.com>
Date: Mon, 7 Aug 2017 19:28:35 +0300
MIME-Version: 1.0
In-Reply-To: <1501964994-5257-4-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: mst@redhat.com, kevin@koconnor.net, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

On 05/08/2017 23:29, Aleksandr Bezzubikov wrote:
> In case of Red Hat Generic PCIE Root Port reserve additional buses,
> which number is provided in a vendor-specific capability.
> 

Hi Aleksandr,

It seems the subject/commit description does not cover
all that the patch does, not it also deals with other resources
as well.

> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   src/fw/pciinit.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   src/hw/pci_ids.h |  3 +++
>   2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 864954f..d241d66 100644
> --- a/src/fw/pciinit.c
> +++ b/src/fw/pciinit.c
> @@ -15,6 +15,7 @@
>   #include "hw/pcidevice.h" // pci_probe_devices
>   #include "hw/pci_ids.h" // PCI_VENDOR_ID_INTEL
>   #include "hw/pci_regs.h" // PCI_COMMAND
> +#include "fw/dev-pci.h" // qemu_pci_cap
>   #include "list.h" // struct hlist_node
>   #include "malloc.h" // free
>   #include "output.h" // dprintf
> @@ -578,9 +579,42 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
>           pci_bios_init_bus_rec(secbus, pci_bus);
>   
>           if (subbus != *pci_bus) {
> +            u8 res_bus = 0;
> +            if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
> +                    pci_config_readw(bdf, PCI_DEVICE_ID) ==
> +                            PCI_DEVICE_ID_REDHAT_ROOT_PORT) {

I think I already pointed out you should extract the code receiving
the limit into a different function. Also now you have a chance
to re-use the code for IO/MEM resources.

> +                u8 cap;
> +                do {
> +                    cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);

Maybe I missed something, but how would the do-while will work
if you always use pci_find_capability with offset 0. It will
always start the search from 0 and find the same (first) capability,
right?
Maybe you need:
   cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, cap);

> +                } while (cap &&
> +                         pci_config_readb(bdf, cap + PCI_CAP_REDHAT_TYPE) !=
> +                                REDHAT_CAP_TYPE_QEMU);
> +                if (cap) {
> +                    u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
> +                    if (cap_len != QEMU_PCI_CAP_SIZE) {
> +                        dprintf(1, "PCI: QEMU cap length %d is invalid\n",
> +                                cap_len);
> +                    } else {
> +                        u32 tmp_res_bus = pci_config_readl(bdf,
> +                                                   cap + QEMU_PCI_CAP_BUS_RES);
> +                        if (tmp_res_bus != (u32)-1) {

I would extract the above check into a separate function
to make code more readable

    pci_qemu_res_cap_set(cap) { return cap != (u32)-1 }

then the code will look like:

                          if(pci_qemu_res_cap_set(res_bus)) {
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
>               dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
> -                    subbus, *pci_bus);
> -            subbus = *pci_bus;
> +                    subbus, res_bus);
> +            subbus = res_bus;
> +            *pci_bus = res_bus;
>           } else {
>               dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
>           }
> @@ -951,11 +985,38 @@ pci_region_map_one_entry(struct pci_region_entry *entry, u64 addr)
>   
>       u16 bdf = entry->dev->bdf;
>       u64 limit = addr + entry->size - 1;
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

The above code should be re-used.

> +            } else {
> +                u32 offset = cap + QEMU_PCI_CAP_LIMITS_OFFSET + entry->type * 8;
> +                u64 tmp_limit = (pci_config_readl(bdf, offset) |
> +                            (u64)pci_config_readl(bdf, offset + 4) << 32);
> +                if (tmp_limit != (u64)-1) {
> +                    tmp_limit += addr - 1;
> +                    limit = (limit > tmp_limit) ? limit : tmp_limit;
> +                }


I think it is too late to read (and use) the cap value here,
because a lot of computations including IO/MEM ranges takes place 
earlier, see:
   pci_bios_check_devices

pci_bios_map_devices uses previously computed ranges, at this time
I think you shouldn't change ranges.

> +            }
> +        }
> +    }
> +
>       if (entry->type == PCI_REGION_TYPE_IO) {
>           pci_config_writeb(bdf, PCI_IO_BASE, addr >> PCI_IO_SHIFT);
> -        pci_config_writew(bdf, PCI_IO_BASE_UPPER16, 0);
> +        pci_config_writew(bdf, PCI_IO_BASE_UPPER16, limit >> 16);
>           pci_config_writeb(bdf, PCI_IO_LIMIT, limit >> PCI_IO_SHIFT);
> -        pci_config_writew(bdf, PCI_IO_LIMIT_UPPER16, 0);
> +        pci_config_writew(bdf, PCI_IO_LIMIT_UPPER16, limit >> 16);

Judging the above code, it seems SeaBIOS does not support 32-bit IO,
I am not sure yuo can change that.


Thanks,
Marcel

>       }
>       if (entry->type == PCI_REGION_TYPE_MEM) {
>           pci_config_writew(bdf, PCI_MEMORY_BASE, addr >> PCI_MEMORY_SHIFT);
> diff --git a/src/hw/pci_ids.h b/src/hw/pci_ids.h
> index 4ac73b4..38fa2ca 100644
> --- a/src/hw/pci_ids.h
> +++ b/src/hw/pci_ids.h
> @@ -2263,6 +2263,9 @@
>   #define PCI_DEVICE_ID_KORENIX_JETCARDF0	0x1600
>   #define PCI_DEVICE_ID_KORENIX_JETCARDF1	0x16ff
>   
> +#define PCI_VENDOR_ID_REDHAT		0x1b36
> +#define PCI_DEVICE_ID_REDHAT_ROOT_PORT	0x000C
> +
>   #define PCI_VENDOR_ID_TEKRAM		0x1de1
>   #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>   
> 
