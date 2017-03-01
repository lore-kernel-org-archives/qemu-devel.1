Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ciu8E-0004Kn-Bx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ciu8B-0001GK-8v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ciu8B-0001GC-2q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 21:36:43 -0500
Date: Wed, 1 Mar 2017 10:36:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170301023635.GE13926@pxdev.xzpeter.org>
References: <1487910561-17825-1-git-send-email-peterx@redhat.com>
	<e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e547f430-d078-27a5-7064-4fc5b9f738d1@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Tue, Feb 28, 2017 at 04:42:25PM +0200, Marcel Apfelbaum wrote:
> On 02/24/2017 06:29 AM, Peter Xu wrote:
> >Intel vIOMMU devices are created with "-device" parameter, while here
> >actually we need to make sure the dmar device be created before other
> >PCI devices (like vfio-pci) so that we know iommu_fn will be setup
> >correctly before realizations of those PCI devices (it is sensible that
> >PCI device fetch these info during its realization). Now this ordering
> >yet cannot be achieved elsewhere, and devices will be created in the
> >order that user specified. That might be dangerous.
> >
> >Here we add one more function to detect this kind of misordering issue,
> >then report to guest. Currently, the only known device that is affected
> >by this VT-d defect is the vfio-pci typed devices. So for now we just
> >check against it to make sure we are safe.
> >
> 
> Hi,
> I can't say that I like it but if we want it for 2.9 maybe we don't have a choice.
> 
> I mentioned in another thread other idea:
>     Maybe we should follow the same "template" as disk/drive, nic/netdev ?
>     I mean something like -device iommu,id=i1, -device vfio-pci,iommu=e1 .
> You are able to change the order, I didn't look how it is done.

I suppose that's done by using different keywords. For example:

  -netdev user,id=net0 -device e1000,netdev=net0

Here we are using "netdev" for the backend and "device" for the
frontend.

Since we have this difference, we can just make sure the ordering by
init netdev first (in net_init_clients()), then the devices (in
device_init_func()).

> 
> A nice side effect is that you can:
>  1. Limit the iommu scope only to the devices you want to protect (tweaking APCI tables)
>  2. In the future we can support multiple iommu devices.

Yes. Thanks,

-- peterx
