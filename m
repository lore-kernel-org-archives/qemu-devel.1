Received: from eggs.gnu.org ([209.51.188.92]:51273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hB2Yh-0006l6-A3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hB2Yd-0002jt-Lv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:25:25 -0400
Date: Mon, 1 Apr 2019 13:25:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190401132512.2f84d036@x1.home>
In-Reply-To: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
References: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] spapr: Fix extended config
 space accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Mon, 01 Apr 2019 19:54:57 +0200
Greg Kurz <groug@kaod.org> wrote:

> Recent commit c2077e2ca0da7 added stricter checks that now prevent
> a guest to access the extended config space of a PCIe device connected
> attached to a PHB on a pseries machine.
> 
> PAPR compatible PHBs act like legacy PCI busses, but they do allow access
> to the full 4k config space of PCIe devices. As discussed several times on
> the list ([1] and [2]), we cannot really change PAPR PHB to have a true
> PCIe root bus since it would call for massive and unwanted changes in
> libvirt.
> 
> This series tries to address the issue with a new PCI bus class method
> that tells if the PCI bus supports extended config space accesses,
> instead of relying on pci_bus_is_express() which wants a PCIe root bus.
> A new legacy PCI bus type is added to implement the PAPR behaviour.
> 
> Note that this fixes a potential 4.0 regression, hence the for-4.0 tag.

Post-4.0, please also evaluate:

https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07164.html

Seems that PAPR only has one IOMMU AddressSpace per bus to return
through the iommu_fn so there should be no harm in aliasing the guest
view of devices, but if anything this series warns never to assume that
PAPR behaves normally.

FWIW, this series might make it easier to create a PCI-X Mode 2 bus,
which would otherwise be similar to conventional PCI for
inter-connectivity, but does support extended config space.  Though a
new bus type would be the more obvious way to do it, which clearly has
been a problem here.  Thanks,

Alex
