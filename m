Received: from eggs.gnu.org ([2001:4830:134:3::10]:41733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYrjC-0001rn-39
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fYriz-0005HK-HF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:38:14 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 29 Jun 2018 14:37:00 +0300
Message-Id: <f304e7cc813193c62f16aacbd2246f3d23a816e8.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
In-Reply-To: <cover.1530270904.git.berto@igalia.com>
References: <cover.1530270904.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/5] block: Remove children options from
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

When bdrv_open_inherit() opens a BlockDriverState the options QDict
can contain options for some of its children, passed in the form of
child-name.option=value

So while each child is opened with that subset of options, those same
options remain stored in the parent BDS, leaving (at least) two copies
of each one of them ("child-name.option=value" in the parent and
"option=value" in the child).

Having the children options stored in the parent is unnecessary and it
can easily lead to an inconsistent state:

  $ qemu-img create -f qcow2 hd0.qcow2 10M
  $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
  $ qemu-img create -f qcow2 -b hd1.qcow2 hd2.qcow2

  $ $QEMU -drive file=hd2.qcow2,node-name=hd2,backing.node-name=hd1

This opens a chain of images hd0 <- hd1 <- hd2. Now let's remove hd1
using block_stream:

  (qemu) block_stream hd2 0 hd0.qcow2

After this hd2 contains backing.node-name=hd1, which is no longer
correct because hd1 doesn't exist anymore.

This patch removes all children options from the parent dictionaries
at the end of bdrv_open_inherit() and bdrv_reopen_queue_child().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block.c b/block.c
index 1b8147c1b3..5aaed424b9 100644
--- a/block.c
+++ b/block.c
@@ -2594,6 +2594,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     BlockBackend *file = NULL;
     BlockDriverState *bs;
     BlockDriver *drv = NULL;
+    BdrvChild *child;
     const char *drvname;
     const char *backing;
     Error *local_err = NULL;
@@ -2777,6 +2778,15 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         }
     }
 
+    /* Remove all children options from bs->options and bs->explicit_options */
+    QLIST_FOREACH(child, &bs->children, next) {
+        char *child_key_dot;
+        child_key_dot = g_strdup_printf("%s.", child->name);
+        qdict_extract_subqdict(bs->explicit_options, NULL, child_key_dot);
+        qdict_extract_subqdict(bs->options, NULL, child_key_dot);
+        g_free(child_key_dot);
+    }
+
     bdrv_refresh_filename(bs);
 
     /* Check if any unknown options were used */
@@ -2986,6 +2996,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         }
 
         child_key_dot = g_strdup_printf("%s.", child->name);
+        qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
         qdict_extract_subqdict(options, &new_child_options, child_key_dot);
         g_free(child_key_dot);
 
-- 
2.11.0
