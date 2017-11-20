Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGuql-0007Xe-Mz
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGuqi-0004eM-J1
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:47:35 -0500
Received: from chuckie.co.uk ([82.165.15.123]:44705
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eGuqi-0004cR-BM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:47:32 -0500
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-13-git-send-email-mark.cave-ayland@ilande.co.uk>
	<4350d6e7-8985-a1d4-3315-2bcff7d56e30@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <84db5305-26b3-dbf2-1425-a0342cbd39b4@ilande.co.uk>
Date: Mon, 20 Nov 2017 22:47:23 +0000
MIME-Version: 1.0
In-Reply-To: <4350d6e7-8985-a1d4-3315-2bcff7d56e30@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/15] ebus: wire up OBIO interrupts to APB
 pbm via qdev GPIOs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 20/11/17 01:02, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
>> This enables us to remove the static array mapping in the ISA IRQ
>> handler (and the embedded reference to the APB device) by formalising
>> the interrupt wiring via the qdev GPIO API.
>>
>> For more clarity we replace the APB OBIO interrupt numbers with constants
>> designating the interrupt source, and rename isa_irq_handler() to
>> ebus_isa_irq_handler().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/pci-host/apb.c         |    2 +-
>>  hw/sparc64/sun4u.c        |   48 ++++++++++++++++++++++-----------------------
>>  include/hw/pci-host/apb.h |    8 +++++++-
>>  3 files changed, 32 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>> index 268100e..f092780c 100644
>> --- a/hw/pci-host/apb.c
>> +++ b/hw/pci-host/apb.c
>> @@ -700,7 +700,7 @@ static void pci_pbm_init(Object *obj)
>>      for (i = 0; i < 32; i++) {
>>          s->obio_irq_map[i] = ((0x1f << 6) | 0x20) + i;
>>      }
>> -    s->pbm_irqs = qemu_allocate_irqs(pci_apb_set_irq, s, MAX_IVEC);
>> +    qdev_init_gpio_in_named(DEVICE(s), pci_apb_set_irq, "pbm-irq", MAX_IVEC);
>>      qdev_init_gpio_out_named(DEVICE(s), s->ivec_irqs, "ivec-irq", MAX_IVEC);
>>      s->irq_request = NO_IRQ_REQUEST;
>>      s->pci_irq_in = 0ULL;
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 0a30fb8..da386d3 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -86,6 +86,7 @@ typedef struct EbusState {
>>      PCIDevice parent_obj;
>>  
>>      ISABus *isa_bus;
>> +    qemu_irq isa_bus_irqs[16];
> 
> Can you use ISA_NUM_IRQS here?

Ah yes, good spot. I've updated this (and the other occurrences you
found) to ISA_NUM_IRQS accordingly.


ATB,

Mark.
