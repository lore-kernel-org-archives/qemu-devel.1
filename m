Received: from eggs.gnu.org ([2001:4830:134:3::10]:33461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlcH-0003Ja-BO
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKlcB-0002kb-P8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:49:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKlc9-0002fM-L1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:48:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so1537984wmb.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:48:56 -0800 (PST)
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-3-minyard@acm.org>
	<98b1f2e3-bf71-24a2-f339-9fd63b40d26f@redhat.com>
	<CAFEAcA85HTT-yTmL8Fu1uxbtWLdHVZiQS2PcJim45s65GPob5g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c98444f-b42e-938c-f30b-f701f84f0da7@redhat.com>
Date: Thu, 8 Nov 2018 15:48:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85HTT-yTmL8Fu1uxbtWLdHVZiQS2PcJim45s65GPob5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] i2c: Add an SMBus vmstate structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corey Minyard <minyard@acm.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 8/11/18 15:40, Peter Maydell wrote:
> On 8 November 2018 at 14:23, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> Hi Corey,
>>
>>
>> On 7/11/18 16:54, minyard@acm.org wrote:
>>>
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> There is no vmstate handling for SMBus, so no device sitting on SMBus
>>> can have a state transfer that works reliable.  So add it.
>>>
>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>    hw/i2c/smbus.c         | 14 ++++++++++++++
>>>    include/hw/i2c/smbus.h | 18 +++++++++++++++---
>>>    2 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
>>> index 6ff77c582f..b0774d7683 100644
>>> --- a/hw/i2c/smbus.c
>>> +++ b/hw/i2c/smbus.c
>>> @@ -349,6 +349,20 @@ int smbus_write_block(I2CBus *bus, uint8_t addr,
>>> uint8_t command, uint8_t *data,
>>>        return 0;
>>>    }
>>>    +const VMStateDescription vmstate_smbus_device = {
>>> +    .name = TYPE_SMBUS_DEVICE,
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .fields      = (VMStateField[]) {
>>> +        VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
>>> +        VMSTATE_INT32(mode, SMBusDevice),
>>> +        VMSTATE_INT32(data_len, SMBusDevice),
>>> +        VMSTATE_UINT8_ARRAY(data_buf, SMBusDevice, SMBUS_DATA_MAX_LEN),
>>> +        VMSTATE_UINT8(command, SMBusDevice),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>    static void smbus_device_class_init(ObjectClass *klass, void *data)
>>>    {
>>>        I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
>>> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
>>> index d8b1b9ee81..7b52020121 100644
>>> --- a/include/hw/i2c/smbus.h
>>> +++ b/include/hw/i2c/smbus.h
>>> @@ -53,14 +53,16 @@ typedef struct SMBusDeviceClass
>>>        uint8_t (*read_data)(SMBusDevice *dev, uint8_t cmd, int n);
>>>    } SMBusDeviceClass;
>>>    +#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
>>> +
>>>    struct SMBusDevice {
>>>        /* The SMBus protocol is implemented on top of I2C.  */
>>>        I2CSlave i2c;
>>>          /* Remaining fields for internal use only.  */
>>> -    int mode;
>>> -    int data_len;
>>> -    uint8_t data_buf[34]; /* command + len + 32 bytes of data.  */
>>> +    int32_t mode;
>>> +    int32_t data_len;
>>> +    uint8_t data_buf[SMBUS_DATA_MAX_LEN];
>>
>>
>> Those changes are not in your commit description.
>> Can you include them in a separate patch?
> 
> These are just the standard "promote types in the state struct
> to fixed-width ones required by the VMSTATE macros", aren't
> they? I think they're fine as part of the vmstate conversion.

Fine then!

> 
> thanks
> -- PMM
> 
