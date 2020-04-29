Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D3C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD6E206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xby8GZYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD6E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTklW-0006LE-Nr
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTkil-00059e-1u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTkh2-0005rP-4K
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:17:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTkh1-0005r3-NH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZPsVCSXiV9p7JDzxiy0Y5sACwWktPtXil+AUGleyGs=;
 b=Xby8GZYGTqQUEl2PSSRGp9nmJvBLvEWXf/0AwsRU0yhLy7zAevH+u9BEquTm4ReBsZrst0
 YiMg8q51cNYX5jWXSl/RFtwTc7EPmKHGJgeR2rLjJoEci9SvlN0izkdPlCfv1lWgGGeiwo
 vv14rB2ysctAccNJUCa56bzTL8rh/ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-oiRou9xHMBOxIFfZGxUz8Q-1; Wed, 29 Apr 2020 07:15:53 -0400
X-MC-Unique: oiRou9xHMBOxIFfZGxUz8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F821800D4A;
 Wed, 29 Apr 2020 11:15:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0F9460BF4;
 Wed, 29 Apr 2020 11:15:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] backup: Make sure that source and target size match
Date: Wed, 29 Apr 2020 13:15:38 +0200
Message-Id: <20200429111539.42103-3-kwolf@redhat.com>
In-Reply-To: <20200429111539.42103-1-kwolf@redhat.com>
References: <20200429111539.42103-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the introduction of a backup filter node, the backup block job
crashes when the target image is smaller than the source image because
it will try to write after the end of the target node without having
BLK_PERM_RESIZE. (Previously, the BlockBackend layer would have caught
this and errored out gracefully.)

We can fix this and even do better than the old behaviour: Check that
source and target have the same image size at the start of the block job
and unshare BLK_PERM_RESIZE. This will immediately error out when
starting the job instead of only when writing to a block that doesn't
exist in the target.

Longer target than source would technically work because we would never
write to blocks that don't exist, but semantically these are invalid,
too, because a backup is supposed to create a copy, not just an image
that starts with a copy.

The bugs were introduced in commits 2c8074c45 (BLK_PERM_RESIZE is shared
since this commit) and 00e30f05d (BdrvChild instead of BlockBackend
turns I/O errors into assertion failures).

Fixes: 2c8074c453ff13a94bd08ec26061917670ec03be
Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1778593
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup-top.c | 12 ++++++++----
 block/backup.c     | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 3b50c06e2c..0e515a7705 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -148,8 +148,10 @@ static void backup_top_child_perm(BlockDriverState *bs=
, BdrvChild *c,
          *
          * Share write to target (child_file), to not interfere
          * with guest writes to its disk which may be in target backing ch=
ain.
+         * Can't resize during a backup block job because we check the siz=
e
+         * only upfront.
          */
-        *nshared =3D BLK_PERM_ALL;
+        *nshared =3D BLK_PERM_ALL & ~BLK_PERM_RESIZE;
         *nperm =3D BLK_PERM_WRITE;
     } else {
         /* Source child */
@@ -192,11 +194,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverS=
tate *source,
 {
     Error *local_err =3D NULL;
     BDRVBackupTopState *state;
-    BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_filter=
,
-                                                 filter_node_name,
-                                                 BDRV_O_RDWR, errp);
+    BlockDriverState *top;
     bool appended =3D false;
=20
+    assert(source->total_sectors =3D=3D target->total_sectors);
+
+    top =3D bdrv_new_open_driver(&bdrv_backup_top_filter, filter_node_name=
,
+                              BDRV_O_RDWR, errp);
     if (!top) {
         return NULL;
     }
diff --git a/block/backup.c b/block/backup.c
index c4c3b8cd46..4f13bb20a5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -340,7 +340,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDr=
iverState *bs,
                   BlockCompletionFunc *cb, void *opaque,
                   JobTxn *txn, Error **errp)
 {
-    int64_t len;
+    int64_t len, target_len;
     BackupBlockJob *job =3D NULL;
     int64_t cluster_size;
     BdrvRequestFlags write_flags;
@@ -405,6 +405,18 @@ BlockJob *backup_job_create(const char *job_id, BlockD=
riverState *bs,
         goto error;
     }
=20
+    target_len =3D bdrv_getlength(target);
+    if (target_len < 0) {
+        error_setg_errno(errp, -target_len, "Unable to get length for '%s'=
",
+                         bdrv_get_device_or_node_name(bs));
+        goto error;
+    }
+
+    if (target_len !=3D len) {
+        error_setg(errp, "Source and target image have different sizes");
+        goto error;
+    }
+
     cluster_size =3D backup_calculate_cluster_size(target, errp);
     if (cluster_size < 0) {
         goto error;
--=20
2.25.3


