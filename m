Received: from eggs.gnu.org ([2001:4830:134:3::10]:33253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc8RN-0007tn-7E
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc8RJ-00075q-C7
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dc8RI-000751-Tm
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:00:45 -0400
References: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
	<1501284872-2078-4-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <fae5ef08-b856-7ca9-5c4c-5d014b49c7dd@redhat.com>
Date: Mon, 31 Jul 2017 14:00:19 +0300
MIME-Version: 1.0
In-Reply-To: <1501284872-2078-4-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pci: enable RedHat PCI bridges to
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
Cc: mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

On 29/07/2017 2:34, Aleksandr Bezzubikov wrote:
> In case of Red Hat Generic PCIE Root Port reserve additional buses,
> which number is provided in a vendor-specific capability.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   src/fw/pciinit.c | 37 +++++++++++++++++++++++++++++++++++--
>   src/hw/pci_ids.h |  3 +++
>   src/types.h      |  2 ++
>   3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 864954f..a302a85 100644
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
> @@ -578,9 +579,41 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
>           pci_bios_init_bus_rec(secbus, pci_bus);
>   
>           if (subbus != *pci_bus) {
> +            u8 res_bus = 0;
> +            if (pci_config_readw(bdf, PCI_VENDOR_ID) == PCI_VENDOR_ID_REDHAT &&
> +                    pci_config_readw(bdf, PCI_DEVICE_ID) ==
> +                            PCI_DEVICE_ID_REDHAT_ROOT_PORT) {
> +                u8 cap;
> +                do {
> +                    cap = pci_find_capability(bdf, PCI_CAP_ID_VNDR, 0);
> +                } while (cap &&
> +                         pci_config_readb(bdf, cap + PCI_CAP_VNDR_SPEC_TYPE) !=
> +                                REDHAT_CAP_TYPE_QEMU);

I suggest to extract the bus_reserve computation in a different
function.

> +                if (cap) {
> +                    u8 cap_len = pci_config_readb(bdf, cap + PCI_CAP_FLAGS);
> +                    if (cap_len != QEMU_PCI_CAP_SIZE) {
> +                        dprintf(1, "PCI: QEMU cap length %d is invalid\n",
> +                                cap_len);
> +                    } else {
> +                        res_bus = pci_config_readb(bdf,
> +                                                   cap + QEMU_PCI_CAP_BUS_RES);
> +                        if ((u8)(res_bus + secbus) < secbus ||
> +                            (u8)(res_bus + secbus) < res_bus) {

What do you check here, "garbage" values? Even so, all values
are unsigned, are you checking for overflow?

> +                            dprintf(1, "PCI: bus_reserve value %d is invalid\n",
> +                                    res_bus);
> +                            res_bus = 0;
> +                        } else {
> +                            dprintf(1, "PCI: QEMU cap is found, value = %u\n",
> +                                    res_bus);
> +                        }
> +                    }
> +                }
> +                res_bus = MAX(*pci_bus, secbus + res_bus);

Did you re-check the reboot "issue"?

Thanks,
Marcel

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
> diff --git a/src/types.h b/src/types.h
> index 19d9f6c..75d9108 100644
> --- a/src/types.h
> +++ b/src/types.h
> @@ -122,6 +122,8 @@ extern void __force_link_error__only_in_16bit(void) __noreturn;
>               typeof(divisor) __divisor = divisor;        \
>               (((x) + ((__divisor) / 2)) / (__divisor));  \
>           })
> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))
>   #define ALIGN(x,a)              __ALIGN_MASK(x,(typeof(x))(a)-1)
>   #define __ALIGN_MASK(x,mask)    (((x)+(mask))&~(mask))
>   #define ALIGN_DOWN(x,a)         ((x) & ~((typeof(x))(a)-1))
> 
