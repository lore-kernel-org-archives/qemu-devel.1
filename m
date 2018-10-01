Received: from eggs.gnu.org ([2001:4830:134:3::10]:57613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r8-0002QU-AA
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r4-0007A1-RJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:43 +0200
Message-Id: <20181001171901.11004-6-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/23] block: Don't look for child references in
 append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

In the previous patch we removed child references from bs->options, so
there's no need to look for them here anymore.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block.c b/block.c
index db71ea5b9a..98aca56785 100644
--- a/block.c
+++ b/block.c
@@ -5150,23 +5150,12 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
 {
     const QDictEntry *entry;
     QemuOptDesc *desc;
-    BdrvChild *child;
     bool found_any = false;
 
     for (entry = qdict_first(bs->options); entry;
          entry = qdict_next(bs->options, entry))
     {
-        /* Exclude node-name references to children */
-        QLIST_FOREACH(child, &bs->children, next) {
-            if (!strcmp(entry->key, child->name)) {
-                break;
-            }
-        }
-        if (child) {
-            continue;
-        }
-
-        /* And exclude all non-driver-specific options */
+        /* Exclude all non-driver-specific options */
         for (desc = bdrv_runtime_opts.desc; desc->name; desc++) {
             if (!strcmp(qdict_entry_key(entry), desc->name)) {
                 break;
-- 
2.13.6
