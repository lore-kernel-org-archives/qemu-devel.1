Received: from eggs.gnu.org ([2001:4830:134:3::10]:53748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gL5KQ-0004Wv-7m
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gL5KO-00076M-Tw
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:56447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gL5KO-00074h-Kd
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:56 -0500
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Date: Fri,  9 Nov 2018 19:49:46 +0800
Message-Id: <1541764187-10732-3-git-send-email-yu.c.zhang@linux.intel.com>
In-Reply-To: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 2/3] intel-iommu: extend VTD emulation to
 allow 57-bit IOVA address width.
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

A 5-level paging capable VM may choose to use 57-bit IOVA address width.
E.g. guest applications like DPDK prefer to use its VA as IOVA when
performing VFIO map/unmap operations, to avoid the burden of managing the
IOVA space.

This patch extends the current vIOMMU logic to cover the extended address
width. When creating a VM with 5-level paging feature, one can choose to
create a virtual VTD with 5-level paging capability, with configurations
like "-device intel-iommu,x-aw-bits=57".

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 54 ++++++++++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |  6 +++++
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e772fca..9cdf755 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -664,16 +664,16 @@ static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce,
 
 /*
  * Rsvd field masks for spte:
- *     Index [1] to [4] 4k pages
- *     Index [5] to [8] large pages
+ *     Index [1] to [5] 4k pages
+ *     Index [6] to [10] large pages
  */
-static uint64_t vtd_paging_entry_rsvd_field[9];
+static uint64_t vtd_paging_entry_rsvd_field[11];
 
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
     if (slpte & VTD_SL_PT_PAGE_SIZE_MASK) {
         /* Maybe large page */
-        return slpte & vtd_paging_entry_rsvd_field[level + 4];
+        return slpte & vtd_paging_entry_rsvd_field[level + 5];
     } else {
         return slpte & vtd_paging_entry_rsvd_field[level];
     }
@@ -3125,6 +3125,9 @@ static void vtd_init(IntelIOMMUState *s)
     if (s->aw_bits == VTD_AW_48BIT) {
         s->cap |= VTD_CAP_SAGAW_48bit;
     }
+    else if (s->aw_bits == VTD_AW_57BIT) {
+        s->cap |= VTD_CAP_SAGAW_57bit | VTD_CAP_SAGAW_48bit;
+    }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
     s->haw_bits = cpu->phys_bits;
 
@@ -3136,10 +3139,12 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->haw_bits);
     vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->haw_bits);
     vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->haw_bits);
-    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
-    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
-    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
-    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_PAGE_L5_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[9] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->haw_bits);
+    vtd_paging_entry_rsvd_field[10] = VTD_SPTE_LPAGE_L5_RSVD_MASK(s->haw_bits);
 
     if (x86_iommu->intr_supported) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
@@ -3238,6 +3243,23 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static bool host_has_la57(void)
+{
+    uint32_t ecx, unused;
+
+    host_cpuid(7, 0, &unused, &unused, &ecx, &unused);
+    return ecx & CPUID_7_0_ECX_LA57;
+}
+
+static bool guest_has_la57(void)
+{
+    CPUState *cs = first_cpu;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    return env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_LA57;
+}
+
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -3264,11 +3286,19 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
+    /* Currently address widths supported are 39, 48, and 57 bits */
     if ((s->aw_bits != VTD_AW_39BIT) &&
-        (s->aw_bits != VTD_AW_48BIT)) {
-        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
-                   VTD_AW_39BIT, VTD_AW_48BIT);
+        (s->aw_bits != VTD_AW_48BIT) &&
+        (s->aw_bits != VTD_AW_57BIT)) {
+        error_setg(errp, "Supported values for x-aw-bits are: %d, %d, %d",
+                   VTD_AW_39BIT, VTD_AW_48BIT, VTD_AW_57BIT);
+        return false;
+    }
+
+    if ((s->aw_bits == VTD_AW_57BIT) &&
+        !(host_has_la57() && guest_has_la57())) {
+        error_setg(errp, "Do not support 57-bit DMA address, unless both "
+                         "host and guest are capable of 5-level paging.\n");
         return false;
     }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d084099..a7ef24b 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -212,6 +212,8 @@
 #define VTD_CAP_SAGAW_39bit         (0x2ULL << VTD_CAP_SAGAW_SHIFT)
  /* 48-bit AGAW, 4-level page-table */
 #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
+ /* 57-bit AGAW, 5-level page-table */
+#define VTD_CAP_SAGAW_57bit         (0x8ULL << VTD_CAP_SAGAW_SHIFT)
 
 /* IQT_REG */
 #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
@@ -379,6 +381,8 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_PAGE_L5_RSVD_MASK(aw) \
+        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
@@ -387,6 +391,8 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+#define VTD_SPTE_LPAGE_L5_RSVD_MASK(aw) \
+        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 820451c..7474c4f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -49,6 +49,7 @@
 #define DMAR_REG_SIZE               0x230
 #define VTD_AW_39BIT                39
 #define VTD_AW_48BIT                48
+#define VTD_AW_57BIT                57
 #define VTD_ADDRESS_WIDTH           VTD_AW_39BIT
 #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
 
-- 
1.9.1
