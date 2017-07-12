Received: from eggs.gnu.org ([2001:4830:134:3::10]:49607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVHQi-0001sT-Jf
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVHQh-0001hy-DY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:11:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jul 2017 23:11:35 +1000
Message-Id: <20170712131140.18146-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv7 0/5] HPT resizing for pseries guests (qemu
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org, danielhb@linux.vnet.ibm.com
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This series implements the host side of the PAPR ACR to allow runtime
resizing of the Hashed Page Table (HPT) for pseries guests.
Exercising this feature requires a guest OS which is also aware of it.
Patches to implement the guest side in Linux are upstream as of v4.11.

Availability of the feature is controlled by a new 'resize-hpt'
machine option: it can be set to "disabled", "enabled" or "required".
The last means that qemu will refuse to boot a guest which is not
aware of the HPT resizing feature (it will instead quit during feature
negotiation).  This is potentially useful because guests which don't
support resizing will need an HPT sized for their maximum possible
RAM, which can be very wasteful of host resources.

This implementation will work for both TCG and KVM guests.  HV KVM
requires support in the host kernel which is also included in v4.11.

Changes since v6:
 * Rebase for current tree
 * Adjustments to fail gracefully for POWER9 RPT guests
Changes since v5:
 * Rebase for qemu-2.10
 * Kernel patches now merged
 * Removed an unnecessary and possibly dangerous assert()
Changes since v4 (misposted as v3):
 * More minor revisions based on review comments
 * Altered to use new simpler encoding of kernel capability
Changes since v3:
 * Assorted minor revisions based on review
 * Added KVM support (PR and HV)
Changes since v2:
 * Some clearer comments based on review
 * Some minor cleanups based on review

David Gibson (5):
  pseries: Stubs for HPT resizing
  pseries: Implement HPT resizing
  pseries: Enable HPT resizing for 2.10
  pseries: Use smaller default hash page tables when guest can resize
  pseries: Allow HPT resizing with KVM

 hw/ppc/spapr.c              | 103 ++++++++++-
 hw/ppc/spapr_hcall.c        | 439 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events         |   2 +
 include/hw/ppc/spapr.h      |  19 ++
 include/hw/ppc/spapr_ovec.h |   1 +
 target/ppc/kvm.c            |  76 ++++++++
 target/ppc/kvm_ppc.h        |  26 +++
 target/ppc/mmu-hash64.h     |   4 +
 8 files changed, 662 insertions(+), 8 deletions(-)

-- 
2.9.4
