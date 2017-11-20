Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaFC-0003BP-Pp
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaF9-0002WS-Ly
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:47:26 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:45989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaF9-0002WK-FN
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:47:23 -0500
Received: by mail-qk0-x244.google.com with SMTP id d125so5616324qkc.12
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:47:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-6-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bce58dcf-ff3d-0d7f-7929-81c3b0e042c4@amsat.org>
Date: Sun, 19 Nov 2017 21:47:20 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-6-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/15] sun4u: move initialisation of all
 ISABus devices into ebus_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> This belongs in the PCI-ISA bridge rather than at the machine level.

nice, this helps me in another series (clean out i386/pc, refactor
superio devices).

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c |   78 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index f3203ea..b441f1e 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -85,6 +85,7 @@ typedef struct EbusState {
>      PCIDevice parent_obj;
>  
>      ISABus *isa_bus;
> +    uint64_t console_serial_base;

I'd rather use hwaddr here, anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      MemoryRegion bar0;
>      MemoryRegion bar1;
>  } EbusState;
> @@ -234,7 +235,10 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>  {
>      EbusState *s = EBUS(pci_dev);
>      APBState *apb;
> +    DeviceState *dev;
>      qemu_irq *isa_irq;
> +    DriveInfo *fd[MAX_FD];
> +    int i;
>  
>      s->isa_bus = isa_bus_new(DEVICE(pci_dev), get_system_memory(),
>                               pci_address_space_io(pci_dev), errp);
> @@ -252,6 +256,38 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>      isa_irq = qemu_allocate_irqs(isa_irq_handler, apb->pbm_irqs, 16);
>      isa_bus_irqs(s->isa_bus, isa_irq);
>  
> +    /* Serial ports */
> +    i = 0;
> +    if (s->console_serial_base) {
> +        serial_mm_init(pci_address_space(pci_dev), s->console_serial_base,
> +                       0, NULL, 115200, serial_hds[i], DEVICE_BIG_ENDIAN);
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
> +    for (i = 0; i < MAX_FD; i++) {
> +        fd[i] = drive_get(IF_FLOPPY, 0, i);
> +    }
> +    dev = DEVICE(isa_create(s->isa_bus, TYPE_ISA_FDC));
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
>      pci_dev->config[0x04] = 0x06; // command = bus master, pci mem
>      pci_dev->config[0x05] = 0x00;
>      pci_dev->config[0x06] = 0xa0; // status = fast back-to-back, 66MHz, no error
> @@ -267,15 +303,23 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>      pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
>  }
>  
> +static Property ebus_properties[] = {
> +    DEFINE_PROP_UINT64("console-serial-base", EbusState,
> +                       console_serial_base, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ebus_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      k->realize = ebus_realize;
>      k->vendor_id = PCI_VENDOR_ID_SUN;
>      k->device_id = PCI_DEVICE_ID_SUN_EBUS;
>      k->revision = 0x01;
>      k->class_id = PCI_CLASS_BRIDGE_OTHER;
> +    dc->props = ebus_properties;
>  }
>  
>  static const TypeInfo ebus_info = {
> @@ -440,11 +484,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
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
> @@ -471,20 +513,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      pci_busB->slot_reserved_mask = 0xfffffff0;
>  
>      ebus = pci_create_multifunction(pci_busA, PCI_DEVFN(1, 0), true, TYPE_EBUS);
> +    qdev_prop_set_uint64(DEVICE(ebus), "console-serial-base",
> +                         hwdef->console_serial_base);
>      qdev_init_nofail(DEVICE(ebus));
>  
> -    isa_bus = EBUS(ebus)->isa_bus;
> -
> -    i = 0;
> -    if (hwdef->console_serial_base) {
> -        serial_mm_init(address_space_mem, hwdef->console_serial_base, 0,
> -                       NULL, 115200, serial_hds[i], DEVICE_BIG_ENDIAN);
> -        i++;
> -    }
> -
> -    serial_hds_isa_init(isa_bus, i, MAX_SERIAL_PORTS);
> -    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> -
>      pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
>  
>      memset(&macaddr, 0, sizeof(MACAddr));
> @@ -523,24 +555,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      qdev_init_nofail(&pci_dev->qdev);
>      pci_ide_create_devs(pci_dev, hd);
>  
> -    isa_create_simple(isa_bus, "i8042");
> -
> -    /* Floppy */
> -    for(i = 0; i < MAX_FD; i++) {
> -        fd[i] = drive_get(IF_FLOPPY, 0, i);
> -    }
> -    dev = DEVICE(isa_create(isa_bus, TYPE_ISA_FDC));
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
>      nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
>      s = SYS_BUS_DEVICE(nvram);
> 
