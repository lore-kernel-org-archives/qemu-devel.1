Received: from eggs.gnu.org ([2001:4830:134:3::10]:49695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWg00-0000cs-Ax
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWfzz-0006OM-9i
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:10:16 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWfzy-0006Nx-RL
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:10:15 -0500
Received: by mail-qt0-x243.google.com with SMTP id g9so1493972qth.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 02:10:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171229174933.1781-1-f4bug@amsat.org>
	<20171229174933.1781-8-f4bug@amsat.org>
	<20180103075633.GE25984@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17a6da8e-0760-535c-1e7a-bf245fb12e3c@amsat.org>
Date: Wed, 3 Jan 2018 07:10:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180103075633.GE25984@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/42] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org

Hi Fam,

On 01/03/2018 04:56 AM, Fam Zheng wrote:
> On Fri, 12/29 14:48, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sdhci.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>> index ad5853d527..06a1ec6f91 100644
>> --- a/hw/sd/sdhci.c
>> +++ b/hw/sd/sdhci.c
>> @@ -31,6 +31,7 @@
>>  #include "qemu/bitops.h"
>>  #include "hw/sd/sdhci.h"
>>  #include "sdhci-internal.h"
>> +#include "qapi/error.h"
>>  #include "qemu/log.h"
>>  
>>  /* host controller debug messages */
>> @@ -1203,15 +1204,17 @@ static void sdhci_realizefn(SDHCIState *s, Error **errp)
>>                            SDHC_REGISTERS_MAP_SIZE);
>>  }
>>  
>> +static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
>> +{
>> +    g_free(s->fifo_buffer);
> 
> Set s->fifo_buffer to NULL to avoid double-free and/or use-after-free?
> Especially since you call this from both the ->exit and the ->unrealize
> callbacks.

Yes, I agree this would be safer. I'll also add a comment around.

Thanks!

>> +}
>> +
>>  static void sdhci_uninitfn(SDHCIState *s)
>>  {
>>      timer_del(s->insert_timer);
>>      timer_free(s->insert_timer);
>>      timer_del(s->transfer_timer);
>>      timer_free(s->transfer_timer);
>> -
>> -    g_free(s->fifo_buffer);
>> -    s->fifo_buffer = NULL;
>>  }
>>  
>>  static bool sdhci_pending_insert_vmstate_needed(void *opaque)
>> @@ -1312,6 +1315,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>>  static void sdhci_pci_exit(PCIDevice *dev)
>>  {
>>      SDHCIState *s = PCI_SDHCI(dev);
>> +
>> +    sdhci_unrealizefn(s, &error_abort);
>>      sdhci_uninitfn(s);
>>  }
>>  
>> @@ -1365,11 +1370,19 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
>>      sysbus_init_mmio(sbd, &s->iomem);
>>  }
>>  
>> +static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    SDHCIState *s = SYSBUS_SDHCI(dev);
>> +
>> +    sdhci_unrealizefn(s, errp);
>> +}
>> +
>>  static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>  
>>      dc->realize = sdhci_sysbus_realize;
>> +    dc->unrealize = sdhci_sysbus_unrealize;
>>  
>>      sdhci_class_init(klass, data);
>>  }
>> -- 
>> 2.15.1
>>
>>
> 
> Fam
> 
