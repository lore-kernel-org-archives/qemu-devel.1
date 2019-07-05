Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC3C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886D1216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886D1216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV04-0003HX-Q5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUeZ-0006KV-2U
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUeY-0007Zy-3h
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUeV-0007Y4-Q9; Fri, 05 Jul 2019 16:17:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1ED18308FEC0;
 Fri,  5 Jul 2019 20:17:51 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27639867F8;
 Fri,  5 Jul 2019 20:17:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:31 -0400
Message-Id: <20190705201631.26266-19-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 05 Jul 2019 20:17:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 18/18] block/backup: loosen restriction on
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the "never" sync policy, we actually can utilize readonly bitmaps
now. Loosen the check at the QMP level, and tighten it based on
provided arguments down at the job creation level instead.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 6 ++++++
 blockdev.c     | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index b25e6179cf..a59962cea8 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -607,6 +607,12 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
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
index 5dfaa976c9..3e30bc2ca7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3489,7 +3489,7 @@ static BlockJob *do_backup_common(BackupCommon *bac=
kup,
                        "when providing a bitmap");
             return NULL;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             return NULL;
         }
     }
--=20
2.21.0


