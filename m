Received: from eggs.gnu.org ([2001:4830:134:3::10]:39184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1cyb9x-0007Yf-Qa
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiaoguangrong.eric@gmail.com>) id 1cyb9t-000778-TA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:35:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiaoguangrong.eric@gmail.com>)
	id 1cyb9t-00076y-Kj
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:35:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id a188so9780867pfa.2
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 02:35:21 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<cdce9f8e-ec58-d210-3be2-932359e0dcf7@redhat.com>
	<d684319d-afb7-62ea-8486-80c1bee23744@gmail.com>
	<d59e2de5-959d-0b94-6030-264b2310c9e1@gmail.com>
	<D1BD20B5DB34024DA951CEEE6C4C5998ADA414FF@DGGEMA501-MBX.china.huawei.com>
	<418f9ca3-09a9-e40c-e15b-9498036f0b12@gmail.com>
	<58EF4512.1060004@huawei.com>
From: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Message-ID: <e596b57f-6f75-f872-1ac7-e83e8b3339bd@gmail.com>
Date: Thu, 13 Apr 2017 17:35:17 +0800
MIME-Version: 1.0
In-Reply-To: <58EF4512.1060004@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBbUEFUQ0ggMC81XSBtYzE0NjgxOHJ0?=
 =?utf-8?q?c=3A_fix_Windows_VM_clock_faster?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: xuquan8@huawei.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "yunfangtai@tencent.com" <yunfangtai@tencent.com>, Xiao Guangrong <xiaoguangrong@tencent.com>



On 04/13/2017 05:29 PM, Hailiang Zhang wrote:
> On 2017/4/13 17:18, Xiao Guangrong wrote:
>>
>> On 04/13/2017 05:05 PM, Zhanghailiang wrote:
>>> Hi,
>>>
>>> -----邮件原件-----
>>> 发件人: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
>>> 代表 Xiao Guangrong
>>> 发送时间: 2017年4月13日 16:53
>>> 收件人: Paolo Bonzini; mst@redhat.com; mtosatti@redhat.com
>>> 抄送: qemu-devel@nongnu.org; kvm@vger.kernel.org;
>>> yunfangtai@tencent.com; Xiao Guangrong
>>> 主题: Re: [PATCH 0/5] mc146818rtc: fix Windows VM clock faster
>>>
>>>
>>>
>>> On 04/13/2017 04:39 PM, Xiao Guangrong wrote:
>>>>
>>>> On 04/13/2017 02:37 PM, Paolo Bonzini wrote:
>>>>>
>>>>> On 12/04/2017 17:51, guangrong.xiao@gmail.com wrote:
>>>>>> The root cause is that the clock will be lost if the periodic period
>>>>>> is changed as currently code counts the next periodic time like this:
>>>>>>        next_irq_clock = (cur_clock & ~(period - 1)) + period;
>>>>>>
>>>>>> consider the case if cur_clock = 0x11FF and period = 0x100, then the
>>>>>> next_irq_clock is 0x1200, however, there is only 1 clock left to
>>>>>> trigger the next irq. Unfortunately, Windows guests (at least
>>>>>> Windows7) change the period very frequently if it runs the attached
>>>>>> code, so that the lost clock is accumulated, the wall-time become
>>>>>> faster and faster
>>>>> Very interesting.
>>>>>
>>>> Yes, indeed.
>>>>
>>>>> However, I think that the above should be exactly how the RTC should
>>>>> work.  The original RTC circuit had 22 divider stages (see page 13 of
>>>>> the datasheet[1], at the bottom right), and the periodic interrupt
>>>>> taps the rising edge of one of the dividers (page 16, second
>>>>> paragraph).  The datasheet also never mentions a comparator being
>>>>> used to trigger the periodic interrupts.
>>>>>
>>>> That was my thought before, however, after more test, i am not sure if
>>>> re-configuring RegA changes these divider stages internal...
>>>>
>>>>> Have you checked that this Windows bug doesn't happen on real
>>>>> hardware too?  Or is the combination of driftfix=slew and changing
>>>>> periods that is a problem?
>>>>>
>>>> I have two physical windows 7 machines, both of them have
>>>> 'useplatformclock = off' and ntp disabled, the wall time is really
>>>> accurate. The difference is that the physical machines are using Intel
>>>> Q87 LPC chipset which is mc146818rtc compatible. However, on VM, the
>>>> issue is easily be reproduced just in ~10 mins.
>>>>
>>>> Our test mostly focus on 'driftfix=slew' and after this patchset the
>>>> time is accurate and stable.
>>>>
>>>> I will do the test for dropping 'slew' and see what will happen...
>>>>
>>>> Well, the time is easily observed to be faster if 'driftfix=slew' is
>>>> not used. :(
>>> You mean, it only fixes the one case which with the ' driftfix=slew '
>>> is used ?
>> No. for both.
>>
>>> We encountered this problem too, I have tried to fix it long time ago.
>>> https://lists.gnu.org/archive/html/qemu-devel/2016-03/msg06937.html.
>>> (It seems that your solution is more useful)
>>> But it seems that it is impossible to fix, we need to emulate the
>>> behaviors of real hardware,
>>> but we didn't find any clear description about it. And it seems that
>>> other virtualization platforms
>> That is the issue, the hardware spec does not detail how the clock is
>> counted when the timer interval is changed. What we can do at this time
>> is that speculate it from the behaviors. Current RTC is completely
>> unusable anyway.
>>
>>
>>> have this problem too:
>>> VMware:
>>> https://www.vmware.com/files/pdf/Timekeeping-In-VirtualMachines.pdf
>>> Heper-v:
>>> https://blogs.msdn.microsoft.com/virtual_pc_guy/2010/11/19/time-synchronization-in-hyper-v/
>>>
>> Hmm, slower clock is understandable, does really the Windows7 on hyperV
>> have faster clock? Did you meet it?
>
> I don't know, we didn't test it, besides, I'd like to know how long did
> your testcase run before
> you judge it is stable with 'driftfix=slew'  option? (My previous patch
> can't fix it completely but
> only narrows the gap between timer in guest and real timer.)

More than 12 hours.
