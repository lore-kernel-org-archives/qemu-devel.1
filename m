Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZJgc-0002Nw-8j
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dZJgZ-0007kt-6B
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:24:54 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dZJgY-0007kb-Vt
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:24:51 -0400
Received: by mail-qt0-x241.google.com with SMTP id l55so10327530qtl.3
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:24:49 -0700 (PDT)
Date: Sun, 23 Jul 2017 12:24:47 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170723162447.GA28883@morn.lan>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-2-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500761510-1556-2-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/4] pci: refactor
 pci_find_capapibilty to get bdf as the first argument instead of the whole
 pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On Sun, Jul 23, 2017 at 01:11:47AM +0300, Aleksandr Bezzubikov wrote:
> Refactor pci_find_capability function to get bdf instead of
> a whole pci_device* as the only necessary field for this function 
> is still bdf.
> It greatly helps when we have bdf but not pci_device.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>  src/fw/pciinit.c    |  4 ++--
>  src/hw/pcidevice.c  | 12 ++++++------
>  src/hw/pcidevice.h  |  2 +-
>  src/hw/virtio-pci.c |  4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index 08221e6..864954f 100644
> --- a/src/fw/pciinit.c
> +++ b/src/fw/pciinit.c
> @@ -762,7 +762,7 @@ static int pci_bus_hotplug_support(struct pci_bus *bus, u8 pcie_cap)
>          return downstream_port && slot_implemented;
>      }
>  
> -    shpc_cap = pci_find_capability(bus->bus_dev, PCI_CAP_ID_SHPC, 0);
> +    shpc_cap = pci_find_capability(bus->bus_dev->bdf, PCI_CAP_ID_SHPC, 0);
>      return !!shpc_cap;
>  }
>  
> @@ -844,7 +844,7 @@ static int pci_bios_check_devices(struct pci_bus *busses)
>               */
>              parent = &busses[0];
>          int type;
> -        u8 pcie_cap = pci_find_capability(s->bus_dev, PCI_CAP_ID_EXP, 0);
> +        u8 pcie_cap = pci_find_capability(s->bus_dev->bdf, PCI_CAP_ID_EXP, 0);
>          int hotplug_support = pci_bus_hotplug_support(s, pcie_cap);
>          for (type = 0; type < PCI_REGION_TYPE_COUNT; type++) {
>              u64 align = (type == PCI_REGION_TYPE_IO) ?
> diff --git a/src/hw/pcidevice.c b/src/hw/pcidevice.c
> index cfebf66..d01e27b 100644
> --- a/src/hw/pcidevice.c
> +++ b/src/hw/pcidevice.c
> @@ -134,25 +134,25 @@ pci_find_init_device(const struct pci_device_id *ids, void *arg)
>      return NULL;
>  }
>  
> -u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap)
> +u8 pci_find_capability(u16 bdf, u8 cap_id, u8 cap)

Thanks.  If you respin this series, please also move
pci_find_capability() function from pcidevice.c to pci.c.  (If the
function no longer takes a pci_device, it should be moved out of
pcidevice.c.)

-Kevin
