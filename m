Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQlCn-0003xk-VW
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eQlCk-0007Jg-Ns
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:31:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:5730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eQlCk-0007I3-Ck
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:30:58 -0500
Message-ID: <5A3728DC.3060509@intel.com>
Date: Mon, 18 Dec 2017 10:33:00 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
	<20171215192203.GC27160@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F739387C1D@shsmsx102.ccr.corp.intel.com>
	<20171217221842.GA6683@bombadil.infradead.org>
In-Reply-To: <20171217221842.GA6683@bombadil.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>

On 12/18/2017 06:18 AM, Matthew Wilcox wrote:
> On Sun, Dec 17, 2017 at 01:47:21PM +0000, Wang, Wei W wrote:
>> On Saturday, December 16, 2017 3:22 AM, Matthew Wilcox wrote:
>>> On Fri, Dec 15, 2017 at 10:49:15AM -0800, Matthew Wilcox wrote:
>>>   - xbit_clear() can't return an error.  Neither can xbit_zero().
>> I found the current xbit_clear implementation only returns 0, and there isn't an error to be returned from this function. In this case, is it better to make the function "void"?
> Yes, I think so.
>
> My only qualm is that I've been considering optimising the memory
> consumption when an entire 1024-bit chunk is full; instead of keeping a
> pointer to a 128-byte entry full of ones, store a special value in the
> radix tree which means "every bit is set".
>
> The downside is that we then have to pass GFP flags to xbit_clear() and
> xbit_zero(), and they can fail.  It's not clear to me whether that's a
> good tradeoff.

Yes, this will sacrifice performance. In many usages, users may set bits 
one by one, and each time when a bit is set, it needs to scan the whole 
ida_bitmap to see if all other bits are set, if so, it can free the 
ida_bitmap. I think this extra scanning of the ida_bitmap would add a 
lot overhead.


>
>> Are you suggesting to rename the current xb_ APIs to the above xbit_ names (with parameter changes)?
>>
>> Why would we need xbit_alloc, which looks like ida_get_new, I think set/clear should be adequate to the current usages.
> I'm intending on replacing the xb_ and ida_ implementations with this one.
> It removes the preload API which makes it easier to use, and it handles
> the locking for you.
>
> But I need to get the XArray (which replaces the radix tree) finished first.

OK. It seems the new implementation wouldn't be done shortly.
Other parts of this patch series are close to the end of review, and we 
hope to make some progress soon. Would it be acceptable that we continue 
with the basic xb_ implementation (e.g. as xbitmap 1.0) for this patch 
series? and xbit_ implementation can come as xbitmap 2.0 in the future?

Best,
Wei
