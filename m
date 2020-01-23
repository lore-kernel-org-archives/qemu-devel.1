Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA419C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763E42064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJbEMvZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763E42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudGk-0005iY-2S
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9S-0002vE-Gl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9Q-0005Ra-PX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9Q-0005RL-LZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmTg24SLM+LboCGPkF+1IP0xHGThYMcNoGHxIJzK48k=;
 b=CJbEMvZQLmrJKgEONx/zrwRlYVDOr5kK3R9EkDqrJypO+dtGV3MOQLg5Dk6UXpLfxXwPFl
 y9k+6SceFqEaXFzWByWIdA6/azCAxx72x8Tww0mc0viT8L9FUXJ3RYk9KMjwSksOyZGgwY
 fGO5V8nlLzXrjRYLf1HYMl3BOcdGja0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-OA3aUq-QMwKJ_nUvBl-KHw-1; Thu, 23 Jan 2020 06:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3867800D54
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B62985754;
 Thu, 23 Jan 2020 11:59:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 057/111] virtiofsd: fix libfuse information leaks
Date: Thu, 23 Jan 2020 11:57:47 +0000
Message-Id: <20200123115841.138849-58-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OA3aUq-QMwKJ_nUvBl-KHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Some FUSE message replies contain padding fields that are not
initialized by libfuse.  This is fine in traditional FUSE applications
because the kernel is trusted.  virtiofsd does not trust the guest and
must not expose uninitialized memory.

Use C struct initializers to automatically zero out memory.  Not all of
these code changes are strictly necessary but they will prevent future
information leaks if the structs are extended.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 150 ++++++++++++++++----------------
 1 file changed, 76 insertions(+), 74 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 2d6dc5a680..6ceb33d913 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -44,21 +44,23 @@ static __attribute__((constructor)) void fuse_ll_init_p=
agesize(void)
=20
 static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 {
-    attr->ino =3D stbuf->st_ino;
-    attr->mode =3D stbuf->st_mode;
-    attr->nlink =3D stbuf->st_nlink;
-    attr->uid =3D stbuf->st_uid;
-    attr->gid =3D stbuf->st_gid;
-    attr->rdev =3D stbuf->st_rdev;
-    attr->size =3D stbuf->st_size;
-    attr->blksize =3D stbuf->st_blksize;
-    attr->blocks =3D stbuf->st_blocks;
-    attr->atime =3D stbuf->st_atime;
-    attr->mtime =3D stbuf->st_mtime;
-    attr->ctime =3D stbuf->st_ctime;
-    attr->atimensec =3D ST_ATIM_NSEC(stbuf);
-    attr->mtimensec =3D ST_MTIM_NSEC(stbuf);
-    attr->ctimensec =3D ST_CTIM_NSEC(stbuf);
+    *attr =3D (struct fuse_attr){
+        .ino =3D stbuf->st_ino,
+        .mode =3D stbuf->st_mode,
+        .nlink =3D stbuf->st_nlink,
+        .uid =3D stbuf->st_uid,
+        .gid =3D stbuf->st_gid,
+        .rdev =3D stbuf->st_rdev,
+        .size =3D stbuf->st_size,
+        .blksize =3D stbuf->st_blksize,
+        .blocks =3D stbuf->st_blocks,
+        .atime =3D stbuf->st_atime,
+        .mtime =3D stbuf->st_mtime,
+        .ctime =3D stbuf->st_ctime,
+        .atimensec =3D ST_ATIM_NSEC(stbuf),
+        .mtimensec =3D ST_MTIM_NSEC(stbuf),
+        .ctimensec =3D ST_CTIM_NSEC(stbuf),
+    };
 }
