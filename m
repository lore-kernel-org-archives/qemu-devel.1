Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF3320714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUtHYyvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF3320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHH5g-0004ZO-GE
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 21:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jHH4s-0003Hn-Vx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jHH4r-0002XH-31
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:12:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jHH4q-0002Wz-2D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585185175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/QDaoDCaD6/5X3+c8V+d/Gn+xlwDftGQmfsQsJifNE=;
 b=bUtHYyvXd3XDaH4gNpBvg493QktRhkyGcjnPyfuzs2xe485f/agPRkxKcC37sfIVLWS9ln
 1X4w29ajUAe75ykq8WcvYm5z6z/eFHMJuGekoly3M8HMffTH55LOvvdWIMEh1j4cwNy7w7
 bwFclJPaeIdKEUEGZWpJdDwmIJiD544=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-XGgXcfF2NGaOLdg8gu_oHA-1; Wed, 25 Mar 2020 21:12:51 -0400
X-MC-Unique: XGgXcfF2NGaOLdg8gu_oHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C4F1005512;
 Thu, 26 Mar 2020 01:12:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAEA110098FB;
 Thu, 26 Mar 2020 01:12:39 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: trickle down the fallback image creation function
 use to the block drivers
Date: Thu, 26 Mar 2020 03:12:18 +0200
Message-Id: <20200326011218.29230-3-mlevitsk@redhat.com>
In-Reply-To: <20200326011218.29230-1-mlevitsk@redhat.com>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of checking the .bdrv_co_create_opts to see if we need the failback=
,
just implement the .bdrv_co_create_opts in the drivers that need it.

This way we don't break various places that need to know if the underlying
protocol/format really supports image creation, and this way we still
allow some drivers to not support image creation.

Fixes: fd17146cd93d1704cd96d7c2757b325fc7aac6fd
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1816007

Note that technically this driver reverts the image creation failback
for the vxhs driver since I don't have a means to test it,
and IMHO it is better to leave it not supported as it was prior to
generic image creation patches.

Also drop iscsi_create_opts which was left accidently

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block.c               | 35 ++++++++++++++++++++---------------
 block/file-posix.c    |  7 ++++++-
 block/iscsi.c         | 16 ++++------------
 block/nbd.c           |  6 ++++++
 block/nvme.c          |  3 +++
 include/block/block.h |  7 +++++++
 6 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/block.c b/block.c
index ff23e20443..72fdf56af7 100644
--- a/block.c
+++ b/block.c
@@ -598,8 +598,15 @@ static int create_file_fallback_zero_first_sector(Bloc=
kBackend *blk,
     return 0;
 }
=20
-static int bdrv_create_file_fallback(const char *filename, BlockDriver *dr=
v,
-                                     QemuOpts *opts, Error **errp)
+/**
+ * Simple implementation of bdrv_co_create_opts for protocol drivers
+ * which only support creation via opening a file
+ * (usually existing raw storage device)
+ */
+int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
+                                           Error **errp)
 {
     BlockBackend *blk;
     QDict *options;
@@ -663,11 +670,7 @@ int bdrv_create_file(const char *filename, QemuOpts *o=
pts, Error **errp)
         return -ENOENT;
     }
=20
-    if (drv->bdrv_co_create_opts) {
-        return bdrv_create(drv, filename, opts, errp);
-    } else {
-        return bdrv_create_file_fallback(filename, drv, opts, errp);
-    }
+    return bdrv_create(drv, filename, opts, errp);
 }
=20
 int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)
@@ -1592,9 +1595,9 @@ QemuOptsList bdrv_runtime_opts =3D {
     },
 };
