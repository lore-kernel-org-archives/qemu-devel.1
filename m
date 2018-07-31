Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkcbs-0003XD-Du
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 17:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkcbp-0002gr-SM
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 17:55:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Jul 2018 23:55:02 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180731112006.737F77456B6@zero.eik.bme.hu>
References: <20180731112006.737F77456B6@zero.eik.bme.hu>
Message-ID: <c577eb87cb5094a63b58771ac7df6c06@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupts with multiple
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

Am 2018-07-31 13:08, schrieb BALATON Zoltan:
> The four interrupts of the PCI bus are connected to the same UIC pin
> on the real Sam460ex. Evidence for this can be found in the UBoot
> source for the Sam460ex in the Sam460ex.c file where
> PCI_INTERRUPT_LINE is written. Change the ppc440_pcix model to behave
> more like this.
> 
> This fixes the problem that can be observed when adding further PCI
> cards that got their interrupt rotated to other interrupts than PCI
> INT A. In particular, the bug was observed with an additional OHCI PCI
> card or an ES1370 sound device.
[...]
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 0999efc..9c77183 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -515,10 +515,8 @@ static void sam460ex_init(MachineState *machine)
> 
>      /* PCI bus */
>      ppc460ex_pcie_init(env);
> -    /* FIXME: is this correct? */
> -    dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
> -                                uic[1][0], uic[1][20], uic[1][21], 
> uic[1][22],
> -                                NULL);
> +    /* All PCI irqs are connected to the same UIC pin (cf. UBoot 
> source) */
> +    dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000, 
> uic[1][0]);
>      pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>      if (!pci_bus) {
>          error_report("couldn't create PCI controller!");

I'm fine with that change. I tested it with an additional OHCI 
controller on an emulated SAM machine under guest AmigaOS and it works.

Tested-by: Sebastian Bauer <mail@sebastianbauer.info>

Better usage of QOM etc. can IMO be done at a later time point as this 
fixes an unpleasant bug and any side change will just increase the 
probability to introduce new bugs.

Bye
Sebastian
