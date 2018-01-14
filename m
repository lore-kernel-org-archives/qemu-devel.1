Received: from eggs.gnu.org ([2001:4830:134:3::10]:50394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamm0-0006d2-RJ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamlv-00075F-Sc
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:12:48 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eamlv-000755-N0
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 13:12:43 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so1629348qtj.13
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 10:12:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114025234.29436-1-f4bug@amsat.org>
	<CAFEAcA-m+7Cr1R=oBNmuNC3XQbyYmjj2s_tGd5rHK2jmzRmHSA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a70d0093-f3c3-f945-81a1-67134abafd41@amsat.org>
Date: Sun, 14 Jan 2018 15:12:37 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-m+7Cr1R=oBNmuNC3XQbyYmjj2s_tGd5rHK2jmzRmHSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sysbus: convert init() to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 01/14/2018 12:32 PM, Peter Maydell wrote:
> On 14 January 2018 at 02:52, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/core/sysbus.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index 5d0887f499..0531eb60ce 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -18,6 +18,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>  #include "hw/sysbus.h"
>>  #include "monitor/monitor.h"
>>  #include "exec/address-spaces.h"
>> @@ -200,15 +201,15 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
>>      }
>>  }
>>
>> -static int sysbus_device_init(DeviceState *dev)
>> +static void sysbus_device_realize(DeviceState *dev, Error **errp)
>>  {
>>      SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>>      SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>>
>> -    if (!sbc->init) {
>> -        return 0;
>> +    if (sbc->init && sbc->init(sd)) {
>> +        error_setg(errp, "sysbus device initialization failed");
>> +        return;
>>      }
>> -    return sbc->init(sd);
>>  }
>>
>>  DeviceState *sysbus_create_varargs(const char *name,
>> @@ -324,7 +325,7 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
>>  static void sysbus_device_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *k = DEVICE_CLASS(klass);
>> -    k->init = sysbus_device_init;
>> +    k->realize = sysbus_device_realize;
>>      k->bus_type = TYPE_SYSTEM_BUS;
>>      /*
>>       * device_add plugs devices into a suitable bus.  For "real" buses,
> 
> This doesn't look right. SysBus::init is something we're trying
> to deprecate, I think, so we should be looking to complete
> that process, not changing its semantics so it isn't called
> until Device::realize.

Ok, I think if I put all those related patches altogether in the same
series this will make more sens.
