Received: from eggs.gnu.org ([2001:4830:134:3::10]:55055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOI-0006gi-IY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPOH-00016T-Mi
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:02 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPOH-00015y-Ga
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:21:01 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so576261wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:21:01 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:46 +0100
Message-Id: <1965259f2b94c607929f7b70158a100bfd1c2f83.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
In-Reply-To: <cover.1484165352.git.atar4qemu@gmail.com>
References: <cover.1484165352.git.atar4qemu@gmail.com>
Subject: [Qemu-devel] [PATCH v2 15/30] target-sparc: use direct address
 translation in hyperprivileged mode
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

Please note that QEMU doesn't impelement Real->Physical address
translation. The "Real Address" is always the "Physical Address".

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h       | 7 +++----
 target/sparc/translate.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 6c1607e..6fc81e8 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -230,7 +230,7 @@ enum {
 #if !defined(TARGET_SPARC64)
 #define NB_MMU_MODES 3
 #else
-#define NB_MMU_MODES 7
+#define NB_MMU_MODES 6
 typedef struct trap_state {
     uint64_t tpc;
     uint64_t tnpc;
@@ -673,8 +673,7 @@ int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 #define MMU_KERNEL_IDX 2
 #define MMU_KERNEL_SECONDARY_IDX 3
 #define MMU_NUCLEUS_IDX 4
-#define MMU_HYPV_IDX   5
-#define MMU_PHYS_IDX   6
+#define MMU_PHYS_IDX   5
 #else
 #define MMU_USER_IDX   0
 #define MMU_KERNEL_IDX 1
@@ -720,7 +719,7 @@ static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
         : (env->lsu & DMMU_E) == 0) {
         return MMU_PHYS_IDX;
     } else if (cpu_hypervisor_mode(env)) {
-        return MMU_HYPV_IDX;
+        return MMU_PHYS_IDX;
     } else if (env->tl > 0) {
         return MMU_NUCLEUS_IDX;
     } else if (cpu_supervisor_mode(env)) {
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 23d4673..53c327d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2143,7 +2143,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)
         case ASI_NUCLEUS_QUAD_LDD:
         case ASI_NUCLEUS_QUAD_LDD_L:
             if (hypervisor(dc)) {
-                mem_idx = MMU_HYPV_IDX;
+                mem_idx = MMU_PHYS_IDX;
             } else {
                 mem_idx = MMU_NUCLEUS_IDX;
             }
-- 
1.8.3.1
