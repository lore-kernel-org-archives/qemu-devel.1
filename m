Received: from eggs.gnu.org ([2001:4830:134:3::10]:38173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXT6F-0000uJ-LD
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXT6E-00017a-DG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:08:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-8-f4bug@amsat.org>
	<e98bac2c-ce0b-e226-3d96-004e46478f2f@redhat.com>
	<8256c2d4-722c-299f-e8e3-42c1a7f68e1d@amsat.org>
	<0bf443e6-fd49-9aaf-43fb-f171edf5fd38@redhat.com>
	<57e04a05-442c-bd4a-2daa-1b690540c061@amsat.org>
	<2eab61ba-1220-095d-721b-53357104fb45@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ad2df7b-afa2-8470-6353-facdde6b0587@amsat.org>
Date: Mon, 25 Jun 2018 12:07:52 -0300
MIME-Version: 1.0
In-Reply-To: <2eab61ba-1220-095d-721b-53357104fb45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/14] hw/i2c/omap_i2c: Use
 qemu_log_mask(UNIMP) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 06/25/2018 11:30 AM, Thomas Huth wrote:
> On 25.06.2018 14:52, Philippe Mathieu-Daudé wrote:
>> On 06/25/2018 03:08 AM, Thomas Huth wrote:
>>> On 22.06.2018 22:10, Philippe Mathieu-Daudé wrote:
>>>> On 06/22/2018 04:38 PM, Thomas Huth wrote:
>>>>> On 22.06.2018 15:40, Philippe Mathieu-Daudé wrote:
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>> ---
>>>>>>  hw/i2c/omap_i2c.c | 20 ++++++++++++--------
>>>>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
>>>>>> index 26e3e5ebf6..690876e43e 100644
>>>>>> --- a/hw/i2c/omap_i2c.c
>>>>>> +++ b/hw/i2c/omap_i2c.c
>>>>>> @@ -17,6 +17,7 @@
>>>>>>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>>>>>>   */
>>>>>>  #include "qemu/osdep.h"
>>>>>> +#include "qemu/log.h"
>>>>>>  #include "hw/hw.h"
>>>>>>  #include "hw/i2c/i2c.h"
>>>>>>  #include "hw/arm/omap.h"
>>>>>> @@ -339,14 +340,15 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
>>>>>>              }
>>>>>>              break;
>>>>>>          }
>>>>>> -        if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
>>>>>> -            fprintf(stderr, "%s: I^2C slave mode not supported\n",
>>>>>> -                            __func__);
>>>>>> +        if ((value & (1 << 15)) && !(value & (1 << 10))) { /* MST */
>>>>>
>>>>> Please keep the white spaces before the comment if you don't change
>>>>> anything else.
>>>>
>>>> This is a <tab> and checkpatch complains...
>>>>
>>>> I can use 4 spaces for this tab. I tried to align with other tab-aligned
>>>> comments I didn't modify, but the result is messier. Thus a simple space.
>>>
>>> Oh, sorry, I didn't notice that you've replaced a TAB here. I guess it's
>>> ok then. But why does checkpatch complain if it is just in the context
>>> of your modification? That's weird.
>>
>> The first 2 contexts (MST and XA) are fine, however checkpatch complains
>> with the last one (ST_EN):
>>
>> ERROR: code indent should never use tabs
>> #38: FILE: hw/i2c/omap_i2c.c:397:
>> +        if (value & (1 << 15)) {^I^I^I^I^I/* ST_EN */$
>>
>> Since I replaced this one, I also did with the 2 previous.
>>
>> Now I realize I can _not_ add the brackets so I don't have to update the
>> <tabs>:
>>
>>          if (value & (1 << 15))^I^I^I^I^I/* ST_EN */
>> -            fprintf(stderr, "%s: System Test not supported\n", __func__);
>> +            qemu_log_mask(LOG_UNIMP,
>> +                          "%s: System Test not supported\n", __func__);
>>          break;
>>
>> I think if it better to unify the code style when possible, but it is up
>> to you, if you prefer I can resend with tabs and no brackets.
> 
> I think it's OK to fix up the coding style here, too. Maybe just mention
> it in the patch description ("While we're at it, change TABs to spaces
> and add missing curly braces to the surounding if-statements" or so).

OK. If that's fine with you I won't respin the whole series for this
comment, but if I have to respin for another reason I'll improve the
comment. I kindly learned the lesson for the next time although.

Thanks for the series review,

Phil.
