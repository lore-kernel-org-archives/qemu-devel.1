Received: from eggs.gnu.org ([209.51.188.92]:55781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmSdg-0003aW-Mx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 19:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gmSPL-0002eq-Tw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:58:13 -0500
References: <cover.1548160772.git.balaton@eik.bme.hu>
	<c323f08c59b9931310c5d92503d370f77ce3a557.1548160772.git.balaton@eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Message-ID: <1485cc74-b10e-bd62-3b42-9dfe9f587d1e@redhat.com>
Date: Wed, 23 Jan 2019 18:58:02 -0500
MIME-Version: 1.0
In-Reply-To: <c323f08c59b9931310c5d92503d370f77ce3a557.1548160772.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ide/via: Implement and use native PCI
 IDE mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 1/22/19 7:39 AM, BALATON Zoltan wrote:
> The device was initialised in ISA compatibility mode and native PCI
> IDE mode was not implemented but no clents are known to need ISA mode
> but to the contrary, most clients that want to switch to and use
> device in native PCI IDE mode. Therefore implement native PCI mode and
> switch default to that.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ide/via.c | 52 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index c6e43a8812..ac9385228c 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -32,15 +32,6 @@
>  #include "hw/ide/pci.h"
>  #include "trace.h"
>  
> -static const struct {
> -    int iobase;
> -    int iobase2;
> -    int isairq;
> -} port_info[] = {
> -    {0x1f0, 0x3f6, 14},
> -    {0x170, 0x376, 15},
> -};
> -
>  static uint64_t bmdma_read(void *opaque, hwaddr addr,
>                             unsigned size)
>  {
> @@ -110,6 +101,23 @@ static void bmdma_setup_bar(PCIIDEState *d)
>      }
>  }
>  
> +static void via_ide_set_irq(void *opaque, int n, int level)
> +{
> +    PCIDevice *d = PCI_DEVICE(opaque);
> +
> +    if (level) {
> +        d->config[0x70 + n * 8] |= 0x80;
> +    } else {
> +        d->config[0x70 + n * 8] &= ~0x80;
> +    }
> +
> +    level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
> +    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
> +    if (n) {
> +        qemu_set_irq(isa_get_irq(NULL, n), level);
> +    }
> +}
> +
>  static void via_ide_reset(void *opaque)
>  {
>      PCIIDEState *d = opaque;
> @@ -121,7 +129,7 @@ static void via_ide_reset(void *opaque)
>          ide_bus_reset(&d->bus[i]);
>      }
>  
> -    pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_WAIT);
> +    pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | PCI_COMMAND_WAIT);
>      pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
>                   PCI_STATUS_DEVSEL_MEDIUM);
>  
> @@ -158,10 +166,28 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>      uint8_t *pci_conf = dev->config;
>      int i;
>  
> -    pci_config_set_prog_interface(pci_conf, 0x8a); /* legacy ATA mode */
> +    pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
> +    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>  
>      qemu_register_reset(via_ide_reset, d);
> +
> +    memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
> +                          &d->bus[0], "via-ide0-data", 8);
> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[0]);
> +
> +    memory_region_init_io(&d->cmd_bar[0], OBJECT(d), &pci_ide_cmd_le_ops,
> +                          &d->bus[0], "via-ide0-cmd", 4);
> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd_bar[0]);
> +
> +    memory_region_init_io(&d->data_bar[1], OBJECT(d), &pci_ide_data_le_ops,
> +                          &d->bus[1], "via-ide1-data", 8);
> +    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[1]);
> +
> +    memory_region_init_io(&d->cmd_bar[1], OBJECT(d), &pci_ide_cmd_le_ops,
> +                          &d->bus[1], "via-ide1-cmd", 4);
> +    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd_bar[1]);
> +
>      bmdma_setup_bar(d);
>      pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>  
> @@ -169,9 +195,7 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>  
>      for (i = 0; i < 2; i++) {
>          ide_bus_new(&d->bus[i], sizeof(d->bus[i]), DEVICE(d), i, 2);
> -        ide_init_ioport(&d->bus[i], NULL, port_info[i].iobase,
> -                        port_info[i].iobase2);
> -        ide_init2(&d->bus[i], isa_get_irq(NULL, port_info[i].isairq));
> +        ide_init2(&d->bus[i], qemu_allocate_irq(via_ide_set_irq, d, i));
>  
>          bmdma_init(&d->bus[i], &d->bmdma[i], d);
>          d->bmdma[i].bus = &d->bus[i];
> 

I guess this is technically an external change in behavior... I have no
real read on if this will break anything for anyone, or if anyone was
even using it.

Any thoughts on why it's okay to switch?
