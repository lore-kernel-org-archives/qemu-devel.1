Received: from eggs.gnu.org ([2001:4830:134:3::10]:60681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eErg0-0006MA-Ou
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eErfx-0005rK-O0
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:00:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1eErfx-0005nG-50
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:59:57 -0500
From: fangying <fangying1@huawei.com>
Date: Wed, 15 Nov 2017 14:57:35 +0800
Message-ID: <20171115065735.9444-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vhost: Cancel migration when vhost-user
 process restarted during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, stefanha@redhat.com
Cc: quintela@redhat.com, Ying Fang <fangying1@huawei.com>

From: Ying Fang<fangying1@huawei.com>

QEMU will abort when vhost-user process is restarted during migration when
vhost_log_global_start/stop is called. The reason is clear that
vhost_dev_set_log returns -1 because network connection is temporarily lost.
To handle this situation, let's cancel migration and report it to user.

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/virtio/vhost.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..f409b06 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
 #include "sysemu/dma.h"
+#include "qmp-commands.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -882,20 +883,24 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
 static void vhost_log_global_start(MemoryListener *listener)
 {
     int r;
+    Error *errp = NULL;
 
     r = vhost_migration_log(listener, true);
     if (r < 0) {
-        abort();
+        error_setg(errp, "Failed to start vhost migration log");
+        qmp_migrate_cancel(&errp);
     }
 }
 
 static void vhost_log_global_stop(MemoryListener *listener)
 {
     int r;
+    Error *errp = NULL;
 
     r = vhost_migration_log(listener, false);
     if (r < 0) {
-        abort();
+        error_setg(errp, "Failed to stop vhost migration log");
+        qmp_migrate_cancel(&errp);
     }
 }
 
-- 
2.10.0.windows.1
