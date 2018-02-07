Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejSQ3-00075k-0v
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ejSPz-0007MK-RW
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:17:59 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed,  7 Feb 2018 17:17:30 +0100
Message-Id: <20180207161730.17194-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: check smp_threads < vsmt
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

We ignore silently the value of smp_threads when we set
the VSMT value, and if smp_threads is greater than VSMT
kernel is going into trouble later.

Fixes: 8904e5a750
("spapr: Adjust default VSMT value for better migration compatibility")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 32a876be56..638b3cafd0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2294,15 +2294,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
     }
 
     /* Detemine the VSMT mode to use: */
-    if (vsmt_user) {
-        if (spapr->vsmt < smp_threads) {
-            error_setg(&local_err, "Cannot support VSMT mode %d"
-                         " because it must be >= threads/core (%d)",
-                         spapr->vsmt, smp_threads);
-            goto out;
-        }
-        /* In this case, spapr->vsmt has been set by the command line */
-    } else {
+    if (!vsmt_user) {
         /*
          * Default VSMT value is tricky, because we need it to be as
          * consistent as possible (for migration), but this requires
@@ -2313,6 +2305,13 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
         spapr->vsmt = 8;
     }
 
+    if (spapr->vsmt < smp_threads) {
+        error_setg(&local_err, "Cannot support VSMT mode %d"
+                   " because it must be >= threads/core (%d)",
+                   spapr->vsmt, smp_threads);
+        goto out;
+    }
+
     /* KVM: If necessary, set the SMT mode: */
     if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
         ret = kvmppc_set_smt_threads(spapr->vsmt);
-- 
2.14.3
