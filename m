Received: from eggs.gnu.org ([2001:4830:134:3::10]:37650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE7MW-00039R-Sa
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fE7MT-00031L-NC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:05:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fE7MT-00031B-HH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:05:01 -0400
Date: Thu, 3 May 2018 14:04:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180503060442.GB2378@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Fri, Apr 27, 2018 at 11:37:24PM +0000, Tian, Kevin wrote:

[...]

> > Self NAK on this...
> > 
> > More than half of the whole series tries to solve the solo problem
> > that we unmapped some pages that were already mapped, which proved
> > to
> > be wrong.  Now if we squash the change we will do the same wrong
> > thing, so we'll still have a very small window that the remapped page
> > be missing from a device's POV.
> > 
> > Now to solve this I suppose we'll need to cache every translation then
> > we can know whether a mapping has changed, and we only remap when it
> > really has changed.  But I'm afraid that can be a big amount of data
> > for nested guests.  For a most common 4G L2 guest, I think the worst
> > case (e.g., no huge page at all, no continuous pages) is 4G/4K=1M
> > entries in that tree.
> 
> I think one key factor to think about is the effect of PSI. From
> VT-d spec, all internal caches (IOTLB entries, paging-structure
> cache entries, etc.) associated with specified address range
> must be flushed accordingly, i.e. no cache on stale mapping.
> Now per-device iova ranges is new type of cache introduced
> by Qemu VT-d. It doesn't cache actual mapping but its purpose
> is to decide whether to notify VFIO for updated mapping. In
> this manner if we don't differentiate whether an entry is
> for stale mapping, looks the definition of PSI is broken.
> 
> ask another question. In reality how much improvement this
> patch can bring, i.e. is it usual to see guest map on an already
> mapped region, or unmap an already unmapped region?

The funny thing is that there is actually no MAP/UNMAP flag for
PSI/DSI.  For either MAP/UNMAP, guest send one PSI for that range, or
even a DSI (Domain Selective Invalidations).

This patch will mostly be helpful not really for PSIs, but for DSI.
Please have a look on Issue (4) that I mentioned in the cover letter.
This patch is the core part to solve that DMA error problem.

An example is that we can get DSI for a domain that already have
existing mappings. In QEMU, we handle DSI as a whole-range PSI, so
before this patch we will unmap those already mapped pages then remap
all of them.  However we can't map the same page again, so we cache
what we have mapped here.

> 
> > 
> > Is it really worth it to solve this possibly-buggy-guest-OS problem
> > with such a overhead?  I don't know..
> 
> If adding overhead removes the benefit of this patch, then 
> definitely not a good thing.

For the problem that we are going to solve, this patch is not really a
beneficial one, but fixes a critical bug.  Again, please refer to the
issue (4) of the cover letter for that 3ms window problem.

> 
> > 
> > I'm not sure whether it's still acceptable that we put this issue
> > aside.  We should know that normal OSs should not do this, and if they
> > do, IMHO it proves a buggy OS already (so even from hardware POV we
> > allow this, from software POV it should still be problematic), then
> > it'll have problem for sure, but only within the VM itself, and it
> > won't affect other VMs or the host.  That sounds still reasonable to
> > me so far.
> 
> As said earlier, what I'm worried is whether there is a way to
> detect such case when your assumption is violated. usually
> emulation can choose to not implement all the features which
> are supported on the real device, but it's done in a way that
> non-supported features/behaviors can be reported to guest
> (based on spec definition) thus guest knows the expectation
> from the emulated device...

IMHO the guest can't really detect this, but it'll found that the
device is not working functionally if it's doing something like what
Jason has mentioned.

Actually now I have had an idea if we really want to live well even
with Jason's example: maybe we'll need to identify PSI/DSI.  For DSI,
we don't remap for mapped pages; for PSI, we unmap and remap the
mapped pages.  That'll complicate the stuff a bit, but it should
satisfy all the people.

Thanks,

-- 
Peter Xu
