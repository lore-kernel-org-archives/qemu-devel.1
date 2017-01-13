Received: from eggs.gnu.org ([2001:4830:134:3::10]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDt-0002wg-UQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDt-0007se-7o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRsDt-0007sA-25
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:13 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 13 Jan 2017 11:06:38 +0800
Message-Id: <1484276800-26814-13-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-1-git-send-email-peterx@redhat.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 12/14] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Before this one we only invalidate context cache when we receive context
entry invalidations. However it's possible that the invalidation also
contains a domain switch (only if cache-mode is enabled for vIOMMU). In
that case we need to notify all the registered components about the new
mapping.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 59bf683..fd75112 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1162,6 +1162,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 trace_vtd_inv_desc_cc_device(bus_n, (devfn_it >> 3) & 0x1f,
                                              devfn_it & 3);
                 vtd_as->context_cache_entry.context_cache_gen = 0;
+                memory_region_iommu_replay_all(&vtd_as->iommu);
             }
         }
     }
-- 
2.7.4
