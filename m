Received: from eggs.gnu.org ([2001:4830:134:3::10]:44845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eN0zE-00061g-2q
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eN0zA-0003al-4S
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:33:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eN0z9-0003aL-RH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAC8C356CD
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 18:33:26 +0000 (UTC)
References: <20171205174100.GD2405@work-vm>
	<90cb3043-cf68-2635-2dd9-f47cf5e8c10e@redhat.com>
	<20171207162547.GD2439@work-vm>
	<ab90f1b2-a360-e89d-32ea-9aebd7a65db3@redhat.com>
	<20171207182348.GF2439@work-vm>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <7c88b2f7-45a3-a470-c458-7266c485befa@redhat.com>
Date: Thu, 7 Dec 2017 19:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171207182348.GF2439@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Hotplug ram and vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, Victor Kaplansky <vkaplans@redhat.com>



On 12/07/2017 07:23 PM, Dr. David Alan Gilbert wrote:
> * Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
>>
>>
>> On 12/07/2017 05:25 PM, Dr. David Alan Gilbert wrote:
>>> * Maxime Coquelin (maxime.coquelin@redhat.com) wrote:
>>>> Hi David,
>>>>
>>>> On 12/05/2017 06:41 PM, Dr. David Alan Gilbert wrote:
>>>>> Hi,
>>>>>      Since I'm reworking the memory map update code I've been
>>>>> trying to test it with hot adding RAM; but even on upstream
>>>>> I'm finding that hot adding RAM causes the guest to stop passing
>>>>> packets with vhost-user-bridge;  have either of you seen the same
>>>>> thing?
>>>>
>>>> No, I have never tried this.
>>>
>>> Would you know if it works on dpdk?
>>
>> We have a known issue in DPDK, the PMD threads might be accessing the
>> guest memory while the vhost-user protocol thread is unmapping it.
>>
>> We have a similar problem with dirty logging area, and Victor is working
>> on a patch that will fix both issues.
>>
>> Once ready, I'll have a try and let you know.
>>
>>>>> I'm doing:
>>>>> ./tests/vhost-user-bridge -u /tmp/vubrsrc.sock
>>>>> $QEMU -enable-kvm -m 1G,maxmem=2G,slots=4 -smp 2 -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -trace events=vhost-trace-file -chardev socket,id=char0,path=/tmp/vubrsrc.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 $IMAGE -net none
>>>>>
>>>>> (with a f27 guest) and then doing:
>>>>> (qemu) object_add memory-backend-file,id=mem1,size=256M,mem-path=/dev/shm
>>>>> (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
>>>>>
>>>>> but then not getting any responses inside the guest.
>>>>>
>>>>> I can see the code sending another set-mem-table with the
>>>>> extra chunk of RAM and fd, and I think I can see the bridge
>>>>> mapping it.
>>>>
>>>> I think there are at least two problems.
>>>> The first one is that vhost-user-bridge does not support vhost-user
>>>> protocol's reply-ack feature. So when QEMU sends the requests, it cannot
>>>> know whether/when it has been handled by the backend.
>>>
>>> Wouldn't you have to be unlucky to cause that a problem - i.e. the
>>> descriptors would have to get allocated in the new RAM?
>>
>> Yes, you may be right. I think it is worth to debug it to understand
>> what is going on.
>>
>>>> It had been fixed by sending a GET_FEATURE requests to be sure the
>>>> SET_MEM_TABLE was handled, as messages are processed in order. The problem
>>>> is that it caused some test failures when using TCG, so it got
>>>> reverted.
>>>>
>>>> The initial fix:
>>>>
>>>> commit 28ed5ef16384f12500abd3647973ee21b03cbe23
>>>> Author: Prerna Saxena <prerna.saxena@nutanix.com>
>>>> Date:   Fri Aug 5 03:53:51 2016 -0700
>>>>
>>>>       vhost-user: Attempt to fix a race with set_mem_table.
>>>>
>>>> The revert:
>>>>
>>>> commit 94c9cb31c04737f86be29afefbff401cd23bc24d
>>>> Author: Michael S. Tsirkin <mst@redhat.com>
>>>> Date:   Mon Aug 15 16:35:24 2016 +0300
>>>>
>>>>       Revert "vhost-user: Attempt to fix a race with set_mem_table."
>>>>
>>>
>>> Do we know which tests fail?
>>
>> vhost-user-test, but it should no more be failing now that it no more
>> uses TCG.
>>
>> I think we could consider reverting the revert. i.e. send get_features
>> in set_mem_table toi be sure it has been handled.
> 
> How does it fail? Does it fail every time or only some times?
> (The postcopy test in migration-test.c also fails under TCG under
> very heavy load and I've not figured out why yet).

I'm trying to remember the analysis I did one year ago... I don't have
yet the full picture, but found some notes I took at that time:

"
I have managed to reproduce the hang by adding some debug prints into
vhost_user_get_features().

Doing this the issue is reproducible quite easily.
Another way to reproduce it in one shot is to strace (with following
forks) /vhost-user-test execution.

So, by adding debug prints at vhost_user_get_features() entry and exit,
we can see we never return from this function when hang happens.
Strace of Qemu instance shows that its thread keeps retrying to receive
GET_FEATURE reply:

write(1, "vhost_user_get_features IN: \n", 29) = 29
sendmsg(11, {msg_name=NULL, msg_namelen=0,
         msg_iov=[{iov_base="\1\0\0\0\1\0\0\0\0\0\0\0", iov_len=12}],
         msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 12
recvmsg(11, {msg_namelen=0}, MSG_CMSG_CLOEXEC) = -1 EAGAIN
nanosleep({0, 100000}, 0x7fff29f8dd70)  = 0
...
recvmsg(11, {msg_namelen=0}, MSG_CMSG_CLOEXEC) = -1 EAGAIN
nanosleep({0, 100000}, 0x7fff29f8dd70)  = 0

The reason is that vhost-user-test never replies to Qemu,
because its thread handling the GET_FEATURES command is waiting for
the s->data_mutex lock.
This lock is held by the other vhost-user-test thread, executing
read_guest_mem().

The lock is never released because the thread is blocked in read
syscall, when read_guest_mem() is doing the readl().

This is because on Qemu side, the thread polling the qtest socket is
waiting for the qemu_global_mutex (in os_host_main_loop_wait()), but
the mutex is held by the thread trying to get the GET_FEATURE reply
(the TCG one).
"

It does not explain why it would only fail with TCG, I would need to
spend some time investigating the issue to find why I claimed this.

Maxime
> Dave
> 
>>>> Another problem is that memory mmapped with previous call does not seems
>>>> to be unmapped, but that should not cause other problems than leaking
>>>> virtual memory.
>>>
>>> Oh, leaks are the least of our problem there!
>>
>> Sure.
>>
>> Maxime
>>> Dave
>>>
>>>> Maxime
>>>>> Dave
>>>>>
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
