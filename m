Received: from eggs.gnu.org ([2001:4830:134:3::10]:54960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO8-0006YR-NG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPO7-0000zq-Uv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:52 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPO7-0000zU-OP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:51 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so554519wmr.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:51 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:41 +0100
Message-Id: <6c5b3d85dcfabe9935687ecb986e80ce71f89cab.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 10/30] target-sparc: hypervisor mode takes
 over nucleus mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

Accordinf to UA2005, 9.3.3 "Address Space Identifiers",

"In hyperprivileged mode, all instruction fetches and loads and stores with implicit
ASIs use a physical address, regardless of the value of TL".

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h       | 4 ++--
 target/sparc/translate.c | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 113ae33..4f709e1 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -716,10 +716,10 @@ static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
         ? (env->lsu & IMMU_E) == 0 || (env->pstate & PS_RED) != 0
         : (env->lsu & DMMU_E) == 0) {
         return MMU_PHYS_IDX;
-    } else if (env->tl > 0) {
-        return MMU_NUCLEUS_IDX;
     } else if (cpu_hypervisor_mode(env)) {
         return MMU_HYPV_IDX;
+    } else if (env->tl > 0) {
+        return MMU_NUCLEUS_IDX;
     } else if (cpu_supervisor_mode(env)) {
         return MMU_KERNEL_IDX;
     } else {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b898898..82f9965 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2142,7 +2142,11 @@ static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)
         case ASI_TWINX_NL:
         case ASI_NUCLEUS_QUAD_LDD:
         case ASI_NUCLEUS_QUAD_LDD_L:
-            mem_idx = MMU_NUCLEUS_IDX;
+            if (hypervisor(dc)) {
+                mem_idx = MMU_HYPV_IDX;
+            } else {
+                mem_idx = MMU_NUCLEUS_IDX;
+            }
             break;
         case ASI_AIUP:  /* As if user primary */
         case ASI_AIUPL: /* As if user primary LE */
-- 
1.8.3.1
