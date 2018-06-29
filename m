Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYrjC-0001rm-2V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYriz-0005HF-Fj
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:14 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 29 Jun 2018 14:37:03 +0300
Message-Id: <0ac388e86dec1afbff4b5e4e6ade1f1fb7b2d7ff.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 5/5] block: Simplify append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

This function returns a BDS's driver-specific options, excluding also
those from its children. Since we have just removed all children
options from bs->options there's no need to do this last step.

We allow references to children, though ("backing": "node0"), so those
we still have to remove.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 58c8e8e677..9b91b01849 100644
--- a/block.c
+++ b/block.c
@@ -5210,16 +5210,13 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
     QemuOptDesc *desc;
     BdrvChild *child;
     bool found_any = false;
-    const char *p;
 
     for (entry = qdict_first(bs->options); entry;
          entry = qdict_next(bs->options, entry))
     {
-        /* Exclude options for children */
+        /* Exclude node-name references to children */
         QLIST_FOREACH(child, &bs->children, next) {
-            if (strstart(qdict_entry_key(entry), child->name, &p)
-                && (!*p || *p == '.'))
-            {
+            if (!strcmp(entry->key, child->name)) {
                 break;
             }
         }
-- 
2.11.0
