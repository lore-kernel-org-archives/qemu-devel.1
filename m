Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A51DC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E857B20756
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6aFpAjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUNc-0006gP-UI
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUId-0000i3-Pc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kXUIb-0001Hn-Od
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603825584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufmGmTV9ux2C7ivpVrdImE5YAcTfaYCp6E+hdLGxmN4=;
 b=a6aFpAjbpFCUqOzch9fMS7nYaHj9I//6yAWFybyOF6J0cARRuHqYJU1VgtZuqEZLcIyoyG
 x1f6rQX40ZD6FxnT/NiOQpOhNZx3ZvubLWNdKbRHddRV3hgqPOe504X5G4VRXQVDZpCsvG
 FinzLgekJpje2kXDeDlouBtOzgJpp5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-FJC62nV9Ok2DFZ3FZkafYg-1; Tue, 27 Oct 2020 15:06:22 -0400
X-MC-Unique: FJC62nV9Ok2DFZ3FZkafYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3996DEC1AA;
 Tue, 27 Oct 2020 19:06:21 +0000 (UTC)
Received: from localhost (unknown [10.40.193.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D9462A0B;
 Tue, 27 Oct 2020 19:06:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-6.0 v3 03/20] fuse: Implement standard FUSE operations
Date: Tue, 27 Oct 2020 20:05:43 +0100
Message-Id: <20201027190600.192171-4-mreitz@redhat.com>
In-Reply-To: <20201027190600.192171-1-mreitz@redhat.com>
References: <20201027190600.192171-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the export actually useful instead of only producing errors
whenever it is accessed.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/export/fuse.c | 242 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 0553bcd630..d995829ab7 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -282,8 +282,250 @@ static void fuse_init(void *userdata, struct fuse_conn_info *conn)
     conn->max_write = MIN_NON_ZERO(BDRV_REQUEST_MAX_BYTES, conn->max_write);
 }
 
+/**
+ * Let clients look up files.  Always return ENOENT because we only
+ * care about the mountpoint itself.
+ */
+static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
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
+    time_t now = time(NULL);
+    FuseExport *exp = fuse_req_userdata(req);
+    mode_t mode;
+
+    length = blk_getlength(exp->common.blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    allocated_blocks = bdrv_get_allocated_file_size(blk_bs(exp->common.blk));
+    if (allocated_blocks <= 0) {
+        allocated_blocks = DIV_ROUND_UP(length, 512);
+    } else {
+        allocated_blocks = DIV_ROUND_UP(allocated_blocks, 512);
+    }
+
+    mode = S_IFREG | S_IRUSR;
+    if (exp->writable) {
+        mode |= S_IWUSR;
+    }
+
+    statbuf = (struct stat) {
+        .st_ino     = inode,
+        .st_mode    = mode,
+        .st_nlink   = 1,
+        .st_uid     = getuid(),
+        .st_gid     = getgid(),
+        .st_size    = length,
+        .st_blksize = blk_bs(exp->common.blk)->bl.request_alignment,
+        .st_blocks  = allocated_blocks,
+        .st_atime   = now,
+        .st_mtime   = now,
+        .st_ctime   = now,
+    };
+
+    fuse_reply_attr(req, &statbuf, 1.);
+}
+
+static int fuse_do_truncate(const FuseExport *exp, int64_t size,
+                            bool req_zero_write, PreallocMode prealloc)
+{
+    uint64_t blk_perm, blk_shared_perm;
+    BdrvRequestFlags truncate_flags = 0;
+    int ret;
+
+    if (req_zero_write) {
+        truncate_flags |= BDRV_REQ_ZERO_WRITE;
+    }
+
+    blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
+
+    ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
+                       blk_shared_perm, NULL);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = blk_truncate(exp->common.blk, size, true, prealloc,
+                       truncate_flags, NULL);
+
+    /* Must succeed, because we are only giving up the RESIZE permission */
+    blk_set_perm(exp->common.blk, blk_perm, blk_shared_perm, &error_abort);
+
+    return ret;
+}
+
+/**
+ * Let clients set file attributes.  Only resizing is supported.
+ */
+static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
+                         int to_set, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    int ret;
+
+    if (!exp->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    if (to_set & ~FUSE_SET_ATTR_SIZE) {
+        fuse_reply_err(req, ENOTSUP);
+        return;
+    }
+
+    ret = fuse_do_truncate(exp, statbuf->st_size, true, PREALLOC_MODE_OFF);
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
+                      size_t size, off_t offset, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    int64_t length;
+    void *buf;
+    int ret;
+
+    /* Limited by max_read, should not happen */
+    if (size > FUSE_MAX_BOUNCE_BYTES) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    /**
+     * Clients will expect short reads at EOF, so we have to limit
+     * offset+size to the image length.
+     */
+    length = blk_getlength(exp->common.blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    if (offset + size > length) {
+        size = length - offset;
+    }
+
+    buf = qemu_try_blockalign(blk_bs(exp->common.blk), size);
+    if (!buf) {
+        fuse_reply_err(req, ENOMEM);
+        return;
+    }
+
+    ret = blk_pread(exp->common.blk, offset, buf, size);
+    if (ret >= 0) {
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
+                       size_t size, off_t offset, struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    int64_t length;
+    int ret;
+
+    /* Limited by max_write, should not happen */
+    if (size > BDRV_REQUEST_MAX_BYTES) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    if (!exp->writable) {
+        fuse_reply_err(req, EACCES);
+        return;
+    }
+
+    /**
+     * Clients will expect short writes at EOF, so we have to limit
+     * offset+size to the image length.
+     */
+    length = blk_getlength(exp->common.blk);
+    if (length < 0) {
+        fuse_reply_err(req, -length);
+        return;
+    }
+
+    if (offset + size > length) {
+        size = length - offset;
+    }
+
+    ret = blk_pwrite(exp->common.blk, offset, buf, size, 0);
+    if (ret >= 0) {
+        fuse_reply_write(req, size);
+    } else {
+        fuse_reply_err(req, -ret);
+    }
+}
+
+/**
+ * Let clients fsync the exported image.
+ */
+static void fuse_fsync(fuse_req_t req, fuse_ino_t inode, int datasync,
+                       struct fuse_file_info *fi)
+{
+    FuseExport *exp = fuse_req_userdata(req);
+    int ret;
+
+    ret = blk_flush(exp->common.blk);
+    fuse_reply_err(req, ret < 0 ? -ret : 0);
+}
+
+/**
+ * Called before an FD to the exported image is closed.  (libfuse
+ * notes this to be a way to return last-minute errors.)
+ */
+static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
+                        struct fuse_file_info *fi)
+{
+    fuse_fsync(req, inode, 1, fi);
+}
+
 static const struct fuse_lowlevel_ops fuse_ops = {
     .init       = fuse_init,
+    .lookup     = fuse_lookup,
+    .getattr    = fuse_getattr,
+    .setattr    = fuse_setattr,
+    .open       = fuse_open,
+    .read       = fuse_read,
+    .write      = fuse_write,
+    .flush      = fuse_flush,
+    .fsync      = fuse_fsync,
 };
 
 const BlockExportDriver blk_exp_fuse = {
-- 
2.26.2


