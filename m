Received: from eggs.gnu.org ([2001:4830:134:3::10]:32940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1dBsXU-0007aV-NP
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1dBsXR-0006aj-J4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:46:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1dBsXR-0006Zt-06
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:46:33 -0400
References: <36fcce23-2fd2-961a-80b4-c5cb152c7233@huawei.com>
	<b4e2b09b-0fb8-5b71-066e-b1aa50ab45f9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA2A0BA6@DGGEMA505-MBS.china.huawei.com>
	<3a2982aa-cbd8-9e0d-9095-4e88d6a84107@redhat.com>
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <579f175c-c5e6-2db9-7705-2c0194cfa2f0@huawei.com>
Date: Sat, 20 May 2017 08:46:08 +0800
MIME-Version: 1.0
In-Reply-To: <3a2982aa-cbd8-9e0d-9095-4e88d6a84107@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Migration downtime more than 5s when migrating
 guest with massive disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Huangzhichao <huangzhichao@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, imhy.yang@gmail.com



On 2017/5/20 0:46, Paolo Bonzini wrote:
> 
> 
> On 19/05/2017 14:17, Gonglei (Arei) wrote:
>>> It would.  Right now memory_region_transaction_commit() is roughly
>>> O(n^2) (n devices * n BARs), and there are n of them.
>>>
>>> Reducing memory_region_transaction_commit to O(n) would be a large
>>> change.  One idea is to share the AddressSpaceDispatch for AddressSpaces
>>> that have the same root memory region (after resolving aliases).  The
>>> starting point would be to change mem_begin/mem_commit/mem_add from a
>>> MemoryListener to an loop on the FlatView, storing the
>>> AddressSpaceDispatch in the FlatView.
>>>
>> How about do O(1) for stopping stage of live migration? 
>> Because the cpu is stopped in this phase, it wouldn't cause
>> side effects IMHO, right? 
> 
> O(1) update is probably not quite possible, but it's possible to do one
> O(n) update.  We tried doing that, but something in virtio broke.

How were you do that? did you put extra begin/commit before/after destination
guest load, so that the destination guest only do one update(of n devs) throughout
the whole migration?

>  I
> don't remember the details.
> 
> Paolo
> 

-- 
Thanks,
Yang
