Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fuI5F-0002Yl-Ep
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fuI4p-00004t-SJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:01:08 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <b7ec6188-1ea9-1fbd-3cc8-e5b5b331b9c8@ilande.co.uk>
Date: Mon, 27 Aug 2018 15:00:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 27/08/18 12:05, Mark Cave-Ayland wrote:

> According to the PReP specification section 6.1.6 "System Interrupt
> Assignments", all PCI interrupts are routed via IRQ 15.
> 
> With this patch applied it is now possible to boot the sandalfoot
> zImage all the way through to a working userspace when using
> OpenBIOS.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/ppc/prep.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 162b27a3b8..e82c1355d9 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
>      dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
>      qdev_connect_gpio_out(dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
> -    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
> +    /* According to PReP specification section 6.1.6 "System Interrupt
> +     * Assignments", all PCI interrupts are routed via IRQ 15 */
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        sysbus_connect_irq(pcihost, i, qdev_get_gpio_in(dev, 15));
> +    }
>      isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>  
>      /* Memory controller */

Actually it seems that this is just working around the fact that a real
40p machine has certain hard-coded interrupts which only get used when
the residual data sets the machine name to "IBM PPS Model 6015".

In fact if you apply the following diff to OpenBIOS:

diff --git a/arch/ppc/qemu/context.c b/arch/ppc/qemu/context.c
index 06e0122..5815895 100644
--- a/arch/ppc/qemu/context.c
+++ b/arch/ppc/qemu/context.c
@@ -111,7 +111,7 @@ static void *
 residual_build(uint32_t memsize, uint32_t load_base, uint32_t load_size)
 {
     residual_t *res;
-    const unsigned char model[] = "Qemu\0PPC\0";
+    const unsigned char model[] = "IBM PPS Model 6015\0";
     int i;

     res = malloc(sizeof(residual_t));

then QEMU/OpenBIOS can boot a working sandalfoot zImage but only by
coincidence: it just so happens that the PCI IRQ for device 12 maps to
PCI IRQ 2 using the standard algorithm, which in the original code above
maps to IRQ 13 which is reserved on some PReP machines for the SCSI
controller.

So I think there are 2 issues here:

1) The PReP interrupt controller needs to be remodelled to allow PCI
IRQs to be mapped in this way

This is of course possible, but would require implementing logic that
wouldn't be compatible with the existing -M prep machine. But should
this wait until the old -M prep machine has been removed?

2) Setting the machine name as above breaks NetBSD boot

As per this bug report from Artyom:
http://mail-index.netbsd.org/port-prep/2017/04/02/msg000109.html. I'm
inclined to think that the solution here is to get NetBSD to fix their code.

Hervé, what do you think is the best solution for now?


ATB,

Mark.
