Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKFC1-0000PR-Ov
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 22:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKFBw-0005Tj-TO
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 22:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dKFBw-0005TN-Kk
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 22:34:56 -0400
Date: Mon, 12 Jun 2017 10:34:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170612023443.GA25059@pxdev.xzpeter.org>
References: <20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
	<20170606234705.GG13397@umbus.fritz.box>
	<20170607034443.GA7983@pxdev.xzpeter.org>
	<20170607160445-mutt-send-email-mst@kernel.org>
	<20170608061150.GA3628@pxdev.xzpeter.org>
	<20170608215918-mutt-send-email-mst@kernel.org>
	<20170609015847.GG3628@pxdev.xzpeter.org>
	<20170611130710-mutt-send-email-mst@kernel.org>
	<20170611121015.GA18542@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170611121015.GA18542@umbus>
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
To: David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Sun, Jun 11, 2017 at 08:10:15PM +0800, David Gibson wrote:
> On Sun, Jun 11, 2017 at 01:09:26PM +0300, Michael S. Tsirkin wrote:
> > On Fri, Jun 09, 2017 at 09:58:47AM +0800, Peter Xu wrote:
> > > > > The problem is that when I was fixing the problem that vhost had with
> > > > > PT (a764040, "exec: abstract address_space_do_translate()"), I did
> > > > > broke the IOTLB translation a bit (it was using page masks). IMHO we
> > > > > need to fix it first for correctness (patch 1/2).
> > > > > 
> > > > > For patch 3, if we can have Jason's patch to allow dynamic
> > > > > iommu_platform switching, that'll be the best, then I can rewrite
> > > > > patch 3 with the switching logic rather than caching anything. But
> > > > > IMHO that can be separated from patch 1/2 if you like.
> > > > > 
> > > > > Or do you have better suggestion on how should we fix it?
> > > > > 
> > > > > Thanks,
> > > > 
> > > > Can we drop masks completely and replace with length? I think we
> > > > should do that instead of trying to fix masks.
> > > 
> > > Do you mean to modify IOMMUTLBEntry.addr_mask into length?
> > 
> > I think it's better than alternatives.
> > 
> > > Again, I am not sure this is good... At least we need to get ack from
> > > David since spapr should be the initial user of it, and possibly also
> > > Alex since vfio should be assuming that (IIUC both in QEMU and kernel)
> > > addr_mask is page masks rather than arbirary length.
> > > 
> > > (CC Alex)
> > > 
> > > Thanks,
> > 
> > Callbacks that need powers of two can easily split up the range.
> 
> I think I missed part of the thread.  What's the original use case for
> non-power-of-two IOTLB entries?  It certainly won't happen on Power.

Currently address_space_get_iotlb_entry() didn't really follow the
rule, addr_mask can be arbitary length. This series tried to fix it,
while Michael was questioning about whether we should really fix that
at all.

Michael,

Even if for performance's sake, I should still think we should fix it.
Let's consider a most simple worst case: we have a single page mapped
with IOVA range (2M page):

 [0x0, 0x200000)

And if guest access IOVA using the following patern:

 0x1fffff, 0x1ffffe, 0x1ffffd, ...

Then now we'll get this:

- request 0x1fffff, cache miss, will get iotlb [0x1fffff, 0x200000)
- request 0x1ffffe, cache miss, will get iotlb [0x1ffffe, 0x200000)
- request 0x1ffffd, cache miss, will get iotlb [0x1ffffd, 0x200000)
- ...

We'll all cache miss along the way until we access 0x0. While if we
are with page mask, we'll get:

- request 0x1fffff, cache miss, will get iotlb [0x0, 0x200000)
- request 0x1ffffe, cache hit
- request 0x1ffffd, cache hit
- ...

We'll only miss at the first IO.

-- 
Peter Xu
