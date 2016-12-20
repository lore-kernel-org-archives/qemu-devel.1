Received: from eggs.gnu.org ([2001:4830:134:3::10]:55617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJDSE-0003vP-2G
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 00:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJDSA-0008Kk-6a
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 00:59:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 20 Dec 2016 16:58:51 +1100
Message-Id: <20161220055857.9674-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv5 for 2.9 0/6] HPT resizing for pseries guests
 (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paulus@samba.org, sjitindarsingh@gmail.com
Cc: thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This series implements the host side of the PAPR ACR to allow runtime
resizing of the Hashed Page Table (HPT) for pseries guests.
Exercising this feature requires a guest OS which is also aware of it.
Patches to implement the guest side in Linux have just been submitted
upstream:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152164.html

Availability of the feature is controlled by a new 'resize-hpt'
machine option: it can be set to "disabled", "enabled" or "required".
The last means that qemu will refuse to boot a guest which is not
aware of the HPT resizing feature (it will instead quit during feature
negotiation).  This is potentially useful because guests which don't
support resizing will need an HPT sized for their maximum possible
RAM, which can be very wasteful of host resources.

This implementation will work for both TCG and KVM guests, but HV KVM
guests will require host kernel patches posted at:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152473.html

Patch 6/6 can be considered RFC - it can't really be merged until the
host kernel support is merged and we can update our header copies.
The rest I'm hoping are ready to stage to be merged as soon as
qemu-2.9 opens.

Changes since v4 (misposted as v3):
 * More minor revisions based on review comments
 * Altered to use new simpler encoding of kernel capability
Changes since v3:
 * Assorted minor revisions based on review
 * Added KVM support (PR and HV)
Changes since v2:
 * Some clearer comments based on review
 * Some minor cleanups based on review

David Gibson (6):
  pseries: Add pseries-2.9 machine type
  pseries: Stubs for HPT resizing
  pseries: Implement HPT resizing
  pseries: Enable HPT resizing for 2.9
  pseries: Use smaller default hash page tables when guest can resize
  pseries: Allow HPT resizing with KVM

 hw/ppc/spapr.c              | 126 +++++++++++-
 hw/ppc/spapr_hcall.c        | 464 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events         |   2 +
 include/hw/compat.h         |   3 +
 include/hw/ppc/spapr.h      |  19 ++
 include/hw/ppc/spapr_ovec.h |   1 +
 linux-headers/linux/kvm.h   |  11 ++
 target-ppc/kvm.c            |  51 +++++
 target-ppc/kvm_ppc.h        |  19 ++
 target-ppc/mmu-hash64.h     |   4 +
 10 files changed, 690 insertions(+), 10 deletions(-)

-- 
2.9.3
