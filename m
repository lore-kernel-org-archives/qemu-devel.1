Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5r-0008RF-7N
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5o-0004nA-2O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:23 -0300
Message-Id: <20170724182751.18261-8-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 07/35] qcow2: fix null pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

If find_bitmap_by_name() fails we have bm=NULL and go to the 'fail' label, then
call bitmap_free(bm) which does g_free(bm->name) with bm=NULL...

Clang's scan-build-5.0 output:
block/qcow2-bitmap.c:492:12: warning: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'bm')
    g_free(bm->name);
           ^~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/qcow2-bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index fe72df5057..2fd75781ce 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1259,7 +1259,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
     bm = find_bitmap_by_name(bm_list, name);
     if (bm == NULL) {
-        goto fail;
+        goto fail_list;
     }
 
     QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
@@ -1274,6 +1274,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
 fail:
     bitmap_free(bm);
+fail_list:
     bitmap_list_free(bm_list);
 }
 
-- 
2.13.3
