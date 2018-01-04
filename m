Received: from eggs.gnu.org ([2001:4830:134:3::10]:36869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXCDL-0007lD-S6
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eXCDK-0007XX-OO
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:34:11 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eXCDK-0007Og-Hs
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 15:34:10 -0500
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<20171229142922.31701-5-hpoussin@reactos.org>
	<48e5c12c-d598-4917-5c59-e0017ed52ffa@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <8b3faae9-e8c6-8e40-1202-fc6b43112175@reactos.org>
Date: Thu, 4 Jan 2018 21:34:02 +0100
MIME-Version: 1.0
In-Reply-To: <48e5c12c-d598-4917-5c59-e0017ed52ffa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/16] mc146818rtc: always register rtc
 to rtc list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Le 04/01/2018 à 15:30, Marcel Apfelbaum a écrit :
> On 29/12/2017 16:29, Hervé Poussineau wrote:
>> We are not required anymore to use rtc_init() function.
>>
>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>   hw/timer/mc146818rtc.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 3e8c0b7d33..0b0da691cc 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -905,6 +905,13 @@ static void rtc_get_date(Object *obj, struct tm *current_tm, Error **errp)
>>       rtc_get_time(s, current_tm);
>>   }
>> +static int rtc_initfn(DeviceState *dev)
>> +{
>> +    RTCState *s = MC146818_RTC(dev);
>> +    QLIST_INSERT_HEAD(&rtc_devices, s, link);
>> +    return 0;
>> +}
>> +
>>   static void rtc_realizefn(DeviceState *dev, Error **errp)
>>   {
>>       ISADevice *isadev = ISA_DEVICE(dev);
>> @@ -973,11 +980,9 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
>>   {
>>       DeviceState *dev;
>>       ISADevice *isadev;
>> -    RTCState *s;
>>       isadev = isa_create(bus, TYPE_MC146818_RTC);
>>       dev = DEVICE(isadev);
>> -    s = MC146818_RTC(isadev);
>>       qdev_prop_set_int32(dev, "base_year", base_year);
>>       qdev_init_nofail(dev);
>>       if (intercept_irq) {
>> @@ -985,7 +990,6 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
>>       } else {
>>           isa_connect_gpio_out(isadev, 0, RTC_ISA_IRQ);
>>       }
>> -    QLIST_INSERT_HEAD(&rtc_devices, s, link);
>>       return isadev;
>>   }
>> @@ -1012,12 +1016,11 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> +    dc->init = rtc_initfn;
> 
> I am not sure you want to use dc->init function.
> 
> I think you need TypeInfo's instance_init.

OK, I will move list insertion to existing function rtc_realizefn.

> 
> Thanks,
> Marcel
> 
>>       dc->realize = rtc_realizefn;
>>       dc->reset = rtc_resetdev;
>>       dc->vmsd = &vmstate_rtc;
>>       dc->props = mc146818rtc_properties;
>> -    /* Reason: needs to be wired up by rtc_init() */
>> -    dc->user_creatable = false;
>>   }
>>   static void rtc_finalize(Object *obj)
>>
> 
> 
