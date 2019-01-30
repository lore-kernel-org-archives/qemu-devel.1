Received: from eggs.gnu.org ([209.51.188.92]:54320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie3-0004IK-W9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie1-0005MC-JG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:63851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1goidm-0005Gl-G2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:32 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Wed, 30 Jan 2019 13:09:10 +0800
Message-Id: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, Yi Sun <yi.y.sun@linux.intel.com>

Intel vt-d rev3.0 [1] introduces a new translation mode called
'scalable mode', which enables PASID-granular translations for
first level, second level, nested and pass-through modes. The
vt-d scalable mode is the key ingredient to enable Scalable I/O
Virtualization (Scalable IOV) [2] [3], which allows sharing a
device in minimal possible granularity (ADI - Assignable Device
Interface). As a result, previous Extended Context (ECS) mode
is deprecated (no production ever implements ECS).

This patch set emulates a minimal capability set of VT-d scalable
mode, equivalent to what is available in VT-d legacy mode today:
    1. Scalable mode root entry, context entry and PASID table
    2. Seconds level translation under scalable mode
    3. Queued invalidation (with 256 bits descriptor)
    4. Pass-through mode

Corresponding intel-iommu driver support will be included in
kernel 5.0:
    https://www.spinics.net/lists/kernel/msg2985279.html

We will add emulation of full scalable mode capability along with
guest iommu driver progress later, e.g.:
    1. First level translation
    2. Nested translation
    3. Per-PASID invalidation descriptors
    4. Page request services for handling recoverable faults

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf

Liu, Yi L (2):
  intel_iommu: scalable mode emulation
  intel_iommu: add 256 bits qi_desc support

Yi Sun (1):
  intel_iommu: add scalable-mode option to make scalable mode work

 hw/i386/intel_iommu.c          | 732 ++++++++++++++++++++++++++++++++---------
 hw/i386/intel_iommu_internal.h |  57 +++-
 hw/i386/trace-events           |   2 +-
 include/hw/i386/intel_iommu.h  |  20 +-
 4 files changed, 644 insertions(+), 167 deletions(-)

-- 
1.9.1
