Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44j-0000Fj-7j
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fG44f-0001Wt-2m
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:58:45 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue,  8 May 2018 17:58:10 +0300
Message-Id: <1525791496-125188-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 3/9] quorum: set supported write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index a5051da..26e7d78 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -867,6 +867,20 @@ static QemuOptsList quorum_runtime_opts = {
     },
 };
 
+static void quorum_set_supported_flags(BlockDriverState *bs)
+{
+    BDRVQuorumState *s = bs->opaque;
+    int i;
+
+    bs->supported_write_flags = BDRV_REQ_FUA;
+    bs->supported_zero_flags  = BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP;
+
+    for (i = 0; i < s->num_children; i++) {
+        bs->supported_write_flags &= s->children[i]->bs->supported_write_flags;
+        bs->supported_zero_flags  &= s->children[i]->bs->supported_zero_flags;
+    }
+}
+
 static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                        Error **errp)
 {
@@ -961,6 +975,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->next_child_index = s->num_children;
 
+    quorum_set_supported_flags(bs);
+
     g_free(opened);
     goto exit;
 
@@ -1029,6 +1045,8 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     s->children = g_renew(BdrvChild *, s->children, s->num_children + 1);
     s->children[s->num_children++] = child;
 
+    quorum_set_supported_flags(bs);
+
 out:
     bdrv_drained_end(bs);
 }
@@ -1064,6 +1082,8 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
     bdrv_unref_child(bs, child);
 
     bdrv_drained_end(bs);
+
+    quorum_set_supported_flags(bs);
 }
 
 static void quorum_refresh_filename(BlockDriverState *bs, QDict *options)
-- 
2.7.4
