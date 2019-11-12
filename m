Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C31C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E773921783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0x5pcnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E773921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUWP-00062i-5P
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUP9-0007Hx-80
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUP2-0001BU-53
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUOy-00018T-9N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw8sl+1CgmcCR7p4mfbvS51RM3jOkynBnHJ/+9qXwQQ=;
 b=H0x5pcnpTbDfHqk4PBBdbvm5gLrg+GrphHj8uzo6s71xodjs4tBT0ZtsWBYOsXL+YgRf0r
 W1x2hmggIT6XHOqejXyepvVr3ZzGVUiVv9LQ5iy0nw3DbSGD43qDSQicF+ECTZu4sRReoi
 AfkvcjlG3W9Ho5MpOEajPMw7D4SSO28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Mxi0ETbjP_qVFDJrNjeibg-1; Tue, 12 Nov 2019 06:30:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BF78800EB3;
 Tue, 12 Nov 2019 11:30:29 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE40C60A89;
 Tue, 12 Nov 2019 11:30:27 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] blockdev: merge blockdev_backup_prepare with
 do_blockdev_backup
Date: Tue, 12 Nov 2019 12:30:09 +0100
Message-Id: <20191112113012.71136-6-slp@redhat.com>
In-Reply-To: <20191112113012.71136-1-slp@redhat.com>
References: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Mxi0ETbjP_qVFDJrNjeibg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consolidate blockdev_backup_prepare() with do_blockdev_backup() as a
first step towards streamlining all functionality through
transactions.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 64 +++++++++++++-----------------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5e85fc042e..128707cdc6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1940,47 +1940,6 @@ typedef struct BlockdevBackupState {
     BlockJob *job;
 } BlockdevBackupState;
=20
-static BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
-                                    Error **errp);
-
-static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
-{
-    BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
-    BlockdevBackup *backup;
-    BlockDriverState *bs, *target;
-    AioContext *aio_context;
-    Error *local_err =3D NULL;
-
-    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_BA=
CKUP);
-    backup =3D common->action->u.blockdev_backup.data;
-
-    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
-    if (!bs) {
-        return;
-    }
-
-    target =3D bdrv_lookup_bs(backup->target, backup->target, errp);
-    if (!target) {
-        return;
-    }
-
-    aio_context =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-    state->bs =3D bs;
-
-    /* Paired with .clean() */
-    bdrv_drained_begin(state->bs);
-
-    state->job =3D do_blockdev_backup(backup, common->block_job_txn, &loca=
l_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
-    }
-
-out:
-    aio_context_release(aio_context);
-}
-
 static void blockdev_backup_commit(BlkActionState *common)
 {
     BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
@@ -3695,32 +3654,39 @@ XDbgBlockGraph *qmp_x_debug_query_block_graph(Error=
 **errp)
     return bdrv_get_xdbg_block_graph(errp);
 }
=20
-BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
-                             Error **errp)
+static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
 {
+    BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
+    BlockdevBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     AioContext *aio_context;
-    BlockJob *job;
+
+    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_BA=
CKUP);
+    backup =3D common->action->u.blockdev_backup.data;
=20
     bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
     if (!bs) {
-        return NULL;
+        return;
     }
=20
     target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
     if (!target_bs) {
-        return NULL;
+        return;
     }
=20
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
+    state->bs =3D bs;
=20
-    job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
-                           bs, target_bs, aio_context, txn, errp);
+    /* Paired with .clean() */
+    bdrv_drained_begin(state->bs);
+
+    state->job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
+                                  bs, target_bs, aio_context,
+                                  common->block_job_txn, errp);
=20
     aio_context_release(aio_context);
-    return job;
 }
=20
 void qmp_blockdev_backup(BlockdevBackup *arg, Error **errp)
--=20
2.23.0


