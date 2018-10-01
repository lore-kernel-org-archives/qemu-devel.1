Received: from eggs.gnu.org ([2001:4830:134:3::10]:57493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71r2-0002NB-US
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qz-00075N-3L
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:44 +0200
Message-Id: <20181001171901.11004-7-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/23] block: Allow child references on reopen
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block.c b/block.c
index 98aca56785..ff1aded4b8 100644
--- a/block.c
+++ b/block.c
@@ -3242,6 +3242,24 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             QObject *new = entry->value;
             QObject *old = qdict_get(reopen_state->bs->options, entry->key);
 
+            /* Allow child references (child_name=node_name) as long as they
+             * point to the current child (i.e. everything stays the same). */
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
2.13.6
