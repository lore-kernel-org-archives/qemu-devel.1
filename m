Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E229C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567F1208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567F1208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3jwd-0005gf-Fl
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jWm-0000b4-FH
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3jWj-0005go-Ta
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:13:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:60634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jWd-0004Fn-F6; Fri, 30 Aug 2019 12:13:23 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3jVn-0001X0-0D; Fri, 30 Aug 2019 19:12:31 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri, 30 Aug 2019 19:12:27 +0300
Message-Id: <20190830161228.54238-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190830161228.54238-1-vsementsov@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v10 13/14] block: introduce backup-top filter
 driver
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Backup-top filter caches write operations and does copy-before-write
operations.

The driver will be used in backup instead of write-notifiers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup-top.h  |  37 +++++++
 block/backup-top.c  | 244 ++++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs |   2 +
 3 files changed, 283 insertions(+)
 create mode 100644 block/backup-top.h
 create mode 100644 block/backup-top.c

diff --git a/block/backup-top.h b/block/backup-top.h
new file mode 100644
index 0000000000..67de7a9133
--- /dev/null
+++ b/block/backup-top.h
@@ -0,0 +1,37 @@
+/*
+ * backup-top filter driver
+ *
+ * The driver performs Copy-Before-Write (CBW) operation: it is injected above
+ * some node, and before each write it copies _old_ data to the target node.
+ *
+ * Copyright (c) 2018-2019 Virtuozzo International GmbH.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BACKUP_TOP_H
+#define BACKUP_TOP_H
+
+#include "block/block_int.h"
+
+BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
+                                         const char *filter_node_name,
+                                         Error **errp);
+void bdrv_backup_top_set_bcs(BlockDriverState *bs, BlockCopyState *copy_state);
+void bdrv_backup_top_drop(BlockDriverState *bs);
+
+#endif /* BACKUP_TOP_H */
diff --git a/block/backup-top.c b/block/backup-top.c
new file mode 100644
index 0000000000..0991b64759
--- /dev/null
+++ b/block/backup-top.c
@@ -0,0 +1,244 @@
+/*
+ * backup-top filter driver
+ *
+ * The driver performs Copy-Before-Write (CBW) operation: it is injected above
+ * some node, and before each write it copies _old_ data to the target node.
+ *
+ * Copyright (c) 2018-2019 Virtuozzo International GmbH.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "sysemu/block-backend.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+#include "block/block-copy.h"
+
+#include "block/backup-top.h"
+
+typedef struct BDRVBackupTopState {
+    BlockCopyState *bcs;
+    bool active;
+} BDRVBackupTopState;
+
+static coroutine_fn int backup_top_co_preadv(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes)
+{
+    /*
+     * Here we'd like to use block_copy(), but it needs some additional
+     * synchronization mechanism to prevent intersecting guest writes during
+     * copy operation. The will appear in further commit (it should be done
+     * together with moving backup to using of backup-top and to the same
+     * synchronization mechanism), and for now it is a TODO.
+     */
+
+    abort();
+}
+
+static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
+                                               int64_t offset, int bytes)
+{
+    int ret = backup_top_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_pdiscard(bs->backing, offset, bytes);
+}
+
+static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    int ret = backup_top_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+}
+
+static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
+                                              uint64_t offset,
+                                              uint64_t bytes,
+                                              QEMUIOVector *qiov, int flags)
+{
+    if (!(flags & BDRV_REQ_WRITE_UNCHANGED)) {
+        int ret = backup_top_cbw(bs, offset, bytes);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
+{
+    if (!bs->backing) {
+        return 0;
+    }
+
+    return bdrv_co_flush(bs->backing->bs);
+}
+
+static void backup_top_refresh_filename(BlockDriverState *bs)
+{
+    if (bs->backing == NULL) {
+        /*
+         * we can be here after failed bdrv_attach_child in
+         * bdrv_set_backing_hd
+         */
+        return;
+    }
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
+
+static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                  const BdrvChildRole *role,
+                                  BlockReopenQueue *reopen_queue,
+                                  uint64_t perm, uint64_t shared,
+                                  uint64_t *nperm, uint64_t *nshared)
+{
+    BDRVBackupTopState *s = bs->opaque;
+
+    if (!s->active) {
+        /*
+         * The filter node may be in process of bdrv_append(), which firstly do
+         * bdrv_set_backing_hd() and then bdrv_replace_node(). This means that
+         * we can't unshare BLK_PERM_WRITE during bdrv_append() operation. So,
+         * let's require nothing during bdrv_append() and refresh permissions
+         * after it (see bdrv_backup_top_append()).
+         */
+        *nperm = 0;
+        *nshared = BLK_PERM_ALL;
+        return;
+    }
+
+    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+                              nperm, nshared);
+
+    *nshared &= ~BLK_PERM_WRITE;
+}
+
+BlockDriver bdrv_backup_top_filter = {
+    .format_name = "backup-top",
+    .instance_size = sizeof(BDRVBackupTopState),
+
+    .bdrv_co_preadv             = backup_top_co_preadv,
+    .bdrv_co_pwritev            = backup_top_co_pwritev,
+    .bdrv_co_pwrite_zeroes      = backup_top_co_pwrite_zeroes,
+    .bdrv_co_pdiscard           = backup_top_co_pdiscard,
+    .bdrv_co_flush              = backup_top_co_flush,
+
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+
+    .bdrv_refresh_filename      = backup_top_refresh_filename,
+
+    .bdrv_child_perm            = backup_top_child_perm,
+
+    .is_filter = true,
+};
+
+BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
+                                         const char *filter_node_name,
+                                         Error **errp)
+{
+    Error *local_err = NULL;
+    BDRVBackupTopState *state;
+    BlockDriverState *top = bdrv_new_open_driver(&bdrv_backup_top_filter,
+                                                 filter_node_name,
+                                                 BDRV_O_RDWR, errp);
+
+    if (!top) {
+        return NULL;
+    }
+
+    top->total_sectors = source->total_sectors;
+    top->opaque = state = g_new0(BDRVBackupTopState, 1);
+
+    bdrv_drained_begin(source);
+
+    bdrv_ref(top);
+    bdrv_append(top, source, &local_err);
+    if (local_err) {
+        error_prepend(&local_err, "Cannot append backup-top filter: ");
+    } else {
+        /*
+         * bdrv_append() finished successfully, now we can require permissions
+         * we want.
+         */
+        state->active = true;
+        bdrv_child_refresh_perms(top, top->backing, &local_err);
+        if (local_err) {
+            state->active = false;
+            bdrv_backup_top_drop(top);
+            error_prepend(&local_err,
+                          "Cannot set permissions for backup-top filter: ");
+        }
+    }
+
+    bdrv_drained_end(source);
+
+    if (local_err) {
+        bdrv_unref(top);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return top;
+}
+
+void bdrv_backup_top_set_bcs(BlockDriverState *bs, BlockCopyState *copy_state)
+{
+    BDRVBackupTopState *s = bs->opaque;
+
+    assert(blk_bs(copy_state->source) == bs->backing->bs);
+    s->bcs = copy_state;
+}
+
+void bdrv_backup_top_drop(BlockDriverState *bs)
+{
+    BDRVBackupTopState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
+
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_begin(bs);
+
+    s->active = false;
+    bdrv_child_refresh_perms(bs, bs->backing, &error_abort);
+    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
+    bdrv_set_backing_hd(bs, NULL, &error_abort);
+
+    bdrv_drained_end(bs);
+
+    bdrv_unref(bs);
+
+    aio_context_release(aio_context);
+}
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 0b5c635fb2..6f348c56c9 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -41,6 +41,8 @@ block-obj-y += block-copy.o
 
 block-obj-y += crypto.o
 
+block-obj-y += backup-top.o
+
 common-obj-y += stream.o
 
 nfs.o-libs         := $(LIBNFS_LIBS)
-- 
2.18.0


