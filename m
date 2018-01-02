Received: from eggs.gnu.org ([2001:4830:134:3::10]:58236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eWMYl-0001XN-8C
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eWMYg-0006kV-Lj
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:24:51 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eWMYg-0006cY-CM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 08:24:46 -0500
Date: Tue, 2 Jan 2018 05:24:19 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20180102132419.GB8222@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<1513685879-21823-5-git-send-email-wei.w.wang@intel.com>
	<20171224032121.GA5273@bombadil.infradead.org>
	<201712241345.DIG21823.SLFOOJtQFOMVFH@I-love.SAKURA.ne.jp>
	<5A3F5A4A.1070009@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3F5A4A.1070009@intel.com>
Subject: Re: [Qemu-devel] [PATCH v20 4/7] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Sun, Dec 24, 2017 at 03:42:02PM +0800, Wei Wang wrote:
> On 12/24/2017 12:45 PM, Tetsuo Handa wrote:
> > Matthew Wilcox wrote:
> > > If you can't preload with anything better than that, I think that
> > > xb_set_bit() should attempt an allocation with GFP_NOWAIT | __GFP_NOWARN,
> > > and then you can skip the preload; it has no value for you.
> > Yes, that's why I suggest directly using kzalloc() at xb_set_bit().
> 
> It has some possibilities to remove that preload if we also do the bitmap
> allocation in the xb_set_bit():
> 
> bitmap = rcu_dereference_raw(*slot);
> if (!bitmap) {
>     bitmap = this_cpu_xchg(ida_bitmap, NULL);
>     if (!bitmap) {
>         bitmap = kmalloc(sizeof(*bitmap), gfp);
>         if (!bitmap)
>             return -ENOMEM;
>     }
> }
> 
> But why not just follow the radix tree implementation style that puts the
> allocation in preload, which would be invoked with a more relaxed gfp in
> other use cases?

Actually, the radix tree does attempt allocation, and falls back to the
preload.  The IDA was the odd one out that doesn't attempt allocation,
and that was where I copied the code from.  For other users, the preload
API is beneficial, so I will leave it in.

> Its usage in virtio_balloon is just a little special that we need to put the
> allocation within the balloon_lock, which doesn't give us the benefit of
> using a relaxed gfp in preload, but it doesn't prevent us from living with
> the current APIs (i.e. the preload + xb_set pattern).
> On the other side, if we do it as above, we have more things that need to
> consider. For example, what if the a use case just want the radix tree
> implementation style, which means it doesn't want allocation within
> xb_set(), then would we be troubled with how to avoid the allocation path in
> that case?
> 
> So, I think it is better to stick with the convention by putting the
> allocation in preload. Breaking the convention should show obvious
> advantages, IMHO.

The radix tree convention is objectively awful, which is why I'm working
to change it.  Specifying the GFP flags at radix tree initialisation time
rather than allocation time leads to all kinds of confusion.  The preload
API is a pretty awful workaround, and it will go away once the XArray
is working correctly.  That said, there's no alternative to it without
making XBitmap depend on XArray, and I don't want to hold you up there.
So there's an xb_preload for the moment.
