Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0BDCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323E6206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP6DlEIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323E6206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpNY-0002g8-6c
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpE1-0002l5-Rr
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:07:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpE0-0003XC-Kr
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPxnNO0T38iucT4qV+6QYWi+EOXcdcKxRH2fu39xBKk=;
 b=RP6DlEIsMXot80jtJ7Yti6BcLZQZNYYUEacXBBJmjCpsoqVR8liLcUwQN0rv8iCdk2XpO6
 2nLUaxDtTuN0yZwmztHdap3pIcCnH680/jkbMY4uKDbvpZrxzlqc/R896N4tOrQOGFvPOd
 T5pJ4UndcFbz0U7fTW743v2+HdxN/nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-zYrceMhxMGW2xmhJK4d_IA-1; Wed, 13 May 2020 07:06:54 -0400
X-MC-Unique: zYrceMhxMGW2xmhJK4d_IA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 397E019200C0;
 Wed, 13 May 2020 11:06:53 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FA1012A4D;
 Wed, 13 May 2020 11:06:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 25/34] block: Make format drivers use child_of_bds
Date: Wed, 13 May 2020 13:05:35 +0200
Message-Id: <20200513110544.176672-26-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commonly, they need to pass the BDRV_CHILD_IMAGE set as the
BdrvChildRole; but there are exceptions for drivers with external data
files (qcow2 and vmdk).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/bochs.c     |  4 ++--
 block/cloop.c     |  4 ++--
 block/crypto.c    |  4 ++--
 block/dmg.c       |  4 ++--
 block/parallels.c |  4 ++--
 block/qcow.c      |  4 ++--
 block/qcow2.c     | 19 +++++++++++++------
 block/qed.c       |  4 ++--
 block/vdi.c       |  4 ++--
 block/vhdx.c      |  4 ++--
 block/vmdk.c      | 20 +++++++++++++++++---
 block/vpc.c       |  4 ++--
 12 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index b013e73063..62c3f42548 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -110,8 +110,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/cloop.c b/block/cloop.c
index 3ed9fa63cc..d374a8427d 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -71,8 +71,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 8b516bfee2..457f3a06a5 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -218,8 +218,8 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     unsigned int cflags = 0;
     QDict *cryptoopts = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/dmg.c b/block/dmg.c
index af8188638c..bc64194577 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -439,8 +439,8 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/parallels.c b/block/parallels.c
index 9855ac1162..168d6c531a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -739,8 +739,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     char *buf;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 13583f0339..5347037720 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -130,8 +130,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     encryptfmt = qdict_get_try_str(encryptopts, "format");
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         ret = -EINVAL;
         goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 86335d9403..8d7230dca8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1590,8 +1590,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     }
 
     /* Open external data file */
-    s->data_file = bdrv_open_child(NULL, options, "data-file", bs, &child_file,
-                                   0, true, &local_err);
+    s->data_file = bdrv_open_child(NULL, options, "data-file", bs,
+                                   &child_of_bds, BDRV_CHILD_DATA,
+                                   true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1601,8 +1602,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
         if (!s->data_file && s->image_data_file) {
             s->data_file = bdrv_open_child(s->image_data_file, options,
-                                           "data-file", bs, &child_file, 0,
-                                           false, errp);
+                                           "data-file", bs, &child_of_bds,
+                                           BDRV_CHILD_DATA, false, errp);
             if (!s->data_file) {
                 ret = -EINVAL;
                 goto fail;
@@ -1613,6 +1614,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
             ret = -EINVAL;
             goto fail;
         }
+
+        /* No data here */
+        bs->file->role &= ~BDRV_CHILD_DATA;
+
+        /* Must succeed because we have given up permissions if anything */
+        bdrv_child_refresh_perms(bs, bs->file, &error_abort);
     } else {
         if (s->data_file) {
             error_setg(errp, "'data-file' can only be set for images with an "
@@ -1863,8 +1870,8 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
         .ret = -EINPROGRESS
     };
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/qed.c b/block/qed.c
index 1ad2aba810..ef6463b48d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -547,8 +547,8 @@ static int bdrv_qed_open(BlockDriverState *bs, QDict *options, int flags,
         .ret = -EINPROGRESS
     };
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vdi.c b/block/vdi.c
index 653acb5fc1..d20698b3cc 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -378,8 +378,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     QemuUUID uuid_link, uuid_parent;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index dde156c97b..62c6bd69ff 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -996,8 +996,8 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t signature;
     Error *local_err = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index c2cb741e2d..fadc98a262 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1089,6 +1089,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
     char *desc_file_dir = NULL;
     char *extent_path;
     BdrvChild *extent_file;
+    BdrvChildRole extent_role;
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *extent;
     char extent_opt_prefix[32];
@@ -1151,8 +1152,15 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
         ret = snprintf(extent_opt_prefix, 32, "extents.%d", s->num_extents);
         assert(ret < 32);
 
+        extent_role = BDRV_CHILD_DATA;
+        if (strcmp(type, "FLAT") != 0 && strcmp(type, "VMFS") != 0) {
+            /* non-flat extents have metadata */
+            extent_role |= BDRV_CHILD_METADATA;
+        }
+
         extent_file = bdrv_open_child(extent_path, options, extent_opt_prefix,
-                                      bs, &child_file, 0, false, &local_err);
+                                      bs, &child_of_bds, extent_role, false,
+                                      &local_err);
         g_free(extent_path);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -1257,8 +1265,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t magic;
     Error *local_err = NULL;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
@@ -1277,6 +1285,12 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
             s->desc_offset = 0x200;
             break;
         default:
+            /* No data in the descriptor file */
+            bs->file->role &= ~BDRV_CHILD_DATA;
+
+            /* Must succeed because we have given up permissions if anything */
+            bdrv_child_refresh_perms(bs, bs->file, &error_abort);
+
             ret = vmdk_open_desc_file(bs, flags, buf, options, errp);
             break;
     }
diff --git a/block/vpc.c b/block/vpc.c
index b2a86074a5..651a6737b6 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -228,8 +228,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
     int64_t bs_size;
 
-    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
-                               false, errp);
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               BDRV_CHILD_IMAGE, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
-- 
2.26.2


