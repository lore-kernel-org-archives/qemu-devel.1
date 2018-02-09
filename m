Received: from eggs.gnu.org ([2001:4830:134:3::10]:60710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4Td-0000CD-Rs
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4TZ-0004YL-Tx
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:56:13 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-3-f4bug@amsat.org>
	<21f7b55b-72d3-5726-ef71-032bac16e6c8@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a6280f03-22f5-7847-d616-14a384665261@amsat.org>
Date: Fri, 9 Feb 2018 05:56:05 -0300
MIME-Version: 1.0
In-Reply-To: <21f7b55b-72d3-5726-ef71-032bac16e6c8@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/2] hw/arm/aspeed: simplify
 using the 'unimplemented device' for aspeed_soc.io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 02/08/2018 03:14 PM, Cédric Le Goater wrote:
> On 02/08/2018 06:22 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> This looks like a good idea. (Have you actually tried it ? 
> just asking)

v1 obviously not :S v2 yes!

> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks :)

> 
> Thanks,
> 
> C. 
> 
>> ---
>>  include/hw/arm/aspeed_soc.h |  1 -
>>  hw/arm/aspeed_soc.c         | 32 +++-----------------------------
>>  2 files changed, 3 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index f26914a2b9..11ec0179db 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -31,7 +31,6 @@ typedef struct AspeedSoCState {
>>  
>>      /*< public >*/
>>      ARMCPU cpu;
>> -    MemoryRegion iomem;
>>      MemoryRegion sram;
>>      AspeedVICState vic;
>>      AspeedTimerCtrlState timerctrl;
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index a786750e14..3d21128d47 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -15,6 +15,7 @@
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>>  #include "exec/address-spaces.h"
>> +#include "hw/misc/unimp.h"
>>  #include "hw/arm/aspeed_soc.h"
>>  #include "hw/char/serial.h"
>>  #include "qemu/log.h"
>> @@ -99,31 +100,6 @@ static const AspeedSoCInfo aspeed_socs[] = {
>>      },
>>  };
>>  
>> -/*
>> - * IO handlers: simply catch any reads/writes to IO addresses that aren't
>> - * handled by a device mapping.
>> - */
>> -
>> -static uint64_t aspeed_soc_io_read(void *p, hwaddr offset, unsigned size)
>> -{
>> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>> -                  __func__, offset, size);
>> -    return 0;
>> -}
>> -
>> -static void aspeed_soc_io_write(void *opaque, hwaddr offset, uint64_t value,
>> -                unsigned size)
>> -{
>> -    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%u]\n",
>> -                  __func__, offset, value, size);
>> -}
>> -
>> -static const MemoryRegionOps aspeed_soc_io_ops = {
>> -    .read = aspeed_soc_io_read,
>> -    .write = aspeed_soc_io_write,
>> -    .endianness = DEVICE_LITTLE_ENDIAN,
>> -};
>> -
>>  static void aspeed_soc_init(Object *obj)
>>  {
>>      AspeedSoCState *s = ASPEED_SOC(obj);
>> @@ -199,10 +175,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>>      Error *err = NULL, *local_err = NULL;
>>  
>>      /* IO space */
>> -    memory_region_init_io(&s->iomem, NULL, &aspeed_soc_io_ops, NULL,
>> -            "aspeed_soc.io", ASPEED_SOC_IOMEM_SIZE);
>> -    memory_region_add_subregion_overlap(get_system_memory(),
>> -                                        ASPEED_SOC_IOMEM_BASE, &s->iomem, -1);
>> +    create_unimplemented_device("aspeed_soc.io",
>> +                                ASPEED_SOC_IOMEM_BASE, ASPEED_SOC_IOMEM_SIZE);
>>  
>>      /* CPU */
>>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
>>
> 
> 
