Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79DA20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpxtOX0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79DA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTa0-0000Q6-Su
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTW0-0003L5-Ia
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTVy-0002mK-QJ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46941)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTVy-0002lx-Kr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585232986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHrZktTybweA6husRB0wD5LLtIJ/egsn59oX4wviE8A=;
 b=RpxtOX0odDnmsnU2BVAw0vR3lXIcNaa3tdZZsvaBSt6GIRftlHYkVvKA95O/z2MZtWR+Xo
 Bqt0k3801lpxH1OU+U1fsfw4ID619TlYPTNRK8+6JdpqWGDKA5mH1yGtQflqKTSCMnMJX6
 8Gv3Ms4EAgwwjGlqEvZV2w5IVOfa5Ws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-GEz-c97IP_SxkpVvk1H23A-1; Thu, 26 Mar 2020 10:29:44 -0400
X-MC-Unique: GEz-c97IP_SxkpVvk1H23A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51621034AE3;
 Thu, 26 Mar 2020 14:29:42 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4219A60C18;
 Thu, 26 Mar 2020 14:29:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/10] block: pass BlockDriver reference to the .bdrv_co_create
Date: Thu, 26 Mar 2020 15:29:25 +0100
Message-Id: <20200326142933.625037-3-mreitz@redhat.com>
In-Reply-To: <20200326142933.625037-1-mreitz@redhat.com>
References: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

From: Maxim Levitsky <mlevitsk@redhat.com>

This will allow the reuse of a single generic .bdrv_co_create
implementation for several drivers.
No functional changes.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20200326011218.29230-2-mlevitsk@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h | 3 ++-
 block.c                   | 3 ++-
 block/crypto.c            | 3 ++-
 block/file-posix.c        | 4 +++-
 block/file-win32.c        | 4 +++-
 block/gluster.c           | 3 ++-
 block/nfs.c               | 4 +++-
 block/parallels.c         | 3 ++-
 block/qcow.c              | 3 ++-
 block/qcow2.c             | 4 +++-
 block/qed.c               | 3 ++-
 block/raw-format.c        | 4 +++-
 block/rbd.c               | 3 ++-
 block/sheepdog.c          | 4 +++-
 block/ssh.c               | 4 +++-
 block/vdi.c               | 4 +++-
 block/vhdx.c              | 3 ++-
 block/vmdk.c              | 4 +++-
 block/vpc.c               | 6 ++++--
 19 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ae9c4da4d0..57c8ea24b2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -135,7 +135,8 @@ struct BlockDriver {
     void (*bdrv_close)(BlockDriverState *bs);
     int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
                                        Error **errp);
-    int coroutine_fn (*bdrv_co_create_opts)(const char *filename,
+    int coroutine_fn (*bdrv_co_create_opts)(BlockDriver *drv,
+                                            const char *filename,
                                             QemuOpts *opts,
                                             Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
diff --git a/block.c b/block.c
index cccae5add9..ff23e20443 100644
--- a/block.c
+++ b/block.c
@@ -483,7 +483,8 @@ static void coroutine_fn bdrv_create_co_entry(void *opa=
que)
     CreateCo *cco =3D opaque;
     assert(cco->drv);
=20
-    ret =3D cco->drv->bdrv_co_create_opts(cco->filename, cco->opts, &local=
_err);
+    ret =3D cco->drv->bdrv_co_create_opts(cco->drv,
+                                        cco->filename, cco->opts, &local_e=
rr);
     error_propagate(&cco->err, local_err);
     cco->ret =3D ret;
 }
diff --git a/block/crypto.c b/block/crypto.c
index 4425ebeb47..d577f89659 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -601,7 +601,8 @@ fail:
     return ret;
 }
=20
-static int coroutine_fn block_crypto_co_create_opts_luks(const char *filen=
ame,
+static int coroutine_fn block_crypto_co_create_opts_luks(BlockDriver *drv,
+                                                         const char *filen=
ame,
                                                          QemuOpts *opts,
                                                          Error **errp)
 {
diff --git a/block/file-posix.c b/block/file-posix.c
index 9bc3838b2a..65bc980bc4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2405,7 +2405,9 @@ out:
     return result;
 }
=20
-static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts =
*opts,
+static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
                                            Error **errp)
 {
     BlockdevCreateOptions options;
diff --git a/block/file-win32.c b/block/file-win32.c
index 77e8ff7b68..15859839a1 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -588,7 +588,9 @@ static int raw_co_create(BlockdevCreateOptions *options=
, Error **errp)
     return 0;
 }
=20
-static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts =
*opts,
+static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
                                            Error **errp)
 {
     BlockdevCreateOptions options;
diff --git a/block/gluster.c b/block/gluster.c
index 4fa4a77a47..0aa1f2cda4 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1130,7 +1130,8 @@ out:
     return ret;
 }
