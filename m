Received: from eggs.gnu.org ([209.51.188.92]:51641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzaHQ-0000yq-OQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 00:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gza40-0004kG-2L
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:46:24 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  1 Mar 2019 15:46:08 +1100
Message-Id: <20190301044609.9626-2-sjitindarsingh@gmail.com>
In-Reply-To: <20190301044609.9626-1-sjitindarsingh@gmail.com>
References: <20190301044609.9626-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] target/ppc/tcg: make spapr_caps
 apply cap-[cfpc/sbbc/ibs] non-fatal for tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr_caps cap-cfpc, cap-sbbc and cap-ibs are used to control the
availability of certain mitigations to the guest. These haven't been
implemented under TCG, it is unlikely they ever will be, and it is unclear
as to whether they even need to be.

As such, make failure to apply these capabilities under TCG non-fatal.
Instead we print a warning message to the user but still allow the guest
to continue.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f03f2f64e7..b68d767d63 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -239,17 +239,22 @@ sPAPRCapPossible cap_cfpc_possible = {
 static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
+    Error *local_err = NULL;
     uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
 
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe cache capability level not supported by tcg, try a different value for cap-cfpc");
+        /* TCG only supports broken, allow other values and print a warning */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-cfpc=%s",
+                   cap_cfpc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe cache capability level not supported by kvm, try cap-cfpc=%s",
                    cap_cfpc_possible.vals[kvm_val]);
     }
+
+    if (local_err != NULL)
+        warn_report_err(local_err);
 }
 
 sPAPRCapPossible cap_sbbc_possible = {
@@ -262,17 +267,22 @@ sPAPRCapPossible cap_sbbc_possible = {
 static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
                                         Error **errp)
 {
+    Error *local_err = NULL;
     uint8_t kvm_val =  kvmppc_get_cap_safe_bounds_check();
 
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe bounds check capability level not supported by tcg, try a different value for cap-sbbc");
+        /* TCG only supports broken, allow other values and print a warning */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-sbbc=%s",
+                   cap_sbbc_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe bounds check capability level not supported by kvm, try cap-sbbc=%s",
                    cap_sbbc_possible.vals[kvm_val]);
     }
+
+    if (local_err != NULL)
+        warn_report_err(local_err);
 }
 
 sPAPRCapPossible cap_ibs_possible = {
@@ -288,17 +298,22 @@ sPAPRCapPossible cap_ibs_possible = {
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
+    Error *local_err = NULL;
     uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
 
     if (tcg_enabled() && val) {
-        /* TODO - for now only allow broken for TCG */
-        error_setg(errp,
-"Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
+        /* TCG only supports broken, allow other values and print a warning */
+        error_setg(&local_err,
+                   "TCG doesn't support requested feature, cap-ibs=%s",
+                   cap_ibs_possible.vals[val]);
     } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s",
                    cap_ibs_possible.vals[kvm_val]);
     }
+
+    if (local_err != NULL)
+        warn_report_err(local_err);
 }
 
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
-- 
2.13.6
