Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C40DC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D2621537
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 01:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D2621537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdllQ-00006c-GC
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 21:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hdle6-0001zb-1w
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hdlUs-0004sk-8e
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 21:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hdlUq-0004r4-Rd; Wed, 19 Jun 2019 21:04:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 175B230C1CBF;
 Thu, 20 Jun 2019 01:04:12 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F19CB1001E67;
 Thu, 20 Jun 2019 01:04:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 21:03:51 -0400
Message-Id: <20190620010356.19164-8-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-1-jsnow@redhat.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 20 Jun 2019 01:04:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap sync
 policy
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
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds an "always" policy for bitmap synchronization. Regardless of if
the job succeeds or fails, the bitmap is *always* synchronized. This mean=
s
that for backups that fail part-way through, the bitmap retains a record =
of
which sectors need to be copied out to accomplish a new backup using the
old, partial result.

In effect, this allows us to "resume" a failed backup; however the new ba=
ckup
will be from the new point in time, so it isn't a "resume" as much as it =
is
an "incremental retry." This can be useful in the case of extremely large
backups that fail considerably through the operation and we'd like to not=
 waste
the work that was already performed.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json |  5 ++++-
 block/backup.c       | 10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0332dcaabc..58d267f1f5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1143,6 +1143,9 @@
 # An enumeration of possible behaviors for the synchronization of a bitm=
ap
 # when used for data copy operations.
 #
+# @always: The bitmap is always synchronized with remaining blocks to co=
py,
+#          whether or not the operation has completed successfully or no=
t.
+#
 # @conditional: The bitmap is only synchronized when the operation is su=
ccessul.
 #               This is useful for Incremental semantics.
 #
@@ -1153,7 +1156,7 @@
 # Since: 4.1
 ##
 { 'enum': 'BitmapSyncMode',
-  'data': ['conditional', 'never'] }
+  'data': ['always', 'conditional', 'never'] }
=20
 ##
 # @MirrorCopyMode:
diff --git a/block/backup.c b/block/backup.c
index 627f724b68..beb2078696 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -266,15 +266,17 @@ static void backup_cleanup_sync_bitmap(BackupBlockJ=
ob *job, int ret)
     BlockDriverState *bs =3D blk_bs(job->common.blk);
=20
     if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {
-        /* Failure, or we don't want to synchronize the bitmap.
-         * Merge the successor back into the parent, delete nothing. */
+        /* Failure, or we don't want to synchronize the bitmap. */
+        if (job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
+            bdrv_dirty_bitmap_claim(job->sync_bitmap, &job->copy_bitmap)=
;
+        }
+        /* Merge the successor back into the parent. */
         bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
-        assert(bm);
     } else {
         /* Everything is fine, delete this bitmap and install the backup=
. */
         bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
-        assert(bm);
     }
+    assert(bm);
 }
=20
 static void backup_commit(Job *job)
--=20
2.21.0


