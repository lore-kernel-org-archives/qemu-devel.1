Received: from eggs.gnu.org ([2001:4830:134:3::10]:35718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gSphC-0001YI-71
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gSph6-0005JI-8P
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:47:30 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gSph4-00054w-2s
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:47:22 -0500
Received: by mail-oi1-x244.google.com with SMTP id i6so5874103oia.6
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 12:47:21 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181126200435.23408-1-minyard@acm.org>
	<20181126200435.23408-16-minyard@acm.org>
	<CAFEAcA8OuW0o5KmGLPuQB149yXowdb=8DyW5oe1yfjE4H--sPg@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <874bc3cf-825f-7fc5-efed-a39acf1789fa@acm.org>
Date: Fri, 30 Nov 2018 14:47:17 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OuW0o5KmGLPuQB149yXowdb=8DyW5oe1yfjE4H--sPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v3 15/16] hw/i2c/smbus_eeprom: Create at
 most SMBUS_EEPROM_MAX EEPROMs on a SMBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 11/30/18 11:39 AM, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 20:04, <minyard@acm.org> wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Calling smbus_eeprom_init() with more than 8 EEPROMs would lead to a
>> heap overflow.
>> Replace the '8' magic number by a definition, and check no more than
>> this number are created.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/i2c/smbus_eeprom.c         | 13 +++++++++++--
>>   include/hw/i2c/smbus_eeprom.h |  4 +++-
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index 942057dc10..a0dcadbd60 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -23,6 +23,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "hw/hw.h"
>>   #include "hw/boards.h"
>>   #include "hw/i2c/i2c.h"
>> @@ -157,12 +158,20 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
>>       qdev_init_nofail(dev);
>>   }
>>
>> -void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>> +void smbus_eeprom_init(I2CBus *smbus, unsigned int nb_eeprom,
>>                          const uint8_t *eeprom_spd, int eeprom_spd_size)
>>   {
>>       int i;
>> +    uint8_t *eeprom_buf;
>> +
>> +    if (nb_eeprom > SMBUS_EEPROM_MAX) {
>> +        error_report("At most %u EEPROM are supported on a SMBus.",
>> +                     SMBUS_EEPROM_MAX);
>> +        exit(1);
> You could also just assert(), since this would be a
> QEMU bug (all callers use fixed values for this argument).

I'm fine either way.  Philippe?


>> +    }
>> +
>>        /* XXX: make this persistent */
>> -    uint8_t *eeprom_buf = g_malloc0(8 * SMBUS_EEPROM_SIZE);
>> +    eeprom_buf = g_malloc0(nb_eeprom * SMBUS_EEPROM_SIZE);
> So if we allocate N buffers as the caller requests, what
> is the thing that means that more than 8 won't work ?
>
> We've now changed from allocating always 8 lots of
> the EEPROM size to possibly allocating fewer than that.
> How does the code in the device know what the size
> of the buffer we're passing as the "data" property is
> now? We don't pass it the number of EEPROMs as a property.

It doesn't have to.  Each EEPROM is 256 bytes and that's all the data
it has.

But this whole thing is confusing, I agree.  The more I look at this
particular file, the less I like it.  But the caller is basically saying:
"I need N EEPROMs, here's the initialization data".  That's not
really very flexible, IMHO the EEPROM devices should be created
individually using standard qemu methods.

I'm tempted to rewrite this whole thing to make it cleaner.

-corey

>>       if (eeprom_spd_size > 0) {
>>           memcpy(eeprom_buf, eeprom_spd, eeprom_spd_size);
>>       }
>> diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
>> index 46fb1a37d6..8436200599 100644
>> --- a/include/hw/i2c/smbus_eeprom.h
>> +++ b/include/hw/i2c/smbus_eeprom.h
>> @@ -25,8 +25,10 @@
>>
>>   #include "hw/i2c/i2c.h"
>>
>> +#define SMBUS_EEPROM_MAX 8
>> +
>>   void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
>> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
>> +void smbus_eeprom_init(I2CBus *bus, unsigned int nb_eeprom,
>>                          const uint8_t *eeprom_spd, int size);
> thanks
> -- PMM
