Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fRYgN-00044r-H3
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fRYgK-0002vp-FU
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:53:07 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fRYgK-0002tX-7p
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 03:53:04 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Sat,  9 Jun 2018 10:52:43 +0300
Message-Id: <1528530764-21376-3-git-send-email-dimastep@yandex-team.ru>
In-Reply-To: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
References: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v1 2/3] qcow2: fix the uninitialized
 bitmap_table variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, dimastep@yandex-team.ru

The free_bitmap_clusters() routine is using the bitmap_table_load() call
to initialize the local bitmap_table variable. bitmap_table_load()
doesn't initialize variable to NULL in case of error. As a result a
following assert will be hit:
  assert(bitmap_table == NULL);

Remove this assert, since the next instruction is return from routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 block/qcow2-bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 60d5290..69485aa 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -254,7 +254,6 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 
     ret = bitmap_table_load(bs, tb, &bitmap_table);
     if (ret < 0) {
-        assert(bitmap_table == NULL);
         return ret;
     }
 
-- 
2.7.4
