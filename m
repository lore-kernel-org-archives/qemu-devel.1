Received: from eggs.gnu.org ([2001:4830:134:3::10]:57634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCf-0007jy-ST
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCe-0005Kt-N1
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ecfCe-0005I3-HW
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:04 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 17:31:57 -0500
Message-Id: <20180119223159.29890-3-jsnow@redhat.com>
In-Reply-To: <20180119223159.29890-1-jsnow@redhat.com>
References: <20180119223159.29890-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] ide: move ide_sect_range_ok() up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

to use it without a forward declaration in the commit to follow

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 1512735034-35327-3-git-send-email-anton.nefedov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 875f7b442d..27226bfd51 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -380,6 +380,18 @@ static void ide_set_signature(IDEState *s)
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
@@ -603,18 +615,6 @@ static void ide_rw_error(IDEState *s) {
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
2.14.3
