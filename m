Received: from eggs.gnu.org ([209.51.188.92]:40369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDo-0003fG-W2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDl-0007nW-R2
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:34 -0500
Received: from m50-111.126.com ([123.125.50.111]:54034)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gpRDh-0007m7-Mi
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 00:18:32 -0500
From: Fei Li <lifei1214@126.com>
Date: Fri,  1 Feb 2019 13:17:59 +0800
Message-Id: <20190201051806.53183-5-lifei1214@126.com>
In-Reply-To: <20190201051806.53183-1-lifei1214@126.com>
References: <20190201051806.53183-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH v11 for-4.0 04/11] qemu_thread: supplement
 error handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, Markus Armbruster <armbru@redhat.com>, Jiri Slaby <jslaby@suse.cz>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error and do the
corresponding cleanup to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Fei Li <fli@suse.com>
---
 hw/misc/edu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 21adbfddce..8fe232b6d6 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -356,9 +356,14 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
+                           edu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        qemu_cond_destroy(&edu->thr_cond);
+        qemu_mutex_destroy(&edu->thr_mutex);
+        timer_del(&edu->dma_timer);
+        msi_uninit(pdev);
+        return;
+    }
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
-- 
2.17.2 (Apple Git-113)
