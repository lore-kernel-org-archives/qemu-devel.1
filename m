Received: from eggs.gnu.org ([2001:4830:134:3::10]:45158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytUA-0008UW-AS
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cytU5-0007Vk-CU
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cytU5-0007VH-6R
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 01:09:25 -0400
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<cdce9f8e-ec58-d210-3be2-932359e0dcf7@redhat.com>
	<d684319d-afb7-62ea-8486-80c1bee23744@gmail.com>
	<d59e2de5-959d-0b94-6030-264b2310c9e1@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <474b3e70-8f09-5080-3bf5-f72da04d7080@redhat.com>
Date: Fri, 14 Apr 2017 13:09:16 +0800
MIME-Version: 1.0
In-Reply-To: <d59e2de5-959d-0b94-6030-264b2310c9e1@gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 13/04/2017 16:52, Xiao Guangrong wrote:
> On 04/13/2017 04:39 PM, Xiao Guangrong wrote:
>> On 04/13/2017 02:37 PM, Paolo Bonzini wrote:
>>> However, I think that the above should be exactly how the RTC should
>>> work.  The original RTC circuit had 22 divider stages (see page 13 of
>>> the datasheet[1], at the bottom right), and the periodic interrupt taps
>>> the rising edge of one of the dividers (page 16, second paragraph).  The
>>> datasheet also never mentions a comparator being used to trigger the
>>> periodic interrupts.
>>>
>>
>> That was my thought before, however, after more test, i am not sure if
>> re-configuring RegA changes these divider stages internal...

It's unlikely because there is a separate divider reset command.  But
Hailiang found the same problem, and Bochs does the same implementation
as you.

It's even possible (not sure how likely) that the original MC146818 RTC
had the bug, but recent Super I/O chips fixed it to work around the
problem with Windows.

Thanks,

Paolo

>>> Have you checked that this Windows bug doesn't happen on real hardware
>>> too?  Or is the combination of driftfix=slew and changing periods that
>>> is a problem?
>>>
>>
>> I have two physical windows 7 machines, both of them have
>> 'useplatformclock = off' and ntp disabled, the wall time is really
>> accurate. The difference is that the physical machines are using Intel
>> Q87 LPC chipset which is mc146818rtc compatible. However, on VM, the
>> issue is easily be reproduced just in ~10 mins.
>>
>> Our test mostly focus on 'driftfix=slew' and after this patchset the
>> time is accurate and stable.
>>
>> I will do the test for dropping 'slew' and see what will happen...
>>
> 
> Well, the time is easily observed to be faster if 'driftfix=slew' is
> not used. :(
> 
