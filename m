Received: from eggs.gnu.org ([2001:4830:134:3::10]:54689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxTHx-0005te-10
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cxTHs-000644-Qo
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cxTHs-00063a-Le
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 02:58:56 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 10 Apr 2017 08:58:37 +0200
Message-Id: <20170410065837.31847-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: add migration blocker to avoid pre-save
 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 1635339@bugs.launchpad.net

Cc: 1635339@bugs.launchpad.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.h |  1 +
 hw/display/qxl.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index d2d49dd..77e5a36 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -40,6 +40,7 @@ typedef struct PCIQXLDevice {
     uint32_t           cmdlog;
 
     uint32_t           guest_bug;
+    Error              *migration_blocker;
 
     enum qxl_mode      mode;
     uint32_t           cmdflags;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c31b293..74ebeb9 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -26,6 +26,7 @@
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
 #include "sysemu/sysemu.h"
+#include "migration/migration.h"
 #include "trace.h"
 
 #include "qxl.h"
@@ -639,6 +640,27 @@ static int interface_get_command(QXLInstance *sin, struct QXLCommandExt *ext)
         qxl->guest_primary.commands++;
         qxl_track_command(qxl, ext);
         qxl_log_command(qxl, "cmd", ext);
+        {
+            /*
+             * Windows 8 drivers place qxl commands in the vram
+             * (instead of the ram) bar.  We can't live migrate such a
+             * guest, so add a migration blocker in case we detect
+             * this, to avoid triggering the assert in pre_save().
+             *
+             * https://cgit.freedesktop.org/spice/win32/qxl-wddm-dod/commit/?id=f6e099db39e7d0787f294d5fd0dce328b5210faa
+             */
+            void *msg = qxl_phys2virt(qxl, ext->cmd.data, ext->group_id);
+            if (msg != NULL && (
+                    msg < (void *)qxl->vga.vram_ptr ||
+                    msg > ((void *)qxl->vga.vram_ptr + qxl->vga.vram_size))) {
+                if (!qxl->migration_blocker) {
+                    Error *local_err = NULL;
+                    error_setg(&qxl->migration_blocker,
+                               "qxl: guest bug: command not in ram bar");
+                    migrate_add_blocker(qxl->migration_blocker, &local_err);
+                }
+            }
+        }
         trace_qxl_ring_command_get(qxl->id, qxl_mode_to_string(qxl->mode));
         return true;
     default:
-- 
2.9.3
