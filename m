Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXmJn-0007XP-Kz
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXmJk-00073r-Ff
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:31 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXmJk-00073G-73
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:39:28 -0400
Received: by mail-qk0-x243.google.com with SMTP id b66-v6so3784389qkj.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 04:39:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626060941.8326-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <449812dc-605c-a849-c511-350c005740ed@amsat.org>
Date: Tue, 26 Jun 2018 08:39:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180626060941.8326-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vga: set owner for mmio regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 06/26/2018 03:09 AM, Gerd Hoffmann wrote:
> This makes sure the regions are properly cleaned when unplugging -device
> seconday-vga.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/vga_int.h    |  1 +
>  hw/display/vga-pci.c    | 11 ++++++-----
>  hw/display/virtio-vga.c |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 313cff84fc..f8fcf62a56 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -193,6 +193,7 @@ extern const MemoryRegionOps vga_mem_ops;
>  
>  /* vga-pci.c */
>  void pci_std_vga_mmio_region_init(VGACommonState *s,
> +                                  Object *owner,
>                                    MemoryRegion *parent,
>                                    MemoryRegion *subs,
>                                    bool qext);
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index 700ac58c69..1ea559762a 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -192,22 +192,23 @@ static const MemoryRegionOps pci_vga_qext_ops = {
>  };
>  
>  void pci_std_vga_mmio_region_init(VGACommonState *s,
> +                                  Object *owner,
>                                    MemoryRegion *parent,
>                                    MemoryRegion *subs,
>                                    bool qext)
>  {
> -    memory_region_init_io(&subs[0], NULL, &pci_vga_ioport_ops, s,
> +    memory_region_init_io(&subs[0], owner, &pci_vga_ioport_ops, s,
>                            "vga ioports remapped", PCI_VGA_IOPORT_SIZE);
>      memory_region_add_subregion(parent, PCI_VGA_IOPORT_OFFSET,
>                                  &subs[0]);
>  
> -    memory_region_init_io(&subs[1], NULL, &pci_vga_bochs_ops, s,
> +    memory_region_init_io(&subs[1], owner, &pci_vga_bochs_ops, s,
>                            "bochs dispi interface", PCI_VGA_BOCHS_SIZE);
>      memory_region_add_subregion(parent, PCI_VGA_BOCHS_OFFSET,
>                                  &subs[1]);
>  
>      if (qext) {
> -        memory_region_init_io(&subs[2], NULL, &pci_vga_qext_ops, s,
> +        memory_region_init_io(&subs[2], owner, &pci_vga_qext_ops, s,
>                                "qemu extended regs", PCI_VGA_QEXT_SIZE);
>          memory_region_add_subregion(parent, PCI_VGA_QEXT_OFFSET,
>                                      &subs[2]);
> @@ -239,7 +240,7 @@ static void pci_std_vga_realize(PCIDevice *dev, Error **errp)
>              qext = true;
>              pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
>          }
> -        pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs, qext);
> +        pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs, qext);
>  
>          pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
>      }
> @@ -275,7 +276,7 @@ static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
>          qext = true;
>          pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
>      }
> -    pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs, qext);
> +    pci_std_vga_mmio_region_init(s, OBJECT(dev), &d->mmio, d->mrs, qext);
>  
>      pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
>      pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio);
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index baa74ba82c..97db6c3372 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -152,7 +152,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      }
>  
>      /* add stdvga mmio regions */
> -    pci_std_vga_mmio_region_init(vga, &vpci_dev->modern_bar,
> +    pci_std_vga_mmio_region_init(vga, OBJECT(vvga), &vpci_dev->modern_bar,
>                                   vvga->vga_mrs, true);
>  
>      vga->con = g->scanout[0].con;
> 
