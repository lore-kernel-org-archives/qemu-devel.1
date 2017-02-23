Received: from eggs.gnu.org ([2001:4830:134:3::10]:38969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgoZg-0007jS-9O
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgoZc-0004Ti-6e
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cgoZc-0004Tc-0z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:16:24 -0500
Date: Thu, 23 Feb 2017 16:16:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170223081616.GI4015@pxdev.xzpeter.org>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, yi.l.liu@intel.com, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 23, 2017 at 10:10:57AM +0200, Marcel Apfelbaum wrote:
> On 02/23/2017 05:06 AM, Peter Xu wrote:
> >On Wed, Feb 22, 2017 at 10:30:47AM -0700, Alex Williamson wrote:
> >>On Wed, 22 Feb 2017 13:49:25 +0800
> >>Peter Xu <peterx@redhat.com> wrote:
> >>
> >>>Intel vIOMMU devices are created with "-device" parameter, while here
> >>>actually we need to make sure this device will be created before some
> >>>other PCI devices (like vfio-pci devices) so that we know iommu_fn will
> >>>be setup correctly before realizations of those PCI devices.
> >>>
> >>>Here we do explicit check to make sure intel-iommu device will be inited
> >>>before all the rest of the PCI devices. This is done by checking against
> >>>the devices dangled under current root PCIe bus and we should see
> >>>nothing there besides integrated ICH9 ones.
> 
> Hi,
> 
> Commit b86eacb8 (hw/pci: delay bus_master_enable_region initialization)
> creates the IOMMU memory region at machine_done time so the
> devices creation order wouldn't matter.
> 
> I don't think we use the iommu_fn before machine_done.
> What have I missed?

Hi, Marcel,

The problem is that vfio-pci will need to fetch the pci address space
during realization (pci_device_iommu_address_space() is called in
vfio_realize()).

Any thoughts? Thanks,

-- peterx
