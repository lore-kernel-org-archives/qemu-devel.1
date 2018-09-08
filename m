Received: from eggs.gnu.org ([208.118.235.92]:40579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyb6P-0001BL-IE
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyata-0008Ka-1b
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 06:55:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ef09395-52fc-a91a-016b-38a4dacfde39@amsat.org>
Date: Sat, 8 Sep 2018 07:55:06 -0300
MIME-Version: 1.0
In-Reply-To: <20180908090820.15591-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] raven: some minor IRQ-related
 tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 9/8/18 6:08 AM, Mark Cave-Ayland wrote:
> This really lays the groundwork for the upcoming patches: it renames the
> irqs PREPPCIState struct member to pci_irqs (as soon there will be a
> distinction) and then changes the raven IRQ opaque to use PREPPCIState
> instead of just irqs array.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/prep.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 88f035c20b..9b36f19c97 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -55,7 +55,7 @@ typedef struct RavenPCIState {
>  typedef struct PRePPCIState {
>      PCIHostState parent_obj;
>  
> -    qemu_irq irq[PCI_NUM_PINS];
> +    qemu_irq pci_irqs[PCI_NUM_PINS];
>      PCIBus pci_bus;
>      AddressSpace pci_io_as;
>      MemoryRegion pci_io;
> @@ -194,9 +194,9 @@ static int raven_map_irq(PCIDevice *pci_dev, int irq_num)
>  
>  static void raven_set_irq(void *opaque, int irq_num, int level)
>  {
> -    qemu_irq *pic = opaque;
> +    PREPPCIState *s = opaque;
>  
> -    qemu_set_irq(pic[irq_num] , level);
> +    qemu_set_irq(s->pci_irqs[irq_num], level);
>  }
>  
>  static AddressSpace *raven_pcihost_set_iommu(PCIBus *bus, void *opaque,
> @@ -223,13 +223,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>      int i;
>  
>      for (i = 0; i < PCI_NUM_PINS; i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(dev, &s->pci_irqs[i]);
>      }
>  
>      qdev_init_gpio_in(d, raven_change_gpio, 1);
>  
> -    pci_bus_irqs(&s->pci_bus, raven_set_irq, raven_map_irq, s->irq,
> -                 PCI_NUM_PINS);
> +    pci_bus_irqs(&s->pci_bus, raven_set_irq, raven_map_irq, s, PCI_NUM_PINS);
>  
>      memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
>                            "pci-conf-idx", 4);
> 
