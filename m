Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIJ-0001UJ-JN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAII-0000P5-RT
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:21 +0800
Message-Id: <20170321031635.22123-3-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 02/16] block-backend: Add blk_request_perm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This function tries to request, if not granted yet, for the given
permissions.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 12 ++++++++++++
 include/sysemu/block-backend.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09..5d17404 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -595,6 +595,18 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
     *shared_perm = blk->shared_perm;
 }
 
+int blk_request_perm(BlockBackend *blk, uint64_t perm, Error **errp)
+{
+    uint64_t blk_perm, shared_perm;
+
+    blk_get_perm(blk, &blk_perm, &shared_perm);
+    if ((blk_perm & perm) == perm) {
+        return 0;
+    }
+    blk_perm |= perm;
+    return blk_set_perm(blk, blk_perm, shared_perm, errp);
+}
+
 static int blk_do_attach_dev(BlockBackend *blk, void *dev)
 {
     if (blk->dev) {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 096c17f..016632e 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -108,6 +108,7 @@ bool bdrv_is_root_node(BlockDriverState *bs);
 int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
                  Error **errp);
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
+int blk_request_perm(BlockBackend *blk, uint64_t perm, Error **errp);
 
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
 void blk_iostatus_enable(BlockBackend *blk);
-- 
2.9.3
