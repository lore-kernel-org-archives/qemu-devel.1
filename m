Received: from eggs.gnu.org ([2001:4830:134:3::10]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwh-0004G1-SI
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwc-0000YL-K2
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  3 Sep 2018 17:34:02 +0300
Message-Id: <dbc3ea0b4221f2d774e44bd083e1fd87af016476.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 04/10] block: Don't look for child
 references in append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

In the previous patch we removed child references from bs->options, so
there's no need to look for them here anymore.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block.c b/block.c
index c764eb731c..aaa4cf6897 100644
--- a/block.c
+++ b/block.c
@@ -5154,23 +5154,12 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
