Received: from eggs.gnu.org ([2001:4830:134:3::10]:47664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eKnpa-00016K-TA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eKnpW-00022c-UG
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eKnpW-0001pw-83
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:22 -0500
From: fangying <fangying1@huawei.com>
Date: Fri, 1 Dec 2017 13:58:32 +0800
Message-ID: <20171201055832.8392-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4] vhost: Don't abort when vhost-user
 connection is lost during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: quintela@redhat.com, marcandre.lureau@redhat.com, fangying <fangying1@huawei.com>

QEMU will abort when vhost-user process is restarted during migration
when vhost_log_global_start/stop is called. The reason is clear that
vhost_dev_set_log returns -1 because network connection is lost.

To handle this situation, let's cancel migration by setting migrate
state to failure and report it to user.
---
 hw/virtio/vhost.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..92725f7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,8 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
+#include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "sysemu/dma.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -885,7 +887,10 @@ static void vhost_log_global_start(MemoryListener *listener)
 
     r = vhost_migration_log(listener, true);
     if (r < 0) {
-        abort();
+        error_report("Failed to start vhost dirty log");
+        if (migrate_get_current()->migration_thread_running) {
+            qemu_file_set_error(migrate_get_current()->to_dst_file, -ECHILD);
+        }
     }
 }
 
@@ -895,7 +900,10 @@ static void vhost_log_global_stop(MemoryListener *listener)
 
     r = vhost_migration_log(listener, false);
     if (r < 0) {
-        abort();
+        error_report("Failed to stop vhost dirty log");
+        if (migrate_get_current()->migration_thread_running) {
+            qemu_file_set_error(migrate_get_current()->to_dst_file, -ECHILD);
+        }
     }
 }
 
-- 
1.8.3.1
