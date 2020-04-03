Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FCB2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlDTUvzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FCB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQdm-0001cw-Ey
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQbS-00082Y-If
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQbR-0007Wl-Fg
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQbR-0007Vp-Br
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ow8fHVhdF5XdDD9HXHcAMKy9dd3Xe7mid7JBL1s9T2Y=;
 b=MlDTUvzQZqB7jtpxWnSc+urHZaGqUOFaDcDst0UlhUPCvCQ6uItXpRmIJLOW9vwsTduSSm
 FBZeA4GCEyg7aCtuiuMC4ynpLhjFbq21WTp10Aa58p5fBZqy5XBA2y/iygKW/Wh3KItxwK
 P0rkv/IGlroZpdi1JooPua4kmQEuadE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-u0b58hJkPs2nQclaNpvbgw-1; Fri, 03 Apr 2020 13:59:33 -0400
X-MC-Unique: u0b58hJkPs2nQclaNpvbgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CD2107ACC4;
 Fri,  3 Apr 2020 17:59:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9463B5C1BE;
 Fri,  3 Apr 2020 17:59:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/7] sheepdog: Add trivial backing_fmt support
Date: Fri,  3 Apr 2020 12:58:53 -0500
Message-Id: <20200403175859.863248-2-eblake@redhat.com>
In-Reply-To: <20200403175859.863248-1-eblake@redhat.com>
References: <20200403175859.863248-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sheepdog already requires that if backing_file is present, that it be
another sheepdog image (see sd_co_create).  Meanwhile, we want to move
towards always being explicit about the backing format for other
drivers where it matters.  So for convenience, make qemu-img create -F
sheepdog work, while rejecting all other explicit formats (note that
this is only for QemuOpts usage; there is no change to the QAPI to
allow a format through -blockdev).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/sheepdog.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 59f7ebb1710f..8f558367d2d5 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2163,13 +2163,21 @@ static int coroutine_fn sd_co_create_opts(BlockDriv=
er *drv,
                                           Error **errp)
 {
     BlockdevCreateOptions *create_options =3D NULL;
-    QDict *qdict, *location_qdict;
+    QDict *qdict =3D NULL, *location_qdict;
     Visitor *v;
-    char *redundancy;
+    char *redundancy =3D NULL;
     Error *local_err =3D NULL;
     int ret;
+    char *backing_fmt =3D NULL;

     redundancy =3D qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);
+    backing_fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+
+    if (backing_fmt && strcmp(backing_fmt, "sheepdog") !=3D 0) {
+        error_setg(errp, "backing_file must be a sheepdog image");
+        ret =3D -EINVAL;
+        goto fail;
+    }

     qdict =3D qemu_opts_to_qdict(opts, NULL);
     qdict_put_str(qdict, "driver", "sheepdog");
@@ -2234,6 +2242,7 @@ fail:
     qapi_free_BlockdevCreateOptions(create_options);
     qobject_unref(qdict);
     g_free(redundancy);
+    g_free(backing_fmt);
     return ret;
 }

@@ -3191,6 +3200,11 @@ static QemuOptsList sd_create_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "File name of a base image"
         },
+        {
+            .name =3D BLOCK_OPT_BACKING_FMT,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Must be 'sheepdog' if present",
+        },
         {
             .name =3D BLOCK_OPT_PREALLOC,
             .type =3D QEMU_OPT_STRING,
--=20
2.26.0.rc2


