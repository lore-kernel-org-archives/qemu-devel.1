Received: from eggs.gnu.org ([2001:4830:134:3::10]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-00038C-BN
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV8-00089x-Jf
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:35 +1100
Message-Id: <20170222063348.32176-31-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 30/43] target/ppc/POWER9: Direct all instr and
 data storage interrupts to the hypv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The vpm0 bit was removed from the LPCR in POWER9, this bit controlled
whether ISI and DSI interrupts were directed to the hypervisor or the
partition. These interrupts now go to the hypervisor irrespective, thus
it is no longer necessary to check the vmp0 bit in the LPCR.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c09255d..76669ed 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -652,7 +652,15 @@ static void ppc_hash64_set_isi(CPUState *cs, CPUPPCState *env,
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
@@ -670,7 +678,15 @@ static void ppc_hash64_set_dsi(CPUState *cs, CPUPPCState *env, uint64_t dar,
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
2.9.3
