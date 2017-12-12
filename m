Received: from eggs.gnu.org ([2001:4830:134:3::10]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eOkXv-0000Mn-Tf
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eOkXX-0006n2-PZ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:24:31 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:63131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eOkXX-0005i3-6z
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 08:24:07 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
Message-Id: <201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
Date: Tue, 12 Dec 2017 22:20:48 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> +void xb_clear_bit_range(struct xb *xb, unsigned long start, unsigned long end)
> +{
> +	struct radix_tree_root *root = &xb->xbrt;
> +	struct radix_tree_node *node;
> +	void **slot;
> +	struct ida_bitmap *bitmap;
> +	unsigned int nbits;
> +
> +	for (; start < end; start = (start | (IDA_BITMAP_BITS - 1)) + 1) {
> +		unsigned long index = start / IDA_BITMAP_BITS;
> +		unsigned long bit = start % IDA_BITMAP_BITS;
> +
> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
> +		if (radix_tree_exception(bitmap)) {
> +			unsigned long ebit = bit + 2;
> +			unsigned long tmp = (unsigned long)bitmap;
> +
> +			nbits = min(end - start + 1, BITS_PER_LONG - ebit);
> +
> +			if (ebit >= BITS_PER_LONG)

What happens if we hit this "continue;" when "index == ULONG_MAX / IDA_BITMAP_BITS" ?

Can you eliminate exception path and fold all xbitmap patches into one, and
post only one xbitmap patch without virtio-baloon changes? If exception path
is valuable, you can add exception path after minimum version is merged.
This series is too difficult for me to close corner cases.

> +				continue;
> +			bitmap_clear(&tmp, ebit, nbits);
> +			if (tmp == RADIX_TREE_EXCEPTIONAL_ENTRY)
> +				__radix_tree_delete(root, node, slot);
> +			else
> +				rcu_assign_pointer(*slot, (void *)tmp);
> +		} else if (bitmap) {
> +			nbits = min(end - start + 1, IDA_BITMAP_BITS - bit);
> +
> +			if (nbits != IDA_BITMAP_BITS)
> +				bitmap_clear(bitmap->bitmap, bit, nbits);
> +
> +			if (nbits == IDA_BITMAP_BITS ||
> +			    bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
> +				kfree(bitmap);
> +				__radix_tree_delete(root, node, slot);
> +			}
> +		}
> +
> +		/*
> +		 * Already reached the last usable ida bitmap, so just return,
> +		 * otherwise overflow will happen.
> +		 */
> +		if (index == ULONG_MAX / IDA_BITMAP_BITS)
> +			break;
> +	}
> +}



> +/**
> + * xb_find_next_set_bit - find the next set bit in a range
> + * @xb: the xbitmap to search
> + * @start: the start of the range, inclusive
> + * @end: the end of the range, exclusive
> + *
> + * Returns: the index of the found bit, or @end + 1 if no such bit is found.
> + */
> +unsigned long xb_find_next_set_bit(struct xb *xb, unsigned long start,
> +				   unsigned long end)
> +{
> +	return xb_find_next_bit(xb, start, end, 1);
> +}

Won't "exclusive" loose ability to handle ULONG_MAX ? Since this is a
library module, missing ability to handle ULONG_MAX sounds like an omission.
Shouldn't we pass (or return) whether "found or not" flag (e.g. strtoul() in
C library function)?

  bool xb_find_next_set_bit(struct xb *xb, unsigned long start, unsigned long end, unsigned long *result);
  unsigned long xb_find_next_set_bit(struct xb *xb, unsigned long start, unsigned long end, bool *found);
