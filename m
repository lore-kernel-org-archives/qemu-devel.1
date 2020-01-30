Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B75C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E64C2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f24IyTGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E64C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHVE-0007WM-7g
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHQM-0008Dh-LY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHQL-0006PE-Ii
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHQL-0006OO-8X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNNMFMIsemXPxOGDw+fbRy3Gh45uwUm4FAGTPCMX4rE=;
 b=f24IyTGGfCveYu3iNbEFYCAMC9B7VxemoRvKipJjTWhmp6DBg1WgeSKMu13ucNB5Zwi0mb
 cRsMfbiJfe2vpHzcc9eqUlIxo1HQWh41FAcuF6UQg4AduLgjRk3bztBhEqewyGHkHSYsuc
 rZhZFPQVHtg+yTzQFb+2m7D/Dlq5f2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-kCrCiznQMNi-RSQ07_9zrA-1; Thu, 30 Jan 2020 16:32:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D27800D48;
 Thu, 30 Jan 2020 21:32:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C366C10018FF;
 Thu, 30 Jan 2020 21:32:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] blockdev: adds bdrv_parse_aio to use io_uring
Date: Thu, 30 Jan 2020 21:31:06 +0000
Message-Id: <20200130213114.325157-11-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kCrCiznQMNi-RSQ07_9zrA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200120141858.587874-8-stefanha@redhat.com
Message-Id: <20200120141858.587874-8-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c               | 22 ++++++++++++++++++++++
 blockdev.c            | 12 ++++--------
 include/block/block.h |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index ecd09dbbfd..6c2b2bd2e2 100644
--- a/block.c
+++ b/block.c
@@ -845,6 +845,28 @@ static BlockdevDetectZeroesOptions bdrv_parse_detect_z=
eroes(QemuOpts *opts,
     return detect_zeroes;
 }
=20
+/**
+ * Set open flags for aio engine
+ *
+ * Return 0 on success, -1 if the engine specified is invalid
+ */
+int bdrv_parse_aio(const char *mode, int *flags)
+{
+    if (!strcmp(mode, "threads")) {
+        /* do nothing, default */
+    } else if (!strcmp(mode, "native")) {
+        *flags |=3D BDRV_O_NATIVE_AIO;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (!strcmp(mode, "io_uring")) {
+        *flags |=3D BDRV_O_IO_URING;
+#endif
+    } else {
+        return -1;
+    }
+
+    return 0;
+}
+
 /**
  * Set open flags for a given discard mode
  *
diff --git a/blockdev.c b/blockdev.c
index 4cd9a58d36..c6a727cca9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -385,13 +385,9 @@ static void extract_common_blockdev_options(QemuOpts *=
opts, int *bdrv_flags,
         }
=20
         if ((aio =3D qemu_opt_get(opts, "aio")) !=3D NULL) {
-            if (!strcmp(aio, "native")) {
-                *bdrv_flags |=3D BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(aio, "threads")) {
-                /* this is the default */
-            } else {
-               error_setg(errp, "invalid aio option");
-               return;
+            if (bdrv_parse_aio(aio, bdrv_flags) < 0) {
+                error_setg(errp, "invalid aio option");
+                return;
             }
         }
     }
@@ -4672,7 +4668,7 @@ QemuOptsList qemu_common_drive_opts =3D {
         },{
             .name =3D "aio",
             .type =3D QEMU_OPT_STRING,
-            .help =3D "host AIO implementation (threads, native)",
+            .help =3D "host AIO implementation (threads, native, io_uring)=
",
         },{
             .name =3D BDRV_OPT_CACHE_WB,
             .type =3D QEMU_OPT_BOOL,
diff --git a/include/block/block.h b/include/block/block.h
index 19184d5850..6cd566324d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -289,6 +289,7 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverS=
tate *bs_top,
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                        Error **errp);
=20
+int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough=
);
 int bdrv_parse_discard_flags(const char *mode, int *flags);
 BdrvChild *bdrv_open_child(const char *filename,
--=20
2.24.1


