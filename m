Received: from eggs.gnu.org ([2001:4830:134:3::10]:37887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzxJ-0005Tu-I2
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzxG-0005Rq-BN
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:27:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-11-peter.maydell@linaro.org>
	<b16ded66-e814-43f4-389f-65e697660740@amsat.org>
Message-ID: <fd82c9db-1ecd-a833-8eab-0060647c2220@amsat.org>
Date: Fri, 10 Aug 2018 02:27:13 -0300
MIME-Version: 1.0
In-Reply-To: <b16ded66-e814-43f4-389f-65e697660740@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 10/16] hw/dma/pl080: Allow use
 as embedded-struct device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/10/2018 02:18 AM, Philippe Mathieu-Daudé wrote:
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> Create a new include file for the pl081's device struct,
>> type macros, etc, so that it can be instantiated using
>> the "embedded struct" coding style.
[...]
>> +#ifndef HW_DMA_PL080_H
>> +#define HW_DMA_PL080_H
>> +
>> +#include "hw/sysbus.h"
>> +
>> +#define PL080_MAX_CHANNELS 8
>> +
>> +typedef struct {
>> +    uint32_t src;
>> +    uint32_t dest;
>> +    uint32_t lli;
>> +    uint32_t ctrl;
>> +    uint32_t conf;
>> +} pl080_channel;
>> +
>> +#define TYPE_PL080 "pl080"
>> +#define TYPE_PL081 "pl081"
>> +#define PL080(obj) OBJECT_CHECK(PL080State, (obj), TYPE_PL080)
> 
> The PL080() macro can stay in the source.

Oh this respect the "coding style" indeed.
Can you add the PL081() companion? Thanks.

> 
> Regardless:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +
>> +typedef struct PL080State {
>> +    SysBusDevice parent_obj;
>> +
>> +    MemoryRegion iomem;
>> +    uint8_t tc_int;
>> +    uint8_t tc_mask;
>> +    uint8_t err_int;
>> +    uint8_t err_mask;
>> +    uint32_t conf;
>> +    uint32_t sync;
>> +    uint32_t req_single;
>> +    uint32_t req_burst;
>> +    pl080_channel chan[PL080_MAX_CHANNELS];
>> +    int nchannels;
>> +    /* Flag to avoid recursive DMA invocations.  */
>> +    int running;
>> +    qemu_irq irq;
>> +} PL080State;
>> +
>> +#endif
>> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
>> index 7724c93b8f2..0f79c2d8a6c 100644
>> --- a/hw/dma/pl080.c
>> +++ b/hw/dma/pl080.c
>> @@ -11,8 +11,8 @@
>>  #include "hw/sysbus.h"
>>  #include "exec/address-spaces.h"
>>  #include "qemu/log.h"
>> +#include "hw/dma/pl080.h"
>>  
>> -#define PL080_MAX_CHANNELS 8
>>  #define PL080_CONF_E    0x1
>>  #define PL080_CONF_M1   0x2
>>  #define PL080_CONF_M2   0x4
>> @@ -30,36 +30,6 @@
>>  #define PL080_CCTRL_D   0x02000000
>>  #define PL080_CCTRL_S   0x01000000
>>  
>> -typedef struct {
>> -    uint32_t src;
>> -    uint32_t dest;
>> -    uint32_t lli;
>> -    uint32_t ctrl;
>> -    uint32_t conf;
>> -} pl080_channel;
>> -
>> -#define TYPE_PL080 "pl080"
>> -#define PL080(obj) OBJECT_CHECK(PL080State, (obj), TYPE_PL080)
>> -
>> -typedef struct PL080State {
>> -    SysBusDevice parent_obj;
>> -
>> -    MemoryRegion iomem;
>> -    uint8_t tc_int;
>> -    uint8_t tc_mask;
>> -    uint8_t err_int;
>> -    uint8_t err_mask;
>> -    uint32_t conf;
>> -    uint32_t sync;
>> -    uint32_t req_single;
>> -    uint32_t req_burst;
>> -    pl080_channel chan[PL080_MAX_CHANNELS];
>> -    int nchannels;
>> -    /* Flag to avoid recursive DMA invocations.  */
>> -    int running;
>> -    qemu_irq irq;
>> -} PL080State;
>> -
>>  static const VMStateDescription vmstate_pl080_channel = {
>>      .name = "pl080_channel",
>>      .version_id = 1,
>> @@ -408,7 +378,7 @@ static const TypeInfo pl080_info = {
>>  };
>>  
>>  static const TypeInfo pl081_info = {
>> -    .name          = "pl081",
>> +    .name          = TYPE_PL081,
>>      .parent        = TYPE_PL080,
>>      .instance_init = pl081_init,
>>  };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5d1a3645dd4..92ccca716c6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -444,6 +444,7 @@ F: hw/char/pl011.c
>>  F: include/hw/char/pl011.h
>>  F: hw/display/pl110*
>>  F: hw/dma/pl080.c
>> +F: include/hw/dma/pl080.h
>>  F: hw/dma/pl330.c
>>  F: hw/gpio/pl061.c
>>  F: hw/input/pl050.c
>>
