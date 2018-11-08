Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlUQ-0001Pg-EF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKlUK-0001AZ-KM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:40:58 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKlUK-00018K-5Z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:40:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id q1so18352267otk.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:40:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <98b1f2e3-bf71-24a2-f339-9fd63b40d26f@redhat.com>
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-3-minyard@acm.org>
	<98b1f2e3-bf71-24a2-f339-9fd63b40d26f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 14:40:30 +0000
Message-ID: <CAFEAcA85HTT-yTmL8Fu1uxbtWLdHVZiQS2PcJim45s65GPob5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] i2c: Add an SMBus vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Corey Minyard <minyard@acm.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 8 November 2018 at 14:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Hi Corey,
>
>
> On 7/11/18 16:54, minyard@acm.org wrote:
>>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> There is no vmstate handling for SMBus, so no device sitting on SMBus
>> can have a state transfer that works reliable.  So add it.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/i2c/smbus.c         | 14 ++++++++++++++
>>   include/hw/i2c/smbus.h | 18 +++++++++++++++---
>>   2 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
>> index 6ff77c582f..b0774d7683 100644
>> --- a/hw/i2c/smbus.c
>> +++ b/hw/i2c/smbus.c
>> @@ -349,6 +349,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr,
>> uint8_t command, uint8_t *data,
>>       return 0;
>>   }
>>   +const VMStateDescription vmstate_smbus_device =3D {
>> +    .name =3D TYPE_SMBUS_DEVICE,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields      =3D (VMStateField[]) {
>> +        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
>> +        VMSTATE_INT32(mode, SMBusDevice),
>> +        VMSTATE_INT32(data_len, SMBusDevice),
>> +        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
>> +        VMSTATE_UINT8(command, SMBusDevice),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void smbus_device_class_init(ObjectClass *klass, void *data)
>>   {
>>       I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
>> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
>> index d8b1b9ee81..7b52020121 100644
>> --- a/include/hw/i2c/smbus.h
>> +++ b/include/hw/i2c/smbus.h
>> @@ -53,14 +53,16 @@ typedef struct SMBusDeviceClass
>>       uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
>>   } SMBusDeviceClass;
>>   +#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  =
*/
>> +
>>   struct SMBusDevice {
>>       /* The SMBus protocol is implemented on top of I2C.  */
>>       I2CSlave i2c;
>>         /* Remaining fields for internal use only.  */
>> -    int mode;
>> -    int data_len;
>> -    uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
>> +    int32_t mode;
>> +    int32_t data_len;
>> +    uint8_t data_buf[SMBUS_DATA_MAX_LEN];
>
>
> Those changes are not in your commit description.
> Can you include them in a separate patch?

These are just the standard "promote types in the state struct
to fixed-width ones required by the VMSTATE macros", aren't
they? I think they're fine as part of the vmstate conversion.

thanks
-- PMM
