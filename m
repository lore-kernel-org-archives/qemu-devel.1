Received: from eggs.gnu.org ([2001:4830:134:3::10]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3j4-0006Cs-Dl
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3j3-0001YH-2k
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:30 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 10 Feb 2017 16:25:53 +1100
Message-Id: <1486704360-27361-4-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 03/10] target/ppc/POWER9: Adapt
 LPCR handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The logical partitioning control register controls a threads operation
based on the partition it is currently executing. Add new definitions and
update the mask used when writing to the LPCR based on the POWER9 spec.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h            | 18 ++++++++++++++++++
 target/ppc/mmu-hash64.c     |  8 ++++++++
 target/ppc/translate_init.c | 24 ++++++++++++++++++------
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bb96dd5..425e79d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -384,12 +384,19 @@ struct ppc_slb_t {
 #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
 #define LPCR_VRMASD_SHIFT (63 - 16)
 #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
+/* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
+#define LPCR_PECE_U_SHIFT (63 - 19)
+#define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
+#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit Enable */
 #define LPCR_RMLS_SHIFT   (63 - 37)
 #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
 #define LPCR_ILE          (1ull << (63 - 38))
 #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt location */
 #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
+#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
+#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisation */
 #define LPCR_ONL          (1ull << (63 - 45))
+#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
 #define LPCR_P7_PECE0     (1ull << (63 - 49))
 #define LPCR_P7_PECE1     (1ull << (63 - 50))
 #define LPCR_P7_PECE2     (1ull << (63 - 51))
@@ -398,11 +405,22 @@ struct ppc_slb_t {
 #define LPCR_P8_PECE2     (1ull << (63 - 49))
 #define LPCR_P8_PECE3     (1ull << (63 - 50))
 #define LPCR_P8_PECE4     (1ull << (63 - 51))
+/* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
+#define LPCR_PECE_L_SHIFT (63 - 51)
+#define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
+#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell Exit EN */
+#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit Enable */
+#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable        */
+#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enable     */
+#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable           */
 #define LPCR_MER          (1ull << (63 - 52))
+#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Shootdown */
 #define LPCR_TC           (1ull << (63 - 54))
+#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt Control */
 #define LPCR_LPES0        (1ull << (63 - 60))
 #define LPCR_LPES1        (1ull << (63 - 61))
 #define LPCR_RMI          (1ull << (63 - 62))
+#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int Enable */
 #define LPCR_HDICE        (1ull << (63 - 63))
 
 #define msr_sf   ((env->msr >> MSR_SF)   & 1)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index bb78fb5..24d9901 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1050,6 +1050,14 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
                       LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
                       LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
         break;
+    case POWERPC_MMU_3_00: /* P9 */
+        lpcr = val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
+                      (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
+                      LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
+                      (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_EEE |
+                      LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPCR_TC |
+                      LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
+        break;
     default:
         ;
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 84bf125..be35cbd 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8870,12 +8870,24 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu)
     lpcr->default_value &= ~LPCR_RMLS;
     lpcr->default_value |= 1ull << LPCR_RMLS_SHIFT;
 
-    /* P7 and P8 has slightly different PECE bits, mostly because P8 adds
-     * bit 47 and 48 which are reserved on P7. Here we set them all, which
-     * will work as expected for both implementations
-     */
-    lpcr->default_value |= LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
-                           LPCR_P8_PECE3 | LPCR_P8_PECE4;
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        /* By default we choose legacy mode and switch to new hash or radix
+         * when a register process table hcall is made. So disable process
+         * tables and guest translation shootdown by default
+         */
+        lpcr->default_value &= ~(LPCR_UPRT | LPCR_GTSE);
+        lpcr->default_value |= LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE |
+                               LPCR_OEE;
+        break;
+    default:
+        /* P7 and P8 has slightly different PECE bits, mostly because P8 adds
+         * bit 47 and 48 which are reserved on P7. Here we set them all, which
+         * will work as expected for both implementations
+         */
+        lpcr->default_value |= LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
+                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
+    }
 
     /* We should be followed by a CPU reset but update the active value
      * just in case...
-- 
2.5.5
