Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A12214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A12214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWoD-0002xQ-84
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAWdM-0001PQ-KI
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAWdL-0005tH-7m
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAWdI-0005nU-El; Wed, 18 Sep 2019 05:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4C82A3D394;
 Wed, 18 Sep 2019 09:52:19 +0000 (UTC)
Received: from localhost (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 430835C219;
 Wed, 18 Sep 2019 09:52:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 11:51:43 +0200
Message-Id: <20190918095144.955-8-mreitz@redhat.com>
In-Reply-To: <20190918095144.955-1-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 18 Sep 2019 09:52:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 7/8] block: Pass truncate exact=true where
 reasonable
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
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a change in behavior, so all instances need a good
justification.  The comments added here should explain my reasoning.

qed already had a comment that suggests it always expected
bdrv_truncate()/blk_truncate() to behave as if exact=3Dtrue were passed
(c743849bee7 came eight months before 55b949c8476), so it was simply
broken until now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/parallels.c | 11 +++++++++--
 block/qcow2.c     |  6 +++++-
 block/qed.c       |  2 +-
 qemu-img.c        |  7 ++++++-
 qemu-io-cmds.c    |  7 ++++++-
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a1a92c97a4..603211f83c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -487,7 +487,12 @@ static int coroutine_fn parallels_co_check(BlockDriv=
erState *bs,
         res->leaks +=3D count;
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err =3D NULL;
-            ret =3D bdrv_truncate(bs->file, res->image_end_offset, false=
,
+
+            /*
+             * In order to really repair the image, we must shrink it.
+             * That means we have to pass exact=3Dtrue.
+             */
+            ret =3D bdrv_truncate(bs->file, res->image_end_offset, true,
                                 PREALLOC_MODE_OFF, &local_err);
             if (ret < 0) {
                 error_report_err(local_err);
@@ -880,7 +885,9 @@ static void parallels_close(BlockDriverState *bs)
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INAC=
TIVE)) {
         s->header->inuse =3D 0;
         parallels_update_header(bs);
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, false,
+
+        /* errors are ignored, so we might as well pass exact=3Dtrue */
+        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
                       PREALLOC_MODE_OFF, NULL);
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 4ef19dd29a..eba165de7f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5057,7 +5057,11 @@ static int qcow2_amend_options(BlockDriverState *b=
s, QemuOpts *opts,
             return ret;
         }
=20
-        ret =3D blk_truncate(blk, new_size, false, PREALLOC_MODE_OFF, er=
rp);
+        /*
+         * Amending image options should ensure that the image has
+         * exactly the given new values, so pass exact=3Dtrue here.
+         */
+        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, err=
p);
         blk_unref(blk);
         if (ret < 0) {
             return ret;
diff --git a/block/qed.c b/block/qed.c
index 7c2a65af40..8005cfc305 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -674,7 +674,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
     l1_size =3D header.cluster_size * header.table_size;
=20
     /* File must start empty and grow, check truncate is supported */
-    ret =3D blk_truncate(blk, 0, false, PREALLOC_MODE_OFF, errp);
+    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/qemu-img.c b/qemu-img.c
index f8694f4f72..a3169b6113 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3823,7 +3823,12 @@ static int img_resize(int argc, char **argv)
         }
     }
=20
-    ret =3D blk_truncate(blk, total_size, false, prealloc, &err);
+    /*
+     * The user expects the image to have the desired size after
+     * resizing, so pass @exact=3Dtrue.  It is of no use to report
+     * success when the image has not actually been resized.
+     */
+    ret =3D blk_truncate(blk, total_size, true, prealloc, &err);
     if (ret < 0) {
         error_report_err(err);
         goto out;
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 5e9017c979..1b7e700020 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1710,7 +1710,12 @@ static int truncate_f(BlockBackend *blk, int argc,=
 char **argv)
         return offset;
     }
=20
-    ret =3D blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, &local_e=
rr);
+    /*
+     * qemu-io is a debugging tool, so let us be strict here and pass
+     * exact=3Dtrue.  It is better to err on the "emit more errors" side
+     * than to be overly permissive.
+     */
+    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, &local_er=
r);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
--=20
2.21.0


