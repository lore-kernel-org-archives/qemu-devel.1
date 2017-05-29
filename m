Received: from eggs.gnu.org ([2001:4830:134:3::10]:45332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFCJh-0003kg-Sv
	for qemu-devel@nongnu.org; Mon, 29 May 2017 00:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFCJd-00059G-UY
	for qemu-devel@nongnu.org; Mon, 29 May 2017 00:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFCJd-000596-MJ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 00:30:01 -0400
Date: Mon, 29 May 2017 12:29:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170529042950.GE22816@pxdev.xzpeter.org>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
	<1495163989-9994-11-git-send-email-peterx@redhat.com>
	<20170519195349-mutt-send-email-mst@kernel.org>
	<20170522024200.GE14679@pxdev.xzpeter.org>
	<20170525211413-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170525211413-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 10/10] vhost: iommu: cache static
 mapping if there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>

On Thu, May 25, 2017 at 09:14:55PM +0300, Michael S. Tsirkin wrote:
> On Mon, May 22, 2017 at 10:42:00AM +0800, Peter Xu wrote:
> > On Fri, May 19, 2017 at 07:55:26PM +0300, Michael S. Tsirkin wrote:
> > > On Fri, May 19, 2017 at 11:19:49AM +0800, Peter Xu wrote:
> > > > This patch pre-heat vhost iotlb cache when passthrough mode enabled.
> > > > 
> > > > Sometimes, even if user specified iommu_platform for vhost devices,
> > > > IOMMU might still be disabled. One case is passthrough mode in VT-d
> > > > implementation. We can detect this by observing iommu_list. If it's
> > > > empty, it means IOMMU translation is disabled, then we can actually
> > > > pre-heat the translation (it'll be static mapping then) by first
> > > > invalidating all IOTLB, then cache existing memory ranges into vhost
> > > > backend iotlb using 1:1 mapping.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > 
> > > I don't really understand. Is this a performance optimization?
> > > Can you post some #s please?
> > 
> > Yes, it is. Vhost can work even without this patch, but it should be
> > faster when with this patch.
> 
> You'll have to include perf testing numbers then.

My mistake to not have compared the numbers before, since it's just so
obvious to me that this patch should help.

Though after some simple streaming tests, it shows that this patch
didn't boost performance at all. I added some traces in vhost kernel
to know what's happened, please see below.

Without this patch, boot with iommu=pt, I see IOTLB cache insertion
like this:

vhost_process_iotlb_msg: iotlb new: 1 (0x17879b240-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 2 (0x17879d240-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 3 (0x17879a000-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 4 (0x178570000-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 5 (0x178532606-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 6 (0x177bad0e2-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 7 (0x1768560e2-0x17fffffff)

(Note: we can see the pattern is (ADDR-0x17fffffff), while ADDR is
 increasing, finally the range will cover all addresses that vhost
 needs for DMA, then we won't have cache miss, and 0x17fffffff is the
 upper limit for a 4G memory guest)

While after this patch (this is expected):

vhost_process_iotlb_msg: iotlb new: 1 (0x100000000-0x17fffffff)
vhost_process_iotlb_msg: iotlb new: 2 (0x0-0x9ffff)
vhost_process_iotlb_msg: iotlb new: 3 (0xc0000-0x7fffffff)

(Note: this is one entry per RAM memory region)

So it explained well on why performance didn't really change even
before applying this patch: currently when iommu=pt is on,
address_space_get_iotlb_entry() can get IOTLB that is bigger than page
size (if you see the code, plen decides the page mask, and plen is
only limited by memory region sizes when PT is enabled). So until the
7th cache miss IOTLB request, the range is big enough to cover the
rest of DMA addresses.

My preference is that we still apply this patch even there is no
performance gain on simple streaming test. Reasons:

- the old code has good performance depending on implementation of
  address_space_get_iotlb_entry(), which may alter in the future

- after apply the patch, we are 100% sure that we won't cache miss,
  while we cannot guarantee that without it. If not apply the patch,
  we may still encounter cache miss (e.g., access address <0x1768560e2
  after the 7th cache miss in above test), which can introduce that
  cache-missed IO to be delayed.

>
> > As mentioned in the commit message and below comment [1], this patch
> > pre-heat the cache for vhost. Currently the cache entries depends on
> > the system memory ranges (dev->mem->nregions), and it should be far
> > smaller than vhost's cache count (currently it is statically defined
> > as max_iotlb_entries=2048 in kernel). If with current patch, these
> > cache entries can cover the whole possible DMA ranges that PT mode
> > would allow, so we won't have any cache miss then.
> > 
> > For the comments, do you have any better suggestion besides commit
> > message and [1]?
> > 
> > > 
> > > Also, if it's PT, can't we bypass iommu altogether? That would be
> > > even faster ...
> > 
> > Yes, but I don't yet know a good way to do it... Any suggestion is
> > welcomed as well.
> > 
> > Btw, do you have any comment on other patches besides this one? Since
> > this patch can really be isolated from the whole PT support series.
> > 
> > Thanks,
> 
> I've applied the rest of the series.

Thank you very much.

-- 
Peter Xu
