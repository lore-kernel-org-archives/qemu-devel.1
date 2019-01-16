Received: from eggs.gnu.org ([209.51.188.92]:54696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbnM-0003Lz-2e
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbZ9-0002dW-Rm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjbZ9-0002Zt-HW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:31 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 16 Jan 2019 11:08:11 +0800
Message-Id: <20190116030815.27273-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] intel_iommu: misc fixes for error
 exposed after error_report_once()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

v2:
- dropping the last vfio patch
- add acked-by for Jason on 1&2 patches

Recently we have switched quite a few VT-d trace points into
error_report_once()s and this does expose some errors that we didn't
detect before (previously tracepoints won't trigger as long as
tracepoints weren't enabled).  These errors are not severe in that all
of them will not affect functionality of the guest otherwise we'll
notice them even earlier.  However it still worths to fix all of
them.  This patchset tries to fix quite a few errors like this.

All the errors could easily be triggered by rebooting a guest with
both vfio-pci device and vIOMMU, and we can see errors dumped in
stderr like:

qemu-kvm: vtd_iova_to_slpte: detected slpte permission error (iova=0xffd9ce00, level=0x2, slpte=0x0, write=1)
qemu-kvm: vtd_iommu_translate: detected translation failure (dev=02:00:00, iova=0x0)
qemu-kvm: vtd_interrupt_remap_msi: MSI address low 32 bit invalid: 0x0

Regarding to the patchset itself:

Patch 1:    fixes slpte permission error warning
Patch 2:    fixes intr_enabled flag reset missing
Patch 3-4:  fixes MSI translation warning

It was tested that this series can fix all the error messages observed
in below bugs:

https://bugzilla.redhat.com/show_bug.cgi?id=1662270
https://bugzilla.redhat.com/show_bug.cgi?id=1662291

Please have a look, thanks.

Peter Xu (4):
  intel_iommu: fix operator in vtd_switch_address_space
  intel_iommu: reset intr_enabled when system reset
  pci/msi: export msi_is_masked()
  i386/kvm: ignore masked irqs when update msi routes

 hw/i386/intel_iommu.c |  3 ++-
 hw/pci/msi.c          |  2 +-
 include/hw/pci/msi.h  |  1 +
 target/i386/kvm.c     | 14 +++++++++++---
 4 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.17.1
