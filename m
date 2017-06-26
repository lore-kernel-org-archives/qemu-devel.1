Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vQ-L7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrQ-0004Pq-Mh
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:49171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrQ-0004Oi-D3
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:08 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-3-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 2/9] drm/i915/gvt: Apply g2h
 adjustment during fence mmio access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:59:12 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

Apply the guest to host gma conversion while guest config the
fence mmio registers due to the host gma change after the migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/aperture_gm.c |  6 ++++--
 drivers/gpu/drm/i915/gvt/gvt.h         | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index ca3d192..cd68ec6 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -144,8 +144,10 @@ void intel_vgpu_write_fence(struct intel_vgpu *vgpu,
 	I915_WRITE(fence_reg_lo, 0);
 	POSTING_READ(fence_reg_lo);
 
-	I915_WRITE(fence_reg_hi, upper_32_bits(value));
-	I915_WRITE(fence_reg_lo, lower_32_bits(value));
+	I915_WRITE(fence_reg_hi,
+			intel_gvt_reg_g2h(vgpu, upper_32_bits(value), 0xFFFFF000));
+	I915_WRITE(fence_reg_lo,
+			intel_gvt_reg_g2h(vgpu, lower_32_bits(value), 0xFFFFF000));
 	POSTING_READ(fence_reg_lo);
 }
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 3a74e79..71c00b2 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -451,6 +451,20 @@ int intel_gvt_ggtt_index_g2h(struct intel_vgpu *vgpu, unsigned long g_index,
 int intel_gvt_ggtt_h2g_index(struct intel_vgpu *vgpu, unsigned long h_index,
 			     unsigned long *g_index);
 
+/* apply guest to host gma convertion in GM registers setting */
+static inline u64 intel_gvt_reg_g2h(struct intel_vgpu *vgpu,
+		u32 addr, u32 mask)
+{
+	u64 gma;
+
+	if (addr) {
+		intel_gvt_ggtt_gmadr_g2h(vgpu,
+				addr & mask, &gma);
+		addr = gma | (addr & (~mask));
+	}
+	return addr;
+}
+
 void intel_vgpu_init_cfg_space(struct intel_vgpu *vgpu,
 		bool primary);
 void intel_vgpu_reset_cfg_space(struct intel_vgpu *vgpu);
-- 
2.7.4
