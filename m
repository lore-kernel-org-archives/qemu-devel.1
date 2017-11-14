Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eEkPE-0004QS-Hq
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eEkP9-0006eo-KZ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:12 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:19200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1eEkP9-0006aq-Bq
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:14:07 -0500
From: prasad.singamsetty@oracle.com
Date: Tue, 14 Nov 2017 18:13:48 -0500
Message-Id: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
Subject: [Qemu-devel] [PATCH v1 0/2] intel-iommu: Extend address width to 48
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, imammedo@redhat.com
Cc: peterx@redhat.com, konrad.wilk@oracle.com

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

This pair of patches extends the intel-iommu to support address
width to 48 bits. This is required to support qemu guest with large
memory (>=1TB). 

Patch1 implements changes to redefine macros and usage to
allow further changes to add support for 48 bit address width.
This patch doesn't change the existing functionality or behavior.

Patch2 adds support for 48 bit address width but keeping the
default to 39 bits.

NOTE: Peter Xu had originaly started on this enhancement
but it was not completed or integrated.

Unit testing done:

patch-1:
   * Boot vm with and without intel-iommu enabled
   * Boot vm with #cpus below and above 255 cpus
patch-2:
   * boot vm without "x-aw-bits" or "x-aw-bits=39": guest boots with 39
   * boot vm with "x-aw-bits=48": guest boots with 48 bits
   * boot vm with invalid value for x-aw-bits: guest fails to boot
   * boot vm with >=1TB memory and "x-aw-bits=48": guest boots

Prasad Singamsetty (2):
  intel-iommu: Redefine macros to enable supporting 48 bit address width
  intel-iommu: Extend address width to 48 bits

 hw/i386/acpi-build.c           |   3 +-
 hw/i386/intel_iommu.c          | 123 +++++++++++++++++++++++++----------------
 hw/i386/intel_iommu_internal.h |  43 +++++++++-----
 include/hw/i386/intel_iommu.h  |   7 ++-
 4 files changed, 110 insertions(+), 66 deletions(-)

-- 
2.14.0-rc1
