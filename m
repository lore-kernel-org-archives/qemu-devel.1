Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzk-0006wZ-F0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzd-0002tj-9a
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHzc-0002t8-Tq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:13 -0500
Date: Tue, 18 Dec 2018 11:13:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-21-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/30] intel_iommu: dma read/write draining
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Yu Wang <wyu@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Support DMA read/write draining should be easy for existing VT-d
emulation since the emulation itself does not have any request queue
there so we don't need to do anything to flush the un-commited queue.
What we need to do is to declare the support.

These capabilities are required to pass Windows SVVP test program.  It
is verified that when with parameters "x-aw-bits=48,caching-mode=off"
we can pass the Windows SVVP test with this patch applied.  Otherwise
we'll fail with:

        IOMMU[0] - DWD (DMA write draining) not supported
        IOMMU[0] - DWD (DMA read draining) not supported
        Segment 0 has no DMA remapping capable IOMMU units

However since these bits are not declared support for QEMU<=3.1, we'll
need a compatibility bit for it and we turn this on by default only
for QEMU>=4.0.

Please refer to VT-d spec 6.5.4 for more information.

CC: Yu Wang <wyu@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1654550
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 3 +++
 include/hw/i386/intel_iommu.h  | 1 +
 include/hw/i386/pc.h           | 5 +++++
 hw/i386/intel_iommu.c          | 4 ++++
 4 files changed, 13 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d084099ed9..00e9edbc66 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -203,6 +203,9 @@
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
 #define VTD_CAP_PSI                 (1ULL << 39)
 #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
+#define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
+#define VTD_CAP_DRAIN_READ          (1ULL << 55)
+#define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 
 /* Supported Adjusted Guest Address Widths */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index ed4e758273..a321cc9691 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -245,6 +245,7 @@ struct IntelIOMMUState {
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
+    bool dma_drain;                 /* Whether DMA r/w draining enabled */
 
     /*
      * Protects IOMMU states in general.  Currently it protects the
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9d29c4b1df..c7c0c944e8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -296,6 +296,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_3_1 \
     HW_COMPAT_3_1 \
+    {\
+        .driver   = "intel-iommu",\
+        .property = "dma-drain",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4806d7edb4..26cc731c7b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2659,6 +2659,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("x-aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
+    DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3147,6 +3148,9 @@ static void vtd_init(IntelIOMMUState *s)
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
              VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
+    if (s->dma_drain) {
+        s->cap |= VTD_CAP_DRAIN;
+    }
     if (s->aw_bits == VTD_HOST_AW_48BIT) {
         s->cap |= VTD_CAP_SAGAW_48bit;
     }
-- 
MST
