Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA2CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C24720663
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4ClCV9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C24720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP541-0008FA-BQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xh-00043L-Kh
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xf-0002SU-Rn
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26204
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xf-0002SD-Na
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cw8wuCRkorBrlkC2Rr+V+y+jyP67yBOBt4kLF1Ox6ek=;
 b=h4ClCV9h5SjcBAanaSX9N3RDVH/3oudNf85D66fNXqXeATvAxsj0lK3wk5X0J365gMozJM
 S+fSUp5jD7TfJYe+yg8KL9FpU+r4AVZcCrIapLyJGvNWCVMpmFhtoVO2KhXHRlkyQP+rc0
 kOUGIkyZYHnngQH3ZrYbKrgqrcqttLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-IRCMxcqTNtKQBuUY2_LjcQ-1; Mon, 28 Oct 2019 08:17:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82FC7800FF1;
 Mon, 28 Oct 2019 12:17:24 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A4BE5DA2C;
 Mon, 28 Oct 2019 12:17:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 67/69] block: Pass truncate exact=true where reasonable
Date: Mon, 28 Oct 2019 13:14:59 +0100
Message-Id: <20191028121501.15279-68-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: IRCMxcqTNtKQBuUY2_LjcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

This is a change in behavior, so all instances need a good
justification.  The comments added here should explain my reasoning.

qed already had a comment that suggests it always expected
bdrv_truncate()/blk_truncate() to behave as if exact=3Dtrue were passed
(c743849bee7 came eight months before 55b949c8476), so it was simply
broken until now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190918095144.955-8-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
[mreitz: Changed comment in qed.c to explain why a new QED file must be
         empty, as requested and suggested by Maxim]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/parallels.c | 11 +++++++++--
 block/qcow2.c     |  6 +++++-
 block/qed.c       |  7 +++++--
 qemu-img.c        |  7 ++++++-
 qemu-io-cmds.c    |  7 ++++++-
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a1a92c97a4..603211f83c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -487,7 +487,12 @@ static int coroutine_fn parallels_co_check(BlockDriver=
State *bs,
         res->leaks +=3D count;
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err =3D NULL;
-            ret =3D bdrv_truncate(bs->file, res->image_end_offset, false,
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
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTI=
VE)) {
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
index 9f32dae41f..7c18721741 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5323,7 +5323,11 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
             return ret;
         }
=20
-        ret =3D blk_truncate(blk, new_size, false, PREALLOC_MODE_OFF, errp=
);
+        /*
+         * Amending image options should ensure that the image has
+         * exactly the given new values, so pass exact=3Dtrue here.
+         */
+        ret =3D blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, errp)=
;
         blk_unref(blk);
         if (ret < 0) {
             return ret;
diff --git a/block/qed.c b/block/qed.c
index 7c2a65af40..d8c4e5fb1e 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -673,8 +673,11 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCre=
ateOptions *opts,
=20
     l1_size =3D header.cluster_size * header.table_size;
=20
-    /* File must start empty and grow, check truncate is supported */
-    ret =3D blk_truncate(blk, 0, false, PREALLOC_MODE_OFF, errp);
+    /*
+     * The QED format associates file length with allocation status,
+     * so a new file (which is empty) must have a length of 0.
+     */
+    ret =3D blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, errp);
     if (ret < 0) {
         goto out;
     }
diff --git a/qemu-img.c b/qemu-img.c
index c738297b04..b288c967b5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3831,7 +3831,12 @@ static int img_resize(int argc, char **argv)
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
@@ -1710,7 +1710,12 @@ static int truncate_f(BlockBackend *blk, int argc, c=
har **argv)
         return offset;
     }
=20
-    ret =3D blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, &local_err=
);
+    /*
+     * qemu-io is a debugging tool, so let us be strict here and pass
+     * exact=3Dtrue.  It is better to err on the "emit more errors" side
+     * than to be overly permissive.
+     */
+    ret =3D blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, &local_err)=
;
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
--=20
2.21.0


