Received: from eggs.gnu.org ([208.118.235.92]:51368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gefkw-0000OZ-CF
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gefkp-0003fN-6g
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:36:16 -0500
Date: Wed, 2 Jan 2019 13:36:04 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190102040900.GL27457@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.9999.1901021306120.78010@zero.eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<fc40f941cf84750609e1093eca98fd9248a0981e.1546394798.git.balaton@eik.bme.hu>
	<20190102040900.GL27457@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 1/8] smbus: Add a helper to generate SPD
 EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 2 Jan 2019, David Gibson wrote:
> On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
>> There are several boards with SPD EEPROMs that are now using
>> duplicated or slightly different hard coded data. Add a helper to
>> generate SPD data for a memory module of given type and size that
>> could be used by these boards (either as is or with further changes if
>> needed) which should help cleaning this up and avoid further duplication.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/i2c/smbus_eeprom.c  | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/i2c/smbus.h |   3 ++
>>  2 files changed, 131 insertions(+)
>>
>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>> index f18aa3de35..a1f51eb921 100644
>> --- a/hw/i2c/smbus_eeprom.c
>> +++ b/hw/i2c/smbus_eeprom.c
>> @@ -23,6 +23,8 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/units.h"
>>  #include "hw/hw.h"
>>  #include "hw/i2c/i2c.h"
>>  #include "hw/i2c/smbus.h"
>> @@ -162,3 +164,129 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>>          smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
>>      }
>>  }
>> +
>> +/* Generate SDRAM SPD EEPROM data describing a module of type and size */
>> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
>> +{
>> +    uint8_t *spd;
>> +    uint8_t nbanks;
>> +    uint16_t density;
>> +    uint32_t size;
>> +    int min_log2, max_log2, sz_log2;
>> +    int i;
>> +
>> +    switch (type) {
>> +    case SDR:
>> +        min_log2 = 2;
>> +        max_log2 = 9;
>> +        break;
>> +    case DDR:
>> +        min_log2 = 5;
>> +        max_log2 = 12;
>> +        break;
>> +    case DDR2:
>> +        min_log2 = 7;
>> +        max_log2 = 14;
>> +        break;
>> +    default:
>> +        error_report("Unknown SDRAM type");
>> +        abort();
>
> The error handling might work a little cleaner if you give this
> function an Error ** parameter, then just pass in &error_abort from
> the callers.

Good idea but I'm not sure it's needed. This is the only fatal error here 
(apart from g_malloc0 failing which should also abort) and in practice 
this could only happen if a caller specifies wrong type which is quite 
unlikely given that it's an enum so value outside of that would fail to 
compile with a warning (promoted to error by default). So this default 
case is only really here to please the compiler.

>> +    }
>> +    size = ram_size >> 20; /* work in terms of megabytes */
>> +    if (size < 4) {
>> +        error_report("SDRAM size is too small");
>> +        return NULL;
>> +    }
>> +    sz_log2 = 31 - clz32(size);
>> +    size = 1U << sz_log2;
>> +    if (ram_size > size * MiB) {
>> +        warn_report("SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, "
>> +                    "truncating to %u MB", ram_size, size);
>> +    }
>> +    if (sz_log2 < min_log2) {
>> +        warn_report("Memory size is too small for SDRAM type, adjusting type");
>> +        if (size >= 32) {
>> +            type = DDR;
>> +            min_log2 = 5;
>> +            max_log2 = 12;
>> +        } else {
>> +            type = SDR;
>> +            min_log2 = 2;
>> +            max_log2 = 9;
>> +        }
>
> What do these various fall back cases represent?  Are they bugs in the
> callers, or a user configuration error?

The memory size is given by the user so it can be a config error (like 
when board has DDR2 but user sets memory size to 64MB).

> If the first, we should just assert or abort.  If the second I think
> we should still die with a fatal error - allowing broken
> configurations to work with just a warning is kind of begging to
> maintain nasty compatiliby cruft in the future.

I'd leave that to the caller to decide and not abort in this function. It 
will warn user that config is unexpected for the board but does not 
prevent it and try to give something that might still work (e.g. DDR 
instead of DDR2). Then the caller can check the returned data and abort if 
it insists that only DDR2 will work for the machine. Otherwise we'd make 
it impossible to use non-standard memory sizes for cases when it would 
still work (like when the OS does not check SPD EEPROMs and would happily 
use whatever memory size). I think it's already possible to start machines 
with odd memory sizes so that's not new and I did not want to prevent this 
if SPD EEPROMs are added (just SPD can't describe all memory in that 
case which may only be a problem for firmware but not when directly 
booting a kernel for example).

The idea of this function is to generate some data to start from instead 
of the static data some boards now have. which is often sufficient for the 
board as is but it could be checked or modified further to fit the 
specific needs of the board. As those needs can be widely different I did 
not attempt to handle all of them in this function to keep it generic.

Regards,
BALATON Zoltan
