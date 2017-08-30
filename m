Received: from eggs.gnu.org ([2001:4830:134:3::10]:42824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnCP6-00024n-MN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnCP5-0004hM-Ly
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:28:12 -0400
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-8-jsnow@redhat.com>
	<93538cee-a05c-44cc-cd69-3e3c8a0d168e@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <6a5e72c1-526d-0601-6590-08213b2362a6@redhat.com>
Date: Wed, 30 Aug 2017 19:28:02 -0400
MIME-Version: 1.0
In-Reply-To: <93538cee-a05c-44cc-cd69-3e3c8a0d168e@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] AHCI: Rework IRQ constants
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



On 08/29/2017 11:54 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/29/2017 05:49 PM, John Snow wrote:
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
>> index c60a000..a0a4dd6 100644
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
> I still think this assert is superfluous, anyway (and having hard time
> reading C99 statement before declarations - I need to grow):
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

Left in because of my distrust of compilers as explained in my reply to
#05. We'll get to the bottom of it ;)

Thank you for the reviews.

--js
