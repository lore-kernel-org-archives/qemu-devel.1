Received: from eggs.gnu.org ([2001:4830:134:3::10]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu13-00047j-Dt
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmu12-0001lM-A9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:50:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-8-jsnow@redhat.com>
	<bd435a55-7aea-2652-f67a-32e669bbfc30@amsat.org>
	<73d55141-94d0-bc96-b101-5562caa16e50@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <638144f2-2e6a-5c48-8547-9fb18244d7fb@amsat.org>
Date: Wed, 30 Aug 2017 00:24:03 -0300
MIME-Version: 1.0
In-Reply-To: <73d55141-94d0-bc96-b101-5562caa16e50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/9] AHCI: Rework IRQ constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

>> On 08/08/2017 03:33 PM, John Snow wrote:
>>> Create a new enum so that we can name the IRQ bits, which will make
>>> debugging
>>> them a little nicer if we can print them out. Not handled in this
>>> patch, but
>>> this will make it possible to get a nice debug printf detailing
>>> exactly which
>>> status bits are set, as it can be multiple at any given time.
>>>
>>> As a consequence of this patch, it is no longer possible to set
>>> multiple IRQ
>>> codes at once, but nothing was utilizing this ability anyway.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>    hw/ide/ahci.c          | 49
>>> ++++++++++++++++++++++++++++++++++++++-----------
>>>    hw/ide/ahci_internal.h | 44
>>> +++++++++++++++++++++++++++++++++++---------
>>>    hw/ide/trace-events    |  2 +-
>>>    3 files changed, 74 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>>> index d5acceb..c5a9b69 100644
>>> --- a/hw/ide/ahci.c
>>> +++ b/hw/ide/ahci.c
>>> @@ -56,6 +56,27 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
>>>    static void ahci_unmap_clb_address(AHCIDevice *ad);
>>>    static void ahci_unmap_fis_address(AHCIDevice *ad);
>>>    +static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__END] = {
>>> +    [AHCI_PORT_IRQ_BIT_DHRS] = "DHRS",
>>> +    [AHCI_PORT_IRQ_BIT_PSS]  = "PSS",
>>> +    [AHCI_PORT_IRQ_BIT_DSS]  = "DSS",
>>> +    [AHCI_PORT_IRQ_BIT_SDBS] = "SDBS",
>>> +    [AHCI_PORT_IRQ_BIT_UFS]  = "UFS",
>>> +    [AHCI_PORT_IRQ_BIT_DPS]  = "DPS",
>>> +    [AHCI_PORT_IRQ_BIT_PCS]  = "PCS",
>>> +    [AHCI_PORT_IRQ_BIT_DMPS] = "DMPS",
>>> +    [8 ... 21]               = "RESERVED",
>>> +    [AHCI_PORT_IRQ_BIT_PRCS] = "PRCS",
>>> +    [AHCI_PORT_IRQ_BIT_IPMS] = "IPMS",
>>> +    [AHCI_PORT_IRQ_BIT_OFS]  = "OFS",
>>> +    [25]                     = "RESERVED",
>>> +    [AHCI_PORT_IRQ_BIT_INFS] = "INFS",
>>> +    [AHCI_PORT_IRQ_BIT_IFS]  = "IFS",
>>> +    [AHCI_PORT_IRQ_BIT_HBDS] = "HBDS",
>>> +    [AHCI_PORT_IRQ_BIT_HBFS] = "HBFS",
>>> +    [AHCI_PORT_IRQ_BIT_TFES] = "TFES",
>>> +    [AHCI_PORT_IRQ_BIT_CPDS] = "CPDS"
>>> +};
>>>      static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
>>>    {
>>> @@ -170,12 +191,18 @@ static void ahci_check_irq(AHCIState *s)
>>>    }
>>>      static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
>>> -                             int irq_type)
>>> +                             enum AHCIPortIRQ irqbit)
>>>    {
>>> -    DPRINTF(d->port_no, "trigger irq %#x -> %x\n",
>>> -            irq_type, d->port_regs.irq_mask & irq_type);
>>> +    g_assert(irqbit >= 0 && irqbit < 32);
>>
>> Since you now use an enum this check is no more necessary.
>>
> 
> You can actually still pass in a wrong value if you wanted to. This is
> to prevent old-style IRQ masks from getting passed in by accident.

No accident :) This is now an enum, also:

hw/ide$ git grep ahci_trigger_irq
ahci.c:764:        ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_SDBS);
ahci.c:807:        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
ahci.c:810:    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
ahci.c:850:        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
ahci.c:853:    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
ahci.c:1128:        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_OFS);
ahci.c:1276:        ahci_trigger_irq(s, &s->dev[port], 
AHCI_PORT_IRQ_BIT_HBFS);

You only use enum values, not any cast.

> 
>> However ...
>>
>>> +    uint32_t irq = 1U << irqbit;
>>> +    uint32_t irqstat = d->port_regs.irq_stat | irq;
>>>    -    d->port_regs.irq_stat |= irq_type;
>>> +    trace_ahci_trigger_irq(s, d->port_no,
>>> +                           AHCIPortIRQ_lookup[irqbit], irq,
>>> +                           d->port_regs.irq_stat, irqstat,
>>> +                           irqstat & d->port_regs.irq_mask);
>>> +
>>
>> Why not keep using masked irqs, and iterate over AHCI_PORT_IRQ__END
>> bits? Something like:
>>
>>      if (TRACE_AHCI_IRQ_ENABLED) {
>>          int irqbit;
>>          for (irqbit = 0; irqbit < AHCI_PORT_IRQ__END; irqbit++) {
>>              if (irqmask & BIT(irqbit)) {
>>                  trace_ahci_trigger_irq(s, d->port_no, ...
>>
> 
> Would rather not iterate like that for the IRQ path. Generally no place
> in the codebase needs to raise more than one IRQ type at a time, so why
> bother allowing it?

Indeed.
