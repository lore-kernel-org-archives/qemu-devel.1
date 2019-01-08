Received: from eggs.gnu.org ([209.51.188.92]:37769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ggpr9-0007Kt-EA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ggpr8-0002sJ-C9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:47:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ggpr8-0002my-6p
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:47:38 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  8 Jan 2019 19:47:15 +0800
Message-Id: <20190108114720.21760-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] intel_iommu: misc fixes for error exposed
 after error_report_once()
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

Recently we have switched quite a few VT-d trace points into
error_report_once()s and this does expose some errors that we didn't
detect before (previously tracepoints won't trigger as long as
tracepoints weren't enabled).  These errors are not severe in that all
of them will not affect functionality of the guest otherwise we'll
notice them even earlier.  However it still worths to fix all of
them.  This patchset tries to fix quite a few errors like this (except
the last patch, which should also workaround an error but has nothing
to do with the newly introduced error_report_once).

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
Patch 5:    workaround of a kernel bug that could cause UNMAP fail error

It was tested that this series can fix all the error messages observed
in below bugs:

https://bugzilla.redhat.com/show_bug.cgi?id=1662270
https://bugzilla.redhat.com/show_bug.cgi?id=1662291

Please have a look, thanks.

Peter Xu (5):
  intel_iommu: fix operator in vtd_switch_address_space
  intel_iommu: reset intr_enabled when system reset
  pci/msi: export msi_is_masked()
  i386/kvm: ignore masked irqs when update msi routes
  vfio: retry one more time conditionally for type1 unmap

 hw/i386/intel_iommu.c |  3 ++-
 hw/pci/msi.c          |  2 +-
 hw/vfio/common.c      | 16 ++++++++++++++++
 hw/vfio/trace-events  |  1 +
 include/hw/pci/msi.h  |  1 +
 target/i386/kvm.c     | 14 +++++++++++---
 6 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.17.1
