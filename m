Received: from eggs.gnu.org ([2001:4830:134:3::10]:48064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbwm-0004fU-9F
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbwi-00085V-A2
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:03:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecbwi-00085P-5V
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:03:24 -0500
Received: by mail-qt0-x241.google.com with SMTP id l20so4970884qtj.11
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 11:03:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-7-f4bug@amsat.org>
	<20180119180302.GK15832@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <596f32f8-625b-497f-a52c-facb70404792@amsat.org>
Date: Fri, 19 Jan 2018 16:03:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180119180302.GK15832@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] sysbus: add realize() and unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On 01/19/2018 03:03 PM, Eduardo Habkost wrote:
> On Tue, Jan 16, 2018 at 10:15:50AM -0300, Philippe Mathieu-Daudé wrote:
> [...]
>> +static void sysbus_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>> +
>> +    if (sbc->realize) {
>> +        sbc->realize(sd, errp);
>> +    }
>> +}
>> +
>> +static void sysbus_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>> +
>> +    if (sbc->unrealize) {
>> +        sbc->unrealize(sd, errp);
>> +    }
>> +}
> 
> Why not just let the subclasses set DeviceClass::realize and
> DeviceClass::unrealize directly?

yes, clever :)

> 
>> +
>>  DeviceState *sysbus_create_varargs(const char *name,
>>                                     hwaddr addr, ...)
>>  {
>> @@ -325,6 +346,8 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *k = DEVICE_CLASS(klass);
>>      k->init = sysbus_device_init;
>> +    k->realize = sysbus_realize;
>> +    k->unrealize = sysbus_unrealize;
>>      k->bus_type = TYPE_SYSTEM_BUS;
>>      /*
>>       * device_add plugs devices into a suitable bus.  For "real" buses,
>> -- 
>> 2.15.1
>>
>>
> 
