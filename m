Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05058CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C127C20717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejmWN1eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C127C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4eq-0000cT-No
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xY-0003kf-Rf
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xX-0002NO-BW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xX-0002Lh-4i
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lP2YHcXJHDezvwbghFtZ159Ceu5JspkLq15PL35uTvM=;
 b=ejmWN1eI9hSxY9GomhLvtyvl/hnnfOysvmmLIjKSdjUK1SbLjIzDSbZY5+k4vWoT+Aaxm/
 kJJYBnz4bbf24cfMklDnlQiYJtAsjsUTExh7HL8FMIp4aaWvD0/EtsWm2/QZLfrV8cbDLV
 UjNF4z75VYsd8x9ZsTHCrPhYXaGSbeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-ou7QfFRhO4mMUFxGnrnZ4Q-1; Mon, 28 Oct 2019 08:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 027CF8017DD;
 Mon, 28 Oct 2019 12:17:12 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DDB95C1D6;
 Mon, 28 Oct 2019 12:17:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 61/69] block: Handle filter truncation like native impl.
Date: Mon, 28 Oct 2019 13:14:53 +0100
Message-Id: <20191028121501.15279-62-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ou7QfFRhO4mMUFxGnrnZ4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Make the filter truncation (passing it through to bs->file) a
first-class citizen and handle it exactly as if it was the filter
driver's native implementation of .bdrv_co_truncate().

I do not see a reason not to, it makes the code a bit shorter, and may
be even more correct because this gets us to finish the write_req that
we prepared before (may be important to e.g. bring dirty bitmaps to the
correct size).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190918095144.955-2-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index f0b86c1d19..8ff3b47fb4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3347,20 +3347,19 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child,=
 int64_t offset,
         goto out;
     }
=20
-    if (!drv->bdrv_co_truncate) {
-        if (bs->file && drv->is_filter) {
-            ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
-            goto out;
-        }
+    if (drv->bdrv_co_truncate) {
+        ret =3D drv->bdrv_co_truncate(bs, offset, prealloc, errp);
+    } else if (bs->file && drv->is_filter) {
+        ret =3D bdrv_co_truncate(bs->file, offset, prealloc, errp);
+    } else {
         error_setg(errp, "Image format driver does not support resize");
         ret =3D -ENOTSUP;
         goto out;
     }
-
-    ret =3D drv->bdrv_co_truncate(bs, offset, prealloc, errp);
     if (ret < 0) {
         goto out;
     }
+
     ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count=
");
--=20
2.21.0


