Received: from eggs.gnu.org ([2001:4830:134:3::10]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFzh0-0000sT-Fo
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFzgu-0008PN-PM
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:50:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFzgs-0008KR-HF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:50:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so848577wru.9
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 03:50:03 -0700 (PDT)
References: <20181025133301.16578-1-ehabkost@redhat.com>
	<20181025133301.16578-6-ehabkost@redhat.com>
	<20181025171759.GG2697@umbus.hotspot.internet-for-guests.com>
	<20181026082741.GK4096@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6112ad64-267d-16d1-abe5-cdaed3981a95@redhat.com>
Date: Fri, 26 Oct 2018 12:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <20181026082741.GK4096@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 05/43] hw/timer/sun4v-rtc: Convert from
 DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 26/10/18 10:27, Eduardo Habkost wrote:
> On Thu, Oct 25, 2018 at 06:17:59PM +0100, David Gibson wrote:
>> On Thu, Oct 25, 2018 at 10:32:23AM -0300, Eduardo Habkost wrote:
>>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> Message-Id: <20181002212522.23303-3-f4bug@amsat.org>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>   hw/timer/sun4v-rtc.c  | 13 +++----------
>>>   hw/timer/trace-events |  4 ++++
>>>   2 files changed, 7 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
>>> index 310523225f..13be94f8da 100644
>>> --- a/hw/timer/sun4v-rtc.c
>>> +++ b/hw/timer/sun4v-rtc.c
>>> @@ -14,15 +14,8 @@
>>>   #include "hw/sysbus.h"
>>>   #include "qemu/timer.h"
>>>   #include "hw/timer/sun4v-rtc.h"
>>> +#include "trace.h"
>>>   
>>> -//#define DEBUG_SUN4V_RTC
>>> -
>>> -#ifdef DEBUG_SUN4V_RTC
>>> -#define DPRINTF(fmt, ...)                                       \
>>> -    do { printf("sun4v_rtc: " fmt , ## __VA_ARGS__); } while (0)
>>> -#else
>>> -#define DPRINTF(fmt, ...) do {} while (0)
>>> -#endif
>>>   
>>>   #define TYPE_SUN4V_RTC "sun4v_rtc"
>>>   #define SUN4V_RTC(obj) OBJECT_CHECK(Sun4vRtc, (obj), TYPE_SUN4V_RTC)
>>> @@ -41,14 +34,14 @@ static uint64_t sun4v_rtc_read(void *opaque, hwaddr addr,
>>>           /* accessing the high 32 bits */
>>>           val >>= 32;
>>>       }
>>> -    DPRINTF("read from " TARGET_FMT_plx " val %lx\n", addr, val);
>>> +    trace_sun4v_rtc_read(addr, val);
>>>       return val;
>>>   }
>>>   
>>>   static void sun4v_rtc_write(void *opaque, hwaddr addr,
>>>                                uint64_t val, unsigned size)
>>>   {
>>> -    DPRINTF("write 0x%x to " TARGET_FMT_plx "\n", (unsigned)val, addr);
>>> +    trace_sun4v_rtc_read(addr, val);
>>
>> Uh.. as in v1, it looks like this should be trace_sun4v_rtc_write().
> 
> Oops, my bad.  I can fix this manually in case there's a v3 pull
> request, but I would really prefer that to be included in a
> follow up patch instead of making this block the entire pull
> request.

Oops sorry... I noticed you fixed that in 605be3a8c0, thanks!

Regards,

Phil.
