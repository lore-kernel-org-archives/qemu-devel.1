Received: from eggs.gnu.org ([2001:4830:134:3::10]:45963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxzC-0005fC-Gu
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxzB-0005ra-0s
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:21:58 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:38075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eRxzA-0005rI-QW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:21:56 -0500
Received: by mail-it0-x243.google.com with SMTP id r6so10272120itr.3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 02:21:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221082045.14022-6-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
	<20171221082045.14022-6-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 21 Dec 2017 11:21:35 +0100
Message-ID: <CACXAS8DktUtHoxwj7og06-V3mhWPApckxW_P+8cevMFqJxbr0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 05/16] sun4u: move initialisation of all
 ISABus devices into ebus_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 21, 2017 at 9:20 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This belongs in the PCI-ISA bridge rather than at the machine level.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc64/sun4u.c | 78 ++++++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 46 insertions(+), 32 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index f3203ea887..b441f1ecdb 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -85,6 +85,7 @@ typedef struct EbusState {
>      PCIDevice parent_obj;
>
>      ISABus *isa_bus;
> +    uint64_t console_serial_base;
>      MemoryRegion bar0;
>      MemoryRegion bar1;
>  } EbusState;
> @@ -234,7 +235,10 @@ static void ebus_realize(PCIDevice *pci_dev, Error *=
*errp)
>  {
>      EbusState *s =3D EBUS(pci_dev);
>      APBState *apb;
> +    DeviceState *dev;
>      qemu_irq *isa_irq;
> +    DriveInfo *fd[MAX_FD];
> +    int i;
>
>      s->isa_bus =3D isa_bus_new(DEVICE(pci_dev), get_system_memory(),
>                               pci_address_space_io(pci_dev), errp);
> @@ -252,6 +256,38 @@ static void ebus_realize(PCIDevice *pci_dev, Error *=
*errp)
>      isa_irq =3D qemu_allocate_irqs(isa_irq_handler, apb->pbm_irqs, 16);
>      isa_bus_irqs(s->isa_bus, isa_irq);
>
> +    /* Serial ports */
> +    i =3D 0;
> +    if (s->console_serial_base) {
> +        serial_mm_init(pci_address_space(pci_dev), s->console_serial_bas=
e,
> +                       0, NULL, 115200, serial_hds[i], DEVICE_BIG_ENDIAN=
);
> +        i++;
> +    }
> +    serial_hds_isa_init(s->isa_bus, i, MAX_SERIAL_PORTS);
> +
> +    /* Parallel ports */
> +    parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
> +
> +    /* Keyboard */
> +    isa_create_simple(s->isa_bus, "i8042");
> +
> +    /* Floppy */
> +    for (i =3D 0; i < MAX_FD; i++) {
> +        fd[i] =3D drive_get(IF_FLOPPY, 0, i);
> +    }
> +    dev =3D DEVICE(isa_create(s->isa_bus, TYPE_ISA_FDC));
> +    if (fd[0]) {
> +        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fd[0]),
> +                            &error_abort);
> +    }
> +    if (fd[1]) {
> +        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fd[1]),
> +                            &error_abort);
> +    }
> +    qdev_prop_set_uint32(dev, "dma", -1);
> +    qdev_init_nofail(dev);
> +
> +    /* PCI */
>      pci_dev->config[0x04] =3D 0x06; // command =3D bus master, pci mem
>      pci_dev->config[0x05] =3D 0x00;
>      pci_dev->config[0x06] =3D 0xa0; // status =3D fast back-to-back, 66M=
Hz, no error
> @@ -267,15 +303,23 @@ static void ebus_realize(PCIDevice *pci_dev, Error =
**errp)
>      pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
>  }
>
> +static Property ebus_properties[] =3D {
> +    DEFINE_PROP_UINT64("console-serial-base", EbusState,
> +                       console_serial_base, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ebus_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      k->realize =3D ebus_realize;
>      k->vendor_id =3D PCI_VENDOR_ID_SUN;
>      k->device_id =3D PCI_DEVICE_ID_SUN_EBUS;
>      k->revision =3D 0x01;
>      k->class_id =3D PCI_CLASS_BRIDGE_OTHER;
> +    dc->props =3D ebus_properties;
>  }
>
>  static const TypeInfo ebus_info =3D {
> @@ -440,11 +484,9 @@ static void sun4uv_init(MemoryRegion *address_space_=
mem,
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_=
entry;
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
>      PCIDevice *ebus, *pci_dev;
> -    ISABus *isa_bus;
>      SysBusDevice *s;
>      qemu_irq *ivec_irqs;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> -    DriveInfo *fd[MAX_FD];
>      DeviceState *dev;
>      FWCfgState *fw_cfg;
>      NICInfo *nd;
> @@ -471,20 +513,10 @@ static void sun4uv_init(MemoryRegion *address_space=
_mem,
>      pci_busB->slot_reserved_mask =3D 0xfffffff0;
>
>      ebus =3D pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, T=
YPE_EBUS);
> +    qdev_prop_set_uint64(DEVICE(ebus), "console-serial-base",
> +                         hwdef->console_serial_base);
>      qdev_init_nofail(DEVICE(ebus));
>
> -    isa_bus =3D EBUS(ebus)->isa_bus;
> -
> -    i =3D 0;
> -    if (hwdef->console_serial_base) {
> -        serial_mm_init(address_space_mem, hwdef->console_serial_base, 0,
> -                       NULL, 115200, serial_hds[i], DEVICE_BIG_ENDIAN);
> -        i++;
> -    }
> -
> -    serial_hds_isa_init(isa_bus, i, MAX_SERIAL_PORTS);
> -    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> -
>      pci_dev =3D pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
>
>      memset(&macaddr, 0, sizeof(MACAddr));
> @@ -523,24 +555,6 @@ static void sun4uv_init(MemoryRegion *address_space_=
mem,
>      qdev_init_nofail(&pci_dev->qdev);
>      pci_ide_create_devs(pci_dev, hd);
>
> -    isa_create_simple(isa_bus, "i8042");
> -
> -    /* Floppy */
> -    for(i =3D 0; i < MAX_FD; i++) {
> -        fd[i] =3D drive_get(IF_FLOPPY, 0, i);
> -    }
> -    dev =3D DEVICE(isa_create(isa_bus, TYPE_ISA_FDC));
> -    if (fd[0]) {
> -        qdev_prop_set_drive(dev, "driveA", blk_by_legacy_dinfo(fd[0]),
> -                            &error_abort);
> -    }
> -    if (fd[1]) {
> -        qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fd[1]),
> -                            &error_abort);
> -    }
> -    qdev_prop_set_uint32(dev, "dma", -1);
> -    qdev_init_nofail(dev);
> -
>      /* Map NVRAM into I/O (ebus) space */
>      nvram =3D m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
>      s =3D SYS_BUS_DEVICE(nvram);
> --
> 2.11.0
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
