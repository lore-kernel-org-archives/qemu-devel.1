Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67OD-0003MJ-Ab
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d67OA-0007qJ-8D
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:25:13 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d67OA-0007pp-2Q
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:25:10 -0400
Received: by mail-pf0-x243.google.com with SMTP id o68so305541pfj.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 20:25:09 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-5-xiaoguangrong@tencent.com>
	<7df8de22-9ee9-00b5-f21b-ad7ec27f63c3@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <132f19ec-7f48-308e-29b1-4ddd1dbb6188@gmail.com>
Date: Thu, 4 May 2017 11:25:11 +0800
MIME-Version: 1.0
In-Reply-To: <7df8de22-9ee9-00b5-f21b-ad7ec27f63c3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] mc146818rtc: move x86 specific code
 out of periodic_timer_update
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



On 05/03/2017 11:39 PM, Paolo Bonzini wrote:
> 
> 
> On 12/04/2017 11:51, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Move the x86 specific code in periodic_timer_update() to a common place,
>> the actual logic is not changed
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   hw/timer/mc146818rtc.c | 112 +++++++++++++++++++++++++++++--------------------
>>   1 file changed, 66 insertions(+), 46 deletions(-)
>>
>> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>> index 3bf559d..d7b7c56 100644
>> --- a/hw/timer/mc146818rtc.c
>> +++ b/hw/timer/mc146818rtc.c
>> @@ -144,6 +144,63 @@ static void rtc_coalesced_timer(void *opaque)
>>   
>>       rtc_coalesced_timer_update(s);
>>   }
>> +
>> +static int64_t
>> +arch_periodic_timer_update(RTCState *s, int period, int64_t lost_clock)
>> +{
>> +    if (period != s->period) {
>> +        int64_t scale_lost_clock;
>> +        int current_irq_coalesced = s->irq_coalesced;
>> +
>> +        s->irq_coalesced = (current_irq_coalesced * s->period) / period;
>> +
>> +        /*
>> +         * calculate the lost clock after it is scaled which should be
>> +         * compensated in the next interrupt.
>> +         */
>> +        scale_lost_clock = current_irq_coalesced * s->period -
>> +                            s->irq_coalesced * period;
>> +        DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, %ld clocks "
>> +                  "are compensated.\n", current_irq_coalesced,
>> +                  s->irq_coalesced, scale_lost_clock);
>> +        lost_clock += scale_lost_clock;
>> +        s->period = period;
> 
> This should be moved up to the caller.

It should not. As you pointed out below, all these code are only needed
for LOST_TICK_POLICY_SLEW that is x86 specific.

Or use "if (s->lost_tick_policy != LOST_TICK_POLICY_SLEW)" without
"#ifdef TARGET_I386" is acceptable as only x86 can make it SLEW,
Unnecessary branch checks will little slow down other architectures,
but i think it is acceptable, right? :)

> 
> Also, if s->lost_tick_policy is not SLEW, s->irq_coalesced on input is
> zero.  So I *think* what you get is equivalent to
> 
>     if (s->lost_tick_policy != LOST_TICK_POLICY_SLEW) {
>         return;
>     }
> 
>     /* ... comment ... */
>     lost_interrupt = (s->irq_coalesced * s->period) / period;
>     lost_clock += (s->irq_coalesced * s->period) % period;
>     lost_interrupt += lost_clock / period;
>     lost_clock %= period;
> 
>     s->irq_coalesced = load_interrupt;
>     rtc_coalesced_timer_update(s);
> 
> or equivalently:
> 
>     lost_clock += s->irq_coalesced * s->period;
> 
>     s->irq_coalesced = lost_clock / period;
>     lost_clock %= period;
>     rtc_coalesced_timer_update(s);
> 

Exactly right, it is much better, will apply it.

> I think you should probably merge these three patches and document the
> resulting logic, because it's simpler than building it a patch at a time.

Okay, i will consider it carefully in the next version.

Thank you, Paolo!
