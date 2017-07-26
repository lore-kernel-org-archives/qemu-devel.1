Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNQK-0003Kf-GS
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1daNQJ-0002AZ-JP
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:36:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1daNQJ-00029l-Di
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:36:27 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Wed, 26 Jul 2017 16:35:31 +0200
Message-Id: <20170726143543.2530-3-ldoktor@redhat.com>
In-Reply-To: <20170726143543.2530-1-ldoktor@redhat.com>
References: <20170726143543.2530-1-ldoktor@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/14] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix possible crash on error path in
qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added in
88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
qcow2_remove_persistent_dirty_bitmap was added).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170714123341.373857-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3e8735a..e8d3bdb 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -487,6 +487,10 @@ static inline void bitmap_directory_to_be(uint8_t *dir, size_t size)
 
 static void bitmap_free(Qcow2Bitmap *bm)
 {
+    if (bm == NULL) {
+        return;
+    }
+
     g_free(bm->name);
     g_free(bm);
 }
-- 
2.9.4
