Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZu6P-0002tw-D9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZu6K-0002ZO-C2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:17:57 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZu6K-0002Z3-5r
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:17:52 -0400
Received: by mail-wm0-f43.google.com with SMTP id t201so37457282wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 00:17:52 -0700 (PDT)
References: <201707251214058120036@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <713ce91f-d163-8607-ea39-673317b70eed@redhat.com>
Date: Tue, 25 Jul 2017 09:17:44 +0200
MIME-Version: 1.0
In-Reply-To: <201707251214058120036@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows vm
 startup
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

On 25/07/2017 06:14, peng.hao2@zte.com.cn wrote:
>> On 24/07/2017 20:35, Peng Hao wrote:
> 
> 
> 
> 
> 
>>> When a windows vm starts, periodic timer of rtc will stop several times.
>>> windows kernel will check whether REG_A_UIP is changed. REG_C's interrupt
>>> flags will not be cleared when periodic timer stops and the update timer
>>> will switch to alarm timer. So the expiration time of alarm timer is very
>>> long and REG_A_UIP will not vary.At last windows kernel will repeat to 
>>> check REG_A_UIP all the time.
> 
>> This should not happen.  REG_A_UIP is set and cleared in register A
>> every second, like this:
>>        case RTC_REG_A:
> 
>>            if (update_in_progress(s)) {
>>                s->cmos_data[s->cmos_index] |= REG_A_UIP
>>            } else {
>>                s->cmos_data[s->cmos_index] &= ~REG_A_UIP
>>            }
>>            ret = s->cmos_data[s->cmos_index]
>>            break
> 
> 
> 
> when periodic timer stop, update timer is set to a long expire time (as alarm timer).

I think I see the bug now:

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 1b8d3d7d4c..6184b4378e 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -321,9 +321,11 @@ static void check_update_timer(RTCState *s)
     s->next_alarm_time = next_update_time +
                          (next_alarm_sec - 1) * NANOSECONDS_PER_SECOND;
 
-    if (s->cmos_data[RTC_REG_C] & REG_C_UF) {
-        /* UF is set, but AF is clear.  Program the timer to target
-         * the alarm time.  */
+    if ((s->cmos_data[RTC_REG_C] & REG_C_UF) &&
+        !(s->cmos_data[RTC_REG_A] & REG_A_UIP)) {
+        /* If UIP was latched, we need to clear it at the next update.
+         * Otherwise, if UF is set we only need to program the timer to
+         * target the alarm time.  */
         next_update_time = s->next_alarm_time;
     }
     if (next_update_time != timer_expire_time_ns(s->update_timer)) {


but I would like to have a testcase for it in tests/rtc-test.c.

Can you check if the above works and try writing a testcase (that fails 
without the patch and succeeds with it)?

Thanks,

Paolo
