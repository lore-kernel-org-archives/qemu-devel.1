Received: from eggs.gnu.org ([209.51.188.92]:40448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDs-0003hi-Pu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDr-0007qI-Ob
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:40 -0500
Received: from m50-111.126.com ([123.125.50.111]:54117)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDr-0007mb-5W
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:39 -0500
From: Fei Li <lifei1214@126.com>
Date: Fri,  1 Feb 2019 13:18:00 +0800
Message-Id: <20190201051806.53183-6-lifei1214@126.com>
In-Reply-To: <20190201051806.53183-1-lifei1214@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH v11 for-4.0 05/11] qemu_thread: supplement
 error handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Fei Li <fli@suse.com>

Add a local_err to hold the error, and return the corresponding
error code to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Fei Li <fli@suse.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index bee2895b94..5ef73bef0e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     sPAPRPendingHPT *pending = spapr->pending_hpt;
     uint64_t current_ram_size;
     int rc;
+    Error *local_err = NULL;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->shift = shift;
     pending->ret = H_HARDWARE;
 
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending,
-                       QEMU_THREAD_DETACHED, &error_abort);
+    if (qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
+                           hpt_prepare_thread, pending,
+                           QEMU_THREAD_DETACHED, &local_err) < 0) {
+        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
+        g_free(pending);
+        return H_HARDWARE;
+    }
 
     spapr->pending_hpt = pending;
 
-- 
2.17.2 (Apple Git-113)
