Received: from eggs.gnu.org ([2001:4830:134:3::10]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGutm-0000Ll-SK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGuth-00084J-U7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:50:42 -0500
Received: from chuckie.co.uk ([82.165.15.123]:44717
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eGuth-00082z-MP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:50:37 -0500
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-11-git-send-email-mark.cave-ayland@ilande.co.uk>
	<2308a702-b436-8158-a905-9947277b8a6c@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a68a8aac-955c-1eee-67e3-908b589d06d4@ilande.co.uk>
Date: Mon, 20 Nov 2017 22:50:27 +0000
MIME-Version: 1.0
In-Reply-To: <2308a702-b436-8158-a905-9947277b8a6c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/15] apb: remove pci_apb_init() and
 instantiate APB device using qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 20/11/17 17:51, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
>> By making the special_base and mem_base values qdev properties, we can move
>> the remaining parts of pci_apb_init() into the pbm init() and realize()
>> functions.
>>
>> This finally allows us to instantiate the APB directly using standard qdev
>> create/init functions in sun4u.c.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/pci-host/apb.c         |  123 ++++++++++++++++++++++-----------------------
>>  hw/sparc64/sun4u.c        |    6 ++-
>>  include/hw/pci-host/apb.h |    4 +-
>>  3 files changed, 68 insertions(+), 65 deletions(-)
>>
>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>> index 823661a..6c20285 100644
>> --- a/hw/pci-host/apb.c
>> +++ b/hw/pci-host/apb.c
>> @@ -611,41 +611,56 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>>      pci_bridge_update_mappings(PCI_BRIDGE(br));
>>  }
>>  
>> -APBState *pci_apb_init(hwaddr special_base,
>> -                       hwaddr mem_base)
>> +static void pci_pbm_reset(DeviceState *d)
>>  {
>> -    DeviceState *dev;
>> -    SysBusDevice *s;
>> -    PCIHostState *phb;
>> -    APBState *d;
>> -    IOMMUState *is;
>> +    unsigned int i;
>> +    APBState *s = APB_DEVICE(d);
>> +
>> +    for (i = 0; i < 8; i++) {
>> +        s->pci_irq_map[i] &= PBM_PCI_IMR_MASK;
>> +    }
>> +    for (i = 0; i < 32; i++) {
>> +        s->obio_irq_map[i] &= PBM_PCI_IMR_MASK;
>> +    }
>> +
>> +    s->irq_request = NO_IRQ_REQUEST;
>> +    s->pci_irq_in = 0ULL;
>> +
>> +    if (s->nr_resets++ == 0) {
>> +        /* Power on reset */
>> +        s->reset_control = POR;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pci_config_ops = {
>> +    .read = apb_pci_config_read,
>> +    .write = apb_pci_config_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void pci_pbm_realize(DeviceState *dev, Error **errp)
>> +{
>> +    APBState *s = APB_DEVICE(dev);
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
>>      PCIDevice *pci_dev;
>> +    IOMMUState *is;
>>  
>> -    /* Ultrasparc PBM main bus */
>> -    dev = qdev_create(NULL, TYPE_APB);
>> -    d = APB_DEVICE(dev);
>> -    phb = PCI_HOST_BRIDGE(dev);
>> -    phb->bus = pci_register_bus(DEVICE(phb), "pci",
>> -                                pci_apb_set_irq, pci_apb_map_irq, d,
>> -                                &d->pci_mmio,
>> -                                &d->pci_ioport,
>> -                                0, 32, TYPE_PCI_BUS);
>> -    qdev_init_nofail(dev);
>> -    s = SYS_BUS_DEVICE(dev);
>>      /* apb_config */
>> -    sysbus_mmio_map(s, 0, special_base);
>> +    sysbus_mmio_map(sbd, 0, s->special_base);
> 
> You might add a safety check than special_base is correctly initialize
> (compare to -1?)

I guess strictly speaking this would be good to have, however since the
same value is also hard-coded in OpenBIOS then you'll get a crash if you
change it to any other value anyhow. So for that reason I think it's
okay for the moment as it is.


ATB,

Mark.
