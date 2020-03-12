Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC833C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED13206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEN7+s1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED13206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTal-00059N-Ss
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCTVe-0004X8-Bd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCTVd-00079G-3q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22271
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCTVc-00078n-Vq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmtK5I7dZ+qRFL1n9MbERx53nrOlbYxLc9ckSTE2AwY=;
 b=jEN7+s1YLluMb5wCLoeuIMiH5mM5spY0BYKynd6sZ9MAClhhRGGI1p/GnymLyG0RuLTaGw
 JHVNwoNqPU1SpM7lBHWtUCpvMxxm4e+KXiKD/FeRkZeqUEa+Jm5EIzOV1S1GeL4KTfnPya
 UwQ0Han0jw4bH9+lBth0QjFNHciVukA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-NmWOcutFP4O0zxVGvDphuw-1; Thu, 12 Mar 2020 15:28:34 -0400
X-MC-Unique: NmWOcutFP4O0zxVGvDphuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E336100550E;
 Thu, 12 Mar 2020 19:28:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D52D65DA76;
 Thu, 12 Mar 2020 19:28:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/7] sheepdog: Add trivial backing_fmt support
Date: Thu, 12 Mar 2020 14:28:16 -0500
Message-Id: <20200312192822.3739399-2-eblake@redhat.com>
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
References: <20200312192822.3739399-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 block/sheepdog.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index cfa84338a2d6..376f4ef74638 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2166,8 +2166,16 @@ static int coroutine_fn sd_co_create_opts(const char=
 *filename, QemuOpts *opts,
     char *redundancy;
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
@@ -2232,6 +2240,7 @@ fail:
     qapi_free_BlockdevCreateOptions(create_options);
     qobject_unref(qdict);
     g_free(redundancy);
+    g_free(backing_fmt);
     return ret;
 }

@@ -3189,6 +3198,11 @@ static QemuOptsList sd_create_opts =3D {
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
2.25.1


