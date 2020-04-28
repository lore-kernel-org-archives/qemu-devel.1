Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A6C83007
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738FF206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYjK84Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738FF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVv2-0004eZ-Ga
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVt0-00022p-2O
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTVsy-0000k5-5U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:27:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTVsx-0000jj-J4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588102034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GI5eHWO0dnLWBjuNQ2JYAcbpuOV6Zh0bUxSSRXTQZA=;
 b=bYjK84CljnwDp+9F1/E74/nQhxiCs/yJmVeQ08aEGvLlseilOYbBMr/45tOpqsT0YtAY60
 7bJMVflDh1GxkMpyUHL+cgOyuhWWowxOvhLCl9Glr3RSdOalAgtt3ddE0pKBUmQpBMyLDS
 VWq/aVJsvE/yPX3QnJmgUzmDeZ9oxGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-g9HA-k6SMo2G_VyF8-1Y_Q-1; Tue, 28 Apr 2020 15:27:09 -0400
X-MC-Unique: g9HA-k6SMo2G_VyF8-1Y_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40559107ACF3;
 Tue, 28 Apr 2020 19:27:08 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E45F710016E8;
 Tue, 28 Apr 2020 19:27:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] block: Add blk_new_with_bs() helper
Date: Tue, 28 Apr 2020 14:26:46 -0500
Message-Id: <20200428192648.749066-2-eblake@redhat.com>
In-Reply-To: <20200428192648.749066-1-eblake@redhat.com>
References: <20200428192648.749066-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, mreitz@redhat.com, stefanha@redhat.com,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several callers that need to create a new block backend from
an existing BDS; make the task slightly easier with a common helper
routine.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424190903.522087-2-eblake@redhat.com>
[mreitz: Set @ret only in error paths, see
 https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg01216.html]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  2 ++
 block/block-backend.c          | 23 +++++++++++++++++++++++
 block/crypto.c                 |  9 ++++-----
 block/parallels.c              |  8 ++++----
 block/qcow.c                   |  8 ++++----
 block/qcow2.c                  | 18 ++++++++----------
 block/qed.c                    |  8 ++++----
 block/sheepdog.c               | 10 +++++-----
 block/vdi.c                    |  8 ++++----
 block/vhdx.c                   |  8 ++++----
 block/vmdk.c                   |  9 ++++-----
 block/vpc.c                    |  8 ++++----
 blockdev.c                     |  8 +++-----
 blockjob.c                     |  7 ++-----
 14 files changed, 75 insertions(+), 59 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 34de7faa81de..0917663d89f4 100644
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
index 17ed6d8c5b27..f4944861fa4e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -355,6 +355,29 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, =
uint64_t shared_perm)
     return blk;
 }

+/*
+ * Create a new BlockBackend connected to an existing BlockDriverState.
+ *
+ * @perm is a bitmasks of BLK_PERM_* constants which describes the
+ * permissions to request for @bs that is attached to this
+ * BlockBackend.  @shared_perm is a bitmask which describes which
+ * permissions may be granted to other users of the attached node.
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
index e02f34359019..ca44dae4f7e8 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -261,11 +261,10 @@ static int block_crypto_co_create_generic(BlockDriver=
State *bs,
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
+        ret =3D -EPERM;
         goto cleanup;
     }

diff --git a/block/parallels.c b/block/parallels.c
index 2be92cf41708..8db64a55e3ae 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -559,10 +559,10 @@ static int coroutine_fn parallels_co_create(BlockdevC=
reateOptions* opts,
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
+        ret =3D -EPERM;
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/qcow.c b/block/qcow.c
index 6b5f2269f0ba..b0475b73a551 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -849,10 +849,10 @@ static int coroutine_fn qcow_co_create(BlockdevCreate=
Options *opts,
         return -EIO;
     }

-    qcow_blk =3D blk_new(bdrv_get_aio_context(bs),
-                       BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(qcow_blk, bs, errp);
-    if (ret < 0) {
+    qcow_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                               BLK_PERM_ALL, errp);
+    if (!qcow_blk) {
+        ret =3D -EPERM;
         goto exit;
     }
     blk_set_allow_write_beyond_eof(qcow_blk, true);
diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c391c..0edc7f4643f8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3405,10 +3405,10 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
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
+        ret =3D -EPERM;
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
@@ -5412,12 +5412,10 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
     }

     if (new_size) {
-        BlockBackend *blk =3D blk_new(bdrv_get_aio_context(bs),
-                                    BLK_PERM_RESIZE, BLK_PERM_ALL);
-        ret =3D blk_insert_bs(blk, bs, errp);
-        if (ret < 0) {
-            blk_unref(blk);
-            return ret;
+        BlockBackend *blk =3D blk_new_with_bs(bs, BLK_PERM_RESIZE, BLK_PER=
M_ALL,
+                                            errp);
+        if (!blk) {
+            return -EPERM;
         }

         /*
diff --git a/block/qed.c b/block/qed.c
index b0fdb8f56508..fb609cfba17a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -651,10 +651,10 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
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
+        ret =3D -EPERM;
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index ef0a6e743e27..39010c3f55bb 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1803,12 +1803,12 @@ static int sd_prealloc(BlockDriverState *bs, int64_=
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
+        ret =3D -EPERM;
         goto out_with_err_set;
     }

diff --git a/block/vdi.c b/block/vdi.c
index 0c7835ae70a0..2d2804661527 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -804,10 +804,10 @@ static int coroutine_fn vdi_co_do_create(BlockdevCrea=
teOptions *create_options,
         goto exit;
     }

-    blk =3D blk_new(bdrv_get_aio_context(bs_file),
-                  BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
-    ret =3D blk_insert_bs(blk, bs_file, errp);
-    if (ret < 0) {
+    blk =3D blk_new_with_bs(bs_file, BLK_PERM_WRITE | BLK_PERM_RESIZE,
+                          BLK_PERM_ALL, errp);
+    if (!blk) {
+        ret =3D -EPERM;
         goto exit;
     }

diff --git a/block/vhdx.c b/block/vhdx.c
index 21497f731878..9416cd3fd572 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1984,10 +1984,10 @@ static int coroutine_fn vhdx_co_create(BlockdevCrea=
teOptions *opts,
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
+        ret =3D -EPERM;
         goto delete_and_exit;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/vmdk.c b/block/vmdk.c
index 8ec18f35a536..b02fdd14b2d0 100644
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
index 2d1eade146b7..5e31dd1e47a1 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1012,10 +1012,10 @@ static int coroutine_fn vpc_co_create(BlockdevCreat=
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
+        ret =3D -EPERM;
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/blockdev.c b/blockdev.c
index fbe3a06dbf93..e5b018320ab1 100644
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
-    ret =3D blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
+    blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
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


