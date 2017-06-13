Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKm4i-0008O7-Oy
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKm4f-00046g-LU
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:41:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dKm4f-00044e-1G
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:41:37 -0400
References: <1497274251-26448-1-git-send-email-jianjay.zhou@huawei.com>
	<20170612200315.GB16151@potion>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <593FEB6C.9060405@huawei.com>
Date: Tue, 13 Jun 2017 21:41:00 +0800
MIME-Version: 1.0
In-Reply-To: <20170612200315.GB16151@potion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH RFC] migration: kvmclock: save and load the
 PVCLOCK_TSC_UNSTABLE_BIT flag when migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, arei.gonglei@huawei.com

Hi Radim,

On 2017/6/13 4:03, Radim Krčmář wrote:
> 2017-06-12 21:30+0800, Jay Zhou:
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
>> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
>>
>>       if (running) {
>>           struct kvm_clock_data data = {};
>> +        uint8_t flags_at_migration;
>>
>>           /*
>>            * If the host where s->clock was read did not support reliable
>>            * KVM_GET_CLOCK, read kvmclock value from memory.
>>            */
>>           if (!s->clock_is_reliable) {
>
> 'clock_is_reliable = true' on all newer KVMs (v4.9+), so I don't see a
> reason to add a feature that can't be used.

After rereading the codes, yes, I agree. Sorry to disturb.

>
>> -            uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
>> +            uint64_t pvclock_via_mem = kvmclock_current_nsec(s,
>> +                                                    &flags_at_migration);
>
> kvmclock_current_nsec() was introduced to work around the problem with
> backward time, so we should understand why it returns a time that is
> backwards if we want to do something for old KVMs ...
>
> Is pvclock_via_mem < s->clock?

Please see the other thread I replied to you when the bug occured.


Regards,
Jay Zhou
