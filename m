Received: from eggs.gnu.org ([2001:4830:134:3::10]:40065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fk61F-0006DH-BW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fk61A-0001oU-Hb
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:07:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:11253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fk61A-0001nL-5X
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:07:12 -0400
Date: Mon, 30 Jul 2018 13:06:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180730043904.17023-1-mail@sebastianbauer.info>
Message-ID: <alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org

On Mon, 30 Jul 2018, Sebastian Bauer wrote:
> The four interrupts of the PCI bus are connected to the same UIC pin on the
> real Sam460ex. Evidence for this can be found in the UBoot source for the
> Sam460ex in the Sam460ex.c file where PCI_INTERRUPT_LINE in written. This
> change brings the connection in line with this.
>
> This fixes the problem that can be observed when adding further PCI cards
> that get their interrupt rotated to other interrupts than PCI INT A. In
> particular, the bug was observed and verified to be fixed (after this
> change) with an additional OHCI PCI card.
>
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> ---
> hw/ppc/sam460ex.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 0999efcc1e..b2b22f280d 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -515,9 +515,9 @@ static void sam460ex_init(MachineState *machine)
>
>     /* PCI bus */
>     ppc460ex_pcie_init(env);
> -    /* FIXME: is this correct? */
> +    /* All PCI ints are connected to the same UIC pin (cf. UBoot source) */
>     dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
> -                                uic[1][0], uic[1][20], uic[1][21], uic[1][22],
> +                                uic[1][0], uic[1][0], uic[1][0], uic[1][0],

I don't understand QOM. Does this really work? It will ultimately do

qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 0, uic[1][0]);
qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 1, uic[1][0]);
qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 2, uic[1][0]);
qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 3, uic[1][0]);

which will call for each of these

object_property_set_link(dev, uic[1][0], "some name", &errp);

Would this correctly add all device interrupts to the uic[1][0] irq or 
will this replace it so only the last line will be connected instead of 
the first after this patch? Could someone with more understanding 
about QOM confirm this?

If this does not work this way would mapping all PCI interrupts to first 
line in ppc440_pcix_map_irq at hw/ppc/ppc440_pcix.c:417 and assign only 
that to uic[1][0] be a better fix?

Regards,
BALATON Zoltan
