Received: from eggs.gnu.org ([2001:4830:134:3::10]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fuLDe-00029Q-Dx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fuL4N-0007YF-TT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:12:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:62355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fuL4N-0007WS-BA
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:12:51 -0400
Date: Mon, 27 Aug 2018 19:12:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.1808271903170.61025@zero.eik.bme.hu>
References: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Mon, 27 Aug 2018, Mark Cave-Ayland wrote:
> According to the PReP specification section 6.1.6 "System Interrupt
> Assignments", all PCI interrupts are routed via IRQ 15.
>
> With this patch applied it is now possible to boot the sandalfoot
> zImage all the way through to a working userspace when using
> OpenBIOS.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/ppc/prep.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 162b27a3b8..e82c1355d9 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
>     dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
>     qdev_connect_gpio_out(dev, 0,
>                           cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
> -    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
> -    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
> +    /* According to PReP specification section 6.1.6 "System Interrupt
> +     * Assignments", all PCI interrupts are routed via IRQ 15 */
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        sysbus_connect_irq(pcihost, i, qdev_get_gpio_in(dev, 15));
> +    }

I'm not sure but this looks similar to what we had with sam460ex:

http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00359.html

I think you may not connect multiple interrupts to the same host irq line 
this way but you either need an OR gate or handle it within the mapping in 
the PCI host model (which is what we ended up with for the sam460ex). 
Peter's suggestion was to do whichever matches real hardware the most if 
you can find out that (as noted here also with more explanation that could 
be useful):

http://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00360.html

But I could be mistaken in this case, haven't checked it in detail.

Regards,
BALATON Zoltan
