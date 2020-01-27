Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D431C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6D320CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEH3LkW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6D320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8il-0002sY-I6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cY-0002EU-BW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cT-0002pn-H5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cT-0002pQ-Dz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eibWu5YYNXVA/nSIzjNe7DPtBXdmmzVCw/nu5hrUSWE=;
 b=KEH3LkW+jc5Zbp2aCAH00zlluQSSSoXe6ySahppEwtl32On0hBsDiqKzcakVU/OxEcPYmA
 /C2L5kKmdI1L3cFjqEHWkbu3wRoGUhmP+6Jl1NcNL8y/UgZ5J+/famjYjEcRvEuEf2Lg9w
 cNoc+0FJiItYWtSGZ936KRkKTB3gi80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-GlR6iw4HNtOA8hxyVWDRWA-1; Mon, 27 Jan 2020 12:56:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 010A2804C21;
 Mon, 27 Jan 2020 17:56:12 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BF6F863C0;
 Mon, 27 Jan 2020 17:56:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/13] blockdev: unify qmp_blockdev_backup and blockdev-backup
 transaction paths
Date: Mon, 27 Jan 2020 18:55:51 +0100
Message-Id: <20200127175559.18173-6-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GlR6iw4HNtOA8hxyVWDRWA-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.20.1


