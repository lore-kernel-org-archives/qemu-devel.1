Received: from eggs.gnu.org ([2001:4830:134:3::10]:46306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vP-KJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrQ-0004Ph-6x
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:49171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrP-0004Oi-Th
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:08 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-2-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 1/9] drm/i915/gvt: Apply g2h adjust
 for GTT mmio access
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

Apply guest to host gma conversion while guest try to access the
GTT mmio registers, as after enable live migration the host gma
will be changed due to the resourece re-allocation, but guest
gma should be remaining unchanged, thus g2h conversion is request
for it.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 66374db..df596a6 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -59,8 +59,7 @@ bool intel_gvt_ggtt_validate_range(struct intel_vgpu *vgpu, u64 addr, u32 size)
 /* translate a guest gmadr to host gmadr */
 int intel_gvt_ggtt_gmadr_g2h(struct intel_vgpu *vgpu, u64 g_addr, u64 *h_addr)
 {
-	if (WARN(!vgpu_gmadr_is_valid(vgpu, g_addr),
-		 "invalid guest gmadr %llx\n", g_addr))
+	if (!vgpu_gmadr_is_valid(vgpu, g_addr))
 		return -EACCES;
 
 	if (vgpu_gmadr_is_aperture(vgpu, g_addr))
@@ -1819,17 +1818,15 @@ static int emulate_gtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
 	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	unsigned long g_gtt_index = off >> info->gtt_entry_size_shift;
-	unsigned long gma;
+	unsigned long h_gtt_index;
 	struct intel_gvt_gtt_entry e, m;
 	int ret;
 
 	if (bytes != 4 && bytes != 8)
 		return -EINVAL;
 
-	gma = g_gtt_index << GTT_PAGE_SHIFT;
-
 	/* the VM may configure the whole GM space when ballooning is used */
-	if (!vgpu_gmadr_is_valid(vgpu, gma))
+	if (intel_gvt_ggtt_index_g2h(vgpu, g_gtt_index, &h_gtt_index))
 		return 0;
 
 	ggtt_get_guest_entry(ggtt_mm, &e, g_gtt_index);
@@ -1852,7 +1849,7 @@ static int emulate_gtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 		ops->set_pfn(&m, gvt->gtt.scratch_ggtt_mfn);
 	}
 
-	ggtt_set_shadow_entry(ggtt_mm, &m, g_gtt_index);
+	ggtt_set_shadow_entry(ggtt_mm, &m, h_gtt_index);
 	gtt_invalidate(gvt->dev_priv);
 	ggtt_set_guest_entry(ggtt_mm, &e, g_gtt_index);
 	return 0;
-- 
2.7.4
