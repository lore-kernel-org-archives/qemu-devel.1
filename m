Received: from eggs.gnu.org ([2001:4830:134:3::10]:60206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1OzE-0003dJ-7o
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1OzB-0004tc-1P
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:16:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f1OzA-0004tN-SC
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:16:24 -0400
Date: Thu, 29 Mar 2018 07:16:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180329071003-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180322181952-mutt-send-email-mst@kernel.org>
	<20180328122407.gc6yba26gijlm5g6@debian>
	<20180328183159-mutt-send-email-mst@kernel.org>
	<20180329033329.ucnx34nzimgec7pp@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329033329.ucnx34nzimgec7pp@debian>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 0/6] Extend vhost-user
 to support VFIO based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Mar 29, 2018 at 11:33:29AM +0800, Tiwei Bie wrote:
> On Wed, Mar 28, 2018 at 06:33:01PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Mar 28, 2018 at 08:24:07PM +0800, Tiwei Bie wrote:
> > > > > Update notes
> > > > > ============
> > > > > 
> > > > > IOMMU feature bit check is removed in this version, because:
> > > > > 
> > > > > The IOMMU feature is negotiable, when an accelerator is used and
> > > > > it doesn't support virtual IOMMU, its driver just won't provide
> > > > > this feature bit when vhost library querying its features. And if
> > > > > it supports the virtual IOMMU, its driver can provide this feature
> > > > > bit. It's not reasonable to add this limitation in this patch set.
> > > > 
> > > > Fair enough. Still:
> > > > Can hardware on intel platforms actually support IOTLB requests?
> > > > Don't you need to add support for vIOMMU shadowing instead?
> > > > 
> > > 
> > > For the hardware I have, I guess they can't for now.
> > 
> > So VFIO in QEMU has support for vIOMMU shadowing.
> > Can you use that somehow?
> 
> Yeah, I guess we can use it in some way. Actually supporting
> vIOMMU is a quite interesting feature. It would provide
> better security, and for the hardware backend case there
> would be no performance penalty with static mapping after
> the backend got all the mappings. I think it could be done
> as another work. Based on your previous suggestion in this
> thread, I have split the guest notification offload and host
> notification offload (I'll send the new version very soon).
> And I plan to let this patch set just focus on fixing the
> most critical performance issue - the host notification offload.
> With this fix, using hardware backend in vhost-user could get
> a very big performance boost and become much more practicable.
> So maybe we can focus on fixing this critical performance issue
> first. How do you think?

I think correctness and security go first before performance.
vIOMMU goes under security.

> > 
> > Ability to run dpdk within guest seems important.
> 
> I think vIOMMU isn't a must to run DPDK in guest.

Oh yes it is.

> For Linux
> guest we also have igb_uio and uio_pci_generic to run DPDK,
> for FreeBSD guest we have nic_uio.

These hacks offer no protection from a buggy userspace corrupting guest
kernel memory. Given DPDK is routinely linked into closed source
applications, this is not a configuration anyone can support.


> They don't need vIOMMU,
> and they could offer the best performance.
> 
> Best regards,
> Tiwei Bie
> 
> > 
> > -- 
> > MST
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
