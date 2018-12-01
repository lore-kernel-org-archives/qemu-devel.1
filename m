Received: from eggs.gnu.org ([2001:4830:134:3::10]:42170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gT3bz-0006Yp-1Y
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gT3bu-0004HF-TU
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:39:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gT3bu-0004Gh-MQ
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 06:38:58 -0500
Date: Sat, 1 Dec 2018 11:38:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181201113842.GC3436@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <154362272919.7153.15101701755308287523.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154362272919.7153.15101701755308287523.stgit@gimli.home>
Subject: Re: [Qemu-devel] [for-3.2 PATCH 0/9] pcie: Enhanced link speed and
 width support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

NB, next QEMU version is 4.0, not 3.2, since we bump for first release
of each year as mentioned here https://www.qemu.org/download/

On Fri, Nov 30, 2018 at 05:13:23PM -0700, Alex Williamson wrote:
> RFC->v1:
>  - Add Cc reported by get_maintainer
>  - Fixup some commit logs (no code changes in patches 1-7)
>  - Add Geoffrey's Tested-by
>  - Add patches 8 & 9 which define a QEMU 3.2 machine type and cranking
>    up the link speed and width for that machine type while maintaining
>    compatibile speeds for older machine types (testing requested for
>    non-x86 machine types)
>  - Various other users have also reported success with this series
>    (/r/VFIO)
> 
> Original cover letter:
> 
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
> ---
> 
> Alex Williamson (9):
>       pcie: Create enums for link speed and width
>       pci: Sync PCIe downstream port LNKSTA on read
>       qapi: Define PCIe link speed and width properties
>       pcie: Add link speed and width fields to PCIESlot
>       pcie: Fill PCIESlot link fields to support higher speeds and widths
>       pcie: Allow generic PCIe root port to specify link speed and width
>       vfio/pci: Remove PCIe Link Status emulation
>       q35/440fx/arm/spapr: Add QEMU 3.2 machine type
>       pcie: Fast PCIe root ports for new machines
> 
> 
>  hw/arm/virt.c                      |   19 +++-
>  hw/core/qdev-properties.c          |  178 ++++++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c                  |   15 ++-
>  hw/i386/pc_q35.c                   |   13 ++-
>  hw/pci-bridge/gen_pcie_root_port.c |    2 
>  hw/pci-bridge/pcie_root_port.c     |   14 +++
>  hw/pci/pci.c                       |    4 +
>  hw/pci/pcie.c                      |  118 +++++++++++++++++++++++-
>  hw/ppc/spapr.c                     |   25 ++++-
>  hw/vfio/pci.c                      |    9 --
>  include/hw/compat.h                |   11 ++
>  include/hw/i386/pc.h               |    3 +
>  include/hw/pci/pci.h               |   13 +++
>  include/hw/pci/pcie.h              |    1 
>  include/hw/pci/pcie_port.h         |    4 +
>  include/hw/pci/pcie_regs.h         |   23 ++++-
>  include/hw/qdev-properties.h       |    8 ++
>  qapi/common.json                   |   42 ++++++++
>  18 files changed, 480 insertions(+), 22 deletions(-)
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
