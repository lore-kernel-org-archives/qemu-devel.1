Received: from eggs.gnu.org ([2001:4830:134:3::10]:38992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVN-0007N9-4p
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVK-00044O-GC
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:49 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri,  8 Dec 2017 15:10:33 +0300
Message-Id: <1512735034-35327-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] ide: move ide_sect_range_ok() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

to use it without a forward declaration in the commit to follow

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 hw/ide/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 02a6b2c..23c71fa 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -381,6 +381,18 @@ static void ide_set_signature(IDEState *s)
     }
 }
 
+static bool ide_sect_range_ok(IDEState *s,
+                              uint64_t sector, uint64_t nb_sectors)
+{
+    uint64_t total_sectors;
+
+    blk_get_geometry(s->blk, &total_sectors);
+    if (sector > total_sectors || nb_sectors > total_sectors - sector) {
+        return false;
+    }
+    return true;
+}
+
 typedef struct TrimAIOCB {
     BlockAIOCB common;
     IDEState *s;
@@ -604,18 +616,6 @@ static void ide_rw_error(IDEState *s) {
     ide_set_irq(s->bus);
 }
 
-static bool ide_sect_range_ok(IDEState *s,
-                              uint64_t sector, uint64_t nb_sectors)
-{
-    uint64_t total_sectors;
-
-    blk_get_geometry(s->blk, &total_sectors);
-    if (sector > total_sectors || nb_sectors > total_sectors - sector) {
-        return false;
-    }
-    return true;
-}
-
 static void ide_buffered_readv_cb(void *opaque, int ret)
 {
     IDEBufferedRequest *req = opaque;
-- 
2.7.4
