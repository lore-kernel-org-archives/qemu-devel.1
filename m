Received: from eggs.gnu.org ([209.51.188.92]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0s-00060b-Sy
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0r-00056N-N6
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:34 +0100
Message-Id: <20190428143845.11810-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 03/14] target/ppc: remove getVSR()/putVSR()
 from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which used
to convert the VSR registers into host endian order are no longer required.

Now that there are now no more users of getVSR()/putVSR() these functions can
be completely removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/int_helper.c | 20 +++++++-------------
 target/ppc/internal.h   | 12 ------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f6a088ac08..f616fb249d 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1904,38 +1904,32 @@ VEXTRACT(d, u64)
 void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
                         target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xtn];
+    ppc_vsr_t *xb = &env->vsr[xbn];
     size_t es = sizeof(uint32_t);
     uint32_t ext_index;
     int i;
 
-    getVSR(xbn, &xb, env);
-    memset(&xt, 0, sizeof(xt));
+    memset(xt, 0, sizeof(ppc_vsr_t));
 
     ext_index = index;
     for (i = 0; i < es; i++, ext_index++) {
-        xt.VsrB(8 - es + i) = xb.VsrB(ext_index % 16);
+        xt->VsrB(8 - es + i) = xb->VsrB(ext_index % 16);
     }
-
-    putVSR(xtn, &xt, env);
 }
 
 void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
                       target_ulong xbn, uint32_t index)
 {
-    ppc_vsr_t xt, xb;
+    ppc_vsr_t *xt = &env->vsr[xtn];
+    ppc_vsr_t *xb = &env->vsr[xbn];
     size_t es = sizeof(uint32_t);
     int ins_index, i = 0;
 
-    getVSR(xbn, &xb, env);
-    getVSR(xtn, &xt, env);
-
     ins_index = index;
     for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
-        xt.VsrB(ins_index) = xb.VsrB(8 - es + i);
+        xt->VsrB(ins_index) = xb->VsrB(8 - es + i);
     }
-
-    putVSR(xtn, &xt, env);
 }
 
 #define VEXT_SIGNED(name, element, cast)                            \
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index fb6f64ed1e..d3d327e548 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,18 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
-static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    vsr->VsrD(0) = env->vsr[n].VsrD(0);
-    vsr->VsrD(1) = env->vsr[n].VsrD(1);
-}
-
-static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
-{
-    env->vsr[n].VsrD(0) = vsr->VsrD(0);
-    env->vsr[n].VsrD(1) = vsr->VsrD(1);
-}
-
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
-- 
2.11.0
