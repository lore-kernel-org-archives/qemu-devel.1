Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dajkV-0005Qx-Ei
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dajkS-0002H1-Bh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dajkS-0002Ga-2N
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:26:44 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm>
	<9cea170f-90eb-78e5-6b52-8dd882efd160@redhat.com>
	<20170724190331.GH2127@work-vm>
	<a05bf0cb-77a3-c372-5b9d-d9c15a8bd8a1@redhat.com>
	<20170725191542.GD2820@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <005f7387-d62d-3d51-4289-91184f084255@redhat.com>
Date: Thu, 27 Jul 2017 16:26:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170725191542.GD2820@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, rkrcmar@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On 25/07/2017 21:15, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> On 24/07/2017 21:03, Dr. David Alan Gilbert wrote:
>>>> I don't like having such a long-lived mutex (it seems like a recipe for
>>>> deadlocks with the BQL), plus memory_region_transaction_commit (the
>>>> expensive part of memory_global_dirty_log_stop) needs to be under the
>>>> BQL itself because it calls MemoryListeners.
>>>>
>>>> Maybe memory_global_dirty_log_stop can delay itself to the next vm_start
>>>> if it's called while runstate_running() returns false (which should be
>>>> always the case)?
>>>>
>>>> It could even be entirely enclosed within memory.c if you do it with a
>>>> VMChangeStateHandler.
>>> This still causes the BQL to be held for quite a while; albeit at a less
>>> critical point.
>>>
>>> In this and the existing case we don't actually need efficiency - what we need is just
>>> not to be holding onto the BQL for so long;  could we do a less
>>> efficient commit here, removing one region at a time, yielding the lock
>>> and retaking it?
>>
>> I'm worried that if you release the lock and retake it you open a window
>> where someone else could start a commit, and
>> memory_global_dirty_log_stop's commit would use outdated information.
>>
>> The problem is that a coarse lock, such as the BQL, is very hard to
>> break into another lock with long critical sections (a "memory map
>> commit lock" in this case).  It's obviously very easy to say "the new
>> lock nests inside the BQL"... but then, because you created the lock to
>> move things out of the BQL, any callback inside the new lock cannot take
>> the memory map commit lock, and you need to make entire subsystems
>> thread-safe.  If the new lock nests outside the BQL instead, it's
>> simpler to avoid deadlocks, but you need to be careful about releasing
>> the BQL and any reentrancy implications of doing that.
>>
>> One strategy that worked well so far has been to use two locks, one of
>> them being the BQL, where you can take either lock for reads and both
>> for writes.
> 
> I guess you could say that in the event someone wants to do something
> with the memory map they have to wait for the cleanup to complete?

Yes, you could take pending "invisible" changes (well, toggling dirty
bitmap status is the only invisible change to the guest I guess) and
push those to a separate thread.  That optimization would be in the KVM
memory listener.

Paolo
