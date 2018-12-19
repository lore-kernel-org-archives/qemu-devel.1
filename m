Received: from eggs.gnu.org ([2001:4830:134:3::10]:40078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gZgxP-0001he-Qw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gZgxI-0006ui-Cl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:52:35 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gZgxI-0006px-6A
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:52:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id t204so2459498oie.7
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:52:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-15-minyard@acm.org>
	<20181129132939.GH2333@work-vm>
From: Corey Minyard <minyard@acm.org>
Message-ID: <64256efc-d0e4-1828-bf67-81c46984f387@acm.org>
Date: Wed, 19 Dec 2018 12:52:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181129132939.GH2333@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v3 14/16] i2c:smbus_eeprom: Add vmstate
 handling to the smbus eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 11/29/18 7:29 AM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Transfer the state of the EEPROM on a migration.  This way the
>> data remains consistent on migration.
>>
>> This required moving the actual data to a separate array and
>> using the data provided in the init function as a separate
>> initialization array, since a pointer property has to be a
>> void * and the array needs to be uint8_t[].
> So I think I'm OK with this, but I'd like other peoples comments as
> well; see comments.


Well, no comments so far.

I have a question on this.  If this particular device were modified to 
be able
to support different size eeproms, would this need a new version of the
vmstate structure?  I know the vmstate structure itself would have to
change to have an array size, but would it have to change in such a
way that the array size would need to be transmitted?

I ask because someday, someone might need an eeprom of a different
size, and it would be nice if it could be done now in a way that avoided
creating a new version.

Thanks,

-corey

>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/i2c/smbus_eeprom.c | 34 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 8e9b734c09..942057dc10 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -24,6 +24,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "hw/hw.h"
>> +#include "hw/boards.h"
>>   #include "hw/i2c/i2c.h"
>>   #include "hw/i2c/smbus_slave.h"
>>   #include "hw/i2c/smbus_eeprom.h"
>> @@ -39,8 +40,10 @@
>>   
>>   typedef struct SMBusEEPROMDevice {
>>       SMBusDevice smbusdev;
>> -    void *data;
>> +    uint8_t data[SMBUS_EEPROM_SIZE];
>> +    void *init_data;
>>       uint8_t offset;
>> +    bool accessed;
>>   } SMBusEEPROMDevice;
>>   
>>   static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>> @@ -49,6 +52,7 @@ static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>>       uint8_t *data = eeprom->data;
>>       uint8_t val = data[eeprom->offset++];
>>   
>> +    eeprom->accessed = true;
>>   #ifdef DEBUG
>>       printf("eeprom_receive_byte: addr=0x%02x val=0x%02x\n",
>>              dev->i2c.address, val);
>> @@ -61,6 +65,7 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>>       SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>>       uint8_t *data = eeprom->data;
>>   
>> +    eeprom->accessed = true;
>>   #ifdef DEBUG
>>       printf("eeprom_write_byte: addr=0x%02x cmd=0x%02x val=0x%02x\n",
>>              dev->i2c.address, cmd, buf[0]);
>> @@ -78,15 +83,39 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
>>       return 0;
>>   }
>>   
>> +static bool smbus_eeprom_vmstate_needed(void *opaque)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>> +    SMBusEEPROMDevice *eeprom = opaque;
>> +
>> +    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev)) &&
>> +        !mc->smbus_no_migration_support;
> That's a little complx, but OK.
>
>> +}
>> +
>> +static const VMStateDescription vmstate_smbus_eeprom = {
>> +    .name = "smbus-eeprom",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = smbus_eeprom_vmstate_needed,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
>> +        VMSTATE_UINT8_ARRAY(data, SMBusEEPROMDevice, SMBUS_EEPROM_SIZE),
>> +        VMSTATE_UINT8(offset, SMBusEEPROMDevice),
>> +        VMSTATE_BOOL(accessed, SMBusEEPROMDevice),
> OK, good - including 'accessed' means that if we migrate a->b->c and
> it's not changed while it's on b, then 'c' still gets the updated
> version.
>
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>>   {
>>       SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
>>   
>> +    memcpy(eeprom->data, eeprom->init_data, SMBUS_EEPROM_SIZE);
>>       eeprom->offset = 0;
>>   }
>>   
>>   static Property smbus_eeprom_properties[] = {
>> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, data),
>> +    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> @@ -99,6 +128,7 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>>       sc->receive_byte = eeprom_receive_byte;
>>       sc->write_data = eeprom_write_data;
>>       dc->props = smbus_eeprom_properties;
>> +    dc->vmsd = &vmstate_smbus_eeprom;
>>       /* Reason: pointer property "data" */
>>       dc->user_creatable = false;
>>   }
> so from migration side:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> -- 
>> 2.17.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
