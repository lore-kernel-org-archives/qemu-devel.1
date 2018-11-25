Received: from eggs.gnu.org ([2001:4830:134:3::10]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQjLL-0005rz-VC
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQjLK-0000mN-VA
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 20:36:15 -0500
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-16-maozhongyi@cmss.chinamobile.com>
	<67693f9a-1210-3420-6ff5-c7c8c08810be@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <87bf96bc-d21d-9c7f-4e7f-e716bea12784@cmss.chinamobile.com>
Date: Sun, 25 Nov 2018 09:36:03 +0800
MIME-Version: 1.0
In-Reply-To: <67693f9a-1210-3420-6ff5-c7c8c08810be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/21] pci-bridge/dec: Convert sysbus
 initfunction to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, qemu-ppc@nongnu.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>, david@gibson.dropbear.id.au

Hi, Philippe

On 11/24/18 12:37 AM, Philippe Mathieu-Daudé wrote:
> Hi Mao,
> 
> On 23/11/18 16:30, Mao Zhongyi wrote:
>> Use DeviceClass rather than SysBusDeviceClass in
>> pci_dec_21154_device_class_init().
>>
>> Cc: david@gibson.dropbear.id.au
>> Cc: mst@redhat.com
>> Cc: marcel.apfelbaum@gmail.com
>> Cc: qemu-ppc@nongnu.org
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>   hw/pci-bridge/dec.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
>> index 84492d5e5f..5b21c20e50 100644
>> --- a/hw/pci-bridge/dec.c
>> +++ b/hw/pci-bridge/dec.c
>> @@ -98,7 +98,7 @@ PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devfn)
>>       return pci_bridge_get_sec_bus(br);
>>   }
>>   
>> -static int pci_dec_21154_device_init(SysBusDevice *dev)
>> +static void pci_dec_21154_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       PCIHostState *phb;
> 
> Why don't you use:
> 
>         SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> 
> like in all the other patches from this series...?

Oops, sorry, I missed this one, will fix it in v3.

Thanks,
Mao

> 
>>   
>> @@ -108,9 +108,8 @@ static int pci_dec_21154_device_init(SysBusDevice *dev)
>>                             dev, "pci-conf-idx", 0x1000);
>>       memory_region_init_io(&phb->data_mem, OBJECT(dev), &pci_host_data_le_ops,
>>                             dev, "pci-data-idx", 0x1000);
>> -    sysbus_init_mmio(dev, &phb->conf_mem);
>> -    sysbus_init_mmio(dev, &phb->data_mem);
>> -    return 0;
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->conf_mem);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &phb->data_mem);
> 
> ... this would save extra type checking here, as explain by Peter:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03644.html
> 
>>   }
>>   
>>   static void dec_21154_pci_host_realize(PCIDevice *d, Error **errp)
>> @@ -150,9 +149,9 @@ static const TypeInfo dec_21154_pci_host_info = {
>>   
>>   static void pci_dec_21154_device_class_init(ObjectClass *klass, void *data)
>>   {
>> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>   
>> -    sdc->init = pci_dec_21154_device_init;
>> +    dc->realize = pci_dec_21154_device_realize;
>>   }
>>   
>>   static const TypeInfo pci_dec_21154_device_info = {
>>
> 
