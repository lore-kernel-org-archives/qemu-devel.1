Received: from eggs.gnu.org ([2001:4830:134:3::10]:60117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082q-Hj
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006yk-9d
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:34 +0300
Message-Id: <054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 3/9] block: Remove child references from
 bs->{options, explicit_options}
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

Block drivers allow opening their children using a reference to an
existing BlockDriverState. These references remain stored in the
'options' and 'explicit_options' QDicts, but we don't need to keep
them once everything is open.

What is more important, these values can become wrong if the children
change:

    $ qemu-img create -f qcow2 hd0.qcow2 10M
    $ qemu-img create -f qcow2 hd1.qcow2 10M
    $ qemu-img create -f qcow2 hd2.qcow2 10M
    $ $QEMU -drive if=none,file=hd0.qcow2,node-name=hd0 \
            -drive if=none,file=hd1.qcow2,node-name=hd1,backing=hd0 \
            -drive file=hd2.qcow2,node-name=hd2,backing=hd1

After this hd2 has hd1 as its backing file. Now let's remove it using
block_stream:

    (qemu) block_stream hd2 0 hd0.qcow2

Now hd0 is the backing file of hd2, but hd2's options QDicts still
contain backing=hd1.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 0dbb1fcc7b..2f2484965d 100644
--- a/block.c
+++ b/block.c
@@ -2763,12 +2763,15 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
-    /* Remove all children options from bs->options and bs->explicit_options */
+    /* Remove all children options and references
+     * from bs->options and bs->explicit_options */
     QLIST_FOREACH(child, &bs->children, next) {
         char *child_key_dot;
         child_key_dot = g_strdup_printf("%s.", child->name);
         qdict_extract_subqdict(bs->explicit_options, NULL, child_key_dot);
         qdict_extract_subqdict(bs->options, NULL, child_key_dot);
+        qdict_del(bs->explicit_options, child->name);
+        qdict_del(bs->options, child->name);
         g_free(child_key_dot);
     }
 
@@ -3289,6 +3292,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
     BlockDriverState *bs;
+    BdrvChild *child;
     bool old_can_write, new_can_write;
 
     assert(reopen_state != NULL);
@@ -3313,6 +3317,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     bs->open_flags         = reopen_state->flags;
     bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
 
+    /* Remove child references from bs->options and bs->explicit_options */
+    QLIST_FOREACH(child, &bs->children, next) {
+        qdict_del(bs->explicit_options, child->name);
+        qdict_del(bs->options, child->name);
+    }
+
     bdrv_refresh_limits(bs, NULL);
 
     bdrv_set_perm(reopen_state->bs, reopen_state->perm,
-- 
2.11.0