=20
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *=
stbuf)
@@ -183,16 +185,16 @@ static int fuse_send_msg(struct fuse_session *se, str=
uct fuse_chan *ch,
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *io=
v,
                                int count)
 {
-    struct fuse_out_header out;
+    struct fuse_out_header out =3D {
+        .unique =3D req->unique,
+        .error =3D error,
+    };
=20
     if (error <=3D -1000 || error > 0) {
         fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
         error =3D -ERANGE;
     }
=20
-    out.unique =3D req->unique;
-    out.error =3D error;
-
     iov[0].iov_base =3D &out;
     iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
@@ -277,14 +279,16 @@ size_t fuse_add_direntry(fuse_req_t req, char *buf, s=
ize_t bufsize,
 static void convert_statfs(const struct statvfs *stbuf,
                            struct fuse_kstatfs *kstatfs)
 {
-    kstatfs->bsize =3D stbuf->f_bsize;
-    kstatfs->frsize =3D stbuf->f_frsize;
-    kstatfs->blocks =3D stbuf->f_blocks;
-    kstatfs->bfree =3D stbuf->f_bfree;
-    kstatfs->bavail =3D stbuf->f_bavail;
-    kstatfs->files =3D stbuf->f_files;
-    kstatfs->ffree =3D stbuf->f_ffree;
-    kstatfs->namelen =3D stbuf->f_namemax;
+    *kstatfs =3D (struct fuse_kstatfs){
+        .bsize =3D stbuf->f_bsize,
+        .frsize =3D stbuf->f_frsize,
+        .blocks =3D stbuf->f_blocks,
+        .bfree =3D stbuf->f_bfree,
+        .bavail =3D stbuf->f_bavail,
+        .files =3D stbuf->f_files,
+        .ffree =3D stbuf->f_ffree,
+        .namelen =3D stbuf->f_namemax,
+    };
 }
=20
 static int send_reply_ok(fuse_req_t req, const void *arg, size_t argsize)
@@ -328,12 +332,14 @@ static unsigned int calc_timeout_nsec(double t)
 static void fill_entry(struct fuse_entry_out *arg,
                        const struct fuse_entry_param *e)
 {
-    arg->nodeid =3D e->ino;
-    arg->generation =3D e->generation;
-    arg->entry_valid =3D calc_timeout_sec(e->entry_timeout);
-    arg->entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout);
-    arg->attr_valid =3D calc_timeout_sec(e->attr_timeout);
-    arg->attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout);
+    *arg =3D (struct fuse_entry_out){
+        .nodeid =3D e->ino,
+        .generation =3D e->generation,
+        .entry_valid =3D calc_timeout_sec(e->entry_timeout),
+        .entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout),
+        .attr_valid =3D calc_timeout_sec(e->attr_timeout),
+        .attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout),
+    };
     convert_stat(&e->attr, &arg->attr);
 }
=20
@@ -362,10 +368,12 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *b=
uf, size_t bufsize,
     fill_entry(&dp->entry_out, e);
=20
     struct fuse_dirent *dirent =3D &dp->dirent;
-    dirent->ino =3D e->attr.st_ino;
-    dirent->off =3D off;
-    dirent->namelen =3D namelen;
-    dirent->type =3D (e->attr.st_mode & S_IFMT) >> 12;
+    *dirent =3D (struct fuse_dirent){
+        .ino =3D e->attr.st_ino,
+        .off =3D off,
+        .namelen =3D namelen,
+        .type =3D (e->attr.st_mode & S_IFMT) >> 12,
+    };
     memcpy(dirent->name, name, namelen);
     memset(dirent->name + namelen, 0, entlen_padded - entlen);
