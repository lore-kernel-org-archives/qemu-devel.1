Received: from eggs.gnu.org ([209.51.188.92]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qay-000408-AM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007X3-As
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:60085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007VL-Q9
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:16:00 +0100
Message-Id: <20190311191602.25796-10-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] target/hppa: add TLB protection id check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/cpu.h        |  4 ++++
 target/hppa/mem_helper.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 861bbb1f16..d808796ee3 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -143,6 +143,10 @@
 #endif
 
 #define CR_RC            0
+#define CR_PID1          8
+#define CR_PID2          9
+#define CR_PID3          12
+#define CR_PID4          13
 #define CR_SCRCCR        10
 #define CR_SAR           11
 #define CR_IVA           14
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index fc1b6a4fcd..a52d691d15 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -85,7 +85,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot)
 {
     hwaddr phys;
-    int prot, r_prot, w_prot, x_prot;
+    int prot, r_prot, w_prot, x_prot, wd;
     hppa_tlb_entry *ent;
     int ret = -1;
 
@@ -130,7 +130,31 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         break;
     }
 
-    /* ??? Check PSW_P and ent->access_prot.  This can remove PAGE_WRITE.  */
+    /* access_id == 0 means public page and no check is performed */
+    if ((env->psw & PSW_P) && ent->access_id) {
+            wd = 1;
+
+            if (ent->access_id == (env->cr[CR_PID1] >> 1)) {
+                wd &= env->cr[CR_PID1];
+            }
+
+            if (ent->access_id == (env->cr[CR_PID2] >> 1)) {
+                wd &= env->cr[CR_PID2];
+            }
+
+            if (ent->access_id == (env->cr[CR_PID3] >> 1)) {
+                wd &= env->cr[CR_PID3];
+            }
+
+            if (ent->access_id == (env->cr[CR_PID4] >> 1)) {
+                wd &= env->cr[CR_PID4];
+            }
+
+            if (wd && (type & w_prot)) {
+                ret = EXCP_DMPI;
+                goto egress;
+            }
+    }
 
     /* No guest access type indicates a non-architectural access from
        within QEMU.  Bypass checks for access, D, B and T bits.  */
-- 
2.20.1
