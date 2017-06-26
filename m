Received: from eggs.gnu.org ([2001:4830:134:3::10]:46311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vR-Ln
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrR-0004QM-Aw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrR-0004PL-2a
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:09 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-6-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 5/9] drm/i915/gvt: Align the guest gm
 aperture start offset for live migration
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

As guest gm aperture region start offset is initialized when vGPU created,
in order to make sure that start offset is remain the same after migration,
align the aperture start offset to 0 for guest.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 3 +--
 drivers/gpu/drm/i915/gvt/vgpu.c  | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 1ae0b40..d2b13ae 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1002,8 +1002,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 
 			sparse->nr_areas = nr_areas;
 			cap_type_id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
-			sparse->areas[0].offset =
-					PAGE_ALIGN(vgpu_aperture_offset(vgpu));
+			sparse->areas[0].offset = 0;
 			sparse->areas[0].size = vgpu_aperture_sz(vgpu);
 			break;
 
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 90c14e6..989f353 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -43,8 +43,7 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu)
 	vgpu_vreg(vgpu, vgtif_reg(version_minor)) = 0;
 	vgpu_vreg(vgpu, vgtif_reg(display_ready)) = 0;
 	vgpu_vreg(vgpu, vgtif_reg(vgt_id)) = vgpu->id;
-	vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) =
-		vgpu_aperture_gmadr_base(vgpu);
+	vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) = 0;
 	vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.size)) =
 		vgpu_aperture_sz(vgpu);
 	vgpu_vreg(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base)) =
@@ -480,6 +479,8 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 {
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_workload_scheduler *scheduler = &gvt->scheduler;
+	u64 maddr = vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base));
+	u64 unmaddr = vgpu_vreg(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base));
 
 	gvt_dbg_core("------------------------------------------\n");
 	gvt_dbg_core("resseting vgpu%d, dmlr %d, engine_mask %08x\n",
@@ -510,6 +511,8 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
 
 		intel_vgpu_reset_mmio(vgpu, dmlr);
 		populate_pvinfo_page(vgpu);
+		vgpu_vreg(vgpu, vgtif_reg(avail_rs.mappable_gmadr.base)) = maddr;
+		vgpu_vreg(vgpu, vgtif_reg(avail_rs.nonmappable_gmadr.base)) = unmaddr;
 		intel_vgpu_reset_display(vgpu);
 
 		if (dmlr) {
-- 
2.7.4
