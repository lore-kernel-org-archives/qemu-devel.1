Received: from eggs.gnu.org ([2001:4830:134:3::10]:49123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5Wbv-0003Ua-Df
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e5Wbu-0004vx-93
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:11 -0400
Received: from chuckie.co.uk ([82.165.15.123]:48832
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e5Wbt-0004vc-TE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:10 -0400
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<fab45917-6f63-c2d2-8875-cb33b09f9bc8@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <822b62ef-8446-c8e5-6d1c-731923fb5823@ilande.co.uk>
Date: Fri, 20 Oct 2017 13:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <fab45917-6f63-c2d2-8875-cb33b09f9bc8@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 02/13] sparc32_dma: split esp and le into
 separate DMA devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 19/10/17 05:33, Philippe Mathieu-Daudé wrote:

> On 10/14/2017 03:38 PM, Mark Cave-Ayland wrote:

>> Due to slight differences in behaviour accessing the registers for the
>> esp and le devices, create two separate SPARC32_DMA_DEVICE types and
>> update the sun4m machine to use.
>>
>> Note that by using different device types we already know the size of
>> the register block and the value of is_ledma at init time, allowing us to
>> drop the SPARC32_DMA_DEVICE realize function and the is_ledma device
>> property.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/dma/sparc32_dma.c |   63 ++++++++++++++++++++++++++++++++++++++++----------
>>  hw/sparc/sun4m.c     |    3 +--
>>  2 files changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
>> index a8d31c1..e4ff4a8 100644
>> --- a/hw/dma/sparc32_dma.c
>> +++ b/hw/dma/sparc32_dma.c
>> @@ -78,6 +78,22 @@ struct DMADeviceState {
>>      uint32_t is_ledma;
>>  };
>>  
>> +#define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
>> +#define SPARC32_ESPDMA_DEVICE(obj) OBJECT_CHECK(ESPDMADeviceState, (obj), \
>> +                                                TYPE_SPARC32_ESPDMA_DEVICE)
>> +
>> +typedef struct ESPDMADeviceState {
>> +    DMADeviceState parent_obj;
>> +} ESPDMADeviceState;
>> +
>> +#define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
>> +#define SPARC32_LEDMA_DEVICE(obj) OBJECT_CHECK(LEDMADeviceState, (obj), \
>> +                                               TYPE_SPARC32_LEDMA_DEVICE)
>> +
>> +typedef struct LEDMADeviceState {
>> +    DMADeviceState parent_obj;
>> +} LEDMADeviceState;
>> +
>>  enum {
>>      GPIO_RESET = 0,
>>      GPIO_DMA,
>> @@ -285,19 +301,8 @@ static void sparc32_dma_device_init(Object *obj)
>>      qdev_init_gpio_out(dev, s->gpio, 2);
>>  }
>>  
>> -static void sparc32_dma_device_realize(DeviceState *dev, Error **errp)
>> -{
>> -    DMADeviceState *s = SPARC32_DMA_DEVICE(dev);
>> -    int reg_size;
>> -
>> -    reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
>> -    memory_region_init_io(&s->iomem, OBJECT(dev), &dma_mem_ops, s,
>> -                          "dma", reg_size);
>> -}
>> -
>>  static Property sparc32_dma_device_properties[] = {
>>      DEFINE_PROP_PTR("iommu_opaque", DMADeviceState, iommu),
>> -    DEFINE_PROP_UINT32("is_ledma", DMADeviceState, is_ledma, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> @@ -308,7 +313,6 @@ static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>>      dc->reset = sparc32_dma_device_reset;
>>      dc->vmsd = &vmstate_sparc32_dma_device;
>>      dc->props = sparc32_dma_device_properties;
>> -    dc->realize = sparc32_dma_device_realize;
>>      /* Reason: pointer property "iommu_opaque" */
>>      dc->user_creatable = false;
>>  }
>> @@ -316,14 +320,49 @@ static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>>  static const TypeInfo sparc32_dma_device_info = {
>>      .name          = TYPE_SPARC32_DMA_DEVICE,
>>      .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .abstract      = true,
>>      .instance_size = sizeof(DMADeviceState),
>>      .instance_init = sparc32_dma_device_init,
>>      .class_init    = sparc32_dma_device_class_init,
>>  };
>>  
>> +static void sparc32_espdma_device_init(Object *obj)
>> +{
>> +    DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
>> +                          "espdma-mmio", DMA_SIZE);
>> +    s->is_ledma = 0;
>> +}
>> +
>> +static const TypeInfo sparc32_espdma_device_info = {
>> +    .name          = TYPE_SPARC32_ESPDMA_DEVICE,
>> +    .parent        = TYPE_SPARC32_DMA_DEVICE,
>> +    .instance_size = sizeof(ESPDMADeviceState),
>> +    .instance_init = sparc32_espdma_device_init,
>> +};
>> +
>> +static void sparc32_ledma_device_init(Object *obj)
>> +{
>> +    DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
>> +                          "ledma-mmio", DMA_ETH_SIZE);
>> +    s->is_ledma = 1;
>> +}
>> +
>> +static const TypeInfo sparc32_ledma_device_info = {
>> +    .name          = TYPE_SPARC32_LEDMA_DEVICE,
>> +    .parent        = TYPE_SPARC32_DMA_DEVICE,
>> +    .instance_size = sizeof(LEDMADeviceState),
>> +    .instance_init = sparc32_ledma_device_init,
>> +};
>> +
>>  static void sparc32_dma_register_types(void)
>>  {
>>      type_register_static(&sparc32_dma_device_info);
>> +    type_register_static(&sparc32_espdma_device_info);
>> +    type_register_static(&sparc32_ledma_device_info);
>>  }
>>  
>>  type_init(sparc32_dma_register_types)
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index 82c553c..88a9752 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -313,9 +313,8 @@ static void *sparc32_dma_init(hwaddr daddr, qemu_irq parent_irq,
>>      DeviceState *dev;
>>      SysBusDevice *s;
>>  
>> -    dev = qdev_create(NULL, "sparc32-dma-device");
>> +    dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
> 
> TYPE_SPARC32_LEDMA_DEVICE and TYPE_SPARC32_ESPDMA_DEVICE?

Again please note that this patch is an intermediate step and the type
is switched over to use the macro later in the patchset when the type
macro is eventually moved over to sparc32_dma.h.


ATB,

Mark.
