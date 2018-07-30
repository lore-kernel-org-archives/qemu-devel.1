Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkGxF-0002of-6e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 18:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkGxE-0003pG-5s
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 18:47:53 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkGxD-0003mm-U8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 18:47:52 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so24356084oib.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 15:47:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 23:47:30 +0100
Message-ID: <CAFEAcA_wxAbODS=voCunFYYMZdSG7jOuu7B-8mRhH15snGp6=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 30 July 2018 at 12:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Mon, 30 Jul 2018, Sebastian Bauer wrote:
>>
>> The four interrupts of the PCI bus are connected to the same UIC pin on
>> the
>> real Sam460ex. Evidence for this can be found in the UBoot source for the
>> Sam460ex in the Sam460ex.c file where PCI_INTERRUPT_LINE in written. This
>> change brings the connection in line with this.
>>
>> This fixes the problem that can be observed when adding further PCI cards
>> that get their interrupt rotated to other interrupts than PCI INT A. In
>> particular, the bug was observed and verified to be fixed (after this
>> change) with an additional OHCI PCI card.
>>
>> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>> ---
>> hw/ppc/sam460ex.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index 0999efcc1e..b2b22f280d 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -515,9 +515,9 @@ static void sam460ex_init(MachineState *machine)
>>
>>     /* PCI bus */
>>     ppc460ex_pcie_init(env);
>> -    /* FIXME: is this correct? */
>> +    /* All PCI ints are connected to the same UIC pin (cf. UBoot source)
>> */
>>     dev = sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
>> -                                uic[1][0], uic[1][20], uic[1][21],
>> uic[1][22],
>> +                                uic[1][0], uic[1][0], uic[1][0],
>> uic[1][0],
>
>
> I don't understand QOM. Does this really work? It will ultimately do
>
> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 0, uic[1][0]);
> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 1, uic[1][0]);
> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 2, uic[1][0]);
> qdev_connect_gpio_out_named(dev, SYSBUS_DEVICE_GPIO_IRQ, 3, uic[1][0]);

You are correct; this will not do the intended thing. If you
want to wire up multiple outputs which are logically ORed
together into a single input, you need to instantiate an
OR gate for that (we have the TYPE_OR_IRQ for this).

thanks
-- PMM
