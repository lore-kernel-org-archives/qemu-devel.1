Received: from eggs.gnu.org ([2001:4830:134:3::10]:49706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eSIyw-0000DN-9K
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eSIyt-0008H2-Kx
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:47:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:14988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eSIyt-0008Fy-B4
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 03:47:03 -0500
Message-ID: <5A3CC707.9070708@intel.com>
Date: Fri, 22 Dec 2017 16:49:11 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
	<20171221210327.GB25009@bombadil.infradead.org>
In-Reply-To: <20171221210327.GB25009@bombadil.infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 3/7 RESEND] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, penguin-kernel@I-love.SAKURA.ne.jp

On 12/22/2017 05:03 AM, Matthew Wilcox wrote:
> OK, here's a rewrite of xbitmap.
>
> Compared to the version you sent:
>   - xb_find_set() is the rewrite I sent out yesterday.
>   - xb_find_clear() is a new implementation.  I use the IDR_FREE tag to find
>     clear bits.  This led to me finding a bug in radix_tree_for_each_tagged().
>   - xb_zero() is also a new implementation (replacing xb_clear_bit_range).
>     It should also be more efficient in deep trees.
>   - Did not accept your change to xb_set_bit(); I think it's important to
>     leave the radix tree node in place, so we're guaranteed to make progress
>     in low-memory situations.  We're expecting the caller to retry, so the
>     memory should not leak.
>   - Redid a lot of the kernel-doc.  Thanks for adding it!  I removed mentions
>     of implementation details, leaving only information useful to those who
>     are using it.
>
> Compared to the version I put out back in February:
>   - Accepted your change to xb_preload(); I think it's an improvement.
>   - Rewrote xb_set_bit() to use the radix_tree_iter_ family of functions.
>     Should improve performance for deep trees.
>   - Rewrote xb_clear_bit() for the same reason.
>   - Left out the use of radix tree exceptional entries.  Thanks for taking
>     them out!  Keeps it clearer for now; if they prove useful, we can put
>     them back in.
>   - Removed the use of __radix_tree_delete and __radix_tree_create, so drop
>     the changes to those functions.
>
> Other miscellaneous notes
>   - I left xb_fill() in the header file, even though there's no implementation
>     yet.  Wouldn't be hard to add once we have a user.
>   - Used SPDX tags instead of a license notice.
>
> I think we need more test cases ... in reviewing this to send out,
> I found a bug in xb_zero(), which I've only fixed because I don't have
> time to write a test case for it.

Thanks for the improvement. I also found a small bug in xb_zero. With 
the following changes, it has passed the current test cases and tested 
with the virtio-balloon usage without any issue.


> +
> +/**
> + * xb_zero() - Clear a range of bits in the XBitmap.
> + * @xb: The XBitmap.
> + * @min: The first bit to clear.
> + * @max: The last bit to clear.
> + *
> + * This function is used to clear a range of bits in the xbitmap.
> + */
> +void xb_zero(struct xb *xb, unsigned long min, unsigned long max)
> +{
> +	struct radix_tree_root *root = &xb->xbrt;
> +	struct radix_tree_iter iter;
> +	void __rcu **slot;
> +	struct ida_bitmap *bitmap;
> +	unsigned long index = min / IDA_BITMAP_BITS;
> +	unsigned long first = min % IDA_BITMAP_BITS;
> +	unsigned long maxindex = max / IDA_BITMAP_BITS;
> +
> +	radix_tree_for_each_slot(slot, root, &iter, index) {
> +		unsigned long nbits = IDA_BITMAP_BITS;
> +		if (index > maxindex)
> +			break;
> +		bitmap = radix_tree_deref_slot(slot);
> +		if (!bitmap)
> +			continue;
> +		radix_tree_iter_tag_set(root, &iter, IDR_FREE);
> +
> +		if (!first && iter.index < maxindex)
> +			goto delete;
> +		if (iter.index == maxindex)
> +			nbits = max % IDA_BITMAP_BITS + 1;
> +		bitmap_clear(bitmap->bitmap, first, nbits);

It should be: bitmap_clear(.., first, nbits - first);


> diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
> index fa7ee369b3c9..adf36e34dd77 100644
> --- a/tools/testing/radix-tree/Makefile
> +++ b/tools/testing/radix-tree/Makefile
> @@ -1,12 +1,13 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   CFLAGS += -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE -fsanitize=address
> -LDFLAGS += -fsanitize=address
> -LDLIBS+= -lpthread -lurcu
> -TARGETS = main idr-test multiorder
> +LDFLAGS += -fsanitize=address $(LDLIBS)
> +LDLIBS := -lpthread -lurcu
> +TARGETS = main idr-test multiorder xbitmap
>   CORE_OFILES := radix-tree.o idr.o linux.o test.o find_bit.o
>   OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
> -	 tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o
> +	 tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o \
> +	 xbitmap.o
>   
>   ifndef SHIFT
>   	SHIFT=3
> @@ -25,8 +26,11 @@ idr-test: idr-test.o $(CORE_OFILES)
>   
>   multiorder: multiorder.o $(CORE_OFILES)
>   
> +xbitmap: xbitmap.o $(CORE_OFILES)
> +	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o xbitmap
> +

I think the "$(CC).." line should be removed, which will fix the build 
error when adding "xbitmap" to TARGET.


Best,
Wei
