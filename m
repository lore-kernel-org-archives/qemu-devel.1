Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dZyPP-00083B-1d
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dZyPL-0002qm-VU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:53:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dZyPL-0002qc-M9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:53:47 -0400
Message-ID: <597731E8.9040803@intel.com>
Date: Tue, 25 Jul 2017 19:56:24 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz>
	<596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz>
In-Reply-To: <20170725112513.GD26723@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 07/25/2017 07:25 PM, Michal Hocko wrote:
> On Tue 25-07-17 17:32:00, Wei Wang wrote:
>> On 07/24/2017 05:00 PM, Michal Hocko wrote:
>>> On Wed 19-07-17 20:01:18, Wei Wang wrote:
>>>> On 07/19/2017 04:13 PM, Michal Hocko wrote:
>>> [...
>>>>> All you should need is the check for the page reference count, no?  I
>>>>> assume you do some sort of pfn walk and so you should be able to get an
>>>>> access to the struct page.
>>>> Not necessarily - the guest struct page is not seen by the hypervisor. The
>>>> hypervisor only gets those guest pfns which are hinted as unused. From the
>>>> hypervisor (host) point of view, a guest physical address corresponds to a
>>>> virtual address of a host process. So, once the hypervisor knows a guest
>>>> physical page is unsued, it knows that the corresponding virtual memory of
>>>> the process doesn't need to be transferred in the 1st round.
>>> I am sorry, but I do not understand. Why cannot _guest_ simply check the
>>> struct page ref count and send them to the hypervisor?
>> Were you suggesting the following?
>> 1) get a free page block from the page list using the API;
> No. Use a pfn walk, check the reference count and skip those pages which
> have 0 ref count.


"pfn walk" - do you mean start from the first pfn, and scan all the pfns 
that the VM has?


> I suspected that you need to do some sort of the pfn
> walk anyway because you somehow have to evaluate a memory to migrate,
> right?


We don't need to do the pfn walk in the guest kernel. When the API 
reports, for example,
a 2MB free page block, the API caller offers to the hypervisor the base 
address of the page
block, and size=2MB, to the hypervisor.

The hypervisor maintains a bitmap of all the guest physical memory (a 
bit corresponds to
a guest pfn). When migrating memory, only the pfns that are set in the 
bitmap are transferred
to the destination machine. So, when the hypervisor receives a 2MB free 
page block, the
corresponding bits in the bitmap are cleared.

Best,
Wei
