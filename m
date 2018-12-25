Received: from eggs.gnu.org ([208.118.235.92]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKy-0001R0-Oi
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKy-0003s5-0x
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:36 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:54949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKx-0003rQ-NK
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:35 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:42 +0800
Message-Id: <20181225140449.15786-10-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 09/16] qemu_thread: supplement error
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
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, Jiri Slaby <jslaby@suse.cz>

Utilize the existed errp to propagate the error instead of the
temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Fei Li <fli@suse.com>
---
 hw/misc/edu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 3f4ba7ded3..011fe6e0b7 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -356,9 +356,10 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (!qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
+                            edu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
-- 
2.13.7
