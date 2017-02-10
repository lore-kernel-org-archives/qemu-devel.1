Received: from eggs.gnu.org ([2001:4830:134:3::10]:40321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3j5-0006DV-1A
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cc3j4-0001ZD-5Z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 00:26:31 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 10 Feb 2017 16:25:54 +1100
Message-Id: <1486704360-27361-5-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V2 04/10] target/ppc/POWER9: Direct
 all instr and data storage interrupts to the hypv
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

The vpm0 bit was removed from the LPCR in POWER9, this bit controlled
whether ISI and DSI interrupts were directed to the hypervisor or the
partition. These interrupts now go to the hypervisor irrespective, thus
it is no longer necessary to check the vmp0 bit in the LPCR.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-hash64.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 24d9901..7c5d589 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -640,7 +640,15 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
     if (msr_ir) {
         vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM1);
     } else {
-        vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM0);
+        switch (env->mmu_model) {
+        case POWERPC_MMU_3_00:
+            /* Field deprecated in ISAv3.00 - interrupts always go to hyperv */
+            vpm = true;
+            break;
+        default:
+            vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM0);
+            break;
+        }
     }
     if (vpm && !msr_hv) {
         cs->exception_index = POWERPC_EXCP_HISI;
@@ -658,7 +666,15 @@ static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCState *env, uint64_t dar,
     if (msr_dr) {
         vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM1);
     } else {
-        vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM0);
+        switch (env->mmu_model) {
+        case POWERPC_MMU_3_00:
+            /* Field deprecated in ISAv3.00 - interrupts always go to hyperv */
+            vpm = true;
+            break;
+        default:
+            vpm = !!(env->spr[SPR_LPCR] & LPCR_VPM0);
+            break;
+        }
     }
     if (vpm && !msr_hv) {
         cs->exception_index = POWERPC_EXCP_HDSI;
-- 
2.5.5
