Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1685FC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D092074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQix6OYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D092074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkBf-0001UJ-Th
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRkA0-0007br-DW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRk9v-0006sj-OM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRk9u-0006lU-Ci
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587680241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wECKI9TX9peXLf8DLeDr58MjRiSx0mHFD+bV5rYUJ8A=;
 b=ZQix6OYA1XoNMw5xII7Xw6yCRk5i2o1eRjnFmOSVVFKmN/dv93y0Cj6faL35vQEt9ftOBY
 FkqOOKBcTITDZ6a87WW+SuaBUAR3f/ZL0xuwq0aPVAYr+5mM3GL6naUFMErG/sl9a6Axhe
 F6LEymNsdcNDnrof9VYv4cTOWFUIo2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-QIDC8n1UMqGeUIhqoLgpFA-1; Thu, 23 Apr 2020 18:17:17 -0400
X-MC-Unique: QIDC8n1UMqGeUIhqoLgpFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5EA41895910;
 Thu, 23 Apr 2020 22:17:15 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB86C1C94D;
 Thu, 23 Apr 2020 22:17:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] block: Add blk_new_with_bs() helper
Date: Thu, 23 Apr 2020 17:17:05 -0500
Message-Id: <20200423221707.477404-2-eblake@redhat.com>
In-Reply-To: <20200423221707.477404-1-eblake@redhat.com>
References: <20200423221707.477404-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several callers that need to create a new block backend from
an existing BDS; make the task slightly easier with a common helper
routine.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 23 +++++++++++++++++++++++
 block/crypto.c                 |  8 +++-----
 block/parallels.c              |  7 +++----
 block/qcow.c                   |  7 +++----
 block/qcow2.c                  | 15 ++++++---------
 block/qed.c                    |  7 +++----
 block/sheepdog.c               |  9 ++++-----
 block/vdi.c                    |  7 +++----
 block/vhdx.c                   |  7 +++----
 block/vmdk.c                   |  9 ++++-----
 block/vpc.c                    |  7 +++----
 blockdev.c                     |  8 +++-----
 blockjob.c                     |  7 ++-----
 14 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 9bbdbd63d743..d37c1244dd9c 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -77,6 +77,8 @@ typedef struct BlockBackendPublic {
 } BlockBackendPublic;

 BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm=
);
+BlockBackend *blk_new_with_bs(BlockDriverState *bs, uint64_t perm,
+                              uint64_t shared_perm, Error **errp);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
 int blk_get_refcnt(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 38ae41382652..1e082ce2a0f4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -355,6 +355,29 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, =
uint64_t shared_perm)
     return blk;
 }

+/*
+ * Create a new BlockBackend connected to an existing BlockDriverState.
+ *
+ * @perm is a bitmasks of BLK_PERM_* constants which describes the permiss=
ions
+ * to request for a block driver node that is attached to this BlockBacken=
d.
+ * @shared_perm is a bitmask which describes which permissions may be gran=
ted
+ * to other users of the attached node.
+ * Both sets of permissions can be changed later using blk_set_perm().
+ *
+ * Return the new BlockBackend on success, null on failure.
+ */
+BlockBackend *blk_new_with_bs(BlockDriverState *bs, uint64_t perm,
+                              uint64_t shared_perm, Error **errp)
+{
+    BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs), perm, shared_p=
erm);
+
+    if (blk_insert_bs(blk, bs, errp) < 0) {
+        blk_unref(blk);
+        return NULL;
+    }
+    return blk;
+}
+
 /*
  * Creates a new BlockBackend, opens a new BlockDriverState, and connects =
both.
  * The new BlockBackend is in the main AioContext.
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659fa..1cb8ae17ffde 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -261,11 +261,9 @@ static int block_crypto_co_create_generic(BlockDriverS=
tate *bs,
     QCryptoBlock *crypto =3D NULL;
     struct BlockCryptoCreateData data;

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto cleanup;
     }

diff --git a/block/parallels.c b/block/parallels.c
index 6d4ed77f165f..4019557ceee3 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -559,10 +559,9 @@ static int coroutine_fn parallels_co_create(BlockdevCr=
eateOptions* opts,
         return -EIO;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/qcow.c b/block/qcow.c
index 8973e4e565a1..d9f26c515a49 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -849,10 +849,9 @@ static int coroutine_fn qcow_co_create(BlockdevCreateO=
ptions *opts,
         return -EIO;
     }

-    qcow_blk =3D blk_new(bdrv_get_aio_context(bs),
-                       BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(qcow_blk, bs, errp);
-    if (ret < 0) {
+    qcow_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                               BLK_PERM_ALL, errp);
+    if (!qcow_blk) {
         goto exit;
     }
     blk_set_allow_write_beyond_eof(qcow_blk, true);
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f84..1ce72041978b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3404,10 +3404,9 @@ qcow2_co_create(BlockdevCreateOptions *create_option=
s, Error **errp)
     }

     /* Create BlockBackend to write to the image */
