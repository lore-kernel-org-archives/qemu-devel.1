Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60D2C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EE8214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE8214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWvD-0002Az-6R
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAWdU-0001YP-27
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAWdS-00065Y-Qf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAWdQ-00064O-Ea; Wed, 18 Sep 2019 05:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3FA918C4266;
 Wed, 18 Sep 2019 09:52:27 +0000 (UTC)
Received: from localhost (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E01960603;
 Wed, 18 Sep 2019 09:52:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 11:51:44 +0200
Message-Id: <20190918095144.955-9-mreitz@redhat.com>
In-Reply-To: <20190918095144.955-1-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 18 Sep 2019 09:52:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 8/8] Revert "qemu-img: Check post-truncation
 size"
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

This reverts commit 5279b30392da7a3248b320c75f20c61e3a95863c.

We no longer need this check because exact=3Dtrue forces the block driver
to give the image the exact size requested by the user.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a3169b6113..148f6b8b0e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3648,7 +3648,7 @@ static int img_resize(int argc, char **argv)
     Error *err =3D NULL;
     int c, ret, relative;
     const char *filename, *fmt, *size;
-    int64_t n, total_size, current_size, new_size;
+    int64_t n, total_size, current_size;
     bool quiet =3D false;
     BlockBackend *blk =3D NULL;
     PreallocMode prealloc =3D PREALLOC_MODE_OFF;
@@ -3829,42 +3829,11 @@ static int img_resize(int argc, char **argv)
      * success when the image has not actually been resized.
      */
     ret =3D blk_truncate(blk, total_size, true, prealloc, &err);
-    if (ret < 0) {
+    if (!ret) {
+        qprintf(quiet, "Image resized.\n");
+    } else {
         error_report_err(err);
-        goto out;
-    }
-
-    new_size =3D blk_getlength(blk);
-    if (new_size < 0) {
-        error_report("Failed to verify truncated image length: %s",
-                     strerror(-new_size));
-        ret =3D -1;
-        goto out;
     }
-
-    /* Some block drivers implement a truncation method, but only so
-     * the user can cause qemu to refresh the image's size from disk.
-     * The idea is that the user resizes the image outside of qemu and
-     * then invokes block_resize to inform qemu about it.
-     * (This includes iscsi and file-posix for device files.)
-     * Of course, that is not the behavior someone invoking
-     * qemu-img resize would find useful, so we catch that behavior
-     * here and tell the user. */
-    if (new_size !=3D total_size && new_size =3D=3D current_size) {
-        error_report("Image was not resized; resizing may not be support=
ed "
-                     "for this image");
-        ret =3D -1;
-        goto out;
-    }
-
-    if (new_size !=3D total_size) {
-        warn_report("Image should have been resized to %" PRIi64
-                    " bytes, but was resized to %" PRIi64 " bytes",
-                    total_size, new_size);
-    }
-
-    qprintf(quiet, "Image resized.\n");
-
 out:
     blk_unref(blk);
     if (ret) {
--=20
2.21.0


