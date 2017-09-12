Received: from eggs.gnu.org ([2001:4830:134:3::10]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1drl7e-0006UM-Cl
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1drl7Y-0002Oe-8l
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:21:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:11625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1drl7Y-0002N6-0o
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:20:56 -0400
Message-ID: <59B7DFED.6060502@intel.com>
Date: Tue, 12 Sep 2017 21:23:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-2-git-send-email-wei.w.wang@intel.com>
	<20170911125455.GA32538@bombadil.infradead.org>
In-Reply-To: <20170911125455.GA32538@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 1/5] lib/xbitmap: Introduce xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 09/11/2017 08:54 PM, Matthew Wilcox wrote:
> On Mon, Aug 28, 2017 at 06:08:29PM +0800, Wei Wang wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> The eXtensible Bitmap is a sparse bitmap representation which is
>> efficient for set bits which tend to cluster.  It supports up to
>> 'unsigned long' worth of bits, and this commit adds the bare bones --
>> xb_set_bit(), xb_clear_bit() and xb_test_bit().
>>
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
> This is quite naughty of you.  You've modified the xbitmap implementation
> without any indication in the changelog that you did so.

This was changed in the previous version and included in that
v13->v14 ChangeLog: https://lkml.org/lkml/2017/8/16/923


> I don't
> think the modifications you made are an improvement, but without any
> argumentation from you I don't know why you think they're an improvement.

Probably it shouldn't be modified when the discussion is incomplete:
https://lkml.org/lkml/2017/8/10/36
Sorry about that. Hope we could get more feedback from you on the
changes later.

If you want, we can continue this part from the the v13 patch, which might
be closer to the implementation that you like: 
https://lkml.org/lkml/2017/8/3/60

>> diff --git a/lib/xbitmap.c b/lib/xbitmap.c
>> new file mode 100644
>> index 0000000..8c55296
>> --- /dev/null
>> +++ b/lib/xbitmap.c
>> @@ -0,0 +1,176 @@
>> +#include <linux/slab.h>
>> +#include <linux/xbitmap.h>
>> +
>> +/*
>> + * The xbitmap implementation supports up to ULONG_MAX bits, and it is
>> + * implemented based on ida bitmaps. So, given an unsigned long index,
>> + * the high order XB_INDEX_BITS bits of the index is used to find the
>> + * corresponding item (i.e. ida bitmap) from the radix tree, and the low
>> + * order (i.e. ilog2(IDA_BITMAP_BITS)) bits of the index are indexed into
>> + * the ida bitmap to find the bit.
>> + */
>> +#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
>> +#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
>> +					      RADIX_TREE_MAP_SHIFT))
>> +#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)
> I don't understand why you moved the xb_preload code here from the
> radix tree.  I want all the code which touches the preload implementation
> together in one place, which is the radix tree.

Based on the previous comments (put all the code to lib/xbitmap.c) and your
comment here, I will move xb_preload() and the above Macro to radix-tree.c,
while leaving the rest in xbitmap.c.

Would this be something you expected? Or would you like to move all back
to radix-tree.c like that in v13?


Best,
Wei
