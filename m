Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD35C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34C521882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C521882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinPX-0001Nx-Vt
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hinGI-0007EL-4Q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hinGG-0005PY-3A
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hinG6-00051s-NL; Wed, 03 Jul 2019 17:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 620B485545;
 Wed,  3 Jul 2019 21:57:38 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-117.rdu2.redhat.com [10.10.123.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8008652737;
 Wed,  3 Jul 2019 21:57:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:55:42 -0400
Message-Id: <20190703215542.16123-19-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-1-jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 03 Jul 2019 21:57:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 18/18] block/backup: loosen restriction on
 readonly bitmaps
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the "never" sync policy, we actually can utilize readonly bitmaps
now. Loosen the check at the QMP level, and tighten it based on
provided arguments down at the job creation level instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 6 ++++++
 blockdev.c     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 495d8f71aa..4abe90d462 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -598,6 +598,12 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
             return NULL;
         }
=20
+        /* If we need to write to this bitmap, check that we can: */
+        if (bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER &&
+            bdrv_dirty_bitmap_check(sync_bitmap, BDRV_BITMAP_DEFAULT, er=
rp)) {
+            return NULL;
+        }
+
         /* Create a new bitmap, and freeze/disable this one. */
         if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) < =
0) {
             return NULL;
diff --git a/blockdev.c b/blockdev.c
index d5b089a446..020ce7e960 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3492,7 +3492,7 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
             error_setg(errp, "Bitmap '%s' could not be found", backup->b=
itmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             goto out;
         }
     }
--=20
2.21.0


