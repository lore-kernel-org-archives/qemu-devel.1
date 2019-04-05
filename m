Received: from eggs.gnu.org ([209.51.188.92]:48905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0v-0003ay-4n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0t-0003ye-Vp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:49 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0t-0003tm-FD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: by mail-qt1-f180.google.com with SMTP id t28so9347676qte.6
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:47 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190329061422.7926-2-peterx@redhat.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] intel_iommu: Fix root_scalable migration
 breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Peter Xu <peterx@redhat.com>

When introducing the initial support for scalable mode we added a
new field into vmstate however we blindly migrate that field without
notice.  That'll break migration no matter forward or backward.

The normal way should be that we use something like
VMSTATE_UINT32_TEST() or subsections for the new vmstate field however
for this case of vt-d we can even make it simpler because we've
already migrated all the registers and it'll be fairly simple that we
re-generate root_scalable field from the register values during post
load of the device.

Fixes: fb43cf739e ("intel_iommu: scalable mode emulation")
Reviewed-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190329061422.7926-2-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 146cd16dd2..9318854c51 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -162,6 +162,15 @@ static inline void vtd_iommu_unlock(IntelIOMMUState *s)
     qemu_mutex_unlock(&s->iommu_lock);
 }
 
+static void vtd_update_scalable_state(IntelIOMMUState *s)
+{
+    uint64_t val = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
+
+    if (s->scalable_mode) {
+        s->root_scalable = val & VTD_RTADDR_SMT;
+    }
+}
+
 /* Whether the address space needs to notify new mappings */
 static inline gboolean vtd_as_has_map_notifier(VTDAddressSpace *as)
 {
@@ -1710,11 +1719,10 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
     s->root_extended = s->root & VTD_RTADDR_RTT;
-    if (s->scalable_mode) {
-        s->root_scalable = s->root & VTD_RTADDR_SMT;
-    }
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
+    vtd_update_scalable_state(s);
+
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
 }
 
@@ -2945,6 +2953,15 @@ static int vtd_post_load(void *opaque, int version_id)
      */
     vtd_switch_address_space_all(iommu);
 
+    /*
+     * We don't need to migrate the root_scalable because we can
+     * simply do the calculation after the loading is complete.  We
+     * can actually do similar things with root, dmar_enabled, etc.
+     * however since we've had them already so we'd better keep them
+     * for compatibility of migration.
+     */
+    vtd_update_scalable_state(iommu);
+
     return 0;
 }
 
@@ -2966,7 +2983,6 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
         VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
         VMSTATE_BOOL(root_extended, IntelIOMMUState),
-        VMSTATE_BOOL(root_scalable, IntelIOMMUState),
         VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
         VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
-- 
MST
