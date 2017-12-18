Received: from eggs.gnu.org ([2001:4830:134:3::10]:52659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQqOW-0006mM-RH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQqOT-0002b6-P0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:03:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:5711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQqOT-0002Z4-Ff
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 03:03:25 -0500
Message-ID: <5A3776C8.1040801@intel.com>
Date: Mon, 18 Dec 2017 16:05:28 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <5A34F193.5040700@intel.com>	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>	<5A35FF89.8040500@intel.com>	<201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>	<286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
	<201712180016.GHD34301.MQOLOFFJHOVFtS@I-love.SAKURA.ne.jp>
In-Reply-To: <201712180016.GHD34301.MQOLOFFJHOVFtS@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On 12/17/2017 11:16 PM, Tetsuo Handa wrote:
> Wang, Wei W wrote:
>>> Wei Wang wrote:
>>>>> But passing GFP_NOWAIT means that we can handle allocation failure.
>>>>> There is no need to use preload approach when we can handle allocation failure.
>>>> I think the reason we need xb_preload is because radix tree insertion
>>>> needs the memory being preallocated already (it couldn't suffer from
>>>> memory failure during the process of inserting, probably because
>>>> handling the failure there isn't easy, Matthew may know the backstory
>>>> of
>>>> this)
>>> According to https://lwn.net/Articles/175432/ , I think that preloading is
>>> needed only when failure to insert an item into a radix tree is a significant
>>> problem.
>>> That is, when failure to insert an item into a radix tree is not a problem, I
>>> think that we don't need to use preloading.
>> It also mentions that the preload attempts to allocate sufficient memory to *guarantee* that the next radix tree insertion cannot fail.
>>
>> If we check radix_tree_node_alloc(), the comments there says "this assumes that the caller has performed appropriate preallocation".
> If you read what radix_tree_node_alloc() is doing, you will find that
> radix_tree_node_alloc() returns NULL when memory allocation failed.
>
> I think that "this assumes that the caller has performed appropriate preallocation"
> means "The caller has to perform appropriate preallocation if the caller does not
> want radix_tree_node_alloc() to return NULL".

For the radix tree, I agree that we may not need preload. But 
ida_bitmap, which the xbitmap is based on, is allocated via preload, so 
I think we cannot bypass preload, otherwise, we get no ida_bitmap to use.

Best,
Wei
