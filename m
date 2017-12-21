Received: from eggs.gnu.org ([2001:4830:134:3::10]:51480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS21A-00007f-C3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS217-0006q5-3c
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:40:16 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:49199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eS216-0004Xy-LW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:40:13 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
	<20171221141805.GA27695@bombadil.infradead.org>
In-Reply-To: <20171221141805.GA27695@bombadil.infradead.org>
Message-Id: <201712212337.JFC57368.tLFOJFVSFHMOOQ@I-love.SAKURA.ne.jp>
Date: Thu, 21 Dec 2017 23:37:49 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v20 3/7 RESEND] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: willy@infradead.org, wei.w.wang@intel.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com

Matthew Wilcox wrote:
> > +/**
> > + * xb_find_set - find the next set bit in a range of bits
> > + * @xb: the xbitmap to search from
> > + * @offset: the offset in the range to start searching
> > + * @size: the size of the range
> > + *
> > + * Returns: the found bit or, @size if no set bit is found.
> > + */
> > +unsigned long xb_find_set(struct xb *xb, unsigned long size,
> > +			  unsigned long offset)
> > +{
> > +	struct radix_tree_root *root = &xb->xbrt;
> > +	struct radix_tree_node *node;
> > +	void __rcu **slot;
> > +	struct ida_bitmap *bitmap;
> > +	unsigned long index = offset / IDA_BITMAP_BITS;
> > +	unsigned long index_end = size / IDA_BITMAP_BITS;
> > +	unsigned long bit = offset % IDA_BITMAP_BITS;
> > +
> > +	if (unlikely(offset >= size))
> > +		return size;
> > +
> > +	while (index <= index_end) {
> > +		unsigned long ret;
> > +		unsigned int nbits = size - index * IDA_BITMAP_BITS;
> > +
> > +		bitmap = __radix_tree_lookup(root, index, &node, &slot);
> > +
> > +		if (!node && !bitmap)
> > +			return size;
> > +
> > +		if (bitmap) {
> > +			if (nbits > IDA_BITMAP_BITS)
> > +				nbits = IDA_BITMAP_BITS;
> > +
> > +			ret = find_next_bit(bitmap->bitmap, nbits, bit);
> > +			if (ret != nbits)
> > +				return ret + index * IDA_BITMAP_BITS;
> > +		}
> > +		bit = 0;
> > +		index++;
> > +	}
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(xb_find_set);
> 
> This is going to be slower than the implementation I sent yesterday.  If I
> call:
> 	xb_init(xb);
> 	xb_set_bit(xb, ULONG_MAX);
> 	xb_find_set(xb, ULONG_MAX, 0);
> 
> it's going to call __radix_tree_lookup() 16 quadrillion times.
> My implementation will walk the tree precisely once.
> 
Yes. Wei's patch still can not work.
We should start reviewing Matthew's implementation.