=20
@@ -496,15 +504,14 @@ static int fuse_send_data_iov(struct fuse_session *se=
, struct fuse_chan *ch,
 int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv)
 {
     struct iovec iov[2];
-    struct fuse_out_header out;
+    struct fuse_out_header out =3D {
+        .unique =3D req->unique,
+    };
     int res;
=20
     iov[0].iov_base =3D &out;
     iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
-    out.unique =3D req->unique;
-    out.error =3D 0;
-
     res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv);
     if (res <=3D 0) {
         fuse_free_req(req);
@@ -2145,14 +2152,14 @@ static void do_destroy(fuse_req_t req, fuse_ino_t n=
odeid,
 static int send_notify_iov(struct fuse_session *se, int notify_code,
                            struct iovec *iov, int count)
 {
-    struct fuse_out_header out;
+    struct fuse_out_header out =3D {
+        .error =3D notify_code,
+    };
=20
     if (!se->got_init) {
         return -ENOTCONN;
     }
=20
-    out.unique =3D 0;
-    out.error =3D notify_code;
     iov[0].iov_base =3D &out;
     iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
@@ -2162,11 +2169,11 @@ static int send_notify_iov(struct fuse_session *se,=
 int notify_code,
 int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph)
 {
     if (ph !=3D NULL) {
-        struct fuse_notify_poll_wakeup_out outarg;
+        struct fuse_notify_poll_wakeup_out outarg =3D {
+            .kh =3D ph->kh,
+        };
         struct iovec iov[2];
=20
-        outarg.kh =3D ph->kh;
-
         iov[1].iov_base =3D &outarg;
         iov[1].iov_len =3D sizeof(outarg);
=20
@@ -2179,17 +2186,17 @@ int fuse_lowlevel_notify_poll(struct fuse_pollhandl=
e *ph)
 int fuse_lowlevel_notify_inval_inode(struct fuse_session *se, fuse_ino_t i=
no,
                                      off_t off, off_t len)
 {
-    struct fuse_notify_inval_inode_out outarg;
+    struct fuse_notify_inval_inode_out outarg =3D {
+        .ino =3D ino,
+        .off =3D off,
+        .len =3D len,
+    };
     struct iovec iov[2];
=20
     if (!se) {
         return -EINVAL;
     }
=20
-    outarg.ino =3D ino;
-    outarg.off =3D off;
-    outarg.len =3D len;
-
     iov[1].iov_base =3D &outarg;
     iov[1].iov_len =3D sizeof(outarg);
=20
@@ -2199,17 +2206,16 @@ int fuse_lowlevel_notify_inval_inode(struct fuse_se=
ssion *se, fuse_ino_t ino,
 int fuse_lowlevel_notify_inval_entry(struct fuse_session *se, fuse_ino_t p=
arent,
                                      const char *name, size_t namelen)
 {
-    struct fuse_notify_inval_entry_out outarg;
+    struct fuse_notify_inval_entry_out outarg =3D {
+        .parent =3D parent,
+        .namelen =3D namelen,
+    };
     struct iovec iov[3];
=20
     if (!se) {
         return -EINVAL;
     }
=20
-    outarg.parent =3D parent;
-    outarg.namelen =3D namelen;
-    outarg.padding =3D 0;
-
     iov[1].iov_base =3D &outarg;
     iov[1].iov_len =3D sizeof(outarg);
     iov[2].iov_base =3D (void *)name;
@@ -2222,18 +2228,17 @@ int fuse_lowlevel_notify_delete(struct fuse_session=
 *se, fuse_ino_t parent,
                                 fuse_ino_t child, const char *name,
                                 size_t namelen)
 {
-    struct fuse_notify_delete_out outarg;
+    struct fuse_notify_delete_out outarg =3D {
+        .parent =3D parent,
+        .child =3D child,
+        .namelen =3D namelen,
+    };
     struct iovec iov[3];
=20
     if (!se) {
         return -EINVAL;
     }
=20
-    outarg.parent =3D parent;
-    outarg.child =3D child;
-    outarg.namelen =3D namelen;
-    outarg.padding =3D 0;
-
     iov[1].iov_base =3D &outarg;
     iov[1].iov_len =3D sizeof(outarg);
     iov[2].iov_base =3D (void *)name;
@@ -2245,24 +2250,21 @@ int fuse_lowlevel_notify_delete(struct fuse_session=
 *se, fuse_ino_t parent,
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
                                off_t offset, struct fuse_bufvec *bufv)
 {
-    struct fuse_out_header out;
-    struct fuse_notify_store_out outarg;
+    struct fuse_out_header out =3D {
+        .error =3D FUSE_NOTIFY_STORE,
+    };
+    struct fuse_notify_store_out outarg =3D {
+        .nodeid =3D ino,
+        .offset =3D offset,
+        .size =3D fuse_buf_size(bufv),
+    };
     struct iovec iov[3];
-    size_t size =3D fuse_buf_size(bufv);
     int res;
=20
     if (!se) {
         return -EINVAL;
     }
=20
-    out.unique =3D 0;
-    out.error =3D FUSE_NOTIFY_STORE;
-
-    outarg.nodeid =3D ino;
-    outarg.offset =3D offset;
-    outarg.size =3D size;
-    outarg.padding =3D 0;
-
     iov[0].iov_base =3D &out;
     iov[0].iov_len =3D sizeof(out);
     iov[1].iov_base =3D &outarg;
--=20
2.24.1