=20
-static QemuOptsList fallback_create_opts =3D {
-    .name =3D "fallback-create-opts",
-    .head =3D QTAILQ_HEAD_INITIALIZER(fallback_create_opts.head),
+QemuOptsList bdrv_create_opts_simple =3D {
+    .name =3D "simple-create-opts",
+    .head =3D QTAILQ_HEAD_INITIALIZER(bdrv_create_opts_simple.head),
     .desc =3D {
         {
             .name =3D BLOCK_OPT_SIZE,
@@ -5963,13 +5966,15 @@ void bdrv_img_create(const char *filename, const ch=
ar *fmt,
         return;
     }
=20
+    if (!proto_drv->create_opts) {
+        error_setg(errp, "Protocol driver '%s' does not support image crea=
tion",
+                   proto_drv->format_name);
+        return;
+    }
+
     /* Create parameter list */
     create_opts =3D qemu_opts_append(create_opts, drv->create_opts);
-    if (proto_drv->create_opts) {
-        create_opts =3D qemu_opts_append(create_opts, proto_drv->create_op=
ts);
-    } else {
-        create_opts =3D qemu_opts_append(create_opts, &fallback_create_opt=
s);
-    }
+    create_opts =3D qemu_opts_append(create_opts, proto_drv->create_opts);
=20
     opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
=20
diff --git a/block/file-posix.c b/block/file-posix.c
index 65bc980bc4..7e19bbff5f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3513,6 +3513,8 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
+    .bdrv_co_create_opts =3D bdrv_co_create_opts_simple,
+    .create_opts         =3D &bdrv_create_opts_simple,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D hdev_co_pwrite_zeroes,
@@ -3639,10 +3641,11 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
+    .bdrv_co_create_opts =3D bdrv_co_create_opts_simple,
+    .create_opts         =3D &bdrv_create_opts_simple,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
=20
-
     .bdrv_co_preadv         =3D raw_co_preadv,
     .bdrv_co_pwritev        =3D raw_co_pwritev,
     .bdrv_co_flush_to_disk  =3D raw_co_flush_to_disk,
@@ -3771,6 +3774,8 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_reopen_prepare =3D raw_reopen_prepare,
     .bdrv_reopen_commit  =3D raw_reopen_commit,
     .bdrv_reopen_abort   =3D raw_reopen_abort,
+    .bdrv_co_create_opts =3D bdrv_co_create_opts_simple,
+    .create_opts         =3D &bdrv_create_opts_simple,
     .mutable_opts       =3D mutable_opts,
=20
     .bdrv_co_preadv         =3D raw_co_preadv,
diff --git a/block/iscsi.c b/block/iscsi.c
index 682abd8e09..14680a436a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2399,18 +2399,6 @@ out_unlock:
     return r;
 }
=20
-static QemuOptsList iscsi_create_opts =3D {
-    .name =3D "iscsi-create-opts",
-    .head =3D QTAILQ_HEAD_INITIALIZER(iscsi_create_opts.head),
-    .desc =3D {
-        {
-            .name =3D BLOCK_OPT_SIZE,
-            .type =3D QEMU_OPT_SIZE,
-            .help =3D "Virtual disk size"
-        },
-        { /* end of list */ }
-    }
-};
=20
 static const char *const iscsi_strong_runtime_opts[] =3D {
     "transport",
@@ -2434,6 +2422,8 @@ static BlockDriver bdrv_iscsi =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
+    .bdrv_co_create_opts    =3D bdrv_co_create_opts_simple,
+    .create_opts            =3D &bdrv_create_opts_simple,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache =3D iscsi_co_invalidate_cache,
@@ -2471,6 +2461,8 @@ static BlockDriver bdrv_iser =3D {
     .bdrv_parse_filename    =3D iscsi_parse_filename,
     .bdrv_file_open         =3D iscsi_open,
     .bdrv_close             =3D iscsi_close,
+    .bdrv_co_create_opts    =3D bdrv_co_create_opts_simple,
+    .create_opts            =3D &bdrv_create_opts_simple,
     .bdrv_reopen_prepare    =3D iscsi_reopen_prepare,
     .bdrv_reopen_commit     =3D iscsi_reopen_commit,
     .bdrv_co_invalidate_cache  =3D iscsi_co_invalidate_cache,
diff --git a/block/nbd.c b/block/nbd.c
index 976be76647..2160859f64 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2038,6 +2038,8 @@ static BlockDriver bdrv_nbd =3D {
     .protocol_name              =3D "nbd",
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
+    .bdrv_co_create_opts        =3D bdrv_co_create_opts_simple,
+    .create_opts                =3D &bdrv_create_opts_simple,
     .bdrv_file_open             =3D nbd_open,
     .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
@@ -2063,6 +2065,8 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .protocol_name              =3D "nbd+tcp",
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
+    .bdrv_co_create_opts        =3D bdrv_co_create_opts_simple,
+    .create_opts                =3D &bdrv_create_opts_simple,
     .bdrv_file_open             =3D nbd_open,
     .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
@@ -2088,6 +2092,8 @@ static BlockDriver bdrv_nbd_unix =3D {
     .protocol_name              =3D "nbd+unix",
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
+    .bdrv_co_create_opts        =3D bdrv_co_create_opts_simple,
+    .create_opts                =3D &bdrv_create_opts_simple,
     .bdrv_file_open             =3D nbd_open,
     .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
diff --git a/block/nvme.c b/block/nvme.c
index d41c4bda6e..7b7c0cc5d6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1333,6 +1333,9 @@ static BlockDriver bdrv_nvme =3D {
     .protocol_name            =3D "nvme",
     .instance_size            =3D sizeof(BDRVNVMeState),
=20
+    .bdrv_co_create_opts      =3D bdrv_co_create_opts_simple,
+    .create_opts              =3D &bdrv_create_opts_simple,
+
     .bdrv_parse_filename      =3D nvme_parse_filename,
     .bdrv_file_open           =3D nvme_file_open,
     .bdrv_close               =3D nvme_close,
diff --git a/include/block/block.h b/include/block/block.h
index e569a4d747..7d36ec5433 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -283,6 +283,13 @@ BlockDriver *bdrv_find_format(const char *format_name)=
;
 int bdrv_create(BlockDriver *drv, const char* filename,
                 QemuOpts *opts, Error **errp);
 int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
+
+int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
+                                           const char *filename,
+                                           QemuOpts *opts,
+                                           Error **errp);
+extern QemuOptsList bdrv_create_opts_simple;
+
 BlockDriverState *bdrv_new(void);
 void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                  Error **errp);
--=20
2.17.2


