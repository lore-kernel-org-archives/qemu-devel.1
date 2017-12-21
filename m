Received: from eggs.gnu.org ([2001:4830:134:3::10]:37425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eS1fp-00075z-A5
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eS1fk-0006D5-Uj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:13 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eS1fk-0006CT-Jg
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:18:08 -0500
Date: Thu, 21 Dec 2017 06:18:05 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171221141805.GA27695@bombadil.infradead.org>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v20 3/7 RESEND] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, penguin-kernel@I-love.SAKURA.ne.jp


First of all, the test-suite doesn't build, so I don't know whether you
ran it or not.  Then I added the xb_find_set() call below, and it fails
the assert, so you should probably fix that.

diff --git a/lib/xbitmap.c b/lib/xbitmap.c
index f03a0f9f9e29..b29af08a7597 100644
--- a/lib/xbitmap.c
+++ b/lib/xbitmap.c
@@ -249,11 +249,12 @@ void xbitmap_check_bit(unsigned long bit)
 	assert(!xb_test_bit(&xb1, bit));
 	assert(xb_set_bit(&xb1, bit) == 0);
 	assert(xb_test_bit(&xb1, bit));
-	assert(xb_clear_bit(&xb1, bit) == 0);
+	xb_clear_bit(&xb1, bit);
 	assert(xb_empty(&xb1));
-	assert(xb_clear_bit(&xb1, bit) == 0);
+	xb_clear_bit(&xb1, bit);
 	assert(xb_empty(&xb1));
 	xb_preload_end();
+	assert(xb_find_set(&xb1, ULONG_MAX, 0) == bit);
 }
 
 static void xbitmap_check_bit_range(void)
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 34ece7883629..adf36e34dd77 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address
-LDFLAGS += -fsanitize=address
-LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder
+LDFLAGS += -fsanitize=address $(LDLIBS)
+LDLIBS := -lpthread -lurcu
+TARGETS = main idr-test multiorder xbitmap
 CORE_OFILES := radix-tree.o idr.o linux.o test.o find_bit.o
 OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
 	 tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o \

On Thu, Dec 21, 2017 at 10:30:06AM +0800, Wei Wang wrote:
> v20 RESEND Changes:
> 	- fixed the !node path
> 	- added the test cases for the !node path
> 	- change __builtin_constant_p(start & 7) to __builtin_constant_p(start) 

Why would you do such a thing?  Just copy the kernel definitions.

> diff --git a/include/linux/xbitmap.h b/include/linux/xbitmap.h
> index 108f929..ede1029 100644
> --- a/include/linux/xbitmap.h
> +++ b/include/linux/xbitmap.h
> @@ -35,6 +35,12 @@ static inline void xb_init(struct xb *xb)
>  int xb_set_bit(struct xb *xb, unsigned long bit);
>  bool xb_test_bit(const struct xb *xb, unsigned long bit);
>  void xb_clear_bit(struct xb *xb, unsigned long bit);
> +void xb_clear_bit_range(struct xb *xb, unsigned long start,
> +			unsigned long nbits);

This is xb_zero().  I thought we talked about this before?

> +unsigned long xb_find_set(struct xb *xb, unsigned long size,
> +			  unsigned long offset);
> +unsigned long xb_find_zero(struct xb *xb, unsigned long size,
> +			   unsigned long offset);

Since you're using xb_find_zero(), I think we need the tags from the IDR.
At that point, I'm not sure there's a point in keeping the xbitmap and the
IDR as separate data structures.

> +/**
> + * xb_find_set - find the next set bit in a range of bits
> + * @xb: the xbitmap to search from
> + * @offset: the offset in the range to start searching
> + * @size: the size of the range
> + *
> + * Returns: the found bit or, @size if no set bit is found.
> + */
> +unsigned long xb_find_set(struct xb *xb, unsigned long size,
> +			  unsigned long offset)
> +{
> +	struct radix_tree_root *root = &xb->xbrt;
> +	struct radix_tree_node *node;
> +	void __rcu **slot;
> +	struct ida_bitmap *bitmap;
> +	unsigned long index = offset / IDA_BITMAP_BITS;
> +	unsigned long index_end = size / IDA_BITMAP_BITS;
> +	unsigned long bit = offset % IDA_BITMAP_BITS;
> +
> +	if (unlikely(offset >= size))
> +		return size;
> +
> +	while (index <= index_end) {
> +		unsigned long ret;
> +		unsigned int nbits = size - index * IDA_BITMAP_BITS;
> +
> +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
> +
> +		if (!node && !bitmap)
> +			return size;
> +
> +		if (bitmap) {
> +			if (nbits > IDA_BITMAP_BITS)
> +				nbits = IDA_BITMAP_BITS;
> +
> +			ret = find_next_bit(bitmap->bitmap, nbits, bit);
> +			if (ret != nbits)
> +				return ret + index * IDA_BITMAP_BITS;
> +		}
> +		bit = 0;
> +		index++;
> +	}
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(xb_find_set);

This is going to be slower than the implementation I sent yesterday.  If I
call:
	xb_init(xb);
	xb_set_bit(xb, ULONG_MAX);
	xb_find_set(xb, ULONG_MAX, 0);

it's going to call __radix_tree_lookup() 16 quadrillion times.
My implementation will walk the tree precisely once.
