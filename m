Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5426C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ADF20838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQxqH2ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ADF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46855 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OXy-0003nh-KF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWp-00023u-VO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007oB-Mx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWo-0007nR-Jg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQ6DxV6jZ9EhK0MmlKoFdt0A7LnpMjVQOlhjqUq1BYs=;
 b=NQxqH2uiq+fYhN0FsVGtMBeX6DX/kYk7+cI77/5gLhazl7E8GQXUt5YKGZXZlt+q4eHCgx
 CpTwYVMfqG6dCw2otdx1UOZeR34KXI/BOfoGwN0lkomkG2hH/1s6WrAXR2JYSAISXTkDYY
 eda0P9+gGSeoSJnq/z+N/g9liapJPok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-S5Qm0YZuMzWDVuhvBuNnoQ-1; Mon, 24 Feb 2020 19:56:46 -0500
X-MC-Unique: S5Qm0YZuMzWDVuhvBuNnoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90194800D50;
 Tue, 25 Feb 2020 00:56:45 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A25121CB;
 Tue, 25 Feb 2020 00:56:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] qmp: expose block-dirty-bitmap-populate
Date: Mon, 24 Feb 2020 19:56:37 -0500
Message-Id: <20200225005641.5478-3-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a new job-creating command.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json  | 18 ++++++++++
 qapi/transaction.json |  2 ++
 blockdev.c            | 78 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index df1797681a..a8be1fb36b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2293,6 +2293,24 @@
             '*auto-finalize': 'bool',
             '*auto-dismiss': 'bool' } }
=20
+##
+# @block-dirty-bitmap-populate:
+#
+# Creates a new job that writes a pattern into a dirty bitmap.
+#
+# Since: 5.0
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
index 04301f1be7..28521d5c7f 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -50,6 +50,7 @@
 # - @block-dirty-bitmap-enable: since 4.0
 # - @block-dirty-bitmap-disable: since 4.0
 # - @block-dirty-bitmap-merge: since 4.0
+# - @block-dirty-bitmap-populate: since 5.0
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
index 011dcfec27..33c0e35399 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2314,6 +2314,67 @@ static void block_dirty_bitmap_remove_commit(BlkActi=
onState *common)
     bdrv_release_dirty_bitmap(state->bitmap);
 }
=20
+static void block_dirty_bitmap_populate_prepare(BlkActionState *common, Er=
ror **errp)
+{
+    BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
+    BlockDirtyBitmapPopulate *bitpop;
+    BlockDriverState *bs;
+    AioContext *aio_context;
+    BdrvDirtyBitmap *bmap =3D NULL;
+    int job_flags =3D JOB_DEFAULT;
+
+    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCK_DIRTY=
_BITMAP_POPULATE);
+    bitpop =3D common->action->u.block_dirty_bitmap_populate.data;
+
+    bs =3D bdrv_lookup_bs(bitpop->node, bitpop->node, errp);
+    if (!bs) {
+        return;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+    state->bs =3D bs;
+
+    bmap =3D bdrv_find_dirty_bitmap(bs, bitpop->name);
+    if (!bmap) {
+        error_setg(errp, "Bitmap '%s' could not be found", bitpop->name);
+        return;
+    }
+
+    /* Paired with .clean() */
+    bdrv_drained_begin(state->bs);
+
+    if (!bitpop->has_on_error) {
+        bitpop->on_error =3D BLOCKDEV_ON_ERROR_REPORT;
+    }
+    if (!bitpop->has_auto_finalize) {
+        bitpop->auto_finalize =3D true;
+    }
+    if (!bitpop->has_auto_dismiss) {
+        bitpop->auto_dismiss =3D true;
+    }
+
+    if (!bitpop->auto_finalize) {
+        job_flags |=3D JOB_MANUAL_FINALIZE;
+    }
+    if (!bitpop->auto_dismiss) {
+        job_flags |=3D JOB_MANUAL_DISMISS;
+    }
+
+    state->job =3D bitpop_job_create(
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
@@ -2397,6 +2458,13 @@ static const BlkActionOps actions[] =3D {
         .commit =3D block_dirty_bitmap_remove_commit,
         .abort =3D block_dirty_bitmap_remove_abort,
     },
+    [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE] =3D {
+        .instance_size =3D sizeof(BlockdevBackupState),
+        .prepare =3D block_dirty_bitmap_populate_prepare,
+        .commit =3D blockdev_backup_commit,
+        .abort =3D blockdev_backup_abort,
+        .clean =3D blockdev_backup_clean,
+    },
     /* Where are transactions for MIRROR, COMMIT and STREAM?
      * Although these blockjobs use transaction callbacks like the backup =
job,
      * these jobs do not necessarily adhere to transaction semantics.
@@ -3225,6 +3293,16 @@ void qmp_block_dirty_bitmap_merge(const char *node, =
const char *target,
     do_block_dirty_bitmap_merge(node, target, bitmaps, NULL, errp);
 }
=20
+void qmp_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *bitpop,
+                                     Error **errp)
+{
+    TransactionAction action =3D {
+        .type =3D TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE,
+        .u.block_dirty_bitmap_populate.data =3D bitpop,
+    };
+    blockdev_do_action(&action, errp);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *=
node,
                                                               const char *=
name,
                                                               Error **errp=
)
--=20
2.21.1


