Received: from eggs.gnu.org ([2001:4830:134:3::10]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ20a-0003Dz-8c
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ1rm-000563-Ur
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:10:54 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:21650)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ1rm-0004m4-8S
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 22:10:50 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 11:10:40 +0800
MIME-Version: 1.0
In-Reply-To: <20181119233139.GO3807@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com, armbru@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, alistair.francis@wdc.com, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Hi, Eduardo

On 11/20/18 7:31 AM, Eduardo Habkost wrote:
> On Mon, Nov 19, 2018 at 08:08:20PM +0800, Mao Zhongyi wrote:
>> Currently, all sysbus devices have been converted to realize(),
>> so remove this path.
>>
>> Cc: ehabkost@redhat.com
>> Cc: thuth@redhat.com
>> Cc: pbonzini@redhat.com
>> Cc: armbru@redhat.com
>> Cc: peter.maydell@linaro.org
>> Cc: richard.henderson@linaro.org
>> Cc: alistair.francis@wdc.com
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> ---
>>   hw/core/sysbus.c    | 15 ---------------
>>   include/hw/sysbus.h |  3 ---
>>   2 files changed, 18 deletions(-)
>>
>> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
>> index 7ac36ad3e7..030ad426c1 100644
>> --- a/hw/core/sysbus.c
>> +++ b/hw/core/sysbus.c
>> @@ -201,20 +201,6 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
>>       }
>>   }
>>   
>> -/* TODO remove once all sysbus devices have been converted to realize */
>> -static void sysbus_realize(DeviceState *dev, Error **errp)
>> -{
>> -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>> -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>> -
>> -    if (!sbc->init) {
>> -        return;
>> -    }
>> -    if (sbc->init(sd) < 0) {
>> -        error_setg(errp, "Device initialization failed");
>> -    }
>> -}
> 
> Nice.  :)
> 
> 
>> -
>>   DeviceState *sysbus_create_varargs(const char *name,
>>                                      hwaddr addr, ...)
>>   {
>> @@ -327,7 +313,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
>>   static void sysbus_device_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *k = DEVICE_CLASS(klass);
>> -    k->realize = sysbus_realize;
> 
> Have you ensured this won't break any subclasses that
> saved the original realize function on a parent_realize field?

Thanks for the catch.

> Now they will have parent_realize set to NULL.

In order to void the subclasses whose parent_realize field is
set to NULL, the k->realize function must be retained even
though it doesn't do anything practical. Just like this:


-/* TODO remove once all sysbus devices have been converted to realize*/
  static void sysbus_realize(DeviceState *dev, Error **errp)
  {
-    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
-    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
-
-    if (!sbc->init) {
-        return;
-    }
-    if (sbc->init(sd) < 0) {
-        error_setg(errp, "Device initialization failed");
-    }
  }

it doesn't look elegant, but I didn't think of a better way, if you
can give me some hints, I really appreciate it. :)

Thanks,
Mao


> 
> Most of them use device_class_set_parent_realize() to implement
> that.
> 
>>       k->bus_type = TYPE_SYSTEM_BUS;
>>       /*
>>        * device_add plugs devices into a suitable bus.  For "real" buses,
>> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
>> index 0b59a3b8d6..1aedcf05c9 100644
>> --- a/include/hw/sysbus.h
>> +++ b/include/hw/sysbus.h
>> @@ -38,9 +38,6 @@ typedef struct SysBusDevice SysBusDevice;
>>   typedef struct SysBusDeviceClass {
>>       /*< private >*/
>>       DeviceClass parent_class;
>> -    /*< public >*/
>> -
>> -    int (*init)(SysBusDevice *dev);
>>   
>>       /*
>>        * Let the sysbus device format its own non-PIO, non-MMIO unit address.
>> -- 
>> 2.17.1
>>
>>
>>
> 
