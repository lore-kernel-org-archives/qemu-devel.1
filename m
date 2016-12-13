Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGfZw-0008II-8y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGfZr-0002WQ-8j
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:24:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGfZr-0002WD-2u
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:24:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A1FF37EE1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:24:34 +0000 (UTC)
Date: Tue, 13 Dec 2016 13:24:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161213052429.GB32222@pxdev.xzpeter.org>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-3-git-send-email-peterx@redhat.com>
	<20161211051011-mutt-send-email-mst@kernel.org>
	<20161212015602.GJ28693@pxdev.xzpeter.org>
	<20161212123544.2139b842@t450s.home>
	<20161213033341.GA32222@pxdev.xzpeter.org>
	<20161212205150.3e7f7d3b@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161212205150.3e7f7d3b@t450s.home>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] intel_iommu: extend supported
 guest aw to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Mon, Dec 12, 2016 at 08:51:50PM -0700, Alex Williamson wrote:

[...]

> > > I'm not sure how the vIOMMU supporting 39 bits or 48 bits is directly
> > > relevant to vfio, we're not sharing page tables.  There is already a
> > > case today, without vIOMMU that you can make a guest which has more
> > > guest physical address space than the hardware IOMMU by overcommitting
> > > system memory.  Generally this quickly resolves itself when we start
> > > pinning pages since the physical address width of the IOMMU is
> > > typically the same as the physical address width of the host system
> > > (ie. we exhaust the host memory).  
> > 
> > Hi, Alex,
> > 
> > Here does "hardware IOMMU" means the IOMMU iova address space width?
> > For example, if guest has 48 bits physical address width (without
> > vIOMMU), but host hardware IOMMU only supports 39 bits for its iova
> > address space, could device assigment work in this case?
> 
> The current usage depends entirely on what the user (VM) tries to map.
> You could expose a vIOMMU with a 64bit address width, but the moment
> you try to perform a DMA mapping with IOVA beyond bit 39 (if that's the
> host IOMMU address width), the ioctl will fail and the VM will abort.
> IOW, you can claim whatever vIOMMU address width you want, but if you
> layout guest memory or devices in such a way that actually require IOVA
> mapping beyond the host capabilities, you're going to abort.  Likewise,
> without a vIOMMU if the guest memory layout is sufficiently sparse to
> require such IOVAs, you're going to abort.  Thanks,

Thanks for the explanation. I got the point.

However, should we allow guest behaviors affect hypervisor? In this
case, if guest maps IOVA range over 39 bits (assuming vIOMMU is
declaring itself with 48 bits address width), the VM will crash. How
about we shrink vIOMMU address width to 39 bits during boot if we
detected that assigned devices are configured? IMHO no matter what we
do in the guest, the hypervisor should keep the guest alive from
hypervisor POV (emulation of the guest hardware should not be stopped
by guest behavior). If any operation in guest can cause hypervisor
down, isn't it a bug?

Thanks,

-- peterx
