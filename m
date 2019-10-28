Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA2CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640CF20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkX1zh65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640CF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP54G-0008Uw-6S
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xj-00046O-1d
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xh-0002U1-QB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xh-0002Tf-MG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eR57hYOpETc1WOwroQ3gB2aclK6c6r/Yqpqzc1DOwpg=;
 b=HkX1zh65tOwQGn1vCnv0MfG56VjkHMH/Lq680O6cRHwjdSJn8BR7Nm1dXIZUqdB5EkRFzg
 w8/emNAc51JqpQ5zStswwpWoWBcyPlepc+aVULXc5N+6N7o0LXU2IOhFM3Udo0FZUH+153
 CHCQvddmsAJ4R9JZAsSsIsFYNS4LJAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-HzHk1RTYO8-eDWEsdo7OxA-1; Mon, 28 Oct 2019 08:17:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DA72107AD28;
 Mon, 28 Oct 2019 12:17:26 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 301BA1001B03;
 Mon, 28 Oct 2019 12:17:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 68/69] Revert "qemu-img: Check post-truncation size"
Date: Mon, 28 Oct 2019 13:15:00 +0100
Message-Id: <20191028121501.15279-69-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HzHk1RTYO8-eDWEsdo7OxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

This reverts commit 5279b30392da7a3248b320c75f20c61e3a95863c.

We no longer need this check because exact=3Dtrue forces the block driver
to give the image the exact size requested by the user.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190918095144.955-9-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 39 ++++-----------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b288c967b5..95a24b9762 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3656,7 +3656,7 @@ static int img_resize(int argc, char **argv)
     Error *err =3D NULL;
     int c, ret, relative;
     const char *filename, *fmt, *size;
-    int64_t n, total_size, current_size, new_size;
+    int64_t n, total_size, current_size;
     bool quiet =3D false;
     BlockBackend *blk =3D NULL;
     PreallocMode prealloc =3D PREALLOC_MODE_OFF;
@@ -3837,42 +3837,11 @@ static int img_resize(int argc, char **argv)
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
-        error_report("Image was not resized; resizing may not be supported=
 "
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


