Received: from eggs.gnu.org ([2001:4830:134:3::10]:44845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eSkuL-0001O9-Bp
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eSkuI-0006Hn-46
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:13 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:62863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eSkuH-0004TF-LU
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:10 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
	<20171221210327.GB25009@bombadil.infradead.org>
	<201712231159.ECI73411.tFFFJOHOVMOLQS@I-love.SAKURA.ne.jp>
	<20171223032959.GA11578@bombadil.infradead.org>
In-Reply-To: <20171223032959.GA11578@bombadil.infradead.org>
Message-Id: <201712232333.BAH82874.FFFtOMHSLVQOOJ@I-love.SAKURA.ne.jp>
Date: Sat, 23 Dec 2017 23:33:45 +0900
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
To: willy@infradead.org
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com

Matthew Wilcox wrote:
> On Sat, Dec 23, 2017 at 11:59:54AM +0900, Tetsuo Handa wrote:
> > Matthew Wilcox wrote:
> > > +	bit %= IDA_BITMAP_BITS;
> > > +	radix_tree_iter_init(&iter, index);
> > > +	slot = idr_get_free_cmn(root, &iter, GFP_NOWAIT | __GFP_NOWARN, index);
> > > +	if (IS_ERR(slot)) {
> > > +		if (slot == ERR_PTR(-ENOSPC))
> > > +			return 0;	/* Already set */
> > 
> > Why already set? I guess something is there, but is it guaranteed that
> > there is a bitmap with the "bit" set?
> 
> Yes.  For radix trees tagged with IDR_RT_MARKER, newly created slots
> have the IDR_FREE tag set.  We only clear the IDR_FREE tag once the
> bitmap is full.  So if we try to find a free slot and the tag is clear,
> we know the bitmap is full.
> 

OK. But does using IDR_FREE tag have more benefit than cost?
You are doing

	if (bitmap_full(bitmap->bitmap, IDA_BITMAP_BITS))
		radix_tree_iter_tag_clear(root, &iter, IDR_FREE);

for each xb_set_bit() call. How likely do we hit ERR_PTR(-ENOSPC) path?
Isn't removing both bitmap_full() and ERR_PTR(-ENOSPC) better?

> > > +	bitmap = rcu_dereference_raw(*slot);
> > > +	if (!bitmap) {
> > > +		bitmap = this_cpu_xchg(ida_bitmap, NULL);
> > > +		if (!bitmap)
> > > +			return -ENOMEM;
> > 
> > I can't understand this. I can understand if it were
> > 
> >   BUG_ON(!bitmap);
> > 
> > because you called xb_preload().
> > 
> > But
> > 
> > 	/*
> > 	 * Regular test 2
> > 	 * set bit 2000, 2001, 2040
> > 	 * Next 1 in [0, 2048)		--> 2000
> > 	 * Next 1 in [2000, 2002)	--> 2000
> > 	 * Next 1 in [2002, 2041)	--> 2040
> > 	 * Next 1 in [2002, 2040)	--> none
> > 	 * Next 0 in [2000, 2048)	--> 2002
> > 	 * Next 0 in [2048, 2060)	--> 2048
> > 	 */
> > 	xb_preload(GFP_KERNEL);
> > 	assert(!xb_set_bit(&xb1, 2000));
> > 	assert(!xb_set_bit(&xb1, 2001));
> > 	assert(!xb_set_bit(&xb1, 2040));
> [...]
> > 	xb_preload_end();
> > 
> > you are not calling xb_preload() prior to each xb_set_bit() call.
> > This means that, if each xb_set_bit() is not surrounded with
> > xb_preload()/xb_preload_end(), there is possibility of hitting
> > this_cpu_xchg(ida_bitmap, NULL) == NULL.
> 
> This is just a lazy test.  We "know" that the bits in the range 1024-2047
> will all land in the same bitmap, so there's no need to preload for each
> of them.

Testcases also serves as how to use that API.
Assuming such thing leads to incorrect usage.

> 
> > If bitmap == NULL at this_cpu_xchg(ida_bitmap, NULL) is allowed,
> > you can use kzalloc(sizeof(*bitmap), GFP_NOWAIT | __GFP_NOWARN)
> > and get rid of xb_preload()/xb_preload_end().
> 
> No, we can't.  GFP_NOWAIT | __GFP_NOWARN won't try very hard to allocate
> memory.  There's no reason to fail the call if the user is in a context
> where they can try harder to free memory.

But there is no reason to use GFP_NOWAIT at idr_get_free_cmn() if it is
safe to use GFP_KERNEL. If we don't require xb_preload() which forces
idr_get_free_cmn() to use GFP_NOWAIT due to possibility of preemption
disabled by xb_preload(), we can allow passing gfp flags to xb_set_bit().

> 
> > You are using idr_get_free_cmn(GFP_NOWAIT | __GFP_NOWARN), which
> > means that the caller has to be prepared for allocation failure
> > when calling xb_set_bit(). Thus, there is no need to use preload
> > in order to avoid failing to allocate "bitmap".
> 
> xb_preload also preloads radix tree nodes.
> 

But it after all forces idr_get_free_cmn() to use GFP_NOWAIT, doesn't it?

Speak of initial user (i.e. virtio-balloon), xb_preload() won't be able to
use GFP_KERNEL in order to avoid OOM lockup. Therefore, I don't see
advantages with using xb_preload(). If xb_set_bit() receives gfp flags,
the caller can pass GFP_KERNEL if it is safe to use GFP_KERNEL.
