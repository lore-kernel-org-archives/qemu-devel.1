Received: from eggs.gnu.org ([2001:4830:134:3::10]:33582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePsTT-0000wx-0K
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePsTP-0006uB-6r
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:04:35 -0500
Date: Fri, 15 Dec 2017 09:04:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171215090428.214cc474@w520.home>
In-Reply-To: <20171215040731.GD7753@umbus.fritz.box>
References: <20171212052131.24649-1-aik@ozlabs.ru>
	<20171215040731.GD7753@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: vfio-pci: Allow mmap of MSIX BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Fri, 15 Dec 2017 15:07:31 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Dec 12, 2017 at 04:21:31PM +1100, Alexey Kardashevskiy wrote:
> > This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> > which tells that a region with MSIX data can be mapped entirely, i.e.
> > the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
> > 
> > This adds a "msix-no-mmap" property to the vfio-pci device, it is "true"
> > by default and "false" for pseries-2.12+ machines.
> > 
> > This requites kernel's "vfio-pci: Allow mapping MSIX BAR"
> > https://www.spinics.net/lists/kvm/msg160282.html
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > 
> > This is an RFC as it requires kernel headers update which is not there yet.
> > 
> > I'd like to make it "msix-mmap" (without "no") but could not find a way
> > of enabling a device property for machine versions newer than some value.
> > 
> > I changed 2.11 machine just for the demonstration purpose.  
> 
> As Alex says, the mmap()ability of the MSI-X BAR isn't really the
> point.  The point is whether we need to intercept guest MMIOs to the
> MSI-X region.  Still, the logic's basically right, just rename your
> property to, say, "intercept_msix_mmio".  It would be true by default,
> set to false by the pseries machine type.
> 
> I don't think you actually need to make it vary depending on the
> version of the pseries machine type: whether the BAR is mmap()ed or
> qemu emulated shouldn't be a guest visible change.  No PAPR guest
> should have been directly poking the MSI-X region (ever), so we
> shouldn't need to intercept the region even for old versions.

I have to ask, is the vfio-pci driver really the right point in the VM
to be understanding whether the platform requires MSI-X MMIO
emulation?  vfio-pci is only unique here in that enabling that
emulation harms performance, but AIUI it's unused on any device and
there may eventually be other devices affected in the same way as
vfio-pci.  So should there be some post-realize platform code that
disables MSI-X MemoryRegions or should the MSI-X code call out to some
platform hook to determine whether to enable emulation?  Seems like a
case where the impact might be unique to vfio, but the root of the
problem is not.  Thanks,

Alex
