Received: from eggs.gnu.org ([2001:4830:134:3::10]:37418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLD8B-0000kV-FP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLD88-0002QG-RW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:35:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLD88-0002Q5-I1
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:35:00 -0400
Date: Wed, 14 Jun 2017 21:34:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170614213418-mutt-send-email-mst@kernel.org>
References: <20170607034443.GA7983@pxdev.xzpeter.org>
	<20170607160445-mutt-send-email-mst@kernel.org>
	<20170608061150.GA3628@pxdev.xzpeter.org>
	<20170608215918-mutt-send-email-mst@kernel.org>
	<20170609015847.GG3628@pxdev.xzpeter.org>
	<20170611130710-mutt-send-email-mst@kernel.org>
	<20170611121015.GA18542@umbus>
	<20170612023443.GA25059@pxdev.xzpeter.org>
	<20170612060450-mutt-send-email-mst@kernel.org>
	<20170612040458.GB25059@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612040458.GB25059@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Mon, Jun 12, 2017 at 12:04:58PM +0800, Peter Xu wrote:
> On Mon, Jun 12, 2017 at 06:07:04AM +0300, Michael S. Tsirkin wrote:
> > On Mon, Jun 12, 2017 at 10:34:43AM +0800, Peter Xu wrote:
> > > On Sun, Jun 11, 2017 at 08:10:15PM +0800, David Gibson wrote:
> > > > On Sun, Jun 11, 2017 at 01:09:26PM +0300, Michael S. Tsirkin wrote:
> > > > > On Fri, Jun 09, 2017 at 09:58:47AM +0800, Peter Xu wrote:
> > > > > > > > The problem is that when I was fixing the problem that vhost had with
> > > > > > > > PT (a764040, "exec: abstract address_space_do_translate()"), I did
> > > > > > > > broke the IOTLB translation a bit (it was using page masks). IMHO we
> > > > > > > > need to fix it first for correctness (patch 1/2).
> > > > > > > > 
> > > > > > > > For patch 3, if we can have Jason's patch to allow dynamic
> > > > > > > > iommu_platform switching, that'll be the best, then I can rewrite
> > > > > > > > patch 3 with the switching logic rather than caching anything. But
> > > > > > > > IMHO that can be separated from patch 1/2 if you like.
> > > > > > > > 
> > > > > > > > Or do you have better suggestion on how should we fix it?
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > 
> > > > > > > Can we drop masks completely and replace with length? I think we
> > > > > > > should do that instead of trying to fix masks.
> > > > > > 
> > > > > > Do you mean to modify IOMMUTLBEntry.addr_mask into length?
> > > > > 
> > > > > I think it's better than alternatives.
> > > > > 
> > > > > > Again, I am not sure this is good... At least we need to get ack from
> > > > > > David since spapr should be the initial user of it, and possibly also
> > > > > > Alex since vfio should be assuming that (IIUC both in QEMU and kernel)
> > > > > > addr_mask is page masks rather than arbirary length.
> > > > > > 
> > > > > > (CC Alex)
> > > > > > 
> > > > > > Thanks,
> > > > > 
> > > > > Callbacks that need powers of two can easily split up the range.
> > > > 
> > > > I think I missed part of the thread.  What's the original use case for
> > > > non-power-of-two IOTLB entries?  It certainly won't happen on Power.
> > > 
> > > Currently address_space_get_iotlb_entry() didn't really follow the
> > > rule, addr_mask can be arbitary length. This series tried to fix it,
> > > while Michael was questioning about whether we should really fix that
> > > at all.
> > > 
> > > Michael,
> > > 
> > > Even if for performance's sake, I should still think we should fix it.
> > > Let's consider a most simple worst case: we have a single page mapped
> > > with IOVA range (2M page):
> > > 
> > >  [0x0, 0x200000)
> > > 
> > > And if guest access IOVA using the following patern:
> > > 
> > >  0x1fffff, 0x1ffffe, 0x1ffffd, ...
> > > 
> > > Then now we'll get this:
> > > 
> > > - request 0x1fffff, cache miss, will get iotlb [0x1fffff, 0x200000)
> > > - request 0x1ffffe, cache miss, will get iotlb [0x1ffffe, 0x200000)
> > > - request 0x1ffffd, cache miss, will get iotlb [0x1ffffd, 0x200000)
> > > - ...
> > 
> > We pass an offset too, do we not? So callee can figure out
> > the region starts at 0x0 and avoid 2nd and 3rd misses.
> 
> Here when you say "offset", do you mean the offset in
> MemoryRegionSection?
> 
> In address_space_get_iotlb_entry() we have this:
> 
>     section = address_space_do_translate(as, addr, &xlat, &plen,
>                                          is_write, false);
> 
> One thing to mention is that, imho we cannot really assume the xlat is
> valid on the whole "section" range - the section can be a huge GPA
> range, while the xlat may only be valid on a single 4K page. The only
> safe region we can use here is (xlat, xlat+plen). Outside that, we
> should know nothing valid.
> 
> Please correct me if I didn't really catch the point..

IIUC section is the translation result. If so all of it is valid,
not just one page.

> > 
> > 
> > > We'll all cache miss along the way until we access 0x0. While if we
> > > are with page mask, we'll get:
> > > 
> > > - request 0x1fffff, cache miss, will get iotlb [0x0, 0x200000)
> > > - request 0x1ffffe, cache hit
> > > - request 0x1ffffd, cache hit
> > > - ...
> > > 
> > > We'll only miss at the first IO.
> > 
> > I think we should send as much info as we can.
> > There should be a way to find full region start and length.
> 
> Thanks,
> 
> -- 
> Peter Xu