-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
@@ -5359,11 +5358,9 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
     }

     if (new_size) {
-        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
-                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
-        ret =3D blk_insert_bs(blk, bs, errp);
-        if (ret < 0) {
-            blk_unref(blk);
+        BlockBackend *blk =3D blk_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PER=
M_ALL,
+                                            errp);
+        if (!blk) {
             return ret;
         }

diff --git a/block/qed.c b/block/qed.c
index 1af9b3cb1db1..dd767a5c75c9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -651,10 +651,9 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCre=
ateOptions *opts,
         return -EIO;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 59f7ebb1710f..09d75ff78dd8 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1803,12 +1803,11 @@ static int sd_prealloc(BlockDriverState *bs, int64_=
t old_size, int64_t new_size,
     void *buf =3D NULL;
     int ret;

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RES=
IZE,
-                  BLK_PERM_ALL);
+    blk =3D blk_new_with_bs(bs,
+                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_=
PERM_RESIZE,
+                          BLK_PERM_ALL, errp);

-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    if (!blk) {
         goto out_with_err_set;
     }

diff --git a/block/vdi.c b/block/vdi.c
index e1a11f2aa097..d1b692741620 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -804,10 +804,9 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreat=
eOptions *create_options,
         goto exit;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs_file),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs_file, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs_file, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                          BLK_PERM_ALL, errp);
+    if (!blk) {
         goto exit;
     }

diff --git a/block/vhdx.c b/block/vhdx.c
index 33e57cd6567a..4c908f226f48 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1984,10 +1984,9 @@ static int coroutine_fn vhdx_co_create(BlockdevCreat=
eOptions *opts,
         return -EIO;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto delete_and_exit;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c980059..dff9bd28cc3f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2717,11 +2717,10 @@ static BlockBackend *vmdk_co_create_cb(int64_t size=
, int idx,
     if (!bs) {
         return NULL;
     }
-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_PERM_RES=
IZE,
-                  BLK_PERM_ALL);
-    if (blk_insert_bs(blk, bs, errp)) {
-        bdrv_unref(bs);
+    blk =3D blk_new_with_bs(bs,
+                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE | BLK_=
PERM_RESIZE,
+                          BLK_PERM_ALL, errp);
+    if (!blk) {
         return NULL;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/vpc.c b/block/vpc.c
index d8141b52da8b..250bb0bdad78 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1012,10 +1012,9 @@ static int coroutine_fn vpc_co_create(BlockdevCreate=
Options *opts,
         return -EIO;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM=
_ALL,
+                          errp);
+    if (!blk) {
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/blockdev.c b/blockdev.c
index 5faddaa7052f..f43426ed5fbc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2711,7 +2711,6 @@ void qmp_block_resize(bool has_device, const char *de=
vice,
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs;
     AioContext *aio_context;
-    int ret;

     bs =3D bdrv_lookup_bs(has_device ? device : NULL,
                         has_node_name ? node_name : NULL,
@@ -2734,14 +2733,13 @@ void qmp_block_resize(bool has_device, const char *=
device,
         goto out;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs), BLK_PERM_RESIZE, BLK_PERM_AL=
L);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PERM_ALL, errp);
+    if (!blk) {
         goto out;
     }

     bdrv_drained_begin(bs);
-    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
+    blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
     bdrv_drained_end(bs);

 out:
diff --git a/blockjob.c b/blockjob.c
index fc850312c124..2affa1844d4f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -397,16 +397,13 @@ void *block_job_create(const char *job_id, const Bloc=
kJobDriver *driver,
 {
     BlockBackend *blk;
     BlockJob *job;
-    int ret;

     if (job_id =3D=3D NULL && !(flags & JOB_INTERNAL)) {
         job_id =3D bdrv_get_device_name(bs);
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs), perm, shared_perm);
-    ret =3D blk_insert_bs(blk, bs, errp);
-    if (ret < 0) {
-        blk_unref(blk);
+    blk =3D blk_new_with_bs(bs, perm, shared_perm, errp);
+    if (!blk) {
         return NULL;
     }

--=20
2.26.2


