Received: from eggs.gnu.org ([2001:4830:134:3::10]:57238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6X-00018O-JX
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6U-0000ya-Cc
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:62640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eFa6U-0000tS-3P
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:18 -0500
From: Chao Gao <chao.gao@intel.com>
Date: Fri, 17 Nov 2017 14:24:22 +0800
Message-Id: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/3] Qemu: add Xen vIOMMU interrupt
 remapping function support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chao Gao <chao.gao@intel.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

This patchset is to deal with MSI interrupt remapping request when guest
updates MSI registers.

In case of conflicts, this series also can be found in my personal github:
Xen: https://github.com/gc1008/viommu_xen.git vIOMMU4
Qemu: https://github.com/gc1008/viommu_qemu.git vIOMMU3

Any comments would be highly appreciated. And below is the change histroy

Changes from v2:
In last version, a new interface is used for binding a guest remappable msi
with a physical interrupt, while the old interface is used for binding
non-remappable msi. But for AMD, only from the MSI message itself, the
interrupt format cannot be infered. To address this, we decide to pass the
whole guest msi message to Xen and let vIOMMUs in Xen detemine whether
an given interrupt is remappable or not.
So the following changes are made:
- Instead of introducing a new interface for binding remapping format msi,
the exist interface is modified to support msi of both format.
- In patch 3, define MSI_ADDR_IF_MASK inside a function because
it is intel-specific. It is improper to define it in a common header.

Chao Gao (3):
  i386/msi: Correct mask of destination ID in MSI address
  xen/pt: Pass the whole msi addr/data to Xen
  msi: Handle remappable format interrupt request

 hw/i386/xen/xen-hvm.c         | 10 ++++++++-
 hw/pci/msi.c                  |  5 +++--
 hw/pci/msix.c                 |  4 +++-
 hw/xen/xen_pt_msi.c           | 49 ++++++++++++-------------------------------
 include/hw/i386/apic-msidef.h |  2 +-
 include/hw/xen/xen.h          |  2 +-
 stubs/xen-hvm.c               |  2 +-
 7 files changed, 31 insertions(+), 43 deletions(-)

-- 
1.8.3.1
