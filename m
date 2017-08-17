Received: from eggs.gnu.org ([2001:4830:134:3::10]:46587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1diIuE-0003cp-BP
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1diIuA-0000d5-Cv
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:24:06 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:37536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1diIuA-0000cf-5r
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:24:02 -0400
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 56EE8698F5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:24:00 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Aug 2017 13:23:50 +0200
Message-ID: <150296903004.12575.16996499098384404656.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] spapr: fallback to raw mode if best compat
 mode cannot be set during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

KVM PR doesn't allow to set a compat mode. This causes ppc_set_compat_all()
to fail and we return H_HARDWARE to the guest right away.

This is excessive: even if we favor compat mode since commit 152ef803ceb19,
we should at least fallback to raw mode if the guest supports it.

This patch modifies cas_check_pvr() so that it also reports that the real
PVR was found in the table supplied by the guest. Note that this is only
makes sense if raw mode isn't explicitely disabled (ie, the user didn't
set the machine "max-cpu-compat" property). If this is the case, we can
simply ignore ppc_set_compat_all() failures, and let the guest run in raw
mode.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - initialize raw_mode_supported to silent patchew
---
 hw/ppc/spapr_hcall.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 07b3da8dc4cd..2f4c4f59e110 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1441,7 +1441,8 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
 }
 
 static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
-                              target_ulong *addr, Error **errp)
+                              target_ulong *addr, bool *raw_mode_supported,
+                              Error **errp)
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t max_compat = spapr->max_compat_pvr;
@@ -1481,6 +1482,8 @@ static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
         return 0;
     }
 
+    *raw_mode_supported = explicit_match;
+
     /* Parsing finished */
     trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
 
@@ -1499,8 +1502,9 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
     bool guest_radix;
     Error *local_err = NULL;
+    bool raw_mode_supported = false;
 
-    cas_pvr = cas_check_pvr(spapr, cpu, &addr, &local_err);
+    cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
     if (local_err) {
         error_report_err(local_err);
         return H_HARDWARE;
@@ -1510,8 +1514,14 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     if (cpu->compat_pvr != cas_pvr) {
         ppc_set_compat_all(cas_pvr, &local_err);
         if (local_err) {
-            error_report_err(local_err);
-            return H_HARDWARE;
+            /* We fail to set compat mode (likely because running with KVM PR),
+             * but maybe we can fallback to raw mode if the guest supports it.
+             */
+            if (!raw_mode_supported) {
+                error_report_err(local_err);
+                return H_HARDWARE;
+            }
+            local_err = NULL;
         }
     }
 
