Received: from eggs.gnu.org ([2001:4830:134:3::10]:60101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl9-00082i-Eu
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ftvl6-0006zR-E1
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 10:11:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Sun, 26 Aug 2018 17:09:36 +0300
Message-Id: <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
In-Reply-To: <cover.1535291602.git.berto@igalia.com>
References: <cover.1535291602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
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

In the previous patches we removed all child references from
bs->{options,explicit_options} because keeping them is useless and
wrong.

Because of this, any attempt to reopen a BlockDriverState using a
child reference as one of its options would result in a failure,
because bdrv_reopen_prepare() would detect that there's a new option
(the child reference) that wasn't present in bs->options.

But passing child references on reopen can be useful. It's a way to
specify a BDS's child without having to pass recursively all of the
child's options, and if the reference points to a different BDS then
this can allow us to replace the child.

However, replacing the child is something that needs to be implemented
case by case and only when it makes sense. For now, this patch allows
passing a child reference as long as it points to the current child of
the BlockDriverState.

It's also important to remember that, as a consequence of the
previous patches, this child reference will be removed from
bs->{options,explicit_options} after the reopening has been completed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/block.c b/block.c
index 92afb3dcce..804d557608 100644
--- a/block.c
+++ b/block.c
@@ -3241,6 +3241,25 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             QObject *new = entry->value;
             QObject *old = qdict_get(reopen_state->bs->options, entry->key);
 
+            /* We allow child references 'child_name'='value'
+             * if 'child_name' is an existing child of the BDS
+             * and 'value' is the child's node name (a string). */
+            if (qobject_type(new) == QTYPE_QSTRING) {
+                BdrvChild *child;
+                QLIST_FOREACH(child, &reopen_state->bs->children, next) {
+                    if (!strcmp(child->name, entry->key)) {
+                        break;
+                    }
+                }
+
+                if (child) {
+                    const char *str = qobject_get_try_str(new);
+                    if (!strcmp(child->bs->node_name, str)) {
+                        continue; /* Found child with this name, skip option */
+                    }
+                }
+            }
+
             /*
              * TODO: When using -drive to specify blockdev options, all values
              * will be strings; however, when using -blockdev, blockdev-add or
-- 
2.11.0
