Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D8C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20FF20665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20FF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnAvx-00059D-OM
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 20:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44646)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnAuT-00077B-M5
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnAuR-0007YN-VO
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnAuP-0007VP-Ma; Mon, 15 Jul 2019 20:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DCD2E3098576;
 Tue, 16 Jul 2019 00:01:28 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-130.bos.redhat.com [10.18.17.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 048AC6085B;
 Tue, 16 Jul 2019 00:01:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 20:01:13 -0400
Message-Id: <20190716000117.25219-8-jsnow@redhat.com>
In-Reply-To: <20190716000117.25219-1-jsnow@redhat.com>
References: <20190716000117.25219-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 00:01:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 07/11] block/backup: centralize copy_bitmap
 initialization
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
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just a few housekeeping changes that keeps the following commit easier
to read; perform the initial copy_bitmap initialization in one place.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 22fafbb80f..c88a70fe10 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -441,16 +441,22 @@ static int coroutine_fn backup_loop(BackupBlockJob =
*job)
     return ret;
 }
=20
-/* init copy_bitmap from sync_bitmap */
-static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
+static void backup_init_copy_bitmap(BackupBlockJob *job)
 {
-    bool ret =3D bdrv_dirty_bitmap_merge_internal(job->copy_bitmap,
-                                                job->sync_bitmap,
-                                                NULL, true);
-    assert(ret);
+    bool ret;
+    uint64_t estimate;
=20
-    job_progress_set_remaining(&job->common.job,
-                               bdrv_get_dirty_count(job->copy_bitmap));
+    if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
+        ret =3D bdrv_dirty_bitmap_merge_internal(job->copy_bitmap,
+                                               job->sync_bitmap,
+                                               NULL, true);
+        assert(ret);
+    } else {
+        bdrv_set_dirty_bitmap(job->copy_bitmap, 0, job->len);
+    }
+
+    estimate =3D bdrv_get_dirty_count(job->copy_bitmap);
+    job_progress_set_remaining(&job->common.job, estimate);
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
@@ -462,12 +468,7 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
=20
-    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
-        backup_incremental_init_copy_bitmap(s);
-    } else {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, 0, s->len);
-        job_progress_set_remaining(job, s->len);
-    }
+    backup_init_copy_bitmap(s);
=20
     s->before_write.notify =3D backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
--=20
2.21.0


