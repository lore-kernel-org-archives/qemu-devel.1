Received: from eggs.gnu.org ([2001:4830:134:3::10]:40217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI9-0006LF-2X
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI7-0006To-Ur
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:30 -0400
Message-Id: <20180512012537.22478-6-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 05/12] qcow2-bitmap: track bitmap type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

We only have one type of persistent bitmap right now, but I'd like the
qemu-img tool to be able to give good diagnostic information if it sees
an unknown/unsupported type.

We do enforce it to be the dirty tracking type in check_dir_entry, but
I wanted positive affirmation of the type in the forthcoming info script.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b556dbdccd..60e01abfd7 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -83,6 +83,7 @@ typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable)
 typedef struct Qcow2Bitmap {
     Qcow2BitmapTable table;
     uint32_t flags;
+    uint8_t type;
     uint8_t granularity_bits;
     char *name;
 
@@ -608,6 +609,7 @@ static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, Error **errp)
         bm->table.offset = e->bitmap_table_offset;
         bm->table.size = e->bitmap_table_size;
         bm->flags = e->flags;
+        bm->type = e->type;
         bm->granularity_bits = e->granularity_bits;
         bm->name = dir_entry_copy_name(e);
         QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
-- 
2.14.3
