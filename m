Received: from eggs.gnu.org ([2001:4830:134:3::10]:39510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6TNK-0003gu-Ur
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 23:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6TNJ-0002QK-ME
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 23:26:02 -0400
MIME-Version: 1.0
In-Reply-To: <20171022184847.xgkhvteu67ajxq3d@starbug-vm.ie.oracle.com>
References: <1508678882-4327-1-git-send-email-sundeep.lkml@gmail.com>
	<20171022184847.xgkhvteu67ajxq3d@starbug-vm.ie.oracle.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 23 Oct 2017 08:56:00 +0530
Message-ID: <CALHRZuoFkPwZ+fwCktKEC=itat0pM78jqzzSeghB+0HA2sMQfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v3 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Darren Kenny <darren.kenny@oracle.com>

Hi Darren,

On Mon, Oct 23, 2017 at 12:18 AM, Darren Kenny <darren.kenny@oracle.com>
wrote:

> On Sun, Oct 22, 2017 at 06:58:02PM +0530, Subbaraya Sundeep wrote:
>
>> Fixed incorrect frame size mask, validated maximum frame
>> size in spi_write and removed dead code.
>>
>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> ---
>> v3:
>>         Added comment that [31:6] bits are reserved in R_SPI_DFSIZE
>>         register and logged incorrect value too in guest error(suggested
>>    by Darren).
>> v2:
>>    else if -> else in set_fifodepth
>>    log guest error when frame size is more than 32
>>
>> hw/ssi/mss-spi.c | 18 ++++++++++++++----
>> 1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
>> index 5a8e308..e1b6227 100644
>> --- a/hw/ssi/mss-spi.c
>> +++ b/hw/ssi/mss-spi.c
>> @@ -76,9 +76,10 @@
>> #define C_BIGFIFO            (1 << 29)
>> #define C_RESET              (1 << 31)
>>
>> -#define FRAMESZ_MASK         0x1F
>> +#define FRAMESZ_MASK         0x3F
>> #define FMCOUNT_MASK         0x00FFFF00
>> #define FMCOUNT_SHIFT        8
>> +#define FRAMESZ_MAX          32
>>
>> static void txfifo_reset(MSSSpiState *s)
>> {
>> @@ -104,10 +105,8 @@ static void set_fifodepth(MSSSpiState *s)
>>         s->fifo_depth = 32;
>>     } else if (size <= 16) {
>>         s->fifo_depth = 16;
>> -    } else if (size <= 32) {
>> -        s->fifo_depth = 8;
>>     } else {
>> -        s->fifo_depth = 4;
>> +        s->fifo_depth = 8;
>>     }
>> }
>>
>> @@ -301,6 +300,17 @@ static void spi_write(void *opaque, hwaddr addr,
>>         if (s->enabled) {
>>             break;
>>         }
>> +        /*
>> +         * [31:6] bits are reserved bits and for future use.
>> +         * [5:0] are for frame size. Only [5:0] bits are validated
>> +         * during write, [31:6] bits are untouched.
>> +         */
>> +        if ((value & FRAMESZ_MASK) > FRAMESZ_MAX) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Incorrect size %d
>> provided."
>> +                         "Maximum frame size is %d\n",
>> +                         __func__, value & FRAMESZ_MASK, FRAMESZ_MAX);
>>
>
> Nitpicking here really, but shouldn't the %d be %u since value is a
> uint32_t?
>
> Ok I will change to %u.

Thanks,
Sundeep


> Thanks,
>
> Darren.
>
>
> +            break;
>> +        }
>>         s->regs[R_SPI_DFSIZE] = value;
>>         break;
>>
>> --
>> 2.5.0
>>
>>
>>
