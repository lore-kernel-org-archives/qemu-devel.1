Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkhX-0006t8-Az
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkhU-0004tU-AY
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:01:31 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkhU-0004tK-7R
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:01:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so20077610qtb.1
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 11:01:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497099616-2615-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <940523c4-17fa-d230-0498-139f1cf38ac8@amsat.org>
Date: Sat, 10 Jun 2017 15:01:22 -0300
MIME-Version: 1.0
In-Reply-To: <1497099616-2615-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] sun4u: expose fw_cfg on ebus PCI IO
 address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 06/10/2017 10:00 AM, Mark Cave-Ayland wrote:
> To allow future changes to the sun4u PCI topology.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 98ee6f5..19e64be 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -224,13 +224,11 @@ static void isa_irq_handler(void *opaque, int n, int level)
>
>  /* EBUS (Eight bit bus) bridge */
>  static ISABus *
> -pci_ebus_init(PCIBus *bus, int devfn, qemu_irq *irqs)
> +pci_ebus_init(PCIDevice *pci_dev, qemu_irq *irqs)
>  {
>      qemu_irq *isa_irq;
> -    PCIDevice *pci_dev;
>      ISABus *isa_bus;
>
> -    pci_dev = pci_create_simple(bus, devfn, "ebus");
>      isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
>      isa_irq = qemu_allocate_irqs(isa_irq_handler, irqs, 16);
>      isa_bus_irqs(isa_bus, isa_irq);
> @@ -429,6 +427,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      unsigned int i;
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
>      PCIBus *pci_bus, *pci_bus2, *pci_bus3;
> +    PCIDevice *ebus;
>      ISABus *isa_bus;
>      SysBusDevice *s;
>      qemu_irq *ivec_irqs, *pbm_irqs;
> @@ -452,7 +451,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      pci_vga_init(pci_bus);
>
>      // XXX Should be pci_bus3
> -    isa_bus = pci_ebus_init(pci_bus, -1, pbm_irqs);
> +    ebus = pci_create_simple(pci_bus, -1, "ebus");
> +    isa_bus = pci_ebus_init(ebus, pbm_irqs);
>
>      i = 0;
>      if (hwdef->console_serial_base) {
> @@ -517,7 +517,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      qdev_prop_set_bit(dev, "dma_enabled", false);
>      qdev_init_nofail(dev);
>      s = SYS_BUS_DEVICE(dev);
> -    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
> +    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
>                                  sysbus_mmio_get_region(s, 0));
>
>      fw_cfg = FW_CFG(dev);
>
