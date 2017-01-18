Received: from eggs.gnu.org ([2001:4830:134:3::10]:36887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt4-0006V8-Mu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt4-0002gt-2L
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:26 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTyt3-0002gM-SE
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so7538722wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:25 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:23 +0100
Message-Id: <1484779123-18968-11-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 10/30] target-sparc: hypervisor mode takes over
 nucleus mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Accordinf to UA2005, 9.3.3 "Address Space Identifiers",

"In hyperprivileged mode, all instruction fetches and loads and stores with implicit
ASIs use a physical address, regardless of the value of TL".

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h       | 4 ++--
 target/sparc/translate.c | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9307b91..00fbb4e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -719,10 +719,10 @@ static inline int cpu_mmu_index(CPUSPARCState *env, bool ifetch)
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
index 8902e44..009ea3a 100644
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
2.7.2
