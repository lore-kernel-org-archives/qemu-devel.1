Received: from eggs.gnu.org ([2001:4830:134:3::10]:54419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cGfx5-0003ui-8h
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cGfx2-000434-4v
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cGfx1-00042a-T3
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 00:48:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE3027EBB4
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:48:29 +0000 (UTC)
Date: Mon, 12 Dec 2016 22:48:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20161212224828.5cc9f841@t450s.home>
In-Reply-To: <20161213052429.GB32222@pxdev.xzpeter.org>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-3-git-send-email-peterx@redhat.com>
	<20161211051011-mutt-send-email-mst@kernel.org>
	<20161212015602.GJ28693@pxdev.xzpeter.org>
	<20161212123544.2139b842@t450s.home>
	<20161213033341.GA32222@pxdev.xzpeter.org>
	<20161212205150.3e7f7d3b@t450s.home>
	<20161213052429.GB32222@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, 13 Dec 2016 13:24:29 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Dec 12, 2016 at 08:51:50PM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > > > I'm not sure how the vIOMMU supporting 39 bits or 48 bits is directly
> > > > relevant to vfio, we're not sharing page tables.  There is already a
> > > > case today, without vIOMMU that you can make a guest which has more
> > > > guest physical address space than the hardware IOMMU by overcommitting
> > > > system memory.  Generally this quickly resolves itself when we start
> > > > pinning pages since the physical address width of the IOMMU is
> > > > typically the same as the physical address width of the host system
> > > > (ie. we exhaust the host memory).    
> > > 
> > > Hi, Alex,
> > > 
> > > Here does "hardware IOMMU" means the IOMMU iova address space width?
> > > For example, if guest has 48 bits physical address width (without
> > > vIOMMU), but host hardware IOMMU only supports 39 bits for its iova
> > > address space, could device assigment work in this case?  
> > 
> > The current usage depends entirely on what the user (VM) tries to map.
> > You could expose a vIOMMU with a 64bit address width, but the moment
> > you try to perform a DMA mapping with IOVA beyond bit 39 (if that's the
> > host IOMMU address width), the ioctl will fail and the VM will abort.
> > IOW, you can claim whatever vIOMMU address width you want, but if you
> > layout guest memory or devices in such a way that actually require IOVA
> > mapping beyond the host capabilities, you're going to abort.  Likewise,
> > without a vIOMMU if the guest memory layout is sufficiently sparse to
> > require such IOVAs, you're going to abort.  Thanks,  
> 
> Thanks for the explanation. I got the point.
> 
> However, should we allow guest behaviors affect hypervisor? In this
> case, if guest maps IOVA range over 39 bits (assuming vIOMMU is
> declaring itself with 48 bits address width), the VM will crash. How
> about we shrink vIOMMU address width to 39 bits during boot if we
> detected that assigned devices are configured? IMHO no matter what we
> do in the guest, the hypervisor should keep the guest alive from
> hypervisor POV (emulation of the guest hardware should not be stopped
> by guest behavior). If any operation in guest can cause hypervisor
> down, isn't it a bug?

Any case of the guest crashing the hypervisor (ie. the host) is a
serious bug, but a guest causing it's own VM to abort is an entirely
different class, and in some cases justified.  For instance, you only
need a guest misbehaving in the virtio protocol to generate a VM
abort.  The cases Kevin raises make me reconsider because they are
cases of a VM behaving properly, within the specifications of the
hardware exposed to it, generating a VM abort, and in the case of vfio
exposed through to a guest user, allow the VM to be susceptible to the
actions of that user.

Of course any time we tie VM hardware to a host constraint, we're
asking for trouble.  You're example of shrinking the vIOMMU address
width to 39bits on boot highlights that.  Clearly cold plug devices is
only one scenario, what about hotplug devices?  We cannot dynamically
change the vIOMMU address width.  What about migration, we could start
the VM w/o an assigned device on a 48bit capable host and migrate it to
a 39bit host and then attempt to hot add an assigned device.  For the
most compatibility, why would we ever configure the VM with a vIOMMU
address width beyond the minimum necessary to support the potential
populated guest physical memory?  Thanks,

Alex
