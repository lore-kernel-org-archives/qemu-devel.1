Received: from eggs.gnu.org ([2001:4830:134:3::10]:49070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMoKN-0003x9-TH
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMoKN-0007dA-0P
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:07:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:25615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gMoKM-0007bU-P2
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:07:02 -0500
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Date: Wed, 14 Nov 2018 14:04:44 +0800
Message-Id: <1542175484-2742-4-git-send-email-yu.c.zhang@linux.intel.com>
In-Reply-To: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
References: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 3/3] intel-iommu: extend iotlb search logic
 to cover 57-bit IOVA.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>

The 64-bit key used by vtd_lookup_iotlb() to search the cached
mappings is formed by combining the GFN, source id and the page
level. To cover 57-bit IOVA, the shift of source id and of page
level need to be enlarged by 9 - the stride of one paging structure
level.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Richard Henderson <rth@twiddle.net> 
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index a7ef24b..2b29b6f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -114,8 +114,8 @@
                                      VTD_INTERRUPT_ADDR_FIRST + 1)
 
 /* The shift of source_id in the key of IOTLB hash table */
-#define VTD_IOTLB_SID_SHIFT         36
-#define VTD_IOTLB_LVL_SHIFT         52
+#define VTD_IOTLB_SID_SHIFT         45
+#define VTD_IOTLB_LVL_SHIFT         61
 #define VTD_IOTLB_MAX_SIZE          1024    /* Max size of the hash table */
 
 /* IOTLB_REG */
-- 
1.9.1
