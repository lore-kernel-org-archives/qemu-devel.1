Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50088C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22205206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22205206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylYL-0000PL-Vp
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPf-0006NU-Py
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPd-0005rK-Gh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55612)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPZ-0005k5-J2; Fri, 16 Aug 2019 19:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D327830860C5;
 Fri, 16 Aug 2019 23:13:32 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2611B19C6A;
 Fri, 16 Aug 2019 23:13:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:54 -0400
Message-Id: <20190816231318.8650-13-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 16 Aug 2019 23:13:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/36] block/backup: add 'always' bitmap sync
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-13-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c       | 27 +++++++++++++++++++--------
 qapi/block-core.json |  5 ++++-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 474f8eeae29..2be570c0bfd 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -278,18 +278,29 @@ static void backup_cleanup_sync_bitmap(BackupBlockJ=
ob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
     BlockDriverState *bs =3D blk_bs(job->common.blk);
+    bool sync =3D (((ret =3D=3D 0) || (job->bitmap_mode =3D=3D BITMAP_SY=
NC_MODE_ALWAYS)) \
+                 && (job->bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER));
=20
-    if (ret < 0 || job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_NEVER) {
+    if (sync) {
         /*
-         * Failure, or we don't want to synchronize the bitmap.
-         * Merge the successor back into the parent, delete nothing.
+         * We succeeded, or we always intended to sync the bitmap.
+         * Delete this bitmap and install the child.
          */
-        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
-        assert(bm);
-    } else {
-        /* Everything is fine, delete this bitmap and install the backup=
. */
         bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
-        assert(bm);
+    } else {
+        /*
+         * We failed, or we never intended to sync the bitmap anyway.
+         * Merge the successor back into the parent, keeping all data.
+         */
+        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
+    }
+
+    assert(bm);
+
+    if (ret < 0 && job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
+        /* If we failed and synced, merge in the bits we didn't copy: */
+        bdrv_dirty_bitmap_merge_internal(bm, job->copy_bitmap,
+                                         NULL, true);
     }
 }
=20
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 06e34488a30..8344fbe2030 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1149,10 +1149,13 @@
 # @never: The bitmap is never synchronized with the operation, and is
 #         treated solely as a read-only manifest of blocks to copy.
 #
+# @always: The bitmap is always synchronized with the operation,
+#          regardless of whether or not the operation was successful.
+#
 # Since: 4.2
 ##
 { 'enum': 'BitmapSyncMode',
-  'data': ['on-success', 'never'] }
+  'data': ['on-success', 'never', 'always'] }
=20
 ##
 # @MirrorCopyMode:
--=20
2.21.0


