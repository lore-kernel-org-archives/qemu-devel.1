Received: from eggs.gnu.org ([208.118.235.92]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyb6L-0001AA-96
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 07:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyaw7-0006OL-3B
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 06:57:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180908090820.15591-1-mark.cave-ayland@ilande.co.uk>
	<20180908090820.15591-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb40b900-e864-cb5a-176e-efb131708b09@amsat.org>
Date: Sat, 8 Sep 2018 07:57:43 -0300
MIME-Version: 1.0
In-Reply-To: <20180908090820.15591-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] 40p: use OR gate to wire up raven
 PCI interrupts
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
> According to the PReP specification section 6.1.6 "System Interrupt
> Assignments", all PCI interrupts are routed via IRQ 15.
> 
> Instead of mapping each PCI IRQ separately, we introduce an OR gate within the
> raven PCI host bridge and then wire the single output of the OR gate to the
> interrupt controller.

Neat!

> Note that whilst the (now deprecated) PReP machine still exists we still need
> to preserve the old IRQ routing. This is done by adding a new "is-legacy-prep"
> property to the raven PCI host bridge which is set to true for the PReP
> machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/prep.c | 25 +++++++++++++++++++++++--
>  hw/ppc/prep.c      |  4 +---
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 9b36f19c97..b1b6b16bad 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -32,6 +32,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
>  #include "hw/loader.h"
> +#include "hw/or-irq.h"
>  #include "exec/address-spaces.h"
>  #include "elf.h"
>  
> @@ -55,6 +56,7 @@ typedef struct RavenPCIState {
>  typedef struct PRePPCIState {
>      PCIHostState parent_obj;
>  
> +    qemu_or_irq *or_irq;
>      qemu_irq pci_irqs[PCI_NUM_PINS];
>      PCIBus pci_bus;
>      AddressSpace pci_io_as;
> @@ -69,6 +71,7 @@ typedef struct PRePPCIState {
>      RavenPCIState pci_dev;
>  
>      int contiguous_map;
> +    bool is_legacy_prep;
>  } PREPPCIState;
>  
>  #define BIOS_SIZE (1 * MiB)
> @@ -222,8 +225,23 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>      MemoryRegion *address_space_mem = get_system_memory();
>      int i;
>  
> -    for (i = 0; i < PCI_NUM_PINS; i++) {
> -        sysbus_init_irq(dev, &s->pci_irqs[i]);
> +    if (s->is_legacy_prep) {
> +        for (i = 0; i < PCI_NUM_PINS; i++) {
> +            sysbus_init_irq(dev, &s->pci_irqs[i]);
> +        }
> +    } else {
> +        /* According to PReP specification section 6.1.6 "System Interrupt
> +         * Assignments", all PCI interrupts are routed via IRQ 15 */
> +        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
> +        object_property_set_int(OBJECT(s->or_irq), PCI_NUM_PINS, "num-lines",
> +                                &error_fatal);
> +        object_property_set_bool(OBJECT(s->or_irq), true, "realized",
> +                                 &error_fatal);
> +        sysbus_init_irq(dev, &s->or_irq->out_irq);
> +
> +        for (i = 0; i < PCI_NUM_PINS; i++) {
> +            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
> +        }
>      }
>  
>      qdev_init_gpio_in(d, raven_change_gpio, 1);
> @@ -382,6 +400,9 @@ static Property raven_pcihost_properties[] = {
>      DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
>                         EM_NONE),
>      DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
> +    /* Temporary workaround until legacy prep machine is removed */
> +    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
> +                     false),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index b0ea20416e..615865e46c 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -502,6 +502,7 @@ static void ppc_prep_init(MachineState *machine)
>      }
>      qdev_prop_set_string(dev, "bios-name", bios_name);
>      qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
> +    qdev_prop_set_bit(dev, "is-legacy-prep", true);
>      pcihost = PCI_HOST_BRIDGE(dev);
>      object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev), NULL);
>      qdev_init_nofail(dev);
> @@ -669,9 +670,6 @@ static void ibm_40p_init(MachineState *machine)
>      qdev_connect_gpio_out(dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
>      sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
> -    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
>      isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>  
>      /* Memory controller */
> 
