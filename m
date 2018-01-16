Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebS9N-000859-5x
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebS9L-0007lR-PX
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ebS9L-0007jX-G9
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:39 -0500
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
	<b706db4f-b103-9433-9973-762c7c594005@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3012b56d-9242-47ee-eb58-530080ba8c43@redhat.com>
Date: Tue, 16 Jan 2018 16:23:14 +0200
MIME-Version: 1.0
In-Reply-To: <b706db4f-b103-9433-9973-762c7c594005@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org


Hi Philippe,

On 16/01/2018 2:54, Philippe Mathieu-Daud=C3=A9 wrote:
> CC'ing PCI maintainers.
>=20
> Hi Mark,
>=20
> On 01/15/2018 05:58 PM, Mark Cave-Ayland wrote:
>> This inbuilt device contains a single 4-byte register, of which bit 24=
 is used
>> to power down the machine on a real Ultra 5.
>>
>> The power device exists at offset 0x724000 on a real machine, but due =
to the
>> current configuration of the BARs in QEMU it must be located lower in =
PCI IO
>> space.
> Is is some issue in pci_bar_address()?
>=20

The QEMU IO layout:

     /*
      * QEMU I/O address space usage:
      *   0000 - 0fff    legacy isa, pci config, pci root bus, ...
      *   1000 - 9fff    free
      *   a000 - afff    hotplug (cpu, pci via acpi, i440fx/piix only)
      *   b000 - bfff    power management (PORT_ACPI_PM_BASE)
      *                  [ qemu 1.4+ implements pci config registers
      *                    properly so guests can place the registers
      *                    where they want, on older versions its fixed ]
      *   c000 - ffff    free, traditionally used for pci io
      */

As you can see we don't have IO address space over ffff.

Thanks,
Marcel

>>
>> For the moment we place the power device at offset 0x7240 as a reminde=
r of its
>> original location and raise the base PCI IO address from 0x4000 to 0x8=
000.
>=20
> If we can't fix it, I rather prefer a #define with a comment in the
> code, IMHO this is safer and easier to remember than looking in git his=
tory.
>=20
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/sparc64/sun4u.c | 64 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index ec45ec2801..26ab6e9a9c 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -205,6 +205,59 @@ typedef struct ResetData {
>>       uint64_t prom_addr;
>>   } ResetData;
>>  =20
>> +#define TYPE_SUN4U_POWER "power"
>> +#define SUN4U_POWER(obj) OBJECT_CHECK(PowerDevice, (obj), TYPE_SUN4U_=
POWER)
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
>> +static const MemoryRegionOps power_mem_ops =3D {
>> +    .write =3D power_mem_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void power_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PowerDevice *d =3D SUN4U_POWER(dev);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>> +
>> +    memory_region_init_io(&d->power_mmio, OBJECT(dev), &power_mem_ops=
, d,
>> +                          "power", sizeof(uint32_t));
>> +
>> +    sysbus_init_mmio(sbd, &d->power_mmio);
>> +}
>> +
>> +static void power_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D power_realize;
>> +}
>> +
>> +static const TypeInfo power_info =3D {
>> +    .name          =3D TYPE_SUN4U_POWER,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(PowerDevice),
>> +    .class_init    =3D power_class_init,
>> +};
>> +
>>   static void ebus_isa_irq_handler(void *opaque, int n, int level)
>>   {
>>       EbusState *s =3D EBUS(opaque);
>> @@ -221,6 +274,7 @@ static void ebus_isa_irq_handler(void *opaque, int=
 n, int level)
>>   static void ebus_realize(PCIDevice *pci_dev, Error **errp)
>>   {
>>       EbusState *s =3D EBUS(pci_dev);
>> +    SysBusDevice *sbd;
>>       DeviceState *dev;
>>       qemu_irq *isa_irq;
>>       DriveInfo *fd[MAX_FD];
>> @@ -270,6 +324,13 @@ static void ebus_realize(PCIDevice *pci_dev, Erro=
r **errp)
>>       qdev_prop_set_uint32(dev, "dma", -1);
>>       qdev_init_nofail(dev);
>>  =20
>> +    /* Power */
>> +    dev =3D qdev_create(NULL, TYPE_SUN4U_POWER);
>> +    qdev_init_nofail(dev);
>> +    sbd =3D SYS_BUS_DEVICE(dev);
>> +    memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240=
,
>> +                                sysbus_mmio_get_region(sbd, 0));
>> +
>>       /* PCI */
>>       pci_dev->config[0x04] =3D 0x06; // command =3D bus master, pci m=
em
>>       pci_dev->config[0x05] =3D 0x00;
>> @@ -282,7 +343,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error=
 **errp)
>>                                0, 0x1000000);
>>       pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->=
bar0);
>>       memory_region_init_alias(&s->bar1, OBJECT(s), "bar1", get_system=
_io(),
>> -                             0, 0x4000);
>> +                             0, 0x8000);
>=20
> What about using 2 MR, bar1_lo/bar1_hi, registering bar1_lo at offset @=
0
> and bar1_hi at @0x724000?
>=20
>>       pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1=
);
>>   }
>>  =20
>> @@ -693,6 +754,7 @@ static const TypeInfo sun4v_type =3D {
>>  =20
>>   static void sun4u_register_types(void)
>>   {
>> +    type_register_static(&power_info);
>>       type_register_static(&ebus_info);
>>       type_register_static(&prom_info);
>>       type_register_static(&ram_info);
>>
>=20
