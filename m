Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2c-0004Xo-W1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2a-0002U7-TT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2Z-0002Ji-30
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:57 -0400
Message-Id: <20181029212501.5897-16-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 15/19] nbd: forbid use of frozen bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Whether it's "locked" or "frozen", it's in use and should
not be allowed for the purposes of this operation.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002230218.13949-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 nbd/server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index a1eda0114f..4e8f5ae51b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2456,8 +2456,8 @@ void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
         return;
     }
 
-    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
-        error_setg(errp, "Bitmap '%s' is locked", bitmap);
+    if (bdrv_dirty_bitmap_user_locked(bm)) {
+        error_setg(errp, "Bitmap '%s' is in use", bitmap);
         return;
     }
 
-- 
2.14.5
