Received: from eggs.gnu.org ([2001:4830:134:3::10]:52287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLk-0004kp-Jr
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpvLe-0001N8-VR
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:56:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 15 Aug 2018 14:55:36 +0200
Message-Id: <20180815125537.10651-21-kwolf@redhat.com>
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/21] block: Simplify append_open_options()
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

This function returns a BDS's driver-specific options, excluding also
those from its children. Since we have just removed all children
options from bs->options there's no need to do this last step.

We allow references to children, though ("backing": "node0"), so those
we still have to remove.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 8c95f9893a..6161dbe3eb 100644
--- a/block.c
+++ b/block.c
@@ -5150,16 +5150,13 @@ static bool append_open_options(QDict *d, BlockDriverState *bs)
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
2.13.6
