Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIs9q-0000Ym-Ae
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIs9n-0007r9-4L
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:51:38 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:7407
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIs9m-0007q3-Kg
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:51:35 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 May 2018 08:51:28 +0000
Message-ID: <1329a5076d0a434084a458ae349b7e39@AMSPEX02CL03.citrite.net>
References: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: stop faking I/O to access PCI
 config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>

Anthony, Stefano,

  Ping?

  Paul

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 03 May 2018 12:19
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> Michael S. Tsirkin <mst@redhat.com>; Marcel Apfelbaum
> <marcel@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>
> Subject: [PATCH] xen-hvm: stop faking I/O to access PCI config space
>=20
> This patch removes the current hackery where IOREQ_TYPE_PCI_CONFIG
> reqyests are handled by faking PIO to 0xcf8 and 0xcfc and replaces it
> with direct calls to pci_host_config_read/write_common().
> Doing so necessitates mapping BDFs to PCIDevices but maintaining a simple
> QLIST in xen_device_realize/unrealize() will suffice.
>=20
> NOTE: whilst config space accesses are currently limited to
>       PCI_CONFIG_SPACE_SIZE, this patch paves the way to increasing the
>       limit to PCIE_CONFIG_SPACE_SIZE when Xen gains the ability to
>       emulate MCFG table accesses.
>=20
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> --
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/xen/trace-events |   2 +
>  hw/i386/xen/xen-hvm.c    | 101
> +++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 83 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
> index 8dab7bc..f576f1b 100644
> --- a/hw/i386/xen/trace-events
> +++ b/hw/i386/xen/trace-events
> @@ -15,6 +15,8 @@ cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df,
> uint32_t data_is_ptr, uint64
>  cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t
> size) "I/O=3D%p pio read reg data=3D0x%"PRIx64" port=3D0x%"PRIx64" size=
=3D%d"
>  cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_=
t
> size) "I/O=3D%p pio write reg data=3D0x%"PRIx64" port=3D0x%"PRIx64" size=
=3D%d"
>  cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_pt=
r,
> uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p co=
py
> dir=3D%d df=3D%d ptr=3D%d port=3D0x%"PRIx64" data=3D0x%"PRIx64" count=3D%=
d
> size=3D%d"
> +cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg, uint32_t
> size, uint32_t data) "I/O=3D%p sbdf=3D0x%x reg=3D%u size=3D%u data=3D0x%x=
"
> +cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t
> size, uint32_t data) "I/O=3D%p sbdf=3D0x%x reg=3D%u size=3D%u data=3D0x%x=
"
>=20
>  # xen-mapcache.c
>  xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index caa563b..c139d29 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -12,6 +12,7 @@
>=20
>  #include "cpu.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/xen/xen_common.h"
> @@ -86,6 +87,12 @@ typedef struct XenPhysmap {
>      QLIST_ENTRY(XenPhysmap) list;
>  } XenPhysmap;
>=20
> +typedef struct XenPciDevice {
> +    PCIDevice *pci_dev;
> +    uint32_t sbdf;
> +    QLIST_ENTRY(XenPciDevice) entry;
> +} XenPciDevice;
> +
>  typedef struct XenIOState {
>      ioservid_t ioservid;
>      shared_iopage_t *shared_page;
> @@ -105,6 +112,7 @@ typedef struct XenIOState {
>      struct xs_handle *xenstore;
>      MemoryListener memory_listener;
>      MemoryListener io_listener;
> +    QLIST_HEAD(, XenPciDevice) dev_list;
>      DeviceListener device_listener;
>      QLIST_HEAD(, XenPhysmap) physmap;
>      hwaddr free_phys_offset;
> @@ -569,6 +577,12 @@ static void xen_device_realize(DeviceListener
> *listener,
>=20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> +        XenPciDevice *xendev =3D g_new(XenPciDevice, 1);
> +
> +        xendev->pci_dev =3D pci_dev;
> +        xendev->sbdf =3D PCI_BUILD_BDF(pci_dev_bus_num(pci_dev),
> +                                     pci_dev->devfn);
> +        QLIST_INSERT_HEAD(&state->dev_list, xendev, entry);
>=20
>          xen_map_pcidev(xen_domid, state->ioservid, pci_dev);
>      }
> @@ -581,8 +595,17 @@ static void xen_device_unrealize(DeviceListener
> *listener,
>=20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> +        XenPciDevice *xendev, *next;
>=20
>          xen_unmap_pcidev(xen_domid, state->ioservid, pci_dev);
> +
> +        QLIST_FOREACH_SAFE(xendev, &state->dev_list, entry, next) {
> +            if (xendev->pci_dev =3D=3D pci_dev) {
> +                QLIST_REMOVE(xendev, entry);
> +                g_free(xendev);
> +                break;
> +            }
> +        }
>      }
>  }
>=20
> @@ -903,6 +926,61 @@ static void cpu_ioreq_move(ioreq_t *req)
>      }
>  }
>=20
> +static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
> +{
> +    uint32_t sbdf =3D req->addr >> 32;
> +    uint32_t reg =3D req->addr;
> +    XenPciDevice *xendev;
> +
> +    if (req->size > sizeof(uint32_t)) {
> +        hw_error("PCI config access: bad size (%u)", req->size);
> +    }
> +
> +    QLIST_FOREACH(xendev, &state->dev_list, entry) {
> +        unsigned int i;
> +
> +        if (xendev->sbdf !=3D sbdf) {
> +            continue;
> +        }
> +
> +        if (req->dir =3D=3D IOREQ_READ) {
> +            if (!req->data_is_ptr) {
> +                req->data =3D pci_host_config_read_common(
> +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> +                    req->size);
> +                trace_cpu_ioreq_config_read(req, sbdf, reg, req->size,
> +                                            req->data);
> +            } else {
> +                for (i =3D 0; i < req->count; i++) {
> +                    uint32_t tmp;
> +
> +                    tmp =3D pci_host_config_read_common(
> +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
> +                        req->size);
> +                    write_phys_req_item(req->data, req, i, &tmp);
> +                }
> +            }
> +        } else if (req->dir =3D=3D IOREQ_WRITE) {
> +            if (!req->data_is_ptr) {
> +                trace_cpu_ioreq_config_write(req, sbdf, reg, req->size,
> +                                             req->data);
> +                pci_host_config_write_common(
> +                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, req->da=
ta,
> +                    req->size);
> +            } else {
> +                for (i =3D 0; i < req->count; i++) {
> +                    uint32_t tmp =3D 0;
> +
> +                    read_phys_req_item(req->data, req, i, &tmp);
> +                    pci_host_config_write_common(
> +                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE, tmp=
,
> +                        req->size);
> +                }
> +            }
> +        }
> +    }
> +}
> +
>  static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
>  {
>      X86CPU *cpu;
> @@ -975,27 +1053,9 @@ static void handle_ioreq(XenIOState *state, ioreq_t
> *req)
>          case IOREQ_TYPE_INVALIDATE:
>              xen_invalidate_map_cache();
>              break;
> -        case IOREQ_TYPE_PCI_CONFIG: {
> -            uint32_t sbdf =3D req->addr >> 32;
> -            uint32_t val;
> -
> -            /* Fake a write to port 0xCF8 so that
> -             * the config space access will target the
> -             * correct device model.
> -             */
> -            val =3D (1u << 31) |
> -                  ((req->addr & 0x0f00) << 16) |
> -                  ((sbdf & 0xffff) << 8) |
> -                  (req->addr & 0xfc);
> -            do_outp(0xcf8, 4, val);
> -
> -            /* Now issue the config space access via
> -             * port 0xCFC
> -             */
> -            req->addr =3D 0xcfc | (req->addr & 0x03);
> -            cpu_ioreq_pio(req);
> +        case IOREQ_TYPE_PCI_CONFIG:
> +            cpu_ioreq_config(state, req);
>              break;
> -        }
>          default:
>              hw_error("Invalid ioreq type 0x%x\n", req->type);
>      }
> @@ -1366,6 +1426,7 @@ void xen_hvm_init(PCMachineState *pcms,
> MemoryRegion **ram_memory)
>      memory_listener_register(&state->io_listener, &address_space_io);
>=20
>      state->device_listener =3D xen_device_listener;
> +    QLIST_INIT(&state->dev_list);
>      device_listener_register(&state->device_listener);
>=20
>      /* Initialize backend core & drivers */
> --
> 2.1.4
