Received: from eggs.gnu.org ([2001:4830:134:3::10]:57871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cm5E0-0003BO-5l
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 16:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cm5Dn-00078H-1d
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 16:03:52 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:47686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cm5Dm-000774-Kp
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 16:03:38 -0500
References: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
	<1489048710-22084-5-git-send-email-kraxel@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <94414912-f18a-bb2b-4055-126261181e89@reactos.org>
Date: Thu, 9 Mar 2017 22:03:29 +0100
MIME-Version: 1.0
In-Reply-To: <1489048710-22084-5-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] [RfC] stdvga: add xres and yres
 properties.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Le 09/03/2017 =E0 09:38, Gerd Hoffmann a =E9crit :
> Add two new registers to the qemu extended register range, carrying the
> suggested width and height of the display device.  In case the xres and
> yres properties are set, fill these new registers accordingly.
>
> Additionally guest driver updates are needed to support the new
> registers.  These changes will probably land in linux kernel 4.12.

Is it possible to provide a mecanism to tell guest that the preferred def=
ault size changed?
For example, the user can resize the VM window on host, and guest will au=
to-adapt to new size/resolution.
It is already working like this on VirtualBox with VM Additions.

Regards,

Herv=E9

>
> TODO: add compat properties to turn off qemu-display-size for machine
>       types older than 2.10
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga-pci.c    | 52 ++++++++++++++++++++++++++++++++++-------=
--------
>  hw/display/vga_int.h    |  6 ++++--
>  hw/display/virtio-vga.c |  3 ++-
>  3 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index 8500362..10b1832 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -31,23 +31,28 @@
>  #include "ui/pixel_ops.h"
>  #include "qemu/timer.h"
>  #include "hw/loader.h"
> +#include "sysemu/sysemu.h"
>
>  #define PCI_VGA_IOPORT_OFFSET 0x400
>  #define PCI_VGA_IOPORT_SIZE   (0x3e0 - 0x3c0)
>  #define PCI_VGA_BOCHS_OFFSET  0x500
>  #define PCI_VGA_BOCHS_SIZE    (0x0b * 2)
>  #define PCI_VGA_QEXT_OFFSET   0x600
> -#define PCI_VGA_QEXT_SIZE     (2 * 4)
> +#define PCI_VGA_QEXT_SIZE_V1  (2 * 4)
> +#define PCI_VGA_QEXT_SIZE_V2  (4 * 4)
>  #define PCI_VGA_MMIO_SIZE     0x1000
>
>  #define PCI_VGA_QEXT_REG_SIZE         (0 * 4)
>  #define PCI_VGA_QEXT_REG_BYTEORDER    (1 * 4)
>  #define  PCI_VGA_QEXT_LITTLE_ENDIAN   0x1e1e1e1e
>  #define  PCI_VGA_QEXT_BIG_ENDIAN      0xbebebebe
> +#define PCI_VGA_QEXT_REG_WIDTH        (2 * 4)
> +#define PCI_VGA_QEXT_REG_HEIGHT       (3 * 4)
>
>  enum vga_pci_flags {
> -    PCI_VGA_FLAG_ENABLE_MMIO =3D 1,
> -    PCI_VGA_FLAG_ENABLE_QEXT =3D 2,
> +    PCI_VGA_FLAG_ENABLE_MMIO    =3D 1,
> +    PCI_VGA_FLAG_ENABLE_QEXT    =3D 2,
> +    PCI_VGA_FLAG_ENABLE_QEXT_V2 =3D 3,
>  };
>
>  typedef struct PCIVGAState {
> @@ -157,10 +162,14 @@ static uint64_t pci_vga_qext_read(void *ptr, hwad=
dr addr, unsigned size)
>
>      switch (addr) {
>      case PCI_VGA_QEXT_REG_SIZE:
> -        return PCI_VGA_QEXT_SIZE;
> +        return s->qext_size;
>      case PCI_VGA_QEXT_REG_BYTEORDER:
>          return s->big_endian_fb ?
>              PCI_VGA_QEXT_BIG_ENDIAN : PCI_VGA_QEXT_LITTLE_ENDIAN;
> +    case PCI_VGA_QEXT_REG_WIDTH:
> +        return s->xres;
> +    case PCI_VGA_QEXT_REG_HEIGHT:
> +        return s->yres;
>      default:
>          return 0;
>      }
> @@ -207,8 +216,7 @@ static const MemoryRegionOps pci_vga_qext_ops =3D {
>
>  void pci_std_vga_mmio_region_init(VGACommonState *s,
>                                    MemoryRegion *parent,
> -                                  MemoryRegion *subs,
> -                                  bool qext)
> +                                  MemoryRegion *subs)
>  {
>      memory_region_init_io(&subs[0], NULL, &pci_vga_ioport_ops, s,
>                            "vga ioports remapped", PCI_VGA_IOPORT_SIZE)=
;
> @@ -220,9 +228,9 @@ void pci_std_vga_mmio_region_init(VGACommonState *s=
,
>      memory_region_add_subregion(parent, PCI_VGA_BOCHS_OFFSET,
>                                  &subs[1]);
>
> -    if (qext) {
> +    if (s->qext_size) {
>          memory_region_init_io(&subs[2], NULL, &pci_vga_qext_ops, s,
> -                              "qemu extended regs", PCI_VGA_QEXT_SIZE)=
;
> +                              "qemu extended regs", s->qext_size);
>          memory_region_add_subregion(parent, PCI_VGA_QEXT_OFFSET,
>                                      &subs[2]);
>      }
> @@ -232,7 +240,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Err=
or **errp)
>  {
>      PCIVGAState *d =3D PCI_VGA(dev);
>      VGACommonState *s =3D &d->vga;
> -    bool qext =3D false;
>
>      /* vga + console init */
>      vga_common_init(s, OBJECT(dev), true);
> @@ -249,10 +256,15 @@ static void pci_std_vga_realize(PCIDevice *dev, E=
rror **errp)
>          memory_region_init(&d->mmio, NULL, "vga.mmio", 4096);
>
>          if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
> -            qext =3D true;
> -            pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
> +            if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT_V2)) {
> +                s->qext_size =3D PCI_VGA_QEXT_SIZE_V2;
> +                pci_set_byte(&d->dev.config[PCI_REVISION_ID], 3);
> +            } else {
> +                s->qext_size =3D PCI_VGA_QEXT_SIZE_V1;
> +                pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
> +            }
>          }
> -        pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs, qext);
> +        pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs);
>
>          pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d=
->mmio);
>      }
> @@ -274,7 +286,6 @@ static void pci_secondary_vga_realize(PCIDevice *de=
v, Error **errp)
>  {
>      PCIVGAState *d =3D PCI_VGA(dev);
>      VGACommonState *s =3D &d->vga;
> -    bool qext =3D false;
>
>      /* vga + console init */
>      vga_common_init(s, OBJECT(dev), false);
> @@ -284,10 +295,15 @@ static void pci_secondary_vga_realize(PCIDevice *=
dev, Error **errp)
>      memory_region_init(&d->mmio, OBJECT(dev), "vga.mmio", 4096);
>
>      if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT)) {
> -        qext =3D true;
> -        pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
> +        if (d->flags & (1 << PCI_VGA_FLAG_ENABLE_QEXT_V2)) {
> +            s->qext_size =3D PCI_VGA_QEXT_SIZE_V2;
> +            pci_set_byte(&d->dev.config[PCI_REVISION_ID], 3);
> +        } else {
> +            s->qext_size =3D PCI_VGA_QEXT_SIZE_V1;
> +            pci_set_byte(&d->dev.config[PCI_REVISION_ID], 2);
> +        }
>      }
> -    pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs, qext);
> +    pci_std_vga_mmio_region_init(s, &d->mmio, d->mrs);
>
>      pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vr=
am);
>      pci_register_bar(&d->dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mm=
io);
> @@ -315,6 +331,10 @@ static Property vga_pci_common_properties[] =3D {
>      DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16)=
,
>      DEFINE_PROP_BIT("qemu-extended-regs",
>                      PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true=
),
> +    DEFINE_PROP_BIT("qemu-display-size",
> +                    PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT_V2, t=
rue),
> +    DEFINE_PROP_UINT32("xres", PCIVGAState, vga.xres, 0),
> +    DEFINE_PROP_UINT32("yres", PCIVGAState, vga.yres, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index dd6c958..1e9b0ff 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -162,6 +162,9 @@ typedef struct VGACommonState {
>      bool full_update_gfx;
>      bool big_endian_fb;
>      bool default_endian_fb;
> +    uint32_t qext_size;
> +    uint32_t xres;
> +    uint32_t yres;
>      /* hardware mouse cursor support */
>      uint32_t invalidated_y_table[VGA_MAX_HEIGHT / 32];
>      uint32_t hw_cursor_x;
> @@ -223,7 +226,6 @@ extern const MemoryRegionOps vga_mem_ops;
>  /* vga-pci.c */
>  void pci_std_vga_mmio_region_init(VGACommonState *s,
>                                    MemoryRegion *parent,
> -                                  MemoryRegion *subs,
> -                                  bool qext);
> +                                  MemoryRegion *subs);
>
>  #endif
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index f9b017d..8684dc0 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -153,8 +153,9 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
>      }
>
>      /* add stdvga mmio regions */
> +    vga->qext_size =3D 2 * 4; /* PCI_VGA_QEXT_SIZE_V1 */
>      pci_std_vga_mmio_region_init(vga, &vpci_dev->modern_bar,
> -                                 vvga->vga_mrs, true);
> +                                 vvga->vga_mrs);
>
>      vga->con =3D g->scanout[0].con;
>      graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
>
