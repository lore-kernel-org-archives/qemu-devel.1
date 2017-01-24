Received: from eggs.gnu.org ([2001:4830:134:3::10]:53523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyKM-00066T-Ve
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyKK-0006n7-CX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:27:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVyKK-0006lj-6A
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:27:48 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Jan 2017 18:26:09 +0800
Message-Id: <1485253571-19058-17-git-send-email-peterx@redhat.com>
In-Reply-To: <1485253571-19058-1-git-send-email-peterx@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/18] intel_iommu: do replay when context
 invalidate
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
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a79250b..9d9a38d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1115,6 +1115,16 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
                                              VTD_PCI_FUNC(devfn_it));
                 vtd_as->context_cache_entry.context_cache_gen = 0;
+                /*
+                 * So a device is moving out of (or moving into) a
+                 * domain, a replay() suites here to notify all the
+                 * IOMMU_NOTIFIER_MAP registers about this change.
+                 * This won't bring bad even if we have no such
+                 * notifier registered - the IOMMU notification
+                 * framework will skip MAP notifications if that
+                 * happened.
+                 */
+                memory_region_iommu_replay_all(&vtd_as->iommu);
             }
         }
     }
-- 
2.7.4
