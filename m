Received: from eggs.gnu.org ([2001:4830:134:3::10]:46363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePv3D-0003c1-EJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePv3A-0002HB-81
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:49:39 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:49796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePv37-0002DM-P3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:49:36 -0500
Date: Fri, 15 Dec 2017 10:49:15 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171215184915.GB27160@bombadil.infradead.org>
References: <5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Sat, Dec 16, 2017 at 01:21:52AM +0900, Tetsuo Handa wrote:
> My understanding is that virtio-balloon wants to handle sparsely spreaded
> unsigned long values (which is PATCH 4/7) and wants to find all chunks of
> consecutive "1" bits efficiently. Therefore, I guess that holding the values
> in ascending order at store time is faster than sorting the values at read
> time. I don't know how to use radix tree API, but I think that B+ tree API
> suits for holding the values in ascending order.
> 
> We wait for Wei to post radix tree version combined into one patch and then
> compare performance between radix tree version and B+ tree version (shown
> below)?

Sure.  We all benefit from some friendly competition.  Even if a
competition between trees might remind one of the Entmoot ;-)

But let's not hold back -- let's figure out some good workloads to use
in our competition.  And we should also decide on the API / locking
constraints.  And of course we should compete based on not just speed,
but also memory consumption (both as a runtime overhead for a given set
of bits and as code size).  If you can replace the IDR, you get to count
that savings against the cost of your implementation.

Here's the API I'm looking at right now.  The user need take no lock;
the locking (spinlock) is handled internally to the implementation.

void xbit_init(struct xbitmap *xb);
int xbit_alloc(struct xbitmap *, unsigned long bit, gfp_t);
int xbit_alloc_range(struct xbitmap *, unsigned long start,
                        unsigned long nbits, gfp_t);
int xbit_set(struct xbitmap *, unsigned long bit, gfp_t);
bool xbit_test(struct xbitmap *, unsigned long bit);
int xbit_clear(struct xbitmap *, unsigned long bit);
int xbit_zero(struct xbitmap *, unsigned long start, unsigned long nbits);
int xbit_fill(struct xbitmap *, unsigned long start, unsigned long nbits,
                        gfp_t);
unsigned long xbit_find_clear(struct xbitmap *, unsigned long start,
                        unsigned long max);
unsigned long xbit_find_set(struct xbitmap *, unsigned long start,
                        unsigned long max);

> static bool set_ulong(struct ulong_list_head *head, const unsigned long value)
> {
> 	if (!ptr) {
> 		ptr = kzalloc(sizeof(*ptr), GFP_NOWAIT | __GFP_NOWARN);
> 		if (!ptr)
> 			goto out1;
> 		ptr->bitmap = kzalloc(BITMAP_LEN / 8,
> 				      GFP_NOWAIT | __GFP_NOWARN);
> 		if (!ptr->bitmap)
> 			goto out2;
> 		if (btree_insertl(&head->btree, ~segment, ptr,
> 				   GFP_NOWAIT | __GFP_NOWARN))
> 			goto out3;
> out3:
> 	kfree(ptr->bitmap);
> out2:
> 	kfree(ptr);
> out1:
> 	return false;
> }

And what is the user supposed to do if this returns false?  How do they
make headway?  The xb_ API is clear -- you call xb_prealloc and that
ensures forward progress.
