Received: from eggs.gnu.org ([2001:4830:134:3::10]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1gNAcY-0003wQ-8F
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 00:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1gNAcP-0007z4-56
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 00:55:17 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:41062)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1gNAcO-0007tv-K1
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 00:55:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Nov 2018 16:55:02 +1100
From: geoff@hostfission.com
In-Reply-To: <154222737752.9288.484557356059052047.stgit@gimli.home>
References: <154222737752.9288.484557356059052047.stgit@gimli.home>
Message-ID: <f3bf1ef5b1be32f03377ca66ba415c70@hostfission.com>
Subject: Re: [Qemu-devel] [RFC for-3.2 PATCH 0/7] pcie: Enhanced link speed
 and width support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com

I can confirm that these patches work as expected. Thank you kindly Alex 
for your hard work!

Tested-by: Geoffrey McRae <geoff@hostfission.com>

On 2018-11-15 07:50, Alex Williamson wrote:
> QEMU exposes gen1 PCI-express interconnect devices supporting only
> 2.5GT/s and x1 width.  It might not seem obvious that a virtual
> bandwidth limitation can result in a real performance degradation, but
> it's been reported that in some configurations assigned GPUs might not
> scale their link speed up to the maximum supported value if the
> downstream port above it only advertises limited link support.
> 
> As proposed[1] this series effectively implements virtual link
> negotiation on downstream ports and enhances the generic PCIe root
> port to allow user configurable speeds and widths.  The "negotiation"
> simply mirrors the link status of the connected downstream device
> providing the appearance of dynamic link speed scaling to match the
> endpoint device.  Not yet implemented from the proposal is support
> for globally updating defaults based on machine type, though the
> foundation is provided here by allowing supporting PCIESlots to
> implement an instance_init callback which can call into a common
> helper for this.
> 
> I have not specifically tested migration with this, but we already
> consider LNKSTA to be dynamic and the other changes implemented here
> are static config space changes with no changes being implemented for
> devices using default values, ie. they should be compatible by virtue
> of existing config space migration support.
> 
> I think I've covered the required link related registers to support
> PCIe 4.0, but please let me know if I've missed any.
> 
> Testing and feedback appreciated, patch 6/7 provides example qemu:arg
> options and requirements to use with existing libvirt.  Native libvirt
> support TBD.  Thanks,
> 
> Alex
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03086.html
> 
> ---
> 
> Alex Williamson (7):
>       pcie: Create enums for link speed and width
>       pci: Sync PCIe downstream port LNKSTA on read
>       qapi: Define PCIe link speed and width properties
>       pcie: Add link speed and width fields to PCIESlot
>       pcie: Fill PCIESlot link fields to support higher speeds and 
> widths
>       pcie: Allow generic PCIe root port to specify link speed and 
> width
>       vfio/pci: Remove PCIe Link Status emulation
> 
> 
>  hw/core/qdev-properties.c          |  178 
> ++++++++++++++++++++++++++++++++++++
>  hw/pci-bridge/gen_pcie_root_port.c |    2
>  hw/pci-bridge/pcie_root_port.c     |   14 +++
>  hw/pci/pci.c                       |    4 +
>  hw/pci/pcie.c                      |  118 +++++++++++++++++++++++-
>  hw/vfio/pci.c                      |    9 --
>  include/hw/pci/pci.h               |   13 +++
>  include/hw/pci/pcie.h              |    1
>  include/hw/pci/pcie_port.h         |    4 +
>  include/hw/pci/pcie_regs.h         |   23 ++++-
>  include/hw/qdev-properties.h       |    8 ++
>  qapi/common.json                   |   42 ++++++++
>  12 files changed, 404 insertions(+), 12 deletions(-)
