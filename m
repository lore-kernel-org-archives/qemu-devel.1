Received: from eggs.gnu.org ([2001:4830:134:3::10]:51069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1drOFM-0006cA-Ul
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1drOFJ-0005lw-0B
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:55:29 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:56783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1drOFI-0005Ve-Pg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:55:24 -0400
Date: Mon, 11 Sep 2017 05:54:56 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170911125455.GA32538@bombadil.infradead.org>
References: <1503914913-28893-1-git-send-email-wei.w.wang@intel.com>
	<1503914913-28893-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503914913-28893-2-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v15 1/5] lib/xbitmap: Introduce xbitmap
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

On Mon, Aug 28, 2017 at 06:08:29PM +0800, Wei Wang wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> The eXtensible Bitmap is a sparse bitmap representation which is
> efficient for set bits which tend to cluster.  It supports up to
> 'unsigned long' worth of bits, and this commit adds the bare bones --
> xb_set_bit(), xb_clear_bit() and xb_test_bit().
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>

This is quite naughty of you.  You've modified the xbitmap implementation
without any indication in the changelog that you did so.  I don't
think the modifications you made are an improvement, but without any
argumentation from you I don't know why you think they're an improvement.

> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index 898e879..ee72e2c 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -496,6 +496,7 @@ static int __radix_tree_preload(gfp_t gfp_mask, unsigned nr)
>  out:
>  	return ret;
>  }
> +EXPORT_SYMBOL(__radix_tree_preload);
>  
>  /*
>   * Load up this CPU's radix_tree_node buffer with sufficient objects to

You exported this to modules for some reason.  Why?

> @@ -2003,6 +2018,7 @@ static bool __radix_tree_delete(struct radix_tree_root *root,
>  	replace_slot(slot, NULL, node, -1, exceptional);
>  	return node && delete_node(root, node, NULL, NULL);
>  }
> +EXPORT_SYMBOL(__radix_tree_delete);
>  
>  /**
>   * radix_tree_iter_delete - delete the entry at this iterator position

Ditto?

> diff --git a/lib/xbitmap.c b/lib/xbitmap.c
> new file mode 100644
> index 0000000..8c55296
> --- /dev/null
> +++ b/lib/xbitmap.c
> @@ -0,0 +1,176 @@
> +#include <linux/slab.h>
> +#include <linux/xbitmap.h>
> +
> +/*
> + * The xbitmap implementation supports up to ULONG_MAX bits, and it is
> + * implemented based on ida bitmaps. So, given an unsigned long index,
> + * the high order XB_INDEX_BITS bits of the index is used to find the
> + * corresponding item (i.e. ida bitmap) from the radix tree, and the low
> + * order (i.e. ilog2(IDA_BITMAP_BITS)) bits of the index are indexed into
> + * the ida bitmap to find the bit.
> + */
> +#define XB_INDEX_BITS		(BITS_PER_LONG - ilog2(IDA_BITMAP_BITS))
> +#define XB_MAX_PATH		(DIV_ROUND_UP(XB_INDEX_BITS, \
> +					      RADIX_TREE_MAP_SHIFT))
> +#define XB_PRELOAD_SIZE		(XB_MAX_PATH * 2 - 1)

I don't understand why you moved the xb_preload code here from the
radix tree.  I want all the code which touches the preload implementation
together in one place, which is the radix tree.

> +enum xb_ops {
> +	XB_SET,
> +	XB_CLEAR,
> +	XB_TEST
> +};
> +
> +static int xb_bit_ops(struct xb *xb, unsigned long bit, enum xb_ops ops)
> +{
> +	int ret = 0;
> +	unsigned long index = bit / IDA_BITMAP_BITS;
> +	struct radix_tree_root *root = &xb->xbrt;
> +	struct radix_tree_node *node;
> +	void **slot;
> +	struct ida_bitmap *bitmap;
> +	unsigned long ebit, tmp;
> +
> +	bit %= IDA_BITMAP_BITS;
> +	ebit = bit + RADIX_TREE_EXCEPTIONAL_SHIFT;
> +
> +	switch (ops) {
> +	case XB_SET:
> +		ret = __radix_tree_create(root, index, 0, &node, &slot);
> +		if (ret)
> +			return ret;
> +		bitmap = rcu_dereference_raw(*slot);
> +		if (radix_tree_exception(bitmap)) {
> +			tmp = (unsigned long)bitmap;
> +			if (ebit < BITS_PER_LONG) {
> +				tmp |= 1UL << ebit;
> +				rcu_assign_pointer(*slot, (void *)tmp);
> +				return 0;
> +			}
> +			bitmap = this_cpu_xchg(ida_bitmap, NULL);
> +			if (!bitmap)
> +				return -EAGAIN;
> +			memset(bitmap, 0, sizeof(*bitmap));
> +			bitmap->bitmap[0] =
> +					tmp >> RADIX_TREE_EXCEPTIONAL_SHIFT;
> +			rcu_assign_pointer(*slot, bitmap);
> +		}
> +		if (!bitmap) {
> +			if (ebit < BITS_PER_LONG) {
> +				bitmap = (void *)((1UL << ebit) |
> +					RADIX_TREE_EXCEPTIONAL_ENTRY);
> +				__radix_tree_replace(root, node, slot, bitmap,
> +						     NULL, NULL);
> +				return 0;
> +			}
> +			bitmap = this_cpu_xchg(ida_bitmap, NULL);
> +			if (!bitmap)
> +				return -EAGAIN;
> +			memset(bitmap, 0, sizeof(*bitmap));
> +			__radix_tree_replace(root, node, slot, bitmap, NULL,
> +					     NULL);
> +		}
> +		__set_bit(bit, bitmap->bitmap);
> +		break;
> +	case XB_CLEAR:
> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
> +		if (radix_tree_exception(bitmap)) {
> +			tmp = (unsigned long)bitmap;
> +			if (ebit >= BITS_PER_LONG)
> +				return 0;
> +			tmp &= ~(1UL << ebit);
> +			if (tmp == RADIX_TREE_EXCEPTIONAL_ENTRY)
> +				__radix_tree_delete(root, node, slot);
> +			else
> +				rcu_assign_pointer(*slot, (void *)tmp);
> +			return 0;
> +		}
> +		if (!bitmap)
> +			return 0;
> +		__clear_bit(bit, bitmap->bitmap);
> +		if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
> +			kfree(bitmap);
> +			__radix_tree_delete(root, node, slot);
> +		}
> +		break;
> +	case XB_TEST:
> +		bitmap = radix_tree_lookup(root, index);
> +		if (!bitmap)
> +			return 0;
> +		if (radix_tree_exception(bitmap)) {
> +			if (ebit > BITS_PER_LONG)
> +				return 0;
> +			return (unsigned long)bitmap & (1UL << bit);
> +		}
> +		ret = test_bit(bit, bitmap->bitmap);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return ret;
> +}

This is what I have the biggest problem with.  You've spliced
three functions together into a single 86-line function.  All that
they share is the first 11 lines of setup!  Go back and read
Documentation/process/coding-style.rst section 6 again.


And you've just deleted the test suite.  Test suites are incredibly
important!  They keep us from regressing.
