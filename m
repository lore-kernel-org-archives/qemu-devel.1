Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08B620C09
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8BiJ+pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08B620C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmN8q-0005wZ-5r
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7o-0004H4-7H
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7l-0007d9-M8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592596589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+EN9Do3mUyUs9jCHSaQNHba7uiBgnaN8VZWKJG82sDI=;
 b=A8BiJ+pcyZ/EtJcxRwXHyori5PdXwtAJVIdtU6SZQwuSrJEmd2bc8WF/0T/NKDzE1BIwsj
 UrDU/ld07XaVynDjHUAyZywgjOuw/kYQkDo9TmZUCvM6s/k0t2fU8e6Dbg6tvsdknGoG7l
 7Txw50zF3QjceJYS4lvvQAV4qq8Ze3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-eoUF8EiuMi6aiCzQMWb3Eg-1; Fri, 19 Jun 2020 15:56:27 -0400
X-MC-Unique: eoUF8EiuMi6aiCzQMWb3Eg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086DC1800D42;
 Fri, 19 Jun 2020 19:56:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C9571661;
 Fri, 19 Jun 2020 19:56:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] qmp: expose block-dirty-bitmap-populate
Date: Fri, 19 Jun 2020 14:56:18 -0500
Message-Id: <20200619195621.58740-4-eblake@redhat.com>
In-Reply-To: <20200619195621.58740-1-eblake@redhat.com>
References: <20200619195621.58740-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This is a new job-creating command.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json  | 18 +++++++++++
 qapi/transaction.json |  2 ++
 blockdev.c            | 74 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index a1bcdba04423..313583b47c16 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2259,6 +2259,24 @@
             '*auto-finalize': 'bool',
             '*auto-dismiss': 'bool' } }

+##
+# @block-dirty-bitmap-populate:
+#
+# Creates a new job that writes a pattern into a dirty bitmap.
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-populate",
+#      "arguments": { "node": "drive0", "target": "bitmap0",
+#                     "job-id": "job0", "pattern": "allocate-top" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'block-dirty-bitmap-populate', 'boxed': true,
+  'data': 'BlockDirtyBitmapPopulate' }
+
 ##
 # @BlockDirtyBitmapSha256:
 #
diff --git a/qapi/transaction.json b/qapi/transaction.json
index b6c11158f0b6..21be59faae56 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -50,6 +50,7 @@
 # - @block-dirty-bitmap-enable: since 4.0
 # - @block-dirty-bitmap-disable: since 4.0
 # - @block-dirty-bitmap-merge: since 4.0
+# - @block-dirty-bitmap-populate: since 5.1
 # - @blockdev-backup: since 2.3
 # - @blockdev-snapshot: since 2.5
 # - @blockdev-snapshot-internal-sync: since 1.7
@@ -67,6 +68,7 @@
        'block-dirty-bitmap-enable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-disable': 'BlockDirtyBitmap',
        'block-dirty-bitmap-merge': 'BlockDirtyBitmapMerge',
+       'block-dirty-bitmap-populate': 'BlockDirtyBitmapPopulate',
        'blockdev-backup': 'BlockdevBackup',
        'blockdev-snapshot': 'BlockdevSnapshot',
        'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
diff --git a/blockdev.c b/blockdev.c
index 6d80af903c55..d072519e7b91 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2177,6 +2177,63 @@ static void block_dirty_bitmap_remove_commit(BlkActionState *common)
     bdrv_release_dirty_bitmap(state->bitmap);
 }

+static void block_dirty_bitmap_populate_prepare(BlkActionState *common,
+                                                Error **errp)
+{
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
+    BlockDirtyBitmapPopulate *bitpop;
+    BlockDriverState *bs;
+    AioContext *aio_context;
+    BdrvDirtyBitmap *bmap = NULL;
+    int job_flags = JOB_DEFAULT;
+
+    assert(common->action->type ==
+           TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE);
+    bitpop = common->action->u.block_dirty_bitmap_populate.data;
+
+    bmap = block_dirty_bitmap_lookup(bitpop->node, bitpop->name, &bs, errp);
+    if (!bmap) {
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+    state->bs = bs;
+
+    /* Paired with .clean() */
+    bdrv_drained_begin(state->bs);
+
+    if (!bitpop->has_on_error) {
+        bitpop->on_error = BLOCKDEV_ON_ERROR_REPORT;
+    }
+    if (!bitpop->has_auto_finalize) {
+        bitpop->auto_finalize = true;
+    }
+    if (!bitpop->has_auto_dismiss) {
+        bitpop->auto_dismiss = true;
+    }
+
+    if (!bitpop->auto_finalize) {
+        job_flags |= JOB_MANUAL_FINALIZE;
+    }
+    if (!bitpop->auto_dismiss) {
+        job_flags |= JOB_MANUAL_DISMISS;
+    }
+
+    state->job = bitpop_job_create(
+        bitpop->job_id,
+        bs,
+        bmap,
+        bitpop->pattern,
+        bitpop->on_error,
+        job_flags,
+        NULL, NULL,
+        common->block_job_txn,
+        errp);
+
+    aio_context_release(aio_context);
+}
+
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2260,6 +2317,13 @@ static const BlkActionOps actions[] = {
         .commit = block_dirty_bitmap_remove_commit,
         .abort = block_dirty_bitmap_remove_abort,
     },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE] = {
+        .instance_size = sizeof(BlockJobActionState),
+        .prepare = block_dirty_bitmap_populate_prepare,
+        .commit = blockdev_backup_commit,
+        .abort = blockdev_backup_abort,
+        .clean = blockdev_backup_clean,
+    },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup job,
      * these jobs do not necessarily adhere to transaction semantics.
@@ -2379,6 +2443,16 @@ void qmp_block_passwd(bool has_device, const char *device,
                "Setting block passwords directly is no longer supported");
 }

+void qmp_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *bitpop,
+                                     Error **errp)
+{
+    TransactionAction action = {
+        .type = TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE,
+        .u.block_dirty_bitmap_populate.data = bitpop,
+    };
+    blockdev_do_action(&action, errp);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
-- 
2.27.0


