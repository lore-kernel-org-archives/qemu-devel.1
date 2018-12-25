Received: from eggs.gnu.org ([208.118.235.92]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnL3-0001Vs-MU
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnL0-0003tA-Fw
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:41 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnL0-0003sl-6K
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:38 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:43 +0800
Message-Id: <20181225140449.15786-11-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 10/16] qemu_thread: supplement error
 handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Add a local_err to hold the error, and return the corresponding
error code to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Fei Li <fli@suse.com>
---
 hw/ppc/spapr_hcall.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5bc2cf4540..7c16ade04a 100644
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
+    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
+                            hpt_prepare_thread, pending,
+                            QEMU_THREAD_DETACHED, &local_err)) {
+        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
+        g_free(pending);
+        return H_RESOURCE;
+    }
 
     spapr->pending_hpt = pending;
 
-- 
2.13.7
