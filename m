Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKkVe-0004Ee-Kn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKkVa-00018a-2g
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:01:22 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKkVZ-00017b-Fv
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:01:18 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
References: <1497273796-44720-1-git-send-email-jianjay.zhou@huawei.com>
	<20170612195209.GA16151@potion>
Message-ID: <593FD3E0.5070807@huawei.com>
Date: Tue, 13 Jun 2017 20:00:32 +0800
MIME-Version: 1.0
In-Reply-To: <20170612195209.GA16151@potion>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] KVM: X86: save and load
 PVCLOCK_TSC_UNSTABLE_BIT when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com

Hi Radim,

On 2017/6/13 3:52, Radim Krčmář wrote:
> 2017-06-12 21:23+0800, Jay Zhou:
>> Guest using kvmclock will be hanged when migrating from unstable
>> tsc host to stable tsc host occasionally.
>> Sometimes, the tsc timestamp saved at the source side will be
>> backward when the guest stopped, and this value is transferred
>> to the destination side. The guest at the destination side thought
>> kvmclock is stable, so the protection mechanism against time
>> going backwards is not used.
>> When the first time vcpu0 enters the guest at the destination
>> side to update the wall clock, the result of
>> pvclock_clocksource_read will be backward occasionally,
>> which results in the wall clock drift.
>>
>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>> ---
>
> Hm, are you using KVM that has e3fd9a93a12a (4.9+)?

I'm using KVM (4.4.11) and QEMU (2.6.0). I thought the newest KVM
and QEMU have the same problem, maybe I'm wrong.

>
> If you get a timestamp from KVM_GET_CLOCK() and pass that to
> KVM_SET_CLOCK(), then kvmclock should not jump backwards anymore
> (it could before 4.9, but only if the host had stable tsc).

If migrating from old KVMs to newer KVMs (v4.9+), the clock member
of struct KVMClockState is migrated to the destination side, but the
clock_is_reliable isn't migrated. The value of clock_is_reliable is false
at the source side, and it is true at the destination side. Is it possible
the clock member of struct KVMClockState migrated is smaller than the
last_value saved in the guest theoretically? Could you explain more
why it should not jump backwards in the scenario of migrating from unstable tsc 
host to stable tsc host?

>
> A possible source of this bug in when QEMU recomputes the timestamp to
> pass to KVM_SET_CLOCK() using TSC and kvmclock page.

Yes, this bug happened in this scenario in my tests.

>
> Can you provide the values used for KVM_GET_CLOCK and KVM_SET_CLOCK when
> the bug occurs?

I didn't print these values out when the bug occured, and I do not have the 
physical machine with unstable tsc clocksource now. But I will try to reproduce 
with the newest KVM and QEMU once I have.


Regards,
Jay Zhou
