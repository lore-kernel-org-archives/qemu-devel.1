Received: from eggs.gnu.org ([2001:4830:134:3::10]:55172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVkaE-0004Lh-55
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVkaA-0003U8-Ts
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVkaA-0003Tm-Ka
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:19:30 -0400
Date: Thu, 13 Jul 2017 23:19:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713210819-mutt-send-email-mst@kernel.org>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<20170712160129-mutt-send-email-mst@kernel.org>
	<5966241C.9060503@intel.com>
	<20170712163746-mutt-send-email-mst@kernel.org>
	<5967246B.9030804@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5967246B.9030804@intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Thu, Jul 13, 2017 at 03:42:35PM +0800, Wei Wang wrote:
> On 07/12/2017 09:56 PM, Michael S. Tsirkin wrote:
> > 
> > So the way I see it, there are several issues:
> > 
> > - internal wait - forces multiple APIs like kick/kick_sync
> >    note how kick_sync can fail but your code never checks return code
> > - need to re-write the last descriptor - might not work
> >    for alternative layouts which always expose descriptors
> >    immediately
> 
> Probably it wasn't clear. Please let me explain the two functions here:
> 
> 1) virtqueue_add_chain_desc(vq, head_id, prev_id,..):
> grabs a desc from the vq and inserts it to the chain tail (which is indexed
> by
> prev_id, probably better to call it tail_id). Then, the new added desc
> becomes
> the tail (i.e. the last desc). The _F_NEXT flag is cleared for each desc
> when it's
> added to the chain, and set when another desc comes to follow later.

And this only works if there are multiple rings like
avail + descriptor ring.
It won't work e.g. with the proposed new layout where
writing out a descriptor exposes it immediately.

> 2) virtqueue_add_chain(vq, head_id,..): expose the chain to the other end.
> 
> So, if people want to add a desc and immediately expose it to the other end,
> i.e. build a single desc chain, they can just add and expose:
> 
> virtqueue_add_chain_desc(..);
> virtqueue_add_chain(..,head_id);
> 
> Would you see any issues here?

The way the new APIs poll used ring internally.

> 
> > - some kind of iterator type would be nicer instead of
> >    maintaining head/prev explicitly
> 
> Why would we need to iterate the chain?

In your patches prev/tail are iterators - they keep track of
where you are in the chain.

> I think it would be simpler to use
> a wrapper struct:
> 
> struct virtqueue_desc_chain {
>     unsigned int head;  // head desc id of the chain
>     unsigned int tail;     // tail desc id of the chain
> }
> 
> The new desc will be put to desc[tail].next, and we don't need to walk
> from the head desc[head].next when inserting a new desc to the chain, right?
> 
> 
> > 
> > As for the use, it would be better to do
> > 
> > if (!add_next(vq, ...)) {
> > 	add_last(vq, ...)
> > 	kick
> > 	wait
> > }
> 
> "!add_next(vq, ...)" means that the vq is full?


No - it means there's only 1 entry left for the last descriptor.


> If so, what would add_last()
> do then?
> 
> > Using VIRTQUEUE_DESC_ID_INIT seems to avoid a branch in the driver, but
> > in fact it merely puts the branch in the virtio code.
> > 
> 
> Actually it wasn't intended to improve performance. It is used to indicate
> the "init" state
> of the chain. So, when virtqueue_add_chain_desc(, head_id,..) finds head
> id=INIT, it will
> assign the grabbed desc id to &head_id. In some sense, it is equivalent to
> add_first().
> 
> Do you have a different opinion here?
> 
> Best,
> Wei
> 

It is but let's make it explicit here - an API function is better
than a special value.

-- 
MST
