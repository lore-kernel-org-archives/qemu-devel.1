Received: from eggs.gnu.org ([2001:4830:134:3::10]:50107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcsq-0007oF-Bd
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcsl-0007p2-Fr
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:25617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cfcsl-0007nT-6G
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:15 -0500
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Mon, 20 Feb 2017 09:28:03 +0800
Message-Id: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [Resend RFC PATCH 0/4] VT-d: Inject fault event from
 IOMMU hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, yi.l.liu@intel.com

Resend patchset due to wrong Qemu devel mail address. Sorry for noise.

This patchset proposes a solution for vIOMMU to get hardware IOMMU
fault event and info. Motivation is to make vIOMMU inject associated
fault event when pIOMMU reports fault event. vIOMMU is in charge of
transforming fault info and inject to guest. The feature is also very
important to support first level translation(Translation request with
PASID) in VM which requires vIOMMU to inject device page request to VM.

VFIO can get notification and read fault info via new VFIO cmds.
Add fault event handler in the memory IOMMU ops and Intel IOMMU 
device model needs to register its fault event callback. VFIO
will call the callback via memory wrapper function when get
fault notification.

This patches is prototype code and just passes build test. IOMMU driver
new interface is still in the design stage. This patches is to confirm
interface between Qemu and VFIO kernel driver is on the right way.

Very appreciate for comments. 

Lan Tianyu (4):
  VFIO: Set eventfd for IOMMU fault event via new vfio cmd
  Memory: Introduce IOMMU fault event callback
  Intel iommu: Add Intel IOMMU fault event callback
  VFIO: Read IOMMU fault info from kernel space when get fault event

 hw/i386/intel_iommu.c         | 25 ++++++++++++
 hw/vfio/common.c              | 88 +++++++++++++++++++++++++++++++++++++++++++
 include/exec/memory.h         | 19 ++++++++++
 include/hw/vfio/vfio-common.h |  3 ++
 linux-headers/linux/vfio.h    | 35 +++++++++++++++++
 memory.c                      |  8 ++++
 6 files changed, 178 insertions(+)

-- 
1.8.3.1
