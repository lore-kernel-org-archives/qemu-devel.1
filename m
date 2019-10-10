Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F2C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F3C20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F3C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXn2-0002WV-U2
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrh-0007Ku-HW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrg-0008Ro-6M
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWra-0008Os-9v; Thu, 10 Oct 2019 07:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 813A010CBC4B;
 Thu, 10 Oct 2019 11:44:08 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244455C28C;
 Thu, 10 Oct 2019 11:44:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 30/36] block/backup: move write_flags calculation inside
 backup_job_create
Date: Thu, 10 Oct 2019 13:42:54 +0200
Message-Id: <20191010114300.7746-31-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 11:44:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is logic-less refactoring, which simplifies further patch, as
we'll need write_flags for backup-top filter creation and backup-top
should be created before block job creation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191001131409.14202-3-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d918836f1d..b5b7939356 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -446,20 +446,6 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
         goto error;
     }
=20
-    /* job->len is fixed, so we can't allow resize */
-    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK=
_PERM_ALL,
-                           speed, creation_flags, cb, opaque, errp);
-    if (!job) {
-        goto error;
-    }
-
-    job->source_bs =3D bs;
-    job->on_source_error =3D on_source_error;
-    job->on_target_error =3D on_target_error;
-    job->sync_mode =3D sync_mode;
-    job->sync_bitmap =3D sync_bitmap;
-    job->bitmap_mode =3D bitmap_mode;
-
     /*
      * If source is in backing chain of target assume that target is goi=
ng to be
      * used for "image fleecing", i.e. it should represent a kind of sna=
pshot of
@@ -477,6 +463,20 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
     write_flags =3D (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALIS=
ING : 0) |
                   (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
=20
+    /* job->len is fixed, so we can't allow resize */
+    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK=
_PERM_ALL,
+                           speed, creation_flags, cb, opaque, errp);
+    if (!job) {
+        goto error;
+    }
+
+    job->source_bs =3D bs;
+    job->on_source_error =3D on_source_error;
+    job->on_target_error =3D on_target_error;
+    job->sync_mode =3D sync_mode;
+    job->sync_bitmap =3D sync_bitmap;
+    job->bitmap_mode =3D bitmap_mode;
+
     job->bcs =3D block_copy_state_new(bs, target, cluster_size, write_fl=
ags,
                                     backup_progress_bytes_callback,
                                     backup_progress_reset_callback, job,=
 errp);
@@ -485,11 +485,11 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
     }
=20
     job->cluster_size =3D cluster_size;
+    job->len =3D len;
=20
     /* Required permissions are already taken by block-copy-state target=
 */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
-    job->len =3D len;
=20
     return &job->common;
=20
--=20
2.21.0


