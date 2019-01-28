Received: from eggs.gnu.org ([209.51.188.92]:40250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hd-0007Ta-NZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hY-0007F4-NI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:57 -0500
Received: from m15-113.126.com ([220.181.15.113]:49508)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hT-00075H-41
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:49 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:14:47 +0800
Message-Id: <20190128141506.12731-5-lifei1214@126.com>
In-Reply-To: <20190128141506.12731-1-lifei1214@126.com>
References: <20190128141506.12731-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 04/11] qemu_thread: supplement error
 handling for pci_edu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>, Jiri Slaby <jslaby@suse.cz>

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
index d3583c6141..42c429de9a 100644
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
