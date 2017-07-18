Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dXHxM-0000ol-1T
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dXHxI-0006Td-Qx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:09:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:64223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dXHxI-0006Sn-Fd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:09:44 -0400
Message-ID: <596D6E7E.4070700@intel.com>
Date: Tue, 18 Jul 2017 10:12:14 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
In-Reply-To: <20170717152448.GN12888@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 6/8] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Hocko <mhocko@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 07/17/2017 11:24 PM, Michal Hocko wrote:
> On Fri 14-07-17 22:17:13, Michael S. Tsirkin wrote:
>> On Fri, Jul 14, 2017 at 02:30:23PM +0200, Michal Hocko wrote:
>>> On Wed 12-07-17 20:40:19, Wei Wang wrote:
>>>> This patch adds support for reporting blocks of pages on the free list
>>>> specified by the caller.
>>>>
>>>> As pages can leave the free list during this call or immediately
>>>> afterwards, they are not guaranteed to be free after the function
>>>> returns. The only guarantee this makes is that the page was on the free
>>>> list at some point in time after the function has been invoked.
>>>>
>>>> Therefore, it is not safe for caller to use any pages on the returned
>>>> block or to discard data that is put there after the function returns.
>>>> However, it is safe for caller to discard data that was in one of these
>>>> pages before the function was invoked.
>>> I do not understand what is the point of such a function and how it is
>>> used because the patch doesn't give us any user (I haven't checked other
>>> patches yet).
>>>
>>> But just from the semantic point of view this sounds like a horrible
>>> idea. The only way to get a free block of pages is to call the page
>>> allocator. I am tempted to give it Nack right on those grounds but I
>>> would like to hear more about what you actually want to achieve.
>> Basically it's a performance hint to the hypervisor.
>> For example, these pages would be good candidates to
>> move around as they are not mapped into any running
>> applications.
>>
>> As such, it's important not to slow down other parts of the system too
>> much - otherwise we are speeding up one part of the system while we slow
>> down other parts of it, which is why it's trying to drop the lock as
>> soon a possible.


Probably I should have included the introduction of the usages in
the log. Hope it is not too later to explain here:

Live migration needs to transfer the VM's memory from the source
machine to the destination round by round. For the 1st round, all the VM's
memory is transferred. From the 2nd round, only the pieces of memory
that were written by the guest (after the 1st round) are transferred. One
method that is popularly used by the hypervisor to track which part of
memory is written is to write-protect all the guest memory.

This patch enables the optimization of the 1st round memory transfer -
the hypervisor can skip the transfer of guest unused pages in the 1st round.
It is not concerned that the memory pages are used after they are given to
the hypervisor as a hint of the unused pages, because they will be tracked
by the hypervisor and transferred in the next round if they are used and
written.


> So why cannot you simply allocate those page and then do whatever you
> need. You can tell the page allocator to do only a lightweight
> allocation by the gfp_mask - e.g. GFP_NOWAIT or if you even do not want
> to risk kswapd intervening then 0 mask.


Here are the 2 reasons that we can't get the hint of unused pages by 
allocating
them:

1) It's expected that live migration shouldn't affect the things running 
inside
the VM - take away all the free pages from the guest would greatly slow 
down the
activities inside guest (e.g. the network transmission may be stuck due 
to the lack of
sk_buf).

2) The hint of free pages are used to optimize the 1st round memory 
transfer, so the hint
is expect to be gotten by the hypervisor as quick as possible. Depending 
on the memory
size of the guest, allocation of all the free memory would be too long 
for the case.

Hope it clarifies the use case.


>> As long as hypervisor does not assume it can drop these pages, and as
>> long it's correct in most cases.  we are OK even if the hint is slightly
>> wrong because hypervisor notifications are racing with allocations.
> But the page could have been reused anytime after the lock is dropped
> and you cannot check for that except for elevating the reference count.

As also introduced above, the hypervisor uses a dirty page logging mechanism
to track which memory page is written by the guest when live migration 
begins.


Best,
Wei
