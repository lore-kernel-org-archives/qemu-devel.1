Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1715C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872BE22CE9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872BE22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkOj-0005BK-5I
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkLq-0002tG-Bd
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkLo-0006Iz-Qn
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkLl-0006H7-Ln; Mon, 19 Aug 2019 12:17:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBD8F300189C;
 Mon, 19 Aug 2019 16:17:40 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4381F5;
 Mon, 19 Aug 2019 16:17:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:11 +0200
Message-Id: <20190819161723.7746-6-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 19 Aug 2019 16:17:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/17] block: Implement
 .bdrv_has_zero_init_truncate()
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

We need to implement .bdrv_has_zero_init_truncate() for every block
driver that supports truncation and has a .bdrv_has_zero_init()
implementation.

Implement it the same way each driver implements .bdrv_has_zero_init().
This is at least not any more unsafe than what we had before.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190724171239.8764-5-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 1 +
 block/file-win32.c | 1 +
 block/gluster.c    | 4 ++++
 block/nfs.c        | 1 +
 block/qcow2.c      | 1 +
 block/qed.c        | 1 +
 block/raw-format.c | 6 ++++++
 block/rbd.c        | 1 +
 block/sheepdog.c   | 1 +
 block/ssh.c        | 1 +
 10 files changed, 18 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index e41e91e075..fbeb0068db 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2938,6 +2938,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_co_create =3D raw_co_create,
     .bdrv_co_create_opts =3D raw_co_create_opts,
     .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D raw_co_block_status,
     .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes =3D raw_co_pwrite_zeroes,
diff --git a/block/file-win32.c b/block/file-win32.c
index 6b2d67b239..41f55dfece 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -635,6 +635,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_close         =3D raw_close,
     .bdrv_co_create_opts =3D raw_co_create_opts,
     .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
=20
     .bdrv_aio_preadv    =3D raw_aio_preadv,
     .bdrv_aio_pwritev   =3D raw_aio_pwritev,
diff --git a/block/gluster.c b/block/gluster.c
index f64dc5b01e..64028b2cba 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1567,6 +1567,7 @@ static BlockDriver bdrv_gluster =3D {
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
     .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
+    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1598,6 +1599,7 @@ static BlockDriver bdrv_gluster_tcp =3D {
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
     .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
+    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1629,6 +1631,7 @@ static BlockDriver bdrv_gluster_unix =3D {
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
     .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
+    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
@@ -1666,6 +1669,7 @@ static BlockDriver bdrv_gluster_rdma =3D {
     .bdrv_co_writev               =3D qemu_gluster_co_writev,
     .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
     .bdrv_has_zero_init           =3D qemu_gluster_has_zero_init,
+    .bdrv_has_zero_init_truncate  =3D qemu_gluster_has_zero_init,
 #ifdef CONFIG_GLUSTERFS_DISCARD
     .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
 #endif
diff --git a/block/nfs.c b/block/nfs.c
index ed0cce63bb..0ec50953e4 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -863,6 +863,7 @@ static BlockDriver bdrv_nfs =3D {
     .create_opts                    =3D &nfs_create_opts,
=20
     .bdrv_has_zero_init             =3D nfs_has_zero_init,
+    .bdrv_has_zero_init_truncate    =3D nfs_has_zero_init,
     .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
     .bdrv_co_truncate               =3D nfs_file_co_truncate,
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 59cff1d4cb..ea3b42fdac 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5188,6 +5188,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
     .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
     .bdrv_co_preadv         =3D qcow2_co_preadv,
diff --git a/block/qed.c b/block/qed.c
index d0dcc5f14d..0d8fd507aa 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1669,6 +1669,7 @@ static BlockDriver bdrv_qed =3D {
     .bdrv_co_create           =3D bdrv_qed_co_create,
     .bdrv_co_create_opts      =3D bdrv_qed_co_create_opts,
     .bdrv_has_zero_init       =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_co_block_status     =3D bdrv_qed_co_block_status,
     .bdrv_co_readv            =3D bdrv_qed_co_readv,
     .bdrv_co_writev           =3D bdrv_qed_co_writev,
diff --git a/block/raw-format.c b/block/raw-format.c
index bffd424dd0..42c28cc29a 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -413,6 +413,11 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
=20
+static int raw_has_zero_init_truncate(BlockDriverState *bs)
+{
+    return bdrv_has_zero_init_truncate(bs->file->bs);
+}
+
 static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpt=
s *opts,
                                            Error **errp)
 {
@@ -572,6 +577,7 @@ BlockDriver bdrv_raw =3D {
     .bdrv_co_ioctl        =3D &raw_co_ioctl,
     .create_opts          =3D &raw_create_opts,
     .bdrv_has_zero_init   =3D &raw_has_zero_init,
+    .bdrv_has_zero_init_truncate =3D &raw_has_zero_init_truncate,
     .strong_runtime_opts  =3D raw_strong_runtime_opts,
     .mutable_opts         =3D mutable_opts,
 };
diff --git a/block/rbd.c b/block/rbd.c
index 59757b3120..057af43d48 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1288,6 +1288,7 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_co_create         =3D qemu_rbd_co_create,
     .bdrv_co_create_opts    =3D qemu_rbd_co_create_opts,
     .bdrv_has_zero_init     =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 31b0a820c2..773dfc6ab1 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3229,6 +3229,7 @@ static BlockDriver bdrv_sheepdog =3D {
     .bdrv_co_create               =3D sd_co_create,
     .bdrv_co_create_opts          =3D sd_co_create_opts,
     .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
     .bdrv_getlength               =3D sd_getlength,
     .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
     .bdrv_co_truncate             =3D sd_co_truncate,
diff --git a/block/ssh.c b/block/ssh.c
index 501933b855..84d01e892b 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1390,6 +1390,7 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_co_create_opts          =3D ssh_co_create_opts,
     .bdrv_close                   =3D ssh_close,
     .bdrv_has_zero_init           =3D ssh_has_zero_init,
+    .bdrv_has_zero_init_truncate  =3D ssh_has_zero_init,
     .bdrv_co_readv                =3D ssh_co_readv,
     .bdrv_co_writev               =3D ssh_co_writev,
     .bdrv_getlength               =3D ssh_getlength,
--=20
2.21.0


