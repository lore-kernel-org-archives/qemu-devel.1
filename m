Received: from eggs.gnu.org ([2001:4830:134:3::10]:53254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmUO2-000429-TP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmUO1-0004QC-T4
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:28:10 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-8-jsnow@redhat.com>
	<bd435a55-7aea-2652-f67a-32e669bbfc30@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <73d55141-94d0-bc96-b101-5562caa16e50@redhat.com>
Date: Mon, 28 Aug 2017 20:28:03 -0400
MIME-Version: 1.0
In-Reply-To: <bd435a55-7aea-2652-f67a-32e669bbfc30@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/9] AHCI: Rework IRQ constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/25/2017 10:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi John,
>=20
> On 08/08/2017 03:33 PM, John Snow wrote:
>> Create a new enum so that we can name the IRQ bits, which will make
>> debugging
>> them a little nicer if we can print them out. Not handled in this
>> patch, but
>> this will make it possible to get a nice debug printf detailing
>> exactly which
>> status bits are set, as it can be multiple at any given time.
>>
>> As a consequence of this patch, it is no longer possible to set
>> multiple IRQ
>> codes at once, but nothing was utilizing this ability anyway.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   hw/ide/ahci.c          | 49
>> ++++++++++++++++++++++++++++++++++++++-----------
>>   hw/ide/ahci_internal.h | 44
>> +++++++++++++++++++++++++++++++++++---------
>>   hw/ide/trace-events    |  2 +-
>>   3 files changed, 74 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index d5acceb..c5a9b69 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -56,6 +56,27 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
>>   static void ahci_unmap_clb_address(AHCIDevice *ad);
>>   static void ahci_unmap_fis_address(AHCIDevice *ad);
>>   +static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__END] =3D {
>> +    [AHCI_PORT_IRQ_BIT_DHRS] =3D "DHRS",
>> +    [AHCI_PORT_IRQ_BIT_PSS]  =3D "PSS",
>> +    [AHCI_PORT_IRQ_BIT_DSS]  =3D "DSS",
>> +    [AHCI_PORT_IRQ_BIT_SDBS] =3D "SDBS",
>> +    [AHCI_PORT_IRQ_BIT_UFS]  =3D "UFS",
>> +    [AHCI_PORT_IRQ_BIT_DPS]  =3D "DPS",
>> +    [AHCI_PORT_IRQ_BIT_PCS]  =3D "PCS",
>> +    [AHCI_PORT_IRQ_BIT_DMPS] =3D "DMPS",
>> +    [8 ... 21]               =3D "RESERVED",
>> +    [AHCI_PORT_IRQ_BIT_PRCS] =3D "PRCS",
>> +    [AHCI_PORT_IRQ_BIT_IPMS] =3D "IPMS",
>> +    [AHCI_PORT_IRQ_BIT_OFS]  =3D "OFS",
>> +    [25]                     =3D "RESERVED",
>> +    [AHCI_PORT_IRQ_BIT_INFS] =3D "INFS",
>> +    [AHCI_PORT_IRQ_BIT_IFS]  =3D "IFS",
>> +    [AHCI_PORT_IRQ_BIT_HBDS] =3D "HBDS",
>> +    [AHCI_PORT_IRQ_BIT_HBFS] =3D "HBFS",
>> +    [AHCI_PORT_IRQ_BIT_TFES] =3D "TFES",
>> +    [AHCI_PORT_IRQ_BIT_CPDS] =3D "CPDS"
>> +};
>>     static uint32_t  ahci_port_read(AHCIState *s, int port, int offset=
)
>>   {
>> @@ -170,12 +191,18 @@ static void ahci_check_irq(AHCIState *s)
>>   }
>>     static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
>> -                             int irq_type)
>> +                             enum AHCIPortIRQ irqbit)
>>   {
>> -    DPRINTF(d->port_no, "trigger irq %#x -> %x\n",
>> -            irq_type, d->port_regs.irq_mask & irq_type);
>> +    g_assert(irqbit >=3D 0 && irqbit < 32);
>=20
> Since you now use an enum this check is no more necessary.
>=20

You can actually still pass in a wrong value if you wanted to. This is
to prevent old-style IRQ masks from getting passed in by accident.

> However ...
>=20
>> +    uint32_t irq =3D 1U << irqbit;
>> +    uint32_t irqstat =3D d->port_regs.irq_stat | irq;
>>   -    d->port_regs.irq_stat |=3D irq_type;
>> +    trace_ahci_trigger_irq(s, d->port_no,
>> +                           AHCIPortIRQ_lookup[irqbit], irq,
>> +                           d->port_regs.irq_stat, irqstat,
>> +                           irqstat & d->port_regs.irq_mask);
>> +
>=20
> Why not keep using masked irqs, and iterate over AHCI_PORT_IRQ__END
> bits? Something like:
>=20
>     if (TRACE_AHCI_IRQ_ENABLED) {
>         int irqbit;
>         for (irqbit =3D 0; irqbit < AHCI_PORT_IRQ__END; irqbit++) {
>             if (irqmask & BIT(irqbit)) {
>                 trace_ahci_trigger_irq(s, d->port_no, ...
>=20

Would rather not iterate like that for the IRQ path. Generally no place
in the codebase needs to raise more than one IRQ type at a time, so why
bother allowing it?
