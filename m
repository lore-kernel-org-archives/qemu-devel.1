Received: from eggs.gnu.org ([2001:4830:134:3::10]:34758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ciuro-0003xx-Vn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ciurk-0000or-Uy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ciurk-0000oJ-On
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:23:48 -0500
Date: Wed, 1 Mar 2017 05:23:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301043802-mutt-send-email-mst@kernel.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
	<20170301023635.GE13926@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301023635.GE13926@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Mar 01, 2017 at 10:36:35AM +0800, Peter Xu wrote:
> On Tue, Feb 28, 2017 at 04:42:25PM +0200, Marcel Apfelbaum wrote:
> > On 02/24/2017 06:29 AM, Peter Xu wrote:
> > >Intel vIOMMU devices are created with "-device" parameter, while here
> > >actually we need to make sure the dmar device be created before other
> > >PCI devices (like vfio-pci) so that we know iommu_fn will be setup
> > >correctly before realizations of those PCI devices (it is sensible that
> > >PCI device fetch these info during its realization). Now this ordering
> > >yet cannot be achieved elsewhere, and devices will be created in the
> > >order that user specified. That might be dangerous.
> > >
> > >Here we add one more function to detect this kind of misordering issue,
> > >then report to guest. Currently, the only known device that is affected
> > >by this VT-d defect is the vfio-pci typed devices. So for now we just
> > >check against it to make sure we are safe.
> > >
> > 
> > Hi,
> > I can't say that I like it but if we want it for 2.9 maybe we don't have a choice.
> > 
> > I mentioned in another thread other idea:
> >     Maybe we should follow the same "template" as disk/drive, nic/netdev ?
> >     I mean something like -device iommu,id=i1, -device vfio-pci,iommu=e1 .
> > You are able to change the order, I didn't look how it is done.
> 
> I suppose that's done by using different keywords. For example:
> 
>   -netdev user,id=net0 -device e1000,netdev=net0
> 
> Here we are using "netdev" for the backend and "device" for the
> frontend.
> 
> Since we have this difference, we can just make sure the ordering by
> init netdev first (in net_init_clients()), then the devices (in
> device_init_func()).
> 
> > 
> > A nice side effect is that you can:
> >  1. Limit the iommu scope only to the devices you want to protect (tweaking APCI tables)
> >  2. In the future we can support multiple iommu devices.

Unfortunately AFAIK this needs a bunch of work in practice:
host and guest side.
So this opens a can of worms: you can all too easily create
configurations that we don't support.


> 
> Yes. Thanks,
> 
> -- peterx

While I agree this fixes the specific problem, we have the ordering
issue in many other places.  For example, this is one of the reasons we
don't create built-in PC devices using QOM composition.

So I think that support for dependencies does make a lot of sense
generally.


-- 
MST
