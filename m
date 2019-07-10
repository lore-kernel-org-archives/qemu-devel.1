Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C02C73C63
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32CA20645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32CA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl164-000285-P2
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13q-0000RF-GJ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13n-0004US-EK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13f-0004I3-5n; Tue, 09 Jul 2019 21:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FC9A3092664;
 Wed, 10 Jul 2019 01:06:05 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7401B1001B19;
 Wed, 10 Jul 2019 01:06:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:52 -0400
Message-Id: <20190710010556.32365-5-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 10 Jul 2019 01:06:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/8] block/backup: hoist bitmap check into QMP
 interface
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is nicer to do in the unified QMP interface that we have now,
because it lets us use the right terminology back at the user.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 13 ++++---------
 blockdev.c     | 10 ++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index e2729cf6fa..a64b768e24 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -566,6 +566,10 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
     assert(bs);
     assert(target);
=20
+    /* QMP interface protects us from these cases */
+    assert(sync_mode !=3D MIRROR_SYNC_MODE_INCREMENTAL);
+    assert(sync_bitmap || sync_mode !=3D MIRROR_SYNC_MODE_BITMAP);
+
     if (bs =3D=3D target) {
         error_setg(errp, "Source and target cannot be the same");
         return NULL;
@@ -597,16 +601,7 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
         return NULL;
     }
=20
-    /* QMP interface should have handled translating this to bitmap mode=
 */
-    assert(sync_mode !=3D MIRROR_SYNC_MODE_INCREMENTAL);
-
     if (sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
-        if (!sync_bitmap) {
-            error_setg(errp, "must provide a valid bitmap name for "
-                       "'%s' sync mode", MirrorSyncMode_str(sync_mode));
-            return NULL;
-        }
-
         /* If we need to write to this bitmap, check that we can: */
         if (bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER &&
             bdrv_dirty_bitmap_check(sync_bitmap, BDRV_BITMAP_DEFAULT, er=
rp)) {
diff --git a/blockdev.c b/blockdev.c
index 3e30bc2ca7..f0b7da53b0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3464,6 +3464,16 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
         return NULL;
     }
=20
+    if ((backup->sync =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
+        (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL)) {
+        /* done before desugaring 'incremental' to print the right messa=
ge */
+        if (!backup->has_bitmap) {
+            error_setg(errp, "must provide a valid bitmap name for "
+                       "'%s' sync mode", MirrorSyncMode_str(backup->sync=
));
+            return NULL;
+        }
+    }
+
     if (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
         if (backup->has_bitmap_mode &&
             backup->bitmap_mode !=3D BITMAP_SYNC_MODE_ON_SUCCESS) {
--=20
2.21.0


