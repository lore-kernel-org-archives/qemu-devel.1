Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vT-MY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrR-0004QD-5n
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:49171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrQ-0004Oi-SZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:09 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-5-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 4/9] drm/i915/gvt: Retrieve the guest
 gm base address from PVINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:59:13 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

As after migration the host gm base address will be changed due
to resource re-allocation, in order to make sure the guest gm
address doesn't change with that to retrieve the guest gm base
address from PVINFO.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c |  3 ++-
 drivers/gpu/drm/i915/gvt/gtt.c       |  8 ++++----
 drivers/gpu/drm/i915/gvt/gvt.h       | 22 ++++++++++++++++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index 40af17e..b57ae44 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -33,6 +33,7 @@
 
 #include "i915_drv.h"
 #include "gvt.h"
+#include "i915_pvinfo.h"
 
 enum {
 	INTEL_GVT_PCI_BAR_GTTMMIO = 0,
@@ -123,7 +124,7 @@ static int map_aperture(struct intel_vgpu *vgpu, bool map)
 	else
 		val = *(u32 *)(vgpu_cfg_space(vgpu) + PCI_BASE_ADDRESS_2);
 
-	first_gfn = (val + vgpu_aperture_offset(vgpu)) >> PAGE_SHIFT;
+	first_gfn = (val + vgpu_guest_aperture_offset(vgpu)) >> PAGE_SHIFT;
 	first_mfn = vgpu_aperture_pa_base(vgpu) >> PAGE_SHIFT;
 
 	ret = intel_gvt_hypervisor_map_gfn_to_mfn(vgpu, first_gfn,
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index df596a6..e9a127c 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -64,10 +64,10 @@ int intel_gvt_ggtt_gmadr_g2h(struct intel_vgpu *vgpu, u64 g_addr, u64 *h_addr)
 
 	if (vgpu_gmadr_is_aperture(vgpu, g_addr))
 		*h_addr = vgpu_aperture_gmadr_base(vgpu)
-			  + (g_addr - vgpu_aperture_offset(vgpu));
+			  + (g_addr - vgpu_guest_aperture_gmadr_base(vgpu));
 	else
 		*h_addr = vgpu_hidden_gmadr_base(vgpu)
-			  + (g_addr - vgpu_hidden_offset(vgpu));
+			  + (g_addr - vgpu_guest_hidden_gmadr_base(vgpu));
 	return 0;
 }
 
@@ -79,10 +79,10 @@ int intel_gvt_ggtt_gmadr_h2g(struct intel_vgpu *vgpu, u64 h_addr, u64 *g_addr)
 		return -EACCES;
 
 	if (gvt_gmadr_is_aperture(vgpu->gvt, h_addr))
-		*g_addr = vgpu_aperture_gmadr_base(vgpu)
+		*g_addr = vgpu_guest_aperture_gmadr_base(vgpu)
 			+ (h_addr - gvt_aperture_gmadr_base(vgpu->gvt));
 	else
-		*g_addr = vgpu_hidden_gmadr_base(vgpu)
+		*g_addr = vgpu_guest_hidden_gmadr_base(vgpu)
 			+ (h_addr - gvt_hidden_gmadr_base(vgpu->gvt));
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 71c00b2..23eeb7c 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -343,6 +343,20 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt);
 #define vgpu_fence_base(vgpu) (vgpu->fence.base)
 #define vgpu_fence_sz(vgpu) (vgpu->fence.size)
 
+/* Aperture/GM space definitions for vGPU Guest view point */
+#define vgpu_guest_aperture_offset(vgpu) \
+	vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base))
+#define vgpu_guest_hidden_offset(vgpu)	\
+	vgpu_vreg(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base))
+
+#define vgpu_guest_aperture_gmadr_base(vgpu) (vgpu_guest_aperture_offset(vgpu))
+#define vgpu_guest_aperture_gmadr_end(vgpu) \
+	(vgpu_guest_aperture_gmadr_base(vgpu) + vgpu_aperture_sz(vgpu) - 1)
+
+#define vgpu_guest_hidden_gmadr_base(vgpu) (vgpu_guest_hidden_offset(vgpu))
+#define vgpu_guest_hidden_gmadr_end(vgpu) \
+	(vgpu_guest_hidden_gmadr_base(vgpu) + vgpu_hidden_sz(vgpu) - 1)
+
 struct intel_vgpu_creation_params {
 	__u64 handle;
 	__u64 low_gm_sz;  /* in MB */
@@ -420,12 +434,12 @@ void intel_gvt_deactivate_vgpu(struct intel_vgpu *vgpu);
 
 /* validating GM functions */
 #define vgpu_gmadr_is_aperture(vgpu, gmadr) \
-	((gmadr >= vgpu_aperture_gmadr_base(vgpu)) && \
-	 (gmadr <= vgpu_aperture_gmadr_end(vgpu)))
+	((gmadr >= vgpu_guest_aperture_gmadr_base(vgpu)) && \
+	 (gmadr <= vgpu_guest_aperture_gmadr_end(vgpu)))
 
 #define vgpu_gmadr_is_hidden(vgpu, gmadr) \
-	((gmadr >= vgpu_hidden_gmadr_base(vgpu)) && \
-	 (gmadr <= vgpu_hidden_gmadr_end(vgpu)))
+	((gmadr >= vgpu_guest_hidden_gmadr_base(vgpu)) && \
+	 (gmadr <= vgpu_guest_hidden_gmadr_end(vgpu)))
 
 #define vgpu_gmadr_is_valid(vgpu, gmadr) \
 	 ((vgpu_gmadr_is_aperture(vgpu, gmadr) || \
-- 
2.7.4
