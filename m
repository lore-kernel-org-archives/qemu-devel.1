Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUs-0007Ly-L9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUq-0000tP-NQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:58 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:36 -0500
Message-Id: <20180313171345.659672-9-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 08/17] block: let
 blk_add/remove_aio_context_notifier() tolerate BDS changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 2019ba0a0197 ("block: Add AioContextNotifier functions to BB")
added blk_add/remove_aio_context_notifier() and implemented them by
passing through the bdrv_*() equivalent.

This doesn't work across bdrv_append(), which detaches child->bs and
re-attaches it to a new BlockDriverState.  When
blk_remove_aio_context_notifier() is called we will access the new BDS
instead of the one where the notifier was added!

>From the point of view of the blk_*() API user, changes to the root BDS
should be transparent.

This patch maintains a list of AioContext notifiers in BlockBackend and
adds/removes them from the BlockDriverState as needed.

Reported-by: Stefano Panella <spanella@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180306204819.11266-2-stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-backend.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events    |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index f2e0a855ff7..681b240b126 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -31,6 +31,13 @@

 static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);

+typedef struct BlockBackendAioNotifier {
+    void (*attached_aio_context)(AioContext *new_context, void *opaque);
+    void (*detach_aio_context)(void *opaque);
+    void *opaque;
+    QLIST_ENTRY(BlockBackendAioNotifier) list;
+} BlockBackendAioNotifier;
+
 struct BlockBackend {
     char *name;
     int refcnt;
@@ -69,6 +76,7 @@ struct BlockBackend {
     bool allow_write_beyond_eof;

     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+    QLIST_HEAD(, BlockBackendAioNotifier) aio_notifiers;

     int quiesce_counter;
     VMChangeStateEntry *vmsh;
@@ -247,6 +255,36 @@ static int blk_root_inactivate(BdrvChild *child)
     return 0;
 }

+static void blk_root_attach(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+    BlockBackendAioNotifier *notifier;
+
+    trace_blk_root_attach(child, blk, child->bs);
+
+    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
+        bdrv_add_aio_context_notifier(child->bs,
+                notifier->attached_aio_context,
+                notifier->detach_aio_context,
+                notifier->opaque);
+    }
+}
+
+static void blk_root_detach(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+    BlockBackendAioNotifier *notifier;
+
+    trace_blk_root_detach(child, blk, child->bs);
+
+    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
+        bdrv_remove_aio_context_notifier(child->bs,
+                notifier->attached_aio_context,
+                notifier->detach_aio_context,
+                notifier->opaque);
+    }
+}
+
 static const BdrvChildRole child_root = {
     .inherit_options    = blk_root_inherit_options,

@@ -260,6 +298,9 @@ static const BdrvChildRole child_root = {

     .activate           = blk_root_activate,
     .inactivate         = blk_root_inactivate,
+
+    .attach             = blk_root_attach,
+    .detach             = blk_root_detach,
 };

 /*
@@ -287,6 +328,7 @@ BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)

     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
+    QLIST_INIT(&blk->aio_notifiers);

     QTAILQ_INSERT_TAIL(&block_backends, blk, link);
     return blk;
@@ -364,6 +406,7 @@ static void blk_delete(BlockBackend *blk)
     }
     assert(QLIST_EMPTY(&blk->remove_bs_notifiers.notifiers));
     assert(QLIST_EMPTY(&blk->insert_bs_notifiers.notifiers));
+    assert(QLIST_EMPTY(&blk->aio_notifiers));
     QTAILQ_REMOVE(&block_backends, blk, link);
     drive_info_del(blk->legacy_dinfo);
     block_acct_cleanup(&blk->stats);
@@ -1857,8 +1900,15 @@ void blk_add_aio_context_notifier(BlockBackend *blk,
         void (*attached_aio_context)(AioContext *new_context, void *opaque),
         void (*detach_aio_context)(void *opaque), void *opaque)
 {
+    BlockBackendAioNotifier *notifier;
     BlockDriverState *bs = blk_bs(blk);

+    notifier = g_new(BlockBackendAioNotifier, 1);
+    notifier->attached_aio_context = attached_aio_context;
+    notifier->detach_aio_context = detach_aio_context;
+    notifier->opaque = opaque;
+    QLIST_INSERT_HEAD(&blk->aio_notifiers, notifier, list);
+
     if (bs) {
         bdrv_add_aio_context_notifier(bs, attached_aio_context,
                                       detach_aio_context, opaque);
@@ -1871,12 +1921,25 @@ void blk_remove_aio_context_notifier(BlockBackend *blk,
                                      void (*detach_aio_context)(void *),
                                      void *opaque)
 {
+    BlockBackendAioNotifier *notifier;
     BlockDriverState *bs = blk_bs(blk);

     if (bs) {
         bdrv_remove_aio_context_notifier(bs, attached_aio_context,
                                          detach_aio_context, opaque);
     }
+
+    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
+        if (notifier->attached_aio_context == attached_aio_context &&
+            notifier->detach_aio_context == detach_aio_context &&
+            notifier->opaque == opaque) {
+            QLIST_REMOVE(notifier, list);
+            g_free(notifier);
+            return;
+        }
+    }
+
+    abort();
 }

 void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify)
diff --git a/block/trace-events b/block/trace-events
index 02dd80ff0c3..7493d521dcf 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -7,6 +7,8 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 # block/block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
+blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
+blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"

 # block/io.c
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-- 
2.14.3
