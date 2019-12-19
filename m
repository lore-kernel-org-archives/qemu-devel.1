Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A33C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AD22067C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Yx7tjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AD22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx3B-0005fG-8m
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwwp-0004aX-9A
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwn-0004yD-Pm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwn-0004uk-IL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPZWJr8c0vzG4cTx41oq/Hlj8AqoZ0t1ftb+p2sG3LI=;
 b=L0Yx7tjsvlAvOPjw712HCfr/ZCHC97qtp7aI1BpLf1Q7nxHxowuThTdDihcLq+zWyv+cH7
 2DWBE0BOYMrh/csJgZpEhmCplJdLOcxybn9lHWulfgR89nLQqB1S/RCEEjVJZ8Xm8rsZdV
 RxBs07ri4VWbDlC4jGfNCAGyyqe5xJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-HjcTPbstMQa5GTPxse1f5w-1; Thu, 19 Dec 2019 09:38:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC818801E72;
 Thu, 19 Dec 2019 14:38:34 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 472BF7574A;
 Thu, 19 Dec 2019 14:38:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 03/18] fuse: Implement standard FUSE operations
Date: Thu, 19 Dec 2019 15:38:03 +0100
Message-Id: <20191219143818.1646168-4-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HjcTPbstMQa5GTPxse1f5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the export actually useful instead of only producing errors
whenever it is accessed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/fuse.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/block/fuse.c b/block/fuse.c
index 3a22579dca..f18e8e7591 100644
--- a/block/fuse.c
+++ b/block/fuse.c
@@ -31,6 +31,10 @@
 #include <fuse_lowlevel.h>
=20
=20
+/* Prevent overly long bounce buffer allocations */
+#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 102=
4))
+
+
 typedef struct BdrvFuseSession {
     struct fuse_session *fuse_session;
     struct fuse_buf fuse_buf;
@@ -256,5 +260,223 @@ static bool is_regular_file(const char *path, Error *=
*errp)
     return true;
 }
=20
+
+/**
+ * Let clients look up files.  Always return ENOENT because we only
+ * care about the mountpoint itself.
+ */
+static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e)
+{
+    fuse_reply_err(req, ENOENT);
+}
+
+/**
+ * Let clients get file attributes (i.e., stat() the file).
+ */
+static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
+                         struct fuse_file_info *fi)
+{
+    struct stat statbuf;
+    int64_t length, allocated_blocks;
+    time_t now =3D time(NULL);
+    ImageInfo *info;
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    mode_t mode;
+    Error *local_error =3D NULL;
+
+    length =3D blk_getlength(session->blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    bdrv_query_image_info(blk_bs(session->blk), &info, &local_error);
+    if (local_error) {
+        error_free(local_error);
+        allocated_blocks =3D DIV_ROUND_UP(length, 512);
+    } else {
+        allocated_blocks =3D DIV_ROUND_UP(info->actual_size, 512);
+        qapi_free_ImageInfo(info);
+    }
+
+    mode =3D S_IFREG | 0400;
+    if (session->writable) {
+        mode |=3D 0200;
+    }
+
+    statbuf =3D (struct stat) {
+        .st_ino     =3D inode,
+        .st_mode    =3D mode,
+        .st_nlink   =3D 1,
+        .st_uid     =3D getuid(),
+        .st_gid     =3D getgid(),
+        .st_size    =3D length,
+        .st_blksize =3D blk_bs(session->blk)->bl.request_alignment,
+        .st_blocks  =3D allocated_blocks,
+        .st_atime   =3D now,
+        .st_mtime   =3D now,
+        .st_ctime   =3D now,
+    };
+
+    fuse_reply_attr(req, &statbuf, 1.);
+}
+
+static int fuse_do_truncate(const BdrvFuseSession *session, int64_t size,
+                            PreallocMode prealloc)
+{
+    int ret;
+
+    ret =3D blk_set_perm(session->blk, session->perm | BLK_PERM_RESIZE,
+                       session->shared_perm, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D blk_truncate(session->blk, size, true, prealloc, NULL);
+
+    /* Must succeed, because we are only giving up the RESIZE permission *=
/
+    blk_set_perm(session->blk, session->perm, session->shared_perm,
+                 &error_abort);
+
+    return ret;
+}
+
+/**
+ * Let clients set file attributes.  Only resizing is supported.
+ */
+static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *st=
atbuf,
+                         int to_set, struct fuse_file_info *fi)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    int ret;
+
+    if (!session->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    if (to_set & ~FUSE_SET_ATTR_SIZE) {
+        fuse_reply_err(req, ENOTSUP);
+        return;
+    }
+
+    ret =3D fuse_do_truncate(session, statbuf->st_size, PREALLOC_MODE_OFF)=
;
+    if (ret < 0) {
+        fuse_reply_err(req, -ret);
+        return;
+    }
+
+    fuse_getattr(req, inode, fi);
+}
+
+/**
+ * Let clients open a file (i.e., the exported image).
+ */
+static void fuse_open(fuse_req_t req, fuse_ino_t inode,
+                      struct fuse_file_info *fi)
+{
+    fuse_reply_open(req, fi);
+}
+
+/**
+ * Handle client reads from the exported image.
+ */
+static void fuse_read(fuse_req_t req, fuse_ino_t inode,
+                      size_t size, off_t offset, struct fuse_file_info *fi=
)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    int64_t length;
+    void *buf;
+    int ret;
+
+    /**
+     * Clients will expect short reads at EOF, so we have to limit
+     * offset+size to the image length.
+     */
+    length =3D blk_getlength(session->blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    size =3D MIN(size, FUSE_MAX_BOUNCE_BYTES);
+    if (offset + size > length) {
+        size =3D length - offset;
+    }
+
+    buf =3D qemu_try_blockalign(blk_bs(session->blk), size);
+    if (!buf) {
+        fuse_reply_err(req, ENOMEM);
+        return;
+    }
+
+    ret =3D blk_pread(session->blk, offset, buf, size);
+    if (ret >=3D 0) {
+        fuse_reply_buf(req, buf, size);
+    } else {
+        fuse_reply_err(req, -ret);
+    }
+
+    qemu_vfree(buf);
+}
+
+/**
+ * Handle client writes to the exported image.
+ */
+static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
+                       size_t size, off_t offset, struct fuse_file_info *f=
i)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    int64_t length;
+    int ret;
+
+    if (!session->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    /**
+     * Clients will expect short writes at EOF, so we have to limit
+     * offset+size to the image length.
+     */
+    length =3D blk_getlength(session->blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    size =3D MIN(size, BDRV_REQUEST_MAX_BYTES);
+    if (offset + size > length) {
+        size =3D length - offset;
+    }
+
+    ret =3D blk_pwrite(session->blk, offset, buf, size, 0);
+    if (ret >=3D 0) {
+        fuse_reply_write(req, size);
+    } else {
+        fuse_reply_err(req, -ret);
+    }
+}
+
+/**
+ * Let clients flush the exported image.
+ */
+static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
+                       struct fuse_file_info *fi)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+    int ret;
+
+    ret =3D blk_flush(session->blk);
+    fuse_reply_err(req, ret < 0 ? -ret : 0);
+}
+
 static const struct fuse_lowlevel_ops fuse_ops =3D {
+    .lookup     =3D fuse_lookup,
+    .getattr    =3D fuse_getattr,
+    .setattr    =3D fuse_setattr,
+    .open       =3D fuse_open,
+    .read       =3D fuse_read,
+    .write      =3D fuse_write,
+    .flush      =3D fuse_flush,
 };
--=20
2.23.0


