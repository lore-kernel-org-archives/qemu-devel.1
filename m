Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecePQ-0000c4-Fl
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecePN-0003bc-BC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:41:12 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecePN-0003bQ-6T
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 16:41:09 -0500
Received: by mail-qt0-x243.google.com with SMTP id u10so7351545qtg.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 13:41:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-3-f4bug@amsat.org>
	<20180119181548.GL15832@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ef900a89-bb63-00f6-1c0d-0075160cafd9@amsat.org>
Date: Fri, 19 Jan 2018 18:41:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180119181548.GL15832@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] smbus_eeprom: replace
 SMBusDeviceClass::init by DeviceClass::reset
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

On 01/19/2018 03:15 PM, Eduardo Habkost wrote:
> On Tue, Jan 16, 2018 at 10:15:46AM -0300, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/i2c/smbus_eeprom.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index b13ec0fe7a..7e81ae4fe5 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -97,12 +97,11 @@ static uint8_t eeprom_read_data(SMBusDevice *dev, uint8_t cmd, int n)
>>      return eeprom_receive_byte(dev);
>>  }
>>  
>> -static int smbus_eeprom_initfn(SMBusDevice *dev)
>> +static void smbus_eeprom_reset(DeviceState *dev)
>>  {
>>      SMBusEEPROMDevice *eeprom = (SMBusEEPROMDevice *)dev;
>>  
>>      eeprom->offset = 0;
>> -    return 0;
>>  }
>>  
>>  static Property smbus_eeprom_properties[] = {
>> @@ -115,7 +114,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>>      SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(klass);
>>  
>> -    sc->init = smbus_eeprom_initfn;
>> +    dc->reset = smbus_eeprom_reset;
> 
> Trying to track down when each of these methods is called:
> 
> sc->init (SMBusDeviceClass::init)
>  -> called by i2c_slave_qdev_init() (DeviceClass:init)
>    -> called by device_realize() (DeviceClass::realize)
>      -> called by device_set_realized()
>        -> QOM setter for "realized" property
>          -> (multiple callers)
> 
> (eww, so many indirections)
> 
> dc->reset (DeviceClass::reset)
>   -> called by device_reset()
>     -> (multiple callers)
> 
> (much better!)
> 
> 
> It looks like this changes how the device behaves.  Is this
> fixing a device emulation bug?  If not, why should the device set
> offset=0 on DeviceClass::reset, and not DeviceClass::realize?

You right, if this is a device bugfix (which I'm not sure) this is
unrelated to this series, so I'll just drop it.

> 
> 
>>      sc->quick_cmd = eeprom_quick_cmd;
>>      sc->send_byte = eeprom_send_byte;
>>      sc->receive_byte = eeprom_receive_byte;
>> -- 
>> 2.15.1
>>
>>
> 
