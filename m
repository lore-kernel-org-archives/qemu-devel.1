Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32515C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10BE20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQUp0yys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10BE20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmN8n-0005p6-9l
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7n-0004FR-Bz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7l-0007d4-IH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592596588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECTBnS2he4XAR+17tYX0uLcF6htb9lx7WX+8NFiYHJA=;
 b=KQUp0yysvMM9oNS1kTDU6jPacvIUnnjxM1NTOWshaSWRQSepXBdt54ig/59cfKk8G5UBZj
 j1mDgjLyFhGgLjRJoArgX674reCWPMtpTQHmdFIgsGZh/nB0eXP+aDYCOSICTePffnPb55
 uYbV5FVqEdZgNt2afMtZYwShbG1gOgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-cgoU-4E0OIOeWYnt62wZiw-1; Fri, 19 Jun 2020 15:56:26 -0400
X-MC-Unique: cgoU-4E0OIOeWYnt62wZiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF4C800053;
 Fri, 19 Jun 2020 19:56:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8571171661;
 Fri, 19 Jun 2020 19:56:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/6] blockdev: combine DriveBackupState and
 BlockdevBackupState
Date: Fri, 19 Jun 2020 14:56:17 -0500
Message-Id: <20200619195621.58740-3-eblake@redhat.com>
In-Reply-To: <20200619195621.58740-1-eblake@redhat.com>
References: <20200619195621.58740-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

They have the same fields -- rename it BlockJobActionState.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 72df193ca73b..6d80af903c55 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1655,11 +1655,11 @@ static void external_snapshot_clean(BlkActionState *common)
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
@@ -1669,7 +1669,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,

 static void drive_backup_prepare(BlkActionState *common, Error **errp)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     DriveBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
@@ -1806,7 +1806,7 @@ out:

 static void drive_backup_commit(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     aio_context = bdrv_get_aio_context(state->bs);
@@ -1820,7 +1820,7 @@ static void drive_backup_commit(BlkActionState *common)

 static void drive_backup_abort(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);

     if (state->job) {
         AioContext *aio_context;
@@ -1836,7 +1836,7 @@ static void drive_backup_abort(BlkActionState *common)

 static void drive_backup_clean(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     if (!state->bs) {
@@ -1851,15 +1851,9 @@ static void drive_backup_clean(BlkActionState *common)
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
@@ -1907,7 +1901,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)

 static void blockdev_backup_commit(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     aio_context = bdrv_get_aio_context(state->bs);
@@ -1921,7 +1915,7 @@ static void blockdev_backup_commit(BlkActionState *common)

 static void blockdev_backup_abort(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);

     if (state->job) {
         AioContext *aio_context;
@@ -1937,7 +1931,7 @@ static void blockdev_backup_abort(BlkActionState *common)

 static void blockdev_backup_clean(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     if (!state->bs) {
@@ -2209,14 +2203,14 @@ static const BlkActionOps actions[] = {
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
2.27.0


