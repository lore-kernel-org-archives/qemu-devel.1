Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9EC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B16C20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyyCMy28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B16C20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCRK-0005jv-4m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ipCNJ-0000hx-Vh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ipCNI-0005pk-Jp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ipCNI-0005pG-Bw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ww1NfeHtwgyf+gSaFmGXlH4l83bz3xIuBcVd+rifxPI=;
 b=RyyCMy28glnZohJrB+2lh90HKHMQ/+9wWk4FOjQ1ryfZ++ZIBl1hTgq7E8tlKT6a0ww1CH
 8rXDOf8EUT47PS0f6i3WkDlZpMvFQvyoYUs7maKthJniY+noKoJ6uT3jUus1jPwju9w3zc
 MgEBIzEnzqZw1XnGHE0bhZHcO2zscaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-SwTKh0ENMeyWyoOY0kh9Ew-1; Wed, 08 Jan 2020 09:31:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC341005513;
 Wed,  8 Jan 2020 14:31:53 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E79B81C38;
 Wed,  8 Jan 2020 14:31:50 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/8] blockdev: unify qmp_blockdev_backup and
 blockdev-backup transaction paths
Date: Wed,  8 Jan 2020 15:31:33 +0100
Message-Id: <20200108143138.129909-4-slp@redhat.com>
In-Reply-To: <20200108143138.129909-1-slp@redhat.com>
References: <20200108143138.129909-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SwTKh0ENMeyWyoOY0kh9Ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Issuing a blockdev-backup from qmp_blockdev_backup takes a slightly
different path than when it's issued from a transaction. In the code,
this is manifested as some redundancy between do_blockdev_backup() and
blockdev_backup_prepare().

This change unifies both paths, merging do_blockdev_backup() and
blockdev_backup_prepare(), and changing qmp_blockdev_backup() to
create a transaction instead of calling do_backup_common() direcly.

As a side-effect, now qmp_blockdev_backup() is executed inside a
drained section, as it happens when creating a blockdev-backup
transaction. This change is visible from the user's perspective, as
the job gets paused and immediately resumed before starting the actual
work.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 60 ++++++++++++------------------------------------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5e85fc042e..152a0f7454 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1940,16 +1940,13 @@ typedef struct BlockdevBackupState {
     BlockJob *job;
 } BlockdevBackupState;
=20
-static BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
-                                    Error **errp);
-
 static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
 {
     BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
     BlockdevBackup *backup;
-    BlockDriverState *bs, *target;
+    BlockDriverState *bs;
+    BlockDriverState *target_bs;
     AioContext *aio_context;
-    Error *local_err =3D NULL;
=20
     assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_BA=
CKUP);
     backup =3D common->action->u.blockdev_backup.data;
@@ -1959,8 +1956,8 @@ static void blockdev_backup_prepare(BlkActionState *c=
ommon, Error **errp)
         return;
     }
=20
-    target =3D bdrv_lookup_bs(backup->target, backup->target, errp);
-    if (!target) {
+    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
+    if (!target_bs) {
         return;
     }
=20
@@ -1971,13 +1968,10 @@ static void blockdev_backup_prepare(BlkActionState =
*common, Error **errp)
     /* Paired with .clean() */
     bdrv_drained_begin(state->bs);
=20
-    state->job =3D do_blockdev_backup(backup, common->block_job_txn, &loca=
l_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
-    }
+    state->job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
+                                  bs, target_bs, aio_context,
+                                  common->block_job_txn, errp);
=20
-out:
     aio_context_release(aio_context);
 }
=20
@@ -3695,41 +3689,13 @@ XDbgBlockGraph *qmp_x_debug_query_block_graph(Error=
 **errp)
     return bdrv_get_xdbg_block_graph(errp);
 }
=20
-BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
-                             Error **errp)
+void qmp_blockdev_backup(BlockdevBackup *backup, Error **errp)
 {
-    BlockDriverState *bs;
-    BlockDriverState *target_bs;
-    AioContext *aio_context;
-    BlockJob *job;
-
-    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
-    if (!bs) {
-        return NULL;
-    }
-
-    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
-    if (!target_bs) {
-        return NULL;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
-
-    aio_context_release(aio_context);
-    return job;
-}
-
-void qmp_blockdev_backup(BlockdevBackup *arg, Error **errp)
-{
-    BlockJob *job;
-    job =3D do_blockdev_backup(arg, NULL, errp);
-    if (job) {
-        job_start(&job->job);
-    }
+    TransactionAction action =3D {
+        .type =3D TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP,
+        .u.blockdev_backup.data =3D backup,
+    };
+    blockdev_do_action(&action, errp);
 }
=20
 /* Parameter check and block job starting for drive mirroring.
--=20
2.23.0


