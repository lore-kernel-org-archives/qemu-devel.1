Received: from eggs.gnu.org ([2001:4830:134:3::10]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ3-000855-HB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ2-0006ny-SB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:33 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ2-0006ns-ON
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:32 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so838222qte.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:32 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:51 -0800
Message-Id: <20170112025606.27332-16-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 15/30] target-sparc: use direct address
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
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Please note that QEMU doesn't impelement Real->Physical address
translation. The "Real Address" is always the "Physical Address".

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <1965259f2b94c607929f7b70158a100bfd1c2f83.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
2.9.3
