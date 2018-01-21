Received: from eggs.gnu.org ([2001:4830:134:3::10]:35192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBi2-0007zq-2B
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBhy-0004mk-RW
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:14:38 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48009
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBhy-0004m7-KW
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:14:34 -0500
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
	<CACXAS8CB1hNogfv-bg83HY+XAnqi2O3TJZVUOoRYqRS0Nx=DFA@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1a223e56-72c0-b9e6-7892-412de7bc4ad4@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:14:23 +0000
MIME-Version: 1.0
In-Reply-To: <CACXAS8CB1hNogfv-bg83HY+XAnqi2O3TJZVUOoRYqRS0Nx=DFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 20/01/18 20:10, Artyom Tarasenko wrote:

> Hi Mark,
> 
> 
> On Mon, Jan 15, 2018 at 9:58 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> This inbuilt device contains a single 4-byte register, of which bit 24 is used
>> to power down the machine on a real Ultra 5.
>>
>> The power device exists at offset 0x724000 on a real machine, but due to the
>> current configuration of the BARs in QEMU it must be located lower in PCI IO
>> space.
>>
>> For the moment we place the power device at offset 0x7240 as a reminder of its
>> original location and raise the base PCI IO address from 0x4000 to 0x8000.
> 
> I think it's ok to have it there for now. The guests should get the
> info from the device tree.

Yes indeed. For reference you can see the corresponding OpenBIOS 
patchset at 
https://mail.coreboot.org/pipermail/openbios/2018-January/010160.html.


ATB,

Mark.

>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> 
>> ---
>>   hw/sparc64/sun4u.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index ec45ec2801..26ab6e9a9c 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -205,6 +205,59 @@ typedef struct ResetData {
>>       uint64_t prom_addr;
>>   } ResetData;
>>
>> +#define TYPE_SUN4U_POWER "power"
>> +#define SUN4U_POWER(obj) OBJECT_CHECK(PowerDevice, (obj), TYPE_SUN4U_POWER)
>> +
>> +typedef struct PowerDevice {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion power_mmio;
>> +} PowerDevice;
>> +
>> +/* Power */
>> +static void power_mem_write(void *opaque, hwaddr addr,
>> +                            uint64_t val, unsigned size)
>> +{
>> +    /* According to a real Ultra 5, bit 24 controls the power */
>> +    if (val & 0x1000000) {
>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps power_mem_ops = {
>> +    .write = power_mem_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +};
>> +
>> +static void power_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PowerDevice *d = SUN4U_POWER(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +
>> +    memory_region_init_io(&d->power_mmio, OBJECT(dev), &power_mem_ops, d,
>> +                          "power", sizeof(uint32_t));
>> +
>> +    sysbus_init_mmio(sbd, &d->power_mmio);
>> +}
>> +
>> +static void power_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = power_realize;
>> +}
>> +
>> +static const TypeInfo power_info = {
>> +    .name          = TYPE_SUN4U_POWER,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(PowerDevice),
>> +    .class_init    = power_class_init,
>> +};
>> +
>>   static void ebus_isa_irq_handler(void *opaque, int n, int level)
>>   {
>>       EbusState *s = EBUS(opaque);
>> @@ -221,6 +274,7 @@ static void ebus_isa_irq_handler(void *opaque, int n, int level)
>>   static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>>   {
>>       EbusState *s = EBUS(pci_dev);
>> +    SysBusDevice *sbd;
>>       DeviceState *dev;
>>       qemu_irq *isa_irq;
>>       DriveInfo *fd[MAX_FD];
>> @@ -270,6 +324,13 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>>       qdev_prop_set_uint32(dev, "dma", -1);
>>       qdev_init_nofail(dev);
>>
>> +    /* Power */
>> +    dev = qdev_create(NULL, TYPE_SUN4U_POWER);
>> +    qdev_init_nofail(dev);
>> +    sbd = SYS_BUS_DEVICE(dev);
>> +    memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,
>> +                                sysbus_mmio_get_region(sbd, 0));
>> +
>>       /* PCI */
>>       pci_dev->config[0x04] = 0x06; // command = bus master, pci mem
>>       pci_dev->config[0x05] = 0x00;
>> @@ -282,7 +343,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>>                                0, 0x1000000);
>>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar0);
>>       memory_region_init_alias(&s->bar1, OBJECT(s), "bar1", get_system_io(),
>> -                             0, 0x4000);
>> +                             0, 0x8000);
>>       pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
>>   }
>>
>> @@ -693,6 +754,7 @@ static const TypeInfo sun4v_type = {
>>
>>   static void sun4u_register_types(void)
>>   {
>> +    type_register_static(&power_info);
>>       type_register_static(&ebus_info);
>>       type_register_static(&prom_info);
>>       type_register_static(&ram_info);
>> --
>> 2.11.0
>>
> 
> 
> 
