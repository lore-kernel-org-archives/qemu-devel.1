Received: from eggs.gnu.org ([2001:4830:134:3::10]:59566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dNb7T-0003gy-TJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dNb7Q-0005Gz-RR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:51087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dNb7Q-0005Dl-Id
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 04:36:08 -0400
Message-ID: <594A307F.1090108@intel.com>
Date: Wed, 21 Jun 2017 16:38:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>	<1497977049.20270.100.camel@redhat.com>	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
In-Reply-To: <1497979740.20270.102.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>

On 06/21/2017 01:29 AM, Rik van Riel wrote:
> On Tue, 2017-06-20 at 18:49 +0200, David Hildenbrand wrote:
>> On 20.06.2017 18:44, Rik van Riel wrote:
>>> Nitesh Lal (on the CC list) is working on a way
>>> to efficiently batch recently freed pages for
>>> free page hinting to the hypervisor.
>>>
>>> If that is done efficiently enough (eg. with
>>> MADV_FREE on the hypervisor side for lazy freeing,
>>> and lazy later re-use of the pages), do we still
>>> need the harder to use batch interface from this
>>> patch?
>>>
>> David's opinion incoming:
>>
>> No, I think proper free page hinting would be the optimum solution,
>> if
>> done right. This would avoid the batch interface and even turn
>> virtio-balloon in some sense useless.
> I agree with that.  Let me go into some more detail of
> what Nitesh is implementing:
>
> 1) In arch_free_page, the being-freed page is added
>     to a per-cpu set of freed pages.

I got some questions here:

1. Are the pages managed one by one on the per-CPU set?
For example, when there are 2 adjacent pages, are they still
put as two nodes on the per-CPU list? or the buddy algorithm
will be re-implemented on the per-CPU list as well?

2. Looks like this will be added to the common free function.
Normally, people may not need the free page hint, do they
need to carry the added burden?


> 2) Once that set is full, arch_free_pages goes into a
>     slow path, which:
>     2a) Iterates over the set of freed pages, and
>     2b) Checks whether they are still free, and

The pages that have been double checked as "free"
pages here and added to the list for the hypervisor can
also be immediately used.


>     2c) Adds the still free pages to a list that is
>         to be passed to the hypervisor, to be MADV_FREEd.
>     2d) Makes that hypercall.
>
> Meanwhile all arch_alloc_pages has to do is make sure it
> does not allocate a page while it is currently being
> MADV_FREEd on the hypervisor side.

Is this proposed to replace the balloon driver?

>
> The code Wei is working on looks like it could be
> suitable for steps (2c) and (2d) above. Nitesh already
> has code for steps 1 through 2b.
>

May I know the advantages of the added steps? Thanks.

Best,
Wei
