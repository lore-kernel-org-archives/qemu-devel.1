Received: from eggs.gnu.org ([2001:4830:134:3::10]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dcB63-000392-B8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dcB5y-0000LT-Ex
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:50:59 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dcB5y-0000Ka-5Z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:50:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id i19so18162030qte.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 06:50:52 -0700 (PDT)
Date: Mon, 31 Jul 2017 09:50:50 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170731135050.GA12595@morn.lan>
References: <1501284872-2078-1-git-send-email-zuban32s@gmail.com>
	<1501284872-2078-4-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501284872-2078-4-git-send-email-zuban32s@gmail.com>
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
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, mst@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

On Sat, Jul 29, 2017 at 02:34:32AM +0300, Aleksandr Bezzubikov wrote:
> In case of Red Hat Generic PCIE Root Port reserve additional buses,
> which number is provided in a vendor-specific capability.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/fw/pciinit.c | 37 +++++++++++++++++++++++++++++++++++--
>  src/hw/pci_ids.h |  3 +++
>  src/types.h      |  2 ++
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 864954f..a302a85 100644
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
> @@ -578,9 +579,41 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
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
> +                         pci_config_readb(bdf, cap + PCI_CAP_VNDR_SPEC_TYPE) !=
> +                                REDHAT_CAP_TYPE_QEMU);
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
> diff --git a/src/types.h b/src/types.h
> index 19d9f6c..75d9108 100644
> --- a/src/types.h
> +++ b/src/types.h
> @@ -122,6 +122,8 @@ extern void __force_link_error__only_in_16bit(void) __noreturn;
>              typeof(divisor) __divisor = divisor;        \
>              (((x) + ((__divisor) / 2)) / (__divisor));  \
>          })
> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +#define MAX(a, b) (((a) > (b)) ? (a) : (b))

It seems there are many different implementations of min/max macros
and how they handle the issue of multiple evaluation.  It may be a
good idea to add these to SeaBIOS, but not as part of a PCI patch.
For now, so as not to complicate this patch, I suggest you just
open-code the single use of MAX in your patch.

Otherwise, I'm okay with the SeaBIOS patch series.  The QEMU series
will need to be committed prior to committing the SeaBIOS patches.
However, please continue to address Marcel's (and other's) comments.

-Kevin
