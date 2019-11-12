Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFA121783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAndAIb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFA121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUURO-0000au-Gq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUP2-0007G9-82
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUOy-00019c-AQ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUOy-00018K-0E
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573558321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbvPC0j2Q4yaXtsYW/Ngr7jfFhiP1PPYm5HSHEmn2Q0=;
 b=OAndAIb2R7B1D681Jw+jGWUiQvtjkiBbzygPAdRdgOfYrvx7xcUwIZJuPD7Bo3uo3uv6+j
 eeIgvv6Y6vLh/FG3qUws0ZQe7HANwrWjpuTIDWshIGjMZld+3vG4cdvvN3YP9Kn64jaH0i
 Om8jiItZYFl4WoSRtI8bJQh79S5HVcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-9tauDOo0MqibY3ubE9t7Rw-1; Tue, 12 Nov 2019 06:30:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780B3DC20;
 Tue, 12 Nov 2019 11:30:31 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D864D6090D;
 Tue, 12 Nov 2019 11:30:29 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] blockdev: place blockdev_backup_prepare with the other
 related transaction helpers
Date: Tue, 12 Nov 2019 12:30:10 +0100
Message-Id: <20191112113012.71136-7-slp@redhat.com>
In-Reply-To: <20191112113012.71136-1-slp@redhat.com>
References: <20191112113012.71136-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9tauDOo0MqibY3ubE9t7Rw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Move blockdev_backup_prepare() to be side by side with the other
related transaction helper functions.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 blockdev.c | 70 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 128707cdc6..f94aaa98f0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1940,6 +1940,41 @@ typedef struct BlockdevBackupState {
     BlockJob *job;
 } BlockdevBackupState;
=20
+static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
+{
+    BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
+    BlockdevBackup *backup;
+    BlockDriverState *bs;
+    BlockDriverState *target_bs;
+    AioContext *aio_context;
+
+    assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_BA=
CKUP);
+    backup =3D common->action->u.blockdev_backup.data;
+
+    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
+    if (!bs) {
+        return;
+    }
+
+    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
+    if (!target_bs) {
+        return;
+    }
+
+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+    state->bs =3D bs;
+
+    /* Paired with .clean() */
+    bdrv_drained_begin(state->bs);
+
+    state->job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
+                                  bs, target_bs, aio_context,
+                                  common->block_job_txn, errp);
+
+    aio_context_release(aio_context);
+}
+
 static void blockdev_backup_commit(BlkActionState *common)
 {
     BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
@@ -3654,41 +3689,6 @@ XDbgBlockGraph *qmp_x_debug_query_block_graph(Error =
**errp)
     return bdrv_get_xdbg_block_graph(errp);
 }
=20
-static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
-{
-    BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common, =
common);
-    BlockdevBackup *backup;
-    BlockDriverState *bs;
-    BlockDriverState *target_bs;
-    AioContext *aio_context;
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
-    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
-    if (!target_bs) {
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
-    state->job =3D do_backup_common(qapi_BlockdevBackup_base(backup),
-                                  bs, target_bs, aio_context,
-                                  common->block_job_txn, errp);
-
-    aio_context_release(aio_context);
-}
-
 void qmp_blockdev_backup(BlockdevBackup *arg, Error **errp)
 {
     BlockJob *job;
--=20
2.23.0


