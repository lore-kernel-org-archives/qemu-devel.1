Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A708C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E46207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViVITzly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E46207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXMJ-00007v-4q
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLI-0006ob-Fa
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLE-0001kZ-5F
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599070719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Q3ca8HZdKj+DVmGEeEMKX9GacgwbRdPF+aDj04+WXY=;
 b=ViVITzlyqdLJ8FBXS3S7CqSUl2D+ccvpNorH6lYfXpvOWc7J6f91URd/bJ0OXXw1Hdo9Y5
 W4Qype1WoTp7rGDdZYC9ulfbRU727NCEpHYRjBajQ4GqL/aanZv9drUz7mv/SRPkMO6zRH
 EpjJQNVCXVe04DEW6kAnLr+ms792blw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Bsj8g6HrP6-WQrThPFV3NQ-1; Wed, 02 Sep 2020 14:18:37 -0400
X-MC-Unique: Bsj8g6HrP6-WQrThPFV3NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10EC7800400;
 Wed,  2 Sep 2020 18:18:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63C7410013BD;
 Wed,  2 Sep 2020 18:18:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] blockdev: combine DriveBackupState and
 BlockdevBackupState
Date: Wed,  2 Sep 2020 13:18:28 -0500
Message-Id: <20200902181831.2570048-3-eblake@redhat.com>
In-Reply-To: <20200902181831.2570048-1-eblake@redhat.com>
References: <20200902181831.2570048-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com,
 John Snow <jsnow@redhat.com>
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
index 3848a9c8ab86..f177048a4fe8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1668,11 +1668,11 @@ static void external_snapshot_clean(BlkActionState *common)
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
@@ -1682,7 +1682,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,

 static void drive_backup_prepare(BlkActionState *common, Error **errp)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     DriveBackup *backup;
     BlockDriverState *bs;
     BlockDriverState *target_bs;
@@ -1819,7 +1819,7 @@ out:

 static void drive_backup_commit(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     aio_context = bdrv_get_aio_context(state->bs);
@@ -1833,7 +1833,7 @@ static void drive_backup_commit(BlkActionState *common)

 static void drive_backup_abort(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);

     if (state->job) {
         AioContext *aio_context;
@@ -1849,7 +1849,7 @@ static void drive_backup_abort(BlkActionState *common)

 static void drive_backup_clean(BlkActionState *common)
 {
-    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     if (!state->bs) {
@@ -1864,15 +1864,9 @@ static void drive_backup_clean(BlkActionState *common)
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
@@ -1920,7 +1914,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)

 static void blockdev_backup_commit(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     aio_context = bdrv_get_aio_context(state->bs);
@@ -1934,7 +1928,7 @@ static void blockdev_backup_commit(BlkActionState *common)

 static void blockdev_backup_abort(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);

     if (state->job) {
         AioContext *aio_context;
@@ -1950,7 +1944,7 @@ static void blockdev_backup_abort(BlkActionState *common)

 static void blockdev_backup_clean(BlkActionState *common)
 {
-    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
+    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
     AioContext *aio_context;

     if (!state->bs) {
@@ -2222,14 +2216,14 @@ static const BlkActionOps actions[] = {
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
2.28.0


