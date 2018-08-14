Received: from eggs.gnu.org ([2001:4830:134:3::10]:50582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpZ2t-0004Vq-Sl
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpZ2p-0001PX-Rk
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:07:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpZ2p-0001PL-KG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:07:31 -0400
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
	<20180814115202.GH2580@work-vm>
	<517f613f-3885-7b6f-aff7-cffee9d8f35f@redhat.com>
	<B2D15215269B544CADD246097EACE7473B7345BB@DGGEMM528-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <954665c4-ab5f-6232-6208-19e479d41055@redhat.com>
Date: Tue, 14 Aug 2018 15:07:28 +0200
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473B7345BB@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

On 14/08/2018 15:03, Zhoujian (jay) wrote:
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Tuesday, August 14, 2018 8:02 PM
>> To: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
>> quintela@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>
>> Subject: Re: [RFC PATCH] vl: fix migration when watchdog expires
>>
>> On 14/08/2018 13:52, Dr. David Alan Gilbert wrote:
>>>  a) Should the watchdog expire when the VM is stopped; I think it
>>> shouldn't - hw/acpi/tco.c uses a virtual timer as does i6300esb; so is
>>> the bug here that the watchdog being used didn't use a virtual timer?
>>
>> All watchdogs do.
>>
>>>  b) If the watchdog expires just before the VM gets stopped, is there
>>> a race which could hit this?  Possibly.
>>
>> Yes, I think it is a race that happens just before vm_stop, but I don't
>> understand why the "qemu_clock_enable" in pause_all_vcpus does not prevent it.
> 
> Hi Paolo,
> The sequence is like this I think
> 
>          |
>          |  <-----  watchdog expired, which set reset_requested to SHUTDOWN_CAUSE_GUEST_RESET
>          | 
>          |  <-----  migration thread sets to RUN_STATE_FINISH_MIGRATE, it will disable QEMU_CLOCK_VIRTUAL clock,
>          |          but it is done after the setting of reset_requested

So the fix would be to process the reset request here?  (In do_vm_stop
or pause_all_vcpus).  The code is currently in main_loop_should_exit().

Paolo

>          |  <-----  main loop thread sets to RUN_STATE_PRELAUNCH since it detected a reset request
>          |
>          |  <-----  migration thread sets to RUN_STATE_POSTMIGRATE
> 
> 
> Regards,
> Jay Zhou
> 
>>
>> It should be possible to write a deterministic testcase with qtest...
>>
>> Paolo
