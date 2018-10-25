Received: from eggs.gnu.org ([2001:4830:134:3::10]:57719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTtG-0002CD-2i
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTtC-00048B-E2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFTt8-0003y2-CO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:52:39 -0400
Date: Wed, 24 Oct 2018 20:52:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025005110.249256-3-mst@redhat.com>
References: <20181025005110.249256-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025005110.249256-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/28] intel_iommu: introduce
 vtd_reset_caches()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Provide the function and use it in vtd_init().  Used to reset both
context entry cache and iotlb cache for the whole IOMMU unit.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada19a6..1137861a9d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -227,6 +227,14 @@ static void vtd_reset_iotlb(IntelIOMMUState *s)
     vtd_iommu_unlock(s);
 }
 
+static void vtd_reset_caches(IntelIOMMUState *s)
+{
+    vtd_iommu_lock(s);
+    vtd_reset_iotlb_locked(s);
+    vtd_reset_context_cache_locked(s);
+    vtd_iommu_unlock(s);
+}
+
 static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
                                   uint32_t level)
 {
@@ -3160,10 +3168,7 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
-    vtd_iommu_lock(s);
-    vtd_reset_context_cache_locked(s);
-    vtd_reset_iotlb_locked(s);
-    vtd_iommu_unlock(s);
+    vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
     vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
-- 
MST
