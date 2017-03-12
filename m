Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmr1H-000824-VD
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 19:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cmr1E-0004K4-Q3
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 19:05:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cmr1E-0004Jx-HE
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 19:05:52 -0500
Date: Sun, 12 Mar 2017 02:05:47 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170312020203-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<20170310211102-mutt-send-email-mst@kernel.org>
	<20170310212541.GC16328@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310212541.GC16328@bombadil.infradead.org>
Subject: Re: [Qemu-devel] [PATCH v7 kernel 3/5] virtio-balloon:
 implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 10, 2017 at 01:25:41PM -0800, Matthew Wilcox wrote:
> On Fri, Mar 10, 2017 at 09:35:21PM +0200, Michael S. Tsirkin wrote:
> > > bit 0 clear => bits 1-11 encode a page count, bits 12-63 encode a PFN, page size 4k.
> > > bit 0 set, bit 1 clear => bits 2-12 encode a page count, bits 13-63 encode a PFN, page size 8k
> > > bits 0+1 set, bit 2 clear => bits 3-13 for page count, bits 14-63 for PFN, page size 16k.
> > > bits 0-2 set, bit 3 clear => bits 4-14 for page count, bits 15-63 for PFN, page size 32k
> > > bits 0-3 set, bit 4 clear => bits 5-15 for page count, bits 16-63 for PFN, page size 64k
> > > That means we can always pass 2048 pages (of whatever page size) in a single chunk.  And
> > > we support arbitrary power of two page sizes.  I suggest something like this:
> > > 
> > > u64 page_to_chunk(struct page *page)
> > > {
> > > 	u64 chunk = page_to_pfn(page) << PAGE_SHIFT;
> > > 	chunk |= (1UL << compound_order(page)) - 1;
> > > }
> > 
> > You need to fill in the size, do you not?
> 
> I think I did ... (1UL << compound_order(page)) - 1 sets the bottom
> N bits.  Bit N+1 will already be clear.  What am I missing?

This sets the order but not the number of pages.
For that you would do something like

	chunk |= size << compound_order(page)

right?

> > > > - host should pass its base page size to guest
> > > >   this can be a separate patch and for now we can fall back on 12 bit if not there
> > > 
> > > With this encoding scheme, I don't think we need to do this?  As long as
> > > it's *at least* 12 bit, then we're fine.
> > 
> > I think we will still need something like this down the road.  The point
> > is that not all hosts are able to use 4k pages in a balloon.
> > So it's pointless for guest to pass 4k pages to such a host,
> > and we need host to tell guest the page size it needs.
> > 
> > However that's a separate feature that can wait until
> > another day.
> 
> Ah, the TRIM/DISCARD debate all over again ... should the guest batch
> up or should the host do that work ... probably easier to account it in
> the guest.  Might be better to frame it as 'balloon chunk size' rather than
> host page size as it might have nothing to do with the host page size.

Exactly.

> > > What per-chunk flags are you thinking would be useful?
> > 
> > Not entirely sure but I think would have been prudent to leave some free
> > if possible. Your encoding seems to use them all up, so be it.
> 
> We don't necessarily have to support 2048 pages in a single chunk.
> If it's worth reserving some bits, we can do that at the expense of
> reducing the maximum number of pages per chunk.

Well we can always change things with a feature bit ..
I'll leave this up to you and Wei.

-- 
MST
