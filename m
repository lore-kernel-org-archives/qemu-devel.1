Received: from eggs.gnu.org ([2001:4830:134:3::10]:36343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSmib-0005H1-Ju
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fSmiY-0000X2-B7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:04:29 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:43460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fSmiY-0000WN-44
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:04:26 -0400
Received: from player731.ha.ovh.net (unknown [10.109.120.91])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 73B481075D3
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 19:04:24 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Jun 2018 19:04:15 +0200
Message-ID: <152882305541.114463.3137854902721347235.stgit@bahia.lan>
In-Reply-To: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR values
 when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Bits set in the PCR disable features of the processor. TCG currently
doesn't implement that, ie, we always act like if PCR is all zeros.

But it is still possible for the PCR to have a non-null value. This may
confuse the guest.

There are three distinct cases:

1) a powernv guest doing mtspr SPR_PCR

2) reset of a pseries guest if the max-cpu-compat machine property is set

3) CAS of a pseries guest

This patch adds a ppc_store_pcr() helper that ensures we cannot put
a non-null value in the PCR when using TCG. This helper also has
error propagation support, so that each case listed above can be
handled appropriately:

1) since the powernv machine is mostly used for OpenPOWER FW devel,
   we just print an error and let QEMU continue execution

2) an error is printed and QEMU exits, ie, same behaviour as when
   KVM doesn't support the requested compat mode

3) an error is printed and QEMU reports H_HARDWARE to the guest

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/compat.c      |   26 ++++++++++++++++++++++++--
 target/ppc/cpu.h         |    3 +++
 target/ppc/misc_helper.c |    9 ++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 807c906f6848..08aa99e6ad47 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -138,8 +138,8 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
 {
     const CompatInfo *compat = compat_by_pvr(compat_pvr);
     CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     uint64_t pcr;
+    Error *local_err = NULL;
 
     if (!compat_pvr) {
         pcr = 0;
@@ -165,8 +165,30 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp)
         }
     }
 
+    ppc_store_pcr(env, pcr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     cpu->compat_pvr = compat_pvr;
-    env->spr[SPR_PCR] = pcr & pcc->pcr_mask;
+}
+
+void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp)
+{
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    /* TODO: this check should go away once we actually put the proper PCR
+     * checks in the various bits of TCG that should have them.
+     */
+    if (!kvm_enabled() && value != 0) {
+        error_setg(errp, "TCG doesn't support PCR value 0x"TARGET_FMT_lx,
+                   value);
+        return;
+    }
+
+    env->spr[SPR_PCR] = value & pcc->pcr_mask;
 }
 
 typedef struct {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a91f1a8777eb..fdaae34feffb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1296,6 +1296,9 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
 void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
+#if defined(TARGET_PPC64)
+void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp);
+#endif
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr (CPUPPCState *env, target_ulong value);
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index b88493009609..7a9b45a01453 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -21,6 +21,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 #include "helper_regs.h"
 
@@ -102,10 +103,12 @@ void helper_store_ptcr(CPUPPCState *env, target_ulong val)
 
 void helper_store_pcr(CPUPPCState *env, target_ulong value)
 {
-    PowerPCCPU *cpu = ppc_env_get_cpu(env);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    Error *local_err = NULL;
 
-    env->spr[SPR_PCR] = value & pcc->pcr_mask;
+    ppc_store_pcr(env, value, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 #endif /* defined(TARGET_PPC64) */
 
