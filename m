Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmg9p-0000sA-7a
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dmg9j-0003k6-JH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:02:17 -0400
Date: Tue, 29 Aug 2017 10:01:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170829130159.GW15315@localhost.localdomain>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328021651.19350-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [RFC for-2.10 0/3] Rework handling of PCI/PCIe
 "hybrid" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, marcel@redhat.com, lersek@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

On Tue, Mar 28, 2017 at 01:16:48PM +1100, David Gibson wrote:
> A couple of devices - virtio-pci and XHCI - can present themselves to
> the guest as either PCI or PCIe devices depending on how they're
> attached.  However, the logic is a little different between the two
> devices.  In addition the logic in virtio makes it difficult to put a
> PCIe virtio device into a "pseries" guest because of the unusual way
> the paravirtualized PCI bus works there.

virtio-pci and xhci are not the only hybrid devices.  What about
vmxnet3, pvscsi, and vfio-pci?

> 
> This series makes the logic more consistent, and allows per-machine
> overrides to address that.
> 
> Currently patch 3/3 shows a non-obvious side effect of this change.  A
> PCIe virtio device is, by default, modern mode only, but the qtest
> logic doesn't handle modern-only virtio devices correctly.  We work
> around this by explicitly adding disable-legacy=off to the testcases.
> It would probably be better to update libqos so that it can handle
> modern virtio devices.
> 
> David Gibson (3):
>   pci/pcie: Make a consistent helper for switching PCI/PCIe "hybrid"
>     devices
>   pci: Allow host bridges to override PCI/PCIe hybrid device behaviour
>   pseries: Allow PCIe virtio and XHCI on pseries machine type
> 
>  hw/pci/pci.c              | 14 ++++++++++++++
>  hw/ppc/spapr_pci.c        |  9 +++++++++
>  hw/usb/hcd-xhci.c         |  2 +-
>  hw/virtio/virtio-pci.c    |  3 +--
>  include/hw/pci/pci.h      |  1 +
>  include/hw/pci/pci_host.h |  1 +
>  tests/virtio-9p-test.c    |  2 +-
>  tests/virtio-blk-test.c   |  4 ++--
>  tests/virtio-net-test.c   |  2 +-
>  tests/virtio-scsi-test.c  |  2 +-
>  10 files changed, 32 insertions(+), 8 deletions(-)
> 
> -- 
> 2.9.3
> 
> 

-- 
Eduardo
