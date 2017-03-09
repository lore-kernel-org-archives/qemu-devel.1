Received: from eggs.gnu.org ([2001:4830:134:3::10]:39545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cm00H-0000cb-W3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cm00C-0002mF-Vc
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:29:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cm00C-0002l8-Pn
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:29:16 -0500
Date: Thu, 9 Mar 2017 17:29:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170309172619-mutt-send-email-mst@kernel.org>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
	<20170223081616.GI4015@pxdev.xzpeter.org>
	<52e4d43f-c51f-0ac5-7409-f3087f61f44e@redhat.com>
	<20170223083533.17899e2f@t450s.home>
	<d7bd30e6-c166-24c8-3cf2-31bb0d4f6525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bd30e6-c166-24c8-3cf2-31bb0d4f6525@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, Mar 09, 2017 at 01:31:45PM +0100, Paolo Bonzini wrote:
> 
> 
> On 23/02/2017 16:35, Alex Williamson wrote:
> > It's the architecture of vfio, the user only gets access to the device
> > when the container has iommu protection, therefore vfio needs to look
> > at the device address space to determine if it can share a container
> > with other devices.  Without an iommu all devices share the system
> > address space and use the same container.  With an iommu, each device
> > is in a separate address space and each gets its own container.
> > Without a container, the user doesn't get access to the device.
> > Deferring the address space to machine done would essentially defer the
> > entire vfio device initialization or else we'd need to close the
> > device and re-open and initialize it through a new container at that
> > time.  Thanks,
> 
> If you used only one container you could still provide a working VFIO
> configuration to the guest, even if the guest had an IOMMU.  All devices
> ending up in one IOMMU domain is not particularly useful, but it would work.
> 
> If VFIO had an iommu property, to be used like "-device
> intel_iommu,id=iommu0 -device vfio-pci,iommu=iommu0", It could tell VFIO
> to use separate containers and also ensure proper ordering of command
> line arguments.
> 
> Paolo

Lots of guests can't handle arbitrary stuff like this though.
Normally IOMMU attaches to a bus and that's the only bus it can
handle and that's the only IOMMU that can handle the devices
on this bus.

It's a fact of life that not all hardware dependencies are in a form of
a bus-device relashionship, while modelling it as a bus internally might
be feasible exposing that to users seems risky and confusing as that's
our artifact.

-- 
MST
