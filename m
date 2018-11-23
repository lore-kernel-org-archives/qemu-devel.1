Received: from eggs.gnu.org ([2001:4830:134:3::10]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ26K-0005D1-OY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ26H-0001iC-LG
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:25:52 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:55449)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ26G-0001cR-SU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:25:49 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-7-maozhongyi@cmss.chinamobile.com>
	<CAFEAcA-ywi9OoUHhdQXq9FOXVjKC9OrzUiT1oyTWPAQwUUhF2A@mail.gmail.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <045237dd-e33f-ae9e-eec0-0b46c822faed@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 11:25:40 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ywi9OoUHhdQXq9FOXVjKC9OrzUiT1oyTWPAQwUUhF2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/22] dma/puv3_dma: Convert sysbus
 initfunction to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>



On 11/20/18 10:46 PM, Peter Maydell wrote:
> On 19 November 2018 at 12:08, Mao Zhongyi
> <maozhongyi@cmss.chinamobile.com> wrote:
>> Use DeviceClass rather than SysBusDeviceClass in
>> puv3_dma_class_init().
>>
>> Cc: gxt@mprc.pku.edu.cn
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> ---
>>   hw/dma/puv3_dma.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
>> index b97a6c1767..c89eade029 100644
>> --- a/hw/dma/puv3_dma.c
>> +++ b/hw/dma/puv3_dma.c
>> @@ -76,7 +76,7 @@ static const MemoryRegionOps puv3_dma_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>   };
>>
>> -static int puv3_dma_init(SysBusDevice *dev)
>> +static void puv3_dma_realize(DeviceState *dev, Error **errp)
>>   {
>>       PUV3DMAState *s = PUV3_DMA(dev);
>>       int i;
>> @@ -87,16 +87,14 @@ static int puv3_dma_init(SysBusDevice *dev)
>>
>>       memory_region_init_io(&s->iomem, OBJECT(s), &puv3_dma_ops, s, "puv3_dma",
>>               PUV3_REGS_OFFSET);
>> -    sysbus_init_mmio(dev, &s->iomem);
>> -
>> -    return 0;
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>>   }
>>
>>   static void puv3_dma_class_init(ObjectClass *klass, void *data)
>>   {
>> -    SysBusDeviceClass *sdc = SYS_BUS_DEVICE_CLASS(klass);
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>
>> -    sdc->init = puv3_dma_init;
>> +    dc->realize = puv3_dma_realize;
>>   }
>>
>>   static const TypeInfo puv3_dma_info = {
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> (I note that this device is missing a reset function and is
> instead resetting in its init/realize function, but that's a
> separate bug. It's also missing vmstate.)

OK, I will fix it later in a separate patch.

Thanks,
Mao

> 
> thanks
> -- PMM
> 
