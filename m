Received: from eggs.gnu.org ([2001:4830:134:3::10]:60109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082m-Gp
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006zb-Ew
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:35 +0300
Message-Id: <cbbe82e012ffd2dde05fec3012ab1ebc7cd3d045.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 4/9] block: Don't look for child references in
 append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

In the previous patch we removed child references from bs->options, so
there's no need to look for them here anymore.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 2f2484965d..92afb3dcce 100644
--- a/block.c
+++ b/block.c
@@ -5153,23 +5153,12 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
2.11.0
