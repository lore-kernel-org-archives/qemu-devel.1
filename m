Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6WkV-00016U-Hk
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6WkS-0004g6-Bz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:29:55 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d6WkS-0004ff-2p
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:29:52 -0400
Received: by mail-pf0-x243.google.com with SMTP id d1so4929954pfe.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 23:29:51 -0700 (PDT)
References: <20170504115948.3048-1-xiaoguangrong@tencent.com>
	<20170504115948.3048-3-xiaoguangrong@tencent.com>
	<1bdc4c8a-b07a-dd3a-af9a-1718623fcc2e@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <519c43f6-d9fd-cafc-4569-a1020ff08e3a@gmail.com>
Date: Fri, 5 May 2017 14:29:53 +0800
MIME-Version: 1.0
In-Reply-To: <1bdc4c8a-b07a-dd3a-af9a-1718623fcc2e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] mc146818rtc: precisely count the
 clock for periodic timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/04/2017 08:31 PM, Paolo Bonzini wrote:
> 
> 
> On 04/05/2017 13:59, guangrong.xiao@gmail.com wrote:
>> From: Tai Yunfang <yunfangtai@tencent.com>
>>
>> There are two issues in current code:
>> 1) If the period is changed by re-configuring RegA, the coalesced
>>     irq will be scaled to reflect the new period, however, it
>>     calculates the new interrupt number like this:
>>      s->irq_coalesced = (s->irq_coalesced * s->period) / period;
>>
>>     There are some clocks will be lost if they are not enough to
>>     be squeezed to a single new period that will cause the VM clock
>>     slower
>>
>>     In order to fix the issue, we calculate the interrupt window
>>     based on the precise clock rather than period, then the clocks
>>     lost during period is scaled can be compensated properly
>>
>> 2) If periodic_timer_update() is called due to RegA reconfiguration,
>>     i.e, the period is updated, current time is not the start point
>>     for the next periodic timer, instead, which should start from the
>>     last interrupt, otherwise, the clock in VM will become slow
>>
>>     This patch takes the clocks from last interrupt to current clock
>>     into account and compensates the clocks for the next interrupt,
>>     especially，if a complete interrupt was lost in this window, the
>>     time can be caught up by LOST_TICK_POLICY_SLEW
>>
>> [ Xiao: redesign the algorithm based on Yunfang's original work. ]
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> Signed-off-by: Tai Yunfang <yunfangtai@tencent.com>
>> ---
>>   hw/timer/mc146818rtc.c | 116 ++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 96 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 5cccb2a..14bde1a 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -146,31 +146,104 @@ static void rtc_coalesced_timer(void *opaque)
>>   }
>>   #endif
>>   
>> -/* handle periodic timer */
>> -static void periodic_timer_update(RTCState *s, int64_t current_time)
>> +static int period_code_to_clock(int period_code)
>> +{
>> +    /* periodic timer is disabled. */
>> +    if (!period_code) {
>> +        return 0;
>> +    }
>> +
>> +    if (period_code <= 2) {
>> +        period_code += 7;
>> +    }
>> +
>> +    /* period in 32 Khz cycles */
>> +    return 1 << (period_code - 1);
>> +}
>> +
>> +/*
>> + * handle periodic timer. @old_period indicates the periodic timer update
>> + * is just due to period adjustment.
>> + */
>> +static void
>> +periodic_timer_update(RTCState *s, int64_t current_time, int old_period)
> 
> We need old_period to distinguish reconfiguration from interrupts ("if
> (old_period)" below), but it can be a bool.  Instead of passing the old
> period value, we can use s->period which is
> period_code_to_clock(old_period).
> 
> That is, just do
> 
>      old_period = s->period;
>      s->period = rtc_periodic_clock_ticks(s);
> 
>      /*
>       * if the periodic timer's update is due to period re-configuration,
>       * the clock should count since last interrupt.
>       */
>      if (s->period != 0) {
>          ...
>          if (!from_interrupt) {
>          }
>          ...
>      }
> 
> where rtc_periodic_clock_ticks takes into account both regA and regB,
> returning the result in 32 kHZ ticks.
> 
>>   {
>>       int period_code, period;
>> -    int64_t cur_clock, next_irq_clock;
>> +    int64_t cur_clock, next_irq_clock, lost_clock = 0;
>>   
>>       period_code = s->cmos_data[RTC_REG_A] & 0x0f;
>>       if (period_code != 0
>>           && (s->cmos_data[RTC_REG_B] & REG_B_PIE)) {
>> -        if (period_code <= 2)
>> -            period_code += 7;
>> -        /* period in 32 Khz cycles */
>> -        period = 1 << (period_code - 1);
>> -#ifdef TARGET_I386
>> -        if (period != s->period) {
>> -            s->irq_coalesced = (s->irq_coalesced * s->period) / period;
>> -            DPRINTF_C("cmos: coalesced irqs scaled to %d\n", s->irq_coalesced);
>> -        }
>> -        s->period = period;
>> -#endif
>> +        period = period_code_to_clock(period_code);
> 
> 
> Since we have old_period, we can assign s->period here.
> 
>>           /* compute 32 khz clock */
>>           cur_clock =
>>               muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>>   
>> -        next_irq_clock = (cur_clock & ~(period - 1)) + period;
>> +        /*
>> +        * if the periodic timer's update is due to period re-configuration,
>> +        * we should count the clock since last interrupt.
>> +        */
>> +        if (old_period) {
>> +            int64_t last_periodic_clock;
>> +
>> +            last_periodic_clock = muldiv64(s->next_periodic_time,
>> +                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
>> +            /*
>> +             * if the next interrupt has not happened yet, we recall the last
>> +             * interrupt based on the original period.
>> +             */
>> +            if (last_periodic_clock > cur_clock) {
>> +                last_periodic_clock -= period_code_to_clock(old_period);
> 
> This becomes "last_periodic_clock -= old_period".
> 
> But, I'm not sure how it can happen that last_periodic_clock <=
> cur_clock.  More precisely, if it happened, you have lost a tick and you
> should add it to s->irq_coalesced it below.  The simplest way to do it,
> is to *always* do the subtraction.
> 

Yes, i agree with you.

> 
>> +
>> +                /* the last interrupt must have happened. */
>> +                assert(cur_clock >= last_periodic_clock);
>> +            }
>> +
>> +            /* calculate the clock since last interrupt. */
>> +            lost_clock = cur_clock - last_periodic_clock;
>> +        }
> 
> I think the "assert(lost_clock >= 0)" should be here.  Then you can also
> remove the "the last interrupt must have happened" assertion, since the
> two test exactly the same formula:
> 
> 	lost_clock >= 0
> 	cur_clock - last_periodic_clock >= 0
> 	cur_clock >= last_periodic_clock.
> 
> Putting everything together, this becomes:
> 
> 	if (!from_interrupt) {

the lost-clock needs to be adjusted only for the enable-to-enable case,
i.e, if the periodic_timer is changed from disabled to enabled, nothing
need to be compensated.

So i am going to change this if statement to:
	if (reconfig && old_period) {
		......
         }

>              int64_t next_periodic_clock, last_periodic_clock;
> 
>              next_periodic_clock = muldiv64(s->next_periodic_time,
>                                      RTC_CLOCK_RATE,
> 				    NANOSECONDS_PER_SECOND);
> 	    last_periodic_clock = next_periodic_clock - old_period;
> 	    lost_clock = cur_clock - last_periodic_clock;
> 	    assert(lost_clock >= 0);
> 	}
> 
> 	if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
> 	    ...
> 	} else {
> 	    lost_clock = MIN(lost_clock, s->period);
> 	}
> 	assert(lost_clock >= 0 && lost_clock < s->period);

All of you suggestions look nice to me and very elaborate, however,
there is a issue that you use s->period on all platforms, in the
current code, only x86 is using it. So that will break live migration
between two !x86 VMs if one applied this pathset, another one does not.

If do not object, i will keep the old_period part in this patchset
and apply all you other suggestions. :)

Thanks!
