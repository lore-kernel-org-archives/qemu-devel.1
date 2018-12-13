Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXV9X-00063a-3k
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXV9W-0004d1-DS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:52:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 18:51:54 +0100
Message-Id: <20181213175154.5242-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Replace qdict_put() by qdict_put_obj()
 where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ari@tuxera.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/qobject.cocci \
	    --macro-file scripts/cocci-macro-file.h \
	    --dir block --in-place

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/blklogwrites.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ff98cd5533..d2e01bdb1d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -295,10 +295,9 @@ static void blk_log_writes_refresh_filename(BlockDriverState *bs,
         qdict_put_str(opts, "driver", "blklogwrites");
 
         qobject_ref(bs->file->bs->full_open_options);
-        qdict_put_obj(opts, "file", QOBJECT(bs->file->bs->full_open_options));
+        qdict_put(opts, "file", bs->file->bs->full_open_options);
         qobject_ref(s->log_file->bs->full_open_options);
-        qdict_put_obj(opts, "log",
-                      QOBJECT(s->log_file->bs->full_open_options));
+        qdict_put(opts, "log", s->log_file->bs->full_open_options);
         qdict_put_int(opts, "log-sector-size", s->sectorsize);
 
         bs->full_open_options = opts;
-- 
2.17.2
