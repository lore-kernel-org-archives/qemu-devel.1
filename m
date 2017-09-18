Received: from eggs.gnu.org ([2001:4830:134:3::10]:49536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtwwi-0004fx-AC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtwwd-0006Rw-AR
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:22:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
	<1505494753-10837-3-git-send-email-sundeep.lkml@gmail.com>
	<2c6a4136-fb80-2000-940c-1df5e718cbf1@amsat.org>
	<CALHRZurRLysJCRwvm+SbJUn8YBAst_Q38RCzJkmT4z=mfnYuiQ@mail.gmail.com>
	<CALHRZurNLqH_6Xbh9SKtCA0fuk-CFEZeqBMwYXV=+UaZB4k1Bg@mail.gmail.com>
	<CAFEAcA-BQ=ognSsb3Kxx5ThJ5Q_GA_sFFFofpKY1=XnRS4-WTA@mail.gmail.com>
	<6947945c-6b04-dce0-9010-b3350df0f151@amsat.org>
	<CAFEAcA8yHmZBgudTbW7S6eoObYE_O=CP3YjfL7g7GGip=wsjaA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1abcfaca-3af0-efcf-d577-c3c5cb39e8fe@amsat.org>
Date: Mon, 18 Sep 2017 11:22:28 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yHmZBgudTbW7S6eoObYE_O=CP3YjfL7g7GGip=wsjaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: sundeep subbaraya <sundeep.lkml@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 09/18/2017 11:00 AM, Peter Maydell wrote:
> On 18 September 2017 at 14:58, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Peter,
>>
>> On 09/18/2017 10:36 AM, Peter Maydell wrote:
>>>
>>> On 18 September 2017 at 14:27, sundeep subbaraya <sundeep.lkml@gmail.com>
>>> wrote:
>>>>>>
>>>>>> Hi Sundeep, Peter,
>>>>>>
>>>>>>
>>>>>> On 09/15/2017 01:59 PM, Subbaraya Sundeep wrote:
>>>>>>>
>>>>>>>
>>>>>>> +static void msf2_sysreg_write(void *opaque, hwaddr offset,
>>>>>>> +                          uint64_t val, unsigned size)
>>>>>>> +{
>>>>>>> +    MSF2SysregState *s = opaque;
>>>>>>> +    uint32_t newval = val;
>>>>>>> +
>>>>>>> +    offset >>= 2;
>>>>>>> +
>>>>>>> +    switch (offset) {
>>>>>>> +    case MSSDDR_PLL_STATUS:
>>>>>>> +        trace_msf2_sysreg_write_pll_status();
>>>>>>> +        break;
>>>>>>> +
>>>>>>> +    case ESRAM_CR:
>>>>>>> +    case DDR_CR:
>>>>>>> +    case ENVM_REMAP_BASE_CR:
>>>>>>> +        if (newval != s->regs[offset]) {
>>>>>>> +            qemu_log_mask(LOG_UNIMP,
>>>>>>> +                       TYPE_MSF2_SYSREG": remapping not
>>>>>>> supported\n");
>>>>>>
>>>>>>
>>>>>>
>>>>>> I'd rather exit here than continue with inconsistent cpu, Peter what do
>>>>>> you recommend?
>>>>
>>>>
>>>>
>>>> Could you please suggest.
>>>
>>>
>>> We shouldn't exit QEMU for something the guest can provoke. If
>>> the functionality isn't implemented then just LOG_UNIMP it.
>>
>>
>> This was commented here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg02971.html
>>
>> Guest remapping code is like non-return function. Hardware error here can
>> not happen, so there is no more guest code after a remap request.
>> Continuing running QEMU will lead to chaos, that's why I recommend aborting
>> instead of just LOG_UNIMP it.
> 
> There's lots of stuff that can cause the guest to go badly
> and confusingly wrong if unimplemented. If we print a
> useful message with LOG_UNIMP then there's an easy clue
> for what's gone wrong. The guest shouldn't be able to
> provoke QEMU to exit.

I understand. I'm worried about being PITA for an user to figure out 
what's happening here, that's why I'm wondering how this should be 
handled. Another idea I thought about was raising a PREFETCH or BKPT 
exception, but this would also be an incorrect model behavior.

Anyway I'd be happy enough if instead of using LOG_UNIMP/LOG_GUEST_ERROR 
we use an unconditional qemu_log("bus remap unimplemented, unpredictable 
behaviour!") warning. Fair enough?

Regards,

Phil.
