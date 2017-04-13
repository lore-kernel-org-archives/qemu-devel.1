Received: from eggs.gnu.org ([2001:4830:134:3::10]:57491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyaUx-0004Jd-Es
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cyaUu-0008Qb-7r
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:53:03 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cyaUu-0008QS-0h
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 04:53:00 -0400
Received: by mail-pf0-x241.google.com with SMTP id a188so9553981pfa.2
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 01:52:59 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<cdce9f8e-ec58-d210-3be2-932359e0dcf7@redhat.com>
	<d684319d-afb7-62ea-8486-80c1bee23744@gmail.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <d59e2de5-959d-0b94-6030-264b2310c9e1@gmail.com>
Date: Thu, 13 Apr 2017 16:52:55 +0800
MIME-Version: 1.0
In-Reply-To: <d684319d-afb7-62ea-8486-80c1bee23744@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] mc146818rtc: fix Windows VM clock
 faster
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



On 04/13/2017 04:39 PM, Xiao Guangrong wrote:
>
>
> On 04/13/2017 02:37 PM, Paolo Bonzini wrote:
>>
>>
>> On 12/04/2017 17:51, guangrong.xiao@gmail.com wrote:
>>> The root cause is that the clock will be lost if the periodic period is
>>> changed as currently code counts the next periodic time like this:
>>>       next_irq_clock = (cur_clock & ~(period - 1)) + period;
>>>
>>> consider the case if cur_clock = 0x11FF and period = 0x100, then the
>>> next_irq_clock is 0x1200, however, there is only 1 clock left to trigger
>>> the next irq. Unfortunately, Windows guests (at least Windows7) change
>>> the period very frequently if it runs the attached code, so that the
>>> lost clock is accumulated, the wall-time become faster and faster
>>
>> Very interesting.
>>
>
> Yes, indeed.
>
>> However, I think that the above should be exactly how the RTC should
>> work.  The original RTC circuit had 22 divider stages (see page 13 of
>> the datasheet[1], at the bottom right), and the periodic interrupt taps
>> the rising edge of one of the dividers (page 16, second paragraph).  The
>> datasheet also never mentions a comparator being used to trigger the
>> periodic interrupts.
>>
>
> That was my thought before, however, after more test, i am not sure if
> re-configuring RegA changes these divider stages internal...
>
>> Have you checked that this Windows bug doesn't happen on real hardware
>> too?  Or is the combination of driftfix=slew and changing periods that
>> is a problem?
>>
>
> I have two physical windows 7 machines, both of them have
> 'useplatformclock = off' and ntp disabled, the wall time is really
> accurate. The difference is that the physical machines are using Intel
> Q87 LPC chipset which is mc146818rtc compatible. However, on VM, the
> issue is easily be reproduced just in ~10 mins.
>
> Our test mostly focus on 'driftfix=slew' and after this patchset the
> time is accurate and stable.
>
> I will do the test for dropping 'slew' and see what will happen...
>

Well, the time is easily observed to be faster if 'driftfix=slew' is
not used. :(