=20
-static int coroutine_fn qemu_gluster_co_create_opts(const char *filename,
+static int coroutine_fn qemu_gluster_co_create_opts(BlockDriver *drv,
+                                                    const char *filename,
                                                     QemuOpts *opts,
                                                     Error **errp)
 {
diff --git a/block/nfs.c b/block/nfs.c
index 9a6311e270..cc2413d5ab 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -662,7 +662,9 @@ out:
     return ret;
 }
=20
-static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts =
*opts,
+static int coroutine_fn nfs_file_co_create_opts(BlockDriver *drv,
+                                                const char *url,
+                                                QemuOpts *opts,
                                                 Error **errp)
 {
     BlockdevCreateOptions *create_options;
diff --git a/block/parallels.c b/block/parallels.c
index 7a01997659..6d4ed77f16 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -609,7 +609,8 @@ exit:
     goto out;
 }
=20
-static int coroutine_fn parallels_co_create_opts(const char *filename,
+static int coroutine_fn parallels_co_create_opts(BlockDriver *drv,
+                                                 const char *filename,
                                                  QemuOpts *opts,
                                                  Error **errp)
 {
diff --git a/block/qcow.c b/block/qcow.c
index fce8989868..8973e4e565 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -934,7 +934,8 @@ exit:
     return ret;
 }
=20
-static int coroutine_fn qcow_co_create_opts(const char *filename,
+static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
+                                            const char *filename,
                                             QemuOpts *opts, Error **errp)
 {
     BlockdevCreateOptions *create_options =3D NULL;
diff --git a/block/qcow2.c b/block/qcow2.c
index d1da3d91db..5f65fce924 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3558,7 +3558,9 @@ out:
     return ret;
 }
=20
-static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpt=
s *opts,
+static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
+                                             const char *filename,
+                                             QemuOpts *opts,
                                              Error **errp)
 {
     BlockdevCreateOptions *create_options =3D NULL;
diff --git a/block/qed.c b/block/qed.c
index d8c4e5fb1e..1af9b3cb1d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -720,7 +720,8 @@ out:
     return ret;
 }
=20
-static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
+static int coroutine_fn bdrv_qed_co_create_opts(BlockDriver *drv,
+                                                const char *filename,
                                                 QemuOpts *opts,
                                                 Error **errp)
 {
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a76ec7dd2..93b25e1b6b 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -419,7 +419,9 @@ static int raw_has_zero_init_truncate(BlockDriverState =
*bs)
     return bdrv_has_zero_init_truncate(bs->file->bs);
 }
=20
-static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts =
*opts,
+static int coroutine_fn raw_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
                                            Error **errp)
 {
     return bdrv_create_file(filename, opts, errp);
diff --git a/block/rbd.c b/block/rbd.c
index 84115d34b4..e637639a07 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -437,7 +437,8 @@ static int qemu_rbd_co_create(BlockdevCreateOptions *op=
tions, Error **errp)
     return qemu_rbd_do_create(options, NULL, NULL, errp);
 }
=20
-static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
+static int coroutine_fn qemu_rbd_co_create_opts(BlockDriver *drv,
+                                                const char *filename,
                                                 QemuOpts *opts,
                                                 Error **errp)
 {
diff --git a/block/sheepdog.c b/block/sheepdog.c
index cfa84338a2..a8a7e32a41 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2157,7 +2157,9 @@ out:
     return ret;
 }
=20
-static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *=
opts,
+static int coroutine_fn sd_co_create_opts(BlockDriver *drv,
+                                          const char *filename,
+                                          QemuOpts *opts,
                                           Error **errp)
 {
     BlockdevCreateOptions *create_options =3D NULL;
diff --git a/block/ssh.c b/block/ssh.c
index b4375cf7d2..84e92821c0 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -963,7 +963,9 @@ fail:
     return ret;
 }
=20
-static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts =
*opts,
+static int coroutine_fn ssh_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
                                            Error **errp)
 {
     BlockdevCreateOptions *create_options;
diff --git a/block/vdi.c b/block/vdi.c
index 0142da7233..e1a11f2aa0 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -896,7 +896,9 @@ static int coroutine_fn vdi_co_create(BlockdevCreateOpt=
ions *create_options,
     return vdi_co_do_create(create_options, DEFAULT_CLUSTER_SIZE, errp);
 }
=20
-static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts =
*opts,
+static int coroutine_fn vdi_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
                                            Error **errp)
 {
     QDict *qdict =3D NULL;
diff --git a/block/vhdx.c b/block/vhdx.c
index f02d2611be..33e57cd656 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2046,7 +2046,8 @@ delete_and_exit:
     return ret;
 }
=20
-static int coroutine_fn vhdx_co_create_opts(const char *filename,
+static int coroutine_fn vhdx_co_create_opts(BlockDriver *drv,
+                                            const char *filename,
                                             QemuOpts *opts,
                                             Error **errp)
 {
diff --git a/block/vmdk.c b/block/vmdk.c
index 8466051bc9..218d9c9800 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2588,7 +2588,9 @@ exit:
     return blk;
 }
=20
-static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts=
 *opts,
+static int coroutine_fn vmdk_co_create_opts(BlockDriver *drv,
+                                            const char *filename,
+                                            QemuOpts *opts,
                                             Error **errp)
 {
     Error *local_err =3D NULL;
diff --git a/block/vpc.c b/block/vpc.c
index a65550298e..6df75e22dc 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1089,8 +1089,10 @@ out:
     return ret;
 }
=20
-static int coroutine_fn vpc_co_create_opts(const char *filename,
-                                           QemuOpts *opts, Error **errp)
+static int coroutine_fn vpc_co_create_opts(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
+                                           Error **errp)
 {
     BlockdevCreateOptions *create_options =3D NULL;
     QDict *qdict;
--=20
2.25.1


