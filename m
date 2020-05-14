Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9993B20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCXTgt4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9993B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ4tW-0001Us-Lo
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 23:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sS-0008VP-An
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sR-0008PD-Bg
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589428182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfimXGLJB+UJS1On95ecDTDtyczxeKMoMpfUjJAS63M=;
 b=bCXTgt4+S62KKhrFQcQnFyOhITJ6Yw81+IFid5Myld9bYY/mD7nU8GRq86xLw9cqdXV3Fr
 iXXGBXiSJTHFIqIIp+U/0kkLht9jUJ13HUdzvBrDOLisIM3SJoFZXqKR6lfhynZopKVEyW
 +kOqGunmKltCw2Liil7Lpi/S6c3/t34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-zJU1430fMv-LCXrOuKRhFA-1; Wed, 13 May 2020 23:49:40 -0400
X-MC-Unique: zJU1430fMv-LCXrOuKRhFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72ACD835B41;
 Thu, 14 May 2020 03:49:39 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 229FE7529E;
 Thu, 14 May 2020 03:49:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 2/5] blockdev: combine DriveBackupState and
 BlockdevBackupState
Date: Wed, 13 May 2020 23:49:19 -0400
Message-Id: <20200514034922.24834-3-jsnow@redhat.com>
In-Reply-To: <20200514034922.24834-1-jsnow@redhat.com>
References: <20200514034922.24834-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They have the same fields -- rename it BlockJobState.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index b3c840ec03..d3e8a6ca22 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1702,11 +1702,11 @@ static void external_snapshot_clean(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-typedef struct DriveBackupState {
+typedef struct BlockJobActionState {
     BlkActionState common;
     BlockDriverState *bs;
     BlockJob *job;
-} DriveBackupState;
+} BlockJobActionState;
 
 static BlockJob *do_backup_common(BackupCommon *backup,
                                   BlockDriverState *bs,
@@ -1716,7 +1716,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 
 static void drive_backup_prepare(BlkActionState *common, Error **errp)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     DriveBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
@@ -1853,7 +1853,7 @@ out:
 
 static void drive_backup_commit(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;
 
     aio_context = bdrv_get_aio_context(state->bs);
@@ -1867,7 +1867,7 @@ static void drive_backup_commit(BlkActionState *common)
 
 static void drive_backup_abort(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
 
     if (state->job) {
         AioContext *aio_context;
@@ -1883,7 +1883,7 @@ static void drive_backup_abort(BlkActionState *common)
 
 static void drive_backup_clean(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;
 
     if (!state->bs) {
@@ -1898,15 +1898,9 @@ static void drive_backup_clean(BlkActionState *common)
     aio_context_release(aio_context);
 }
 
-typedef struct BlockdevBackupState {
-    BlkActionState common;
-    BlockDriverState *bs;
-    BlockJob *job;
-} BlockdevBackupState;
-
 static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     BlockdevBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
@@ -1954,7 +1948,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
 
 static void blockdev_backup_commit(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;
 
     aio_context = bdrv_get_aio_context(state->bs);
@@ -1968,7 +1962,7 @@ static void blockdev_backup_commit(BlkActionState *common)
 
 static void blockdev_backup_abort(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
 
     if (state->job) {
         AioContext *aio_context;
@@ -1984,7 +1978,7 @@ static void blockdev_backup_abort(BlkActionState *common)
 
 static void blockdev_backup_clean(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;
 
     if (!state->bs) {
@@ -2265,14 +2259,14 @@ static const BlkActionOps actions[] = {
         .clean = external_snapshot_clean,
     },
     [TRANSACTION_ACTION_KIND_DRIVE_BACKUP] = {
-        .instance_size = sizeof(DriveBackupState),
+        .instance_size = sizeof(BlockJobActionState),
         .prepare = drive_backup_prepare,
         .commit = drive_backup_commit,
         .abort = drive_backup_abort,
         .clean = drive_backup_clean,
     },
     [TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP] = {
-        .instance_size = sizeof(BlockdevBackupState),
+        .instance_size = sizeof(BlockJobActionState),
         .prepare = blockdev_backup_prepare,
         .commit = blockdev_backup_commit,
         .abort = blockdev_backup_abort,
-- 
2.21.1


