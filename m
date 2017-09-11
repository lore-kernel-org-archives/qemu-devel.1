Received: from eggs.gnu.org ([2001:4830:134:3::10]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1drOkA-0001KZ-5X
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1drOk6-0007oU-W5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:27:18 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:55446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1drOk6-0007nN-O8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:27:14 -0400
Date: Mon, 11 Sep 2017 06:27:10 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170911132710.GB32538@bombadil.infradead.org>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503914913-28893-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v15 2/5] lib/xbitmap: add
 xb_find_next_bit() and xb_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Mon, Aug 28, 2017 at 06:08:30PM +0800, Wei Wang wrote:
> +/**
> + *  xb_zero - zero a range of bits in the xbitmap
> + *  @xb: the xbitmap that the bits reside in
> + *  @start: the start of the range, inclusive
> + *  @end: the end of the range, inclusive
> + */
> +void xb_zero(struct xb *xb, unsigned long start, unsigned long end)
> +{
> +	unsigned long i;
> +
> +	for (i = start; i <= end; i++)
> +		xb_clear_bit(xb, i);
> +}
> +EXPORT_SYMBOL(xb_zero);

Um.  This is not exactly going to be quick if you're clearing a range of bits.
I think it needs to be more along the lines of this:

void xb_clear(struct xb *xb, unsigned long start, unsigned long end) 
{ 
        struct radix_tree_root *root = &xb->xbrt; 
        struct radix_tree_node *node; 
        void **slot; 
        struct ida_bitmap *bitmap; 
 
        for (; end < start; start = (start | (IDA_BITMAP_BITS - 1)) + 1) { 
                unsigned long index = start / IDA_BITMAP_BITS; 
                unsigned long bit = start % IDA_BITMAP_BITS; 

                bitmap = __radix_tree_lookup(root, index, &node, &slot);
                if (radix_tree_exception(bitmap)) {
                        unsigned long ebit = bit + 2;
                        unsigned long tmp = (unsigned long)bitmap;
                        if (ebit >= BITS_PER_LONG)
                                continue;
                        tmp &= ... something ...;
                        if (tmp == RADIX_TREE_EXCEPTIONAL_ENTRY)
                                __radix_tree_delete(root, node, slot);
                        else
                                rcu_assign_pointer(*slot, (void *)tmp);
                } else if (bitmap) {
                        unsigned int nbits = end - start + 1;
                        if (nbits + bit > IDA_BITMAP_BITS)
                                nbits = IDA_BITMAP_BITS - bit;
                        bitmap_clear(bitmap->bitmap, bit, nbits);
                        if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
                                kfree(bitmap);
                                __radix_tree_delete(root, node, slot);
                        }
                }
        }
}

Also note that this should be called xb_clear(), not xb_zero() to fit
in with bitmap_clear().  And this needs a thorough test suite testing
all values for 'start' and 'end' between 0 and at least 1024; probably
much higher.  And a variable number of bits need to be set before calling
xb_clear() in the test suite.

Also, this implementation above is missing a few tricks.  For example,
if 'bit' is 0 and 'nbits' == IDA_BITMAP_BITS, we can simply call kfree
without first zeroing out the bits and then checking if the whole thing
is zero.

Another missing optimisation above is that we always restart the radix
tree walk from the top instead of simply moving on to the next bitmap.
This is still a thousand times faster than the implementation you posted,
but I'd be keen to add that optimisation too.

> +/**
> + * xb_find_next_bit - find next 1 or 0 in the give range of bits
> + * @xb: the xbitmap that the bits reside in
> + * @start: the start of the range, inclusive
> + * @end: the end of the range, inclusive
> + * @set: the polarity (1 or 0) of the next bit to find
> + *
> + * Return the index of the found bit in the xbitmap. If the returned index
> + * exceeds @end, it indicates that no such bit is found in the given range.
> + */
> +unsigned long xb_find_next_bit(struct xb *xb, unsigned long start,
> +			       unsigned long end, bool set)
> +{
> +	unsigned long i;
> +
> +	for (i = start; i <= end; i++) {
> +		if (xb_test_bit(xb, i) == set)
> +			break;
> +	}
> +
> +	return i;
> +}
> +EXPORT_SYMBOL(xb_find_next_bit);

Similar comments ... this is going to be very slow.  You can use the
tags in the tree to help you find set and clear bits so performance
doesn't fall apart in big trees.

I'd like to see this be two functions, xb_find_next_zero_bit() and
xb_find_next_set_bit().
