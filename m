Received: from eggs.gnu.org ([2001:4830:134:3::10]:46316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vU-MT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrQ-0004Q1-Sp
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrQ-0004PL-J8
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:08 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-4-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 3/9] drm/i915/gvt: Adjust the gma
 parameter in gpu commands during command parser
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

Adjust the gma parameter in gpu commands according to the shift
offset in guests' aperture and hidden gm address, and patch
the commands before submit to execute.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/cmd_parser.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
index 51241de5..540ee42 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -922,7 +922,7 @@ static int cmd_handler_lrr(struct parser_exec_state *s)
 }
 
 static inline int cmd_address_audit(struct parser_exec_state *s,
-		unsigned long guest_gma, int op_size, bool index_mode);
+		unsigned long guest_gma, int op_size, bool index_mode, int offset);
 
 static int cmd_handler_lrm(struct parser_exec_state *s)
 {
@@ -942,7 +942,7 @@ static int cmd_handler_lrm(struct parser_exec_state *s)
 			gma = cmd_gma(s, i + 1);
 			if (gmadr_bytes == 8)
 				gma |= (cmd_gma_hi(s, i + 2)) << 32;
-			ret |= cmd_address_audit(s, gma, sizeof(u32), false);
+			ret |= cmd_address_audit(s, gma, sizeof(u32), false, i + 1);
 		}
 		i += gmadr_dw_number(s) + 1;
 	}
@@ -962,7 +962,7 @@ static int cmd_handler_srm(struct parser_exec_state *s)
 			gma = cmd_gma(s, i + 1);
 			if (gmadr_bytes == 8)
 				gma |= (cmd_gma_hi(s, i + 2)) << 32;
-			ret |= cmd_address_audit(s, gma, sizeof(u32), false);
+			ret |= cmd_address_audit(s, gma, sizeof(u32), false, i + 1);
 		}
 		i += gmadr_dw_number(s) + 1;
 	}
@@ -1032,7 +1032,7 @@ static int cmd_handler_pipe_control(struct parser_exec_state *s)
 				if (cmd_val(s, 1) & (1 << 21))
 					index_mode = true;
 				ret |= cmd_address_audit(s, gma, sizeof(u64),
-						index_mode);
+						index_mode, 2);
 			}
 		}
 	}
@@ -1364,10 +1364,12 @@ static unsigned long get_gma_bb_from_cmd(struct parser_exec_state *s, int index)
 }
 
 static inline int cmd_address_audit(struct parser_exec_state *s,
-		unsigned long guest_gma, int op_size, bool index_mode)
+		unsigned long guest_gma, int op_size, bool index_mode, int offset)
 {
 	struct intel_vgpu *vgpu = s->vgpu;
 	u32 max_surface_size = vgpu->gvt->device_info.max_surface_size;
+	int gmadr_bytes = vgpu->gvt->device_info.gmadr_bytes_in_cmd;
+	u64 host_gma;
 	int i;
 	int ret;
 
@@ -1387,6 +1389,14 @@ static inline int cmd_address_audit(struct parser_exec_state *s,
 					      guest_gma + op_size - 1))) {
 		ret = -EINVAL;
 		goto err;
+	} else
+		intel_gvt_ggtt_gmadr_g2h(vgpu, guest_gma, &host_gma);
+
+	if (offset > 0) {
+		patch_value(s, cmd_ptr(s, offset), host_gma & GENMASK(31, 2));
+		if (gmadr_bytes == 8)
+			patch_value(s, cmd_ptr(s, offset + 1),
+				(host_gma >> 32) & GENMASK(15, 0));
 	}
 	return 0;
 err:
@@ -1429,7 +1439,7 @@ static int cmd_handler_mi_store_data_imm(struct parser_exec_state *s)
 		gma = (gma_high << 32) | gma_low;
 		core_id = (cmd_val(s, 1) & (1 << 0)) ? 1 : 0;
 	}
-	ret = cmd_address_audit(s, gma + op_size * core_id, op_size, false);
+	ret = cmd_address_audit(s, gma + op_size * core_id, op_size, false, 1);
 	return ret;
 }
 
@@ -1473,7 +1483,7 @@ static int cmd_handler_mi_op_2f(struct parser_exec_state *s)
 		gma_high = cmd_val(s, 2) & GENMASK(15, 0);
 		gma = (gma_high << 32) | gma;
 	}
-	ret = cmd_address_audit(s, gma, op_size, false);
+	ret = cmd_address_audit(s, gma, op_size, false, 1);
 	return ret;
 }
 
@@ -1513,7 +1523,7 @@ static int cmd_handler_mi_flush_dw(struct parser_exec_state *s)
 		/* Store Data Index */
 		if (cmd_val(s, 0) & (1 << 21))
 			index_mode = true;
-		ret = cmd_address_audit(s, gma, sizeof(u64), index_mode);
+		ret = cmd_address_audit(s, (gma | (1 << 2)), sizeof(u64), index_mode, 1);
 	}
 	/* Check notify bit */
 	if ((cmd_val(s, 0) & (1 << 8)))
-- 
2.7.4
