Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvM5-00064F-Hb
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvM4-0001xU-Ml
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:53 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:12 +1100
Message-Id: <1484288903-18807-7-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 06/17] target/ppc/POWER9: Direct all instr
 and data storage interrupts to the hypv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The vpm0 bit was removed from the LPCR in POWER9, this bit controlled
whether ISI and DSI interrupts were directed to the hypervisor or the
partition. These interrupts now go to the hypervisor irrespective, thus
it is no longer necessary to check the vmp0 bit in the LPCR.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-hash64.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 3a2acb8..fe7da18 100644
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
