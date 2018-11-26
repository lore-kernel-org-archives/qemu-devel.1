Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRPZM-0005xC-FF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRPZC-0005Rl-Tw
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:41:32 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRPZC-0005RT-Pj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:41:22 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so18267210oth.7
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 14:41:22 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-17-minyard@acm.org>
	<d588fce5-23ad-3b53-c88a-4dfb542353e8@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <192d9e99-a3e6-0ca3-7c23-bd5a0d2b44cb@acm.org>
Date: Mon, 26 Nov 2018 16:41:18 -0600
MIME-Version: 1.0
In-Reply-To: <d588fce5-23ad-3b53-c88a-4dfb542353e8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v3 16/16] i2c:smbus_eeprom: Add a reset
 function to smbus_eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 11/26/18 2:42 PM, Philippe Mathieu-Daudé wrote:
> Hi Corey,
>
> On 26/11/18 21:04, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Reset the contents to init data and reset the offset on a machine
>> reset.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/i2c/smbus_eeprom.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index a0dcadbd60..de3a492df4 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -107,7 +107,7 @@ static const VMStateDescription vmstate_smbus_eeprom = {
>>       }
>>   };
>>   
>> -static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>> +static void smbus_eeprom_reset(DeviceState *dev)
>>   {
>>       SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>>   
> 'git diff -U4' also shows this line:
>
>         memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
>
> I don't think this is correct.
>
> One test I'd like to have is a machine booting, updating the EPROM then
> rebooting calling hw reset() to use the new values (BIOS use this).
>
> With this patch this won't work, you'll restore the EPROM content on
> each machine reset.
>
> I'd move the memcpy() call to the realize() function.
>
> What do you think?

There was some debate on this in the earlier patch set.  The general 
principle
is that a reset is the same as starting up qemu from scratch, so I added 
this
code based on that principle.  But I'm not really sure.

>>       eeprom->offset = 0;
> This is correct, the offset reset belongs to the reset() function.

Actually, on a real system, a hardware reset will generally not affect the
eeprom current offset register.  So if we don't take the above code, then
IMHO this is wrong, too.

-corey


> Regards,
>
> Phil.
>
>>   }
>>   
>> +static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>> +{
>> +    smbus_eeprom_reset(dev);
>> +}
>> +
>>   static Property smbus_eeprom_properties[] = {
>>       DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
>>       DEFINE_PROP_END_OF_LIST(),
>> @@ -126,6 +131,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>>       SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
>>   
>>       dc->realize = smbus_eeprom_realize;
>> +    dc->reset = smbus_eeprom_reset;
>>       sc->receive_byte = eeprom_receive_byte;
>>       sc->write_data = eeprom_write_data;
>>       dc->props = smbus_eeprom_properties;
>>
