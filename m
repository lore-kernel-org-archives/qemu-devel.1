Received: from eggs.gnu.org ([2001:4830:134:3::10]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g0Yfz-0007Cn-IZ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g0Yfy-0003N1-H2
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 16:57:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b4eb8a31-7373-ea28-3ee8-9f8b20e03161@amsat.org>
Date: Thu, 13 Sep 2018 22:56:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 9/10/18 10:46 PM, Mark Cave-Ayland wrote:
> Whilst the PReP specification describes how all PCI IRQs are routed via IRQ
> 15 on the interrupt controller, the real 40p machine has a routing quirk in
> that the LSI SCSI device is routed directly to IRQ 13.
> 
> Enable the external IRQ for the LSI SCSI device by wiring up the IRQ with
> qdev to the relevant interrupt controller gpio.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/prep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 615865e46c..94fc36b7ef 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -621,7 +621,7 @@ static void ibm_40p_init(MachineState *machine)
>      CPUPPCState *env = NULL;
>      uint16_t cmos_checksum;
>      PowerPCCPU *cpu;
> -    DeviceState *dev;
> +    DeviceState *dev, *i82378_dev;
>      SysBusDevice *pcihost, *s;
>      Nvram *m48t59 = NULL;
>      PCIBus *pci_bus;
> @@ -666,11 +666,11 @@ static void ibm_40p_init(MachineState *machine)
>      }
>  
>      /* PCI -> ISA bridge */
> -    dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
> -    qdev_connect_gpio_out(dev, 0,
> +    i82378_dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
> +    qdev_connect_gpio_out(i82378_dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> -    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> +    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
> +    isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
>  
>      /* Memory controller */
>      dev = DEVICE(isa_create(isa_bus, "rs6000-mc"));
> @@ -703,6 +703,7 @@ static void ibm_40p_init(MachineState *machine)
>          dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
>                                         "lsi53c810"));
>          lsi53c8xx_handle_legacy_cmdline(dev);
> +        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
>  
>          /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>          pci_vga_init(pci_bus);
> 
