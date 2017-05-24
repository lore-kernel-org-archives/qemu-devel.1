Received: from eggs.gnu.org ([2001:4830:134:3::10]:33970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMPw-0000Hr-1B
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMPt-0006mm-0x
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:52:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:21 +0800
Message-Id: <20170524025235.32190-3-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/16] block-backend: Add blk_request_perm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This function tries to request, if not granted yet, for the given
permissions.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 12 ++++++++++++
 include/sysemu/block-backend.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index f3a6008..5492f64 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -654,6 +654,18 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
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
index 840ad61..fc23a9e 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -116,6 +116,7 @@ bool bdrv_is_root_node(BlockDriverState *bs);
 int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
                  Error **errp);
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
+int blk_request_perm(BlockBackend *blk, uint64_t perm, Error **errp);
 
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
 void blk_iostatus_enable(BlockBackend *blk);
-- 
2.9.4
