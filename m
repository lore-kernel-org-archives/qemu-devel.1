Received: from eggs.gnu.org ([2001:4830:134:3::10]:46851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZwVU-0002U7-QI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZwVQ-00019A-Ru
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZwVQ-00018i-II
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:51:56 -0400
References: <201707251729027333495@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <45f7d0bd-2102-972b-0cd8-0a8dfcbd9c57@redhat.com>
Date: Tue, 25 Jul 2017 11:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <201707251729027333495@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows
 vmstartup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: liu.yi24@zte.com.cn, qemu-devel@nongnu.org, mst@redhat.com

On 25/07/2017 11:29, peng.hao2@zte.com.cn wrote:
>>On 25/07/2017 06:14, peng.hao2@zte.com.cn wrote:
> 
>>>> On 24/07/2017 20:35, Peng Hao wrote:
>>> 
>>> 
>>> 
>>> 
>>> 
>>>>> When a windows vm starts, periodic timer of rtc will stop several times.
>>>>> windows kernel will check whether REG_A_UIP is changed. REG_C's interrupt
>>>>> flags will not be cleared when periodic timer stops and the update timer
>>>>> will switch to alarm timer. So the expiration time of alarm timer is very
>>>>> long and REG_A_UIP will not vary.At last windows kernel will repeat to 
>>>>> check REG_A_UIP all the time.
>>> 
>>>> This should not happen.  REG_A_UIP is set and cleared in register A
>>>> every second, like this:
>>>>        case RTC_REG_A:
>>>>            if (update_in_progress(s)) {
>>>>                s->cmos_data[s->cmos_index] |= REG_A_UIP
>>>>            } else {
>>>>                s->cmos_data[s->cmos_index] &= ~REG_A_UIP
>>>>            }
>>>>            ret = s->cmos_data[s->cmos_index]
>>>>            break
>>> 
>>> 
>>> 
>>> when periodic timer stop, update timer is set to a long expire time (as alarm timer).
> 
>>I think I see the bug now:
> 
>>diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
>>index 1b8d3d7d4c..6184b4378e 100644
>>--- a/hw/timer/mc146818rtc.c
>>+++ b/hw/timer/mc146818rtc.c
>>@@ -321,9 +321,11 @@ static void check_update_timer(RTCState *s)
>>     s->next_alarm_time = next_update_time +
>>                          (next_alarm_sec - 1) * NANOSECONDS_PER_SECOND;
>> 
>>-    if (s->cmos_data[RTC_REG_C] & REG_C_UF) {
>>-        /* UF is set, but AF is clear.  Program the timer to target
>>-         * the alarm time.  */
>>+    if ((s->cmos_data[RTC_REG_C] & REG_C_UF) &&
>>+        !(s->cmos_data[RTC_REG_A] & REG_A_UIP)) {
>>+        /* If UIP was latched, we need to clear it at the next update.
>>+         * Otherwise, if UF is set we only need to program the timer to
>>+         * target the alarm time.  */
>>         next_update_time = s->next_alarm_time;
>>     }
>>     if (next_update_time != timer_expire_time_ns(s->update_timer)) {
>>
>>but I would like to have a testcase for it in tests/rtc-test.c.
>>Can you check if the above works and try writing a testcase (that fails 
>>without the patch and succeeds with it)?
>>Thanks,
> 
> I don't  think it can works.

Have you tested it?

> REG_C_UF is totally cleared by periodic timer in original code.
> after periodic timer stoped, the REG_C_UF  is never cleared.

Your patch cleared REG_C_UF, but you have not said why the actual
hardware would clear REG_C_UF (it wouldn't).

> rtc_update_timer has cleared REG_A_UIP,I think  the patch  does nothing.
> 
> I reproduce the bug when many windows VMs reboot and it is about the
> method of  windows kernel accessing rtc .
> 
> so i don't know how to write the testcase.

First of all you have to describe the exact sequence of register
accesses that causes the problem.  I can help you writing the testcase,
but your changes to the device model must reflect the actual behavior of
the hardware.

Paolo
