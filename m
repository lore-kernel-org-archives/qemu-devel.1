Received: from eggs.gnu.org ([209.51.188.92]:48402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOl-0007FG-Bt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOj-0006M7-7b
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:39 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:19 +0000
Message-Id: <20190307180520.13868-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 6/7] target/ppc: switch fpr/vsrl registers
 so all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

When VSX support was initially added, the fpr registers were added at
offset 0 of the VSR register and the vsrl registers were added at offset
1. This is in contrast to the VMX registers (the last 32 VSX registers) which
are stored in host-endian order.

Switch the fpr/vsrl registers so that the lower 32 VSX registers are now also
stored in host endian order to match the VMX registers. This ensures that TCG
vector operations involving mixed VMX and VSX registers will function
correctly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h      | 4 ++--
 target/ppc/internal.h | 8 ++++----
 target/ppc/machine.c  | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index aebb6c01ee..704e595014 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2585,7 +2585,7 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 
 static inline int fpr_offset(int i)
 {
-    return offsetof(CPUPPCState, vsr[i].u64[0]);
+    return offsetof(CPUPPCState, vsr[i].VsrD(0));
 }
 
 static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
@@ -2595,7 +2595,7 @@ static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
 
 static inline int vsrl_offset(int i)
 {
-    return offsetof(CPUPPCState, vsr[i].u64[1]);
+    return offsetof(CPUPPCState, vsr[i].VsrD(1));
 }
 
 static inline int vsr_full_offset(int i)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 3ebbdf4da4..fb6f64ed1e 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -206,14 +206,14 @@ EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
 static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 {
-    vsr->VsrD(0) = env->vsr[n].u64[0];
-    vsr->VsrD(1) = env->vsr[n].u64[1];
+    vsr->VsrD(0) = env->vsr[n].VsrD(0);
+    vsr->VsrD(1) = env->vsr[n].VsrD(1);
 }
 
 static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 {
-    env->vsr[n].u64[0] = vsr->VsrD(0);
-    env->vsr[n].u64[1] = vsr->VsrD(1);
+    env->vsr[n].VsrD(0) = vsr->VsrD(0);
+    env->vsr[n].VsrD(1) = vsr->VsrD(1);
 }
 
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 756b6d2971..a92d0ad3a3 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -150,7 +150,7 @@ static int get_fpr(QEMUFile *f, void *pv, size_t size,
 {
     ppc_vsr_t *v = pv;
 
-    v->u64[0] = qemu_get_be64(f);
+    v->VsrD(0) = qemu_get_be64(f);
 
     return 0;
 }
@@ -160,7 +160,7 @@ static int put_fpr(QEMUFile *f, void *pv, size_t size,
 {
     ppc_vsr_t *v = pv;
 
-    qemu_put_be64(f, v->u64[0]);
+    qemu_put_be64(f, v->VsrD(0));
     return 0;
 }
 
@@ -181,7 +181,7 @@ static int get_vsr(QEMUFile *f, void *pv, size_t size,
 {
     ppc_vsr_t *v = pv;
 
-    v->u64[1] = qemu_get_be64(f);
+    v->VsrD(1) = qemu_get_be64(f);
 
     return 0;
 }
@@ -191,7 +191,7 @@ static int put_vsr(QEMUFile *f, void *pv, size_t size,
 {
     ppc_vsr_t *v = pv;
 
-    qemu_put_be64(f, v->u64[1]);
+    qemu_put_be64(f, v->VsrD(1));
     return 0;
 }
 
-- 
2.11.0
