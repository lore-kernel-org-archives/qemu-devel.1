Received: from eggs.gnu.org ([2001:4830:134:3::10]:42517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUZzc-0002eb-58
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 11:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fUZzY-0001nE-8s
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 11:53:28 -0400
From: John Arbuckle <programmingkidx@gmail.com>
Date: Sun, 17 Jun 2018 11:53:09 -0400
Message-Id: <20180617155309.1653-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org, aurelien@aurel32.net, david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Fix the helper_fpscr_clrbit() function so it correctly
sets the FEX and VX bits.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 target/ppc/fpu_helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d31a933cbb..7e697a11d0 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -325,6 +325,63 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t bit)
         case FPSCR_RN:
             fpscr_set_rounding_mode(env);
             break;
+        case FPSCR_VXSNAN:
+        case FPSCR_VXISI:
+        case FPSCR_VXIDI:
+        case FPSCR_VXZDZ:
+        case FPSCR_VXIMZ:
+        case FPSCR_VXVC:
+        case FPSCR_VXSOFT:
+        case FPSCR_VXSQRT:
+        case FPSCR_VXCVI:
+        {
+            int vxsnan, vxisi, vxidi, vxzdz, vximz, vxvc, vxsoft, vxsqrt, vxcvi;
+            vxsnan = (env->fpscr >> (31 - FPSCR_VXSNAN)) & 1;
+            vxisi = (env->fpscr >> (31 - FPSCR_VXISI)) & 1;
+            vxidi = (env->fpscr >> (31 - FPSCR_VXIDI)) & 1;
+            vxzdz = (env->fpscr >> (31 - FPSCR_VXZDZ)) & 1;
+            vximz = (env->fpscr >> (31 - FPSCR_VXIMZ)) & 1;
+            vxvc = (env->fpscr >> (31 - FPSCR_VXVC)) & 1;
+            vxsoft = (env->fpscr >> (31 - FPSCR_VXSOFT)) & 1;
+            vxsqrt = (env->fpscr >> (31 - FPSCR_VXSQRT)) & 1;
+            vxcvi = (env->fpscr >> (31 - FPSCR_VXCVI)) & 1;
+            if (~(vxsnan & vxisi & vxidi & vxzdz & vximz & vxvc & vxsoft &
+                  vxsqrt & vxcvi)) {
+                /* Set VX bit to zero */
+                env->fpscr = env->fpscr & ~(1 << FPSCR_VX);
+            }
+        }
+            break;
+        case FPSCR_VX:
+        case FPSCR_OX:
+        case FPSCR_UX:
+        case FPSCR_ZX:
+        case FPSCR_XX:
+        case FPSCR_VE:
+        case FPSCR_OE:
+        case FPSCR_UE:
+        case FPSCR_ZE:
+        case FPSCR_XE:
+        {
+            int vx, ox, ux, zx, xx, ve, oe, ue, ze, xe;
+            vx = (env->fpscr >> (31 - FPSCR_VX)) & 1;
+            ox = (env->fpscr >> (31 - FPSCR_OX)) & 1;
+            ux = (env->fpscr >> (31 - FPSCR_UX)) & 1;
+            zx = (env->fpscr >> (31 - FPSCR_ZX)) & 1;
+            xx = (env->fpscr >> (31 - FPSCR_XX)) & 1;
+            ve = (env->fpscr >> (31 - FPSCR_VE)) & 1;
+            oe = (env->fpscr >> (31 - FPSCR_OE)) & 1;
+            ue = (env->fpscr >> (31 - FPSCR_UE)) & 1;
+            ze = (env->fpscr >> (31 - FPSCR_ZE)) & 1;
+            xe = (env->fpscr >> (31 - FPSCR_XE)) & 1;
+            bool fex;
+            fex = (vx & ve) | (ox & oe) | (ux & ue) | (zx & ze) | (xx & xe);
+            unsigned int mask;
+            mask = (1 << FPSCR_FEX);
+            /* Set the FEX bit */
+            env->fpscr = (env->fpscr & ~mask) | (-fex & mask);
+        }
+            break;
         default:
             break;
         }
-- 
2.14.3 (Apple Git-98)
