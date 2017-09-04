Received: from eggs.gnu.org ([2001:4830:134:3::10]:47152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozD9-0003pk-Hd
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozD4-0002yy-R1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:15 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:37341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dozD4-0002yA-KL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:10 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 85A0151124
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 23:47:09 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 23:47:05 +0200
Message-ID: <150456162500.17000.8195671755736683016.stgit@bahia.lan>
In-Reply-To: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/4] spapr: introduce a helper to compute the
 address of the HPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>

The formula used to compute the address of the HPT allocated by QEMU is
open-coded in several places. This patch moves the magic to a dedicated
helper. While here, we also patch the callers to only pass the address
to KVM if we indeed have a userland HPT (ie, KVM PR).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          |    9 +++++++++
 hw/ppc/spapr_cpu_core.c |   12 +++++++-----
 hw/ppc/spapr_hcall.c    |   14 ++++++++------
 include/hw/ppc/spapr.h  |    1 +
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index caffa1276328..bf24c26b756d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1290,6 +1290,15 @@ static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
     }
 }
 
+target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr)
+{
+    if (!spapr->htab) {
+        return 0;
+    }
+
+    return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shift - 18);
+}
+
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
 {
     int shift;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 85037ef71e27..581eb4d92de9 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -93,11 +93,13 @@ static void spapr_cpu_reset(void *opaque)
      * HPT
      */
     if (kvm_enabled()) {
-        env->spr[SPR_SDR1] = (target_ulong)(uintptr_t)spapr->htab
-            | (spapr->htab_shift - 18);
-        if (kvmppc_put_books_sregs(cpu) < 0) {
-            error_report("Unable to update SDR1 in KVM");
-            exit(1);
+        target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
+        if (sdr1) {
+            env->spr[SPR_SDR1] = sdr1;
+            if (kvmppc_put_books_sregs(cpu) < 0) {
+                error_report("Unable to update SDR1 in KVM");
+                exit(1);
+            }
         }
     }
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6ab8c188f381..06059b44ab40 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -735,9 +735,10 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
         if (kvm_enabled()) {
             /* For KVM PR, update the HPT pointer */
-            target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                | (spapr->htab_shift - 18);
-            kvmppc_update_sdr1(sdr1);
+            target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
+            if (sdr1) {
+                kvmppc_update_sdr1(sdr1);
+            }
         }
 
         pending->hpt = NULL; /* so it's not free()d */
@@ -1566,9 +1567,10 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
             if (kvm_enabled()) {
                 /* For KVM PR, update the HPT pointer */
-                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                    | (spapr->htab_shift - 18);
-                kvmppc_update_sdr1(sdr1);
+                target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
+                if (sdr1) {
+                    kvmppc_update_sdr1(sdr1);
+                }
             }
         }
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f56431..a1f5edc15018 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -709,4 +709,5 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 int spapr_vcpu_id(PowerPCCPU *cpu);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
+target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr);
 #endif /* HW_SPAPR_H */
