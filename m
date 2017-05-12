Received: from eggs.gnu.org ([2001:4830:134:3::10]:58998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92lF-000479-H0
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d92lA-0008K9-T0
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:05:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 May 2017 15:04:46 +1000
Message-Id: <20170512050451.9979-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv6 0/5] HPT resizing for pseries guests (qemu
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, aik@ozlabs.ru
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, benh@kernel.crashing.org, David Gibson <david@gibson.dropbear.id.au>

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

 hw/ppc/spapr.c              | 105 ++++++++++-
 hw/ppc/spapr_hcall.c        | 430 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events         |   2 +
 include/hw/ppc/spapr.h      |  19 ++
 include/hw/ppc/spapr_ovec.h |   1 +
 target/ppc/kvm.c            |  75 ++++++++
 target/ppc/kvm_ppc.h        |  26 +++
 target/ppc/mmu-hash64.h     |   4 +
 8 files changed, 654 insertions(+), 8 deletions(-)

-- 
2.9.3
