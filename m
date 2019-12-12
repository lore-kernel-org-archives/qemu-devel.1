Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12213C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C297520637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKBKltld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C297520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRoJ-0001ti-HT
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV8-0005CW-10
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV5-0001IQ-ML
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV5-0001GM-3S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCmVUf8224DmwIH43HB6ENMC0EMkCsu4N/2tgiYschQ=;
 b=RKBKltldlewpw33/ZE9nU+7hotkRwZ6rsU67XJRVKVTROAnQq43cr343/RFzJ+WKno1M7b
 BZXTMMAZwOyqkmIIWGT/07/NgIuywhX0d9OhgDLgRicqQKjngo7ec2HQ4tzHihnbxBpx14
 bOCYASFLHfV1xWyICIkQn0cpwhlsGBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-ss94DHz-Pz6QOVmCutqEcQ-1; Thu, 12 Dec 2019 11:39:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B533477
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70A7060BE1;
 Thu, 12 Dec 2019 16:39:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 012/104] virtiofsd: Trim out compatibility code
Date: Thu, 12 Dec 2019 16:37:32 +0000
Message-Id: <20191212163904.159893-13-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ss94DHz-Pz6QOVmCutqEcQ-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

virtiofsd only supports major=3D7, minor>=3D31; trim out a lot of
old compatibility code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 330 ++++++++++++--------------------
 1 file changed, 119 insertions(+), 211 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 497eb25487..f4bd303a7a 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -387,16 +387,7 @@ static void fill_open(struct fuse_open_out *arg, const=
 struct fuse_file_info *f)
 int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
 {
     struct fuse_entry_out arg;
-    size_t size =3D req->se->conn.proto_minor < 9 ? FUSE_COMPAT_ENTRY_OUT_=
SIZE :
-                                                  sizeof(arg);
-
-    /*
-     * before ABI 7.4 e->ino =3D=3D 0 was invalid, only ENOENT meant
-     * negative entry
-     */
-    if (!e->ino && req->se->conn.proto_minor < 4) {
-        return fuse_reply_err(req, ENOENT);
-    }
+    size_t size =3D sizeof(arg);
=20
     memset(&arg, 0, sizeof(arg));
     fill_entry(&arg, e);
@@ -407,9 +398,7 @@ int fuse_reply_create(fuse_req_t req, const struct fuse=
_entry_param *e,
                       const struct fuse_file_info *f)
 {
     char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)]=
;
-    size_t entrysize =3D req->se->conn.proto_minor < 9 ?
-                           FUSE_COMPAT_ENTRY_OUT_SIZE :
-                           sizeof(struct fuse_entry_out);
+    size_t entrysize =3D sizeof(struct fuse_entry_out);
     struct fuse_entry_out *earg =3D (struct fuse_entry_out *)buf;
     struct fuse_open_out *oarg =3D (struct fuse_open_out *)(buf + entrysiz=
e);
=20
@@ -423,8 +412,7 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *=
attr,
                     double attr_timeout)
 {
     struct fuse_attr_out arg;
-    size_t size =3D
-        req->se->conn.proto_minor < 9 ? FUSE_COMPAT_ATTR_OUT_SIZE : sizeof=
(arg);
+    size_t size =3D sizeof(arg);
=20
     memset(&arg, 0, sizeof(arg));
     arg.attr_valid =3D calc_timeout_sec(attr_timeout);
@@ -521,8 +509,7 @@ int fuse_reply_data(fuse_req_t req, struct fuse_bufvec =
*bufv,
 int fuse_reply_statfs(fuse_req_t req, const struct statvfs *stbuf)
 {
     struct fuse_statfs_out arg;
-    size_t size =3D
-        req->se->conn.proto_minor < 4 ? FUSE_COMPAT_STATFS_SIZE : sizeof(a=
rg);
+    size_t size =3D sizeof(arg);
=20
     memset(&arg, 0, sizeof(arg));
     convert_statfs(stbuf, &arg.st);
@@ -606,45 +593,31 @@ int fuse_reply_ioctl_retry(fuse_req_t req, const stru=
ct iovec *in_iov,
     iov[count].iov_len =3D sizeof(arg);
     count++;
=20
-    if (req->se->conn.proto_minor < 16) {
-        if (in_count) {
-            iov[count].iov_base =3D (void *)in_iov;
-            iov[count].iov_len =3D sizeof(in_iov[0]) * in_count;
-            count++;
-        }
+    /* Can't handle non-compat 64bit ioctls on 32bit */
+    if (sizeof(void *) =3D=3D 4 && req->ioctl_64bit) {
+        res =3D fuse_reply_err(req, EINVAL);
+        goto out;
+    }
=20
-        if (out_count) {
-            iov[count].iov_base =3D (void *)out_iov;
-            iov[count].iov_len =3D sizeof(out_iov[0]) * out_count;
-            count++;
+    if (in_count) {
+        in_fiov =3D fuse_ioctl_iovec_copy(in_iov, in_count);
+        if (!in_fiov) {
+            goto enomem;
         }
-    } else {
-        /* Can't handle non-compat 64bit ioctls on 32bit */
-        if (sizeof(void *) =3D=3D 4 && req->ioctl_64bit) {
-            res =3D fuse_reply_err(req, EINVAL);
-            goto out;
-        }
-
-        if (in_count) {
-            in_fiov =3D fuse_ioctl_iovec_copy(in_iov, in_count);
-            if (!in_fiov) {
-                goto enomem;
-            }
=20
-            iov[count].iov_base =3D (void *)in_fiov;
-            iov[count].iov_len =3D sizeof(in_fiov[0]) * in_count;
-            count++;
+        iov[count].iov_base =3D (void *)in_fiov;
+        iov[count].iov_len =3D sizeof(in_fiov[0]) * in_count;
+        count++;
+    }
+    if (out_count) {
+        out_fiov =3D fuse_ioctl_iovec_copy(out_iov, out_count);
+        if (!out_fiov) {
+            goto enomem;
         }
-        if (out_count) {
-            out_fiov =3D fuse_ioctl_iovec_copy(out_iov, out_count);
-            if (!out_fiov) {
-                goto enomem;
-            }
=20
-            iov[count].iov_base =3D (void *)out_fiov;
-            iov[count].iov_len =3D sizeof(out_fiov[0]) * out_count;
-            count++;
-        }
+        iov[count].iov_base =3D (void *)out_fiov;
+        iov[count].iov_len =3D sizeof(out_fiov[0]) * out_count;
+        count++;
     }
=20
     res =3D send_reply_iov(req, 0, iov, count);
@@ -786,14 +759,12 @@ static void do_getattr(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     struct fuse_file_info *fip =3D NULL;
     struct fuse_file_info fi;
=20
-    if (req->se->conn.proto_minor >=3D 9) {
-        struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *)inarg;
+    struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *)inarg;
=20
-        if (arg->getattr_flags & FUSE_GETATTR_FH) {
-            memset(&fi, 0, sizeof(fi));
-            fi.fh =3D arg->fh;
-            fip =3D &fi;
-        }
+    if (arg->getattr_flags & FUSE_GETATTR_FH) {
+        memset(&fi, 0, sizeof(fi));
+        fi.fh =3D arg->fh;
+        fip =3D &fi;
     }
=20
     if (req->se->op.getattr) {
@@ -858,11 +829,7 @@ static void do_mknod(fuse_req_t req, fuse_ino_t nodeid=
, const void *inarg)
     struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *)inarg;
     char *name =3D PARAM(arg);
=20
-    if (req->se->conn.proto_minor >=3D 12) {
-        req->ctx.umask =3D arg->umask;
-    } else {
-        name =3D (char *)inarg + FUSE_COMPAT_MKNOD_IN_SIZE;
-    }
+    req->ctx.umask =3D arg->umask;
=20
     if (req->se->op.mknod) {
         req->se->op.mknod(req, nodeid, name, arg->mode, arg->rdev);
@@ -875,9 +842,7 @@ static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid,=
 const void *inarg)
 {
     struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *)inarg;
=20
-    if (req->se->conn.proto_minor >=3D 12) {
-        req->ctx.umask =3D arg->umask;
-    }
+    req->ctx.umask =3D arg->umask;
=20
     if (req->se->op.mkdir) {
         req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
@@ -969,11 +934,7 @@ static void do_create(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
         memset(&fi, 0, sizeof(fi));
         fi.flags =3D arg->flags;
=20
-        if (req->se->conn.proto_minor >=3D 12) {
-            req->ctx.umask =3D arg->umask;
-        } else {
-            name =3D (char *)inarg + sizeof(struct fuse_open_in);
-        }
+        req->ctx.umask =3D arg->umask;
=20
         req->se->op.create(req, nodeid, name, arg->mode, &fi);
     } else {
@@ -1005,10 +966,8 @@ static void do_read(fuse_req_t req, fuse_ino_t nodeid=
, const void *inarg)
=20
         memset(&fi, 0, sizeof(fi));
         fi.fh =3D arg->fh;
-        if (req->se->conn.proto_minor >=3D 9) {
-            fi.lock_owner =3D arg->lock_owner;
-            fi.flags =3D arg->flags;
-        }
+        fi.lock_owner =3D arg->lock_owner;
+        fi.flags =3D arg->flags;
         req->se->op.read(req, nodeid, arg->size, arg->offset, &fi);
     } else {
         fuse_reply_err(req, ENOSYS);
@@ -1025,13 +984,9 @@ static void do_write(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     fi.fh =3D arg->fh;
     fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
=20
-    if (req->se->conn.proto_minor < 9) {
-        param =3D ((char *)arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-    } else {
-        fi.lock_owner =3D arg->lock_owner;
-        fi.flags =3D arg->flags;
-        param =3D PARAM(arg);
-    }
+    fi.lock_owner =3D arg->lock_owner;
+    fi.flags =3D arg->flags;
+    param =3D PARAM(arg);
=20
     if (req->se->op.write) {
         req->se->op.write(req, nodeid, param, arg->size, arg->offset, &fi)=
;
@@ -1055,21 +1010,14 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg,
     fi.fh =3D arg->fh;
     fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
=20
-    if (se->conn.proto_minor < 9) {
-        bufv.buf[0].mem =3D ((char *)arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-        bufv.buf[0].size -=3D
-            sizeof(struct fuse_in_header) + FUSE_COMPAT_WRITE_IN_SIZE;
-        assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
-    } else {
-        fi.lock_owner =3D arg->lock_owner;
-        fi.flags =3D arg->flags;
-        if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
-            bufv.buf[0].mem =3D PARAM(arg);
-        }
-
-        bufv.buf[0].size -=3D
-            sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
+    fi.lock_owner =3D arg->lock_owner;
+    fi.flags =3D arg->flags;
+    if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
+        bufv.buf[0].mem =3D PARAM(arg);
     }
+
+    bufv.buf[0].size -=3D
+        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
     if (bufv.buf[0].size < arg->size) {
         fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\=
n");
         fuse_reply_err(req, EIO);
@@ -1088,9 +1036,7 @@ static void do_flush(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.flush =3D 1;
-    if (req->se->conn.proto_minor >=3D 7) {
-        fi.lock_owner =3D arg->lock_owner;
-    }
+    fi.lock_owner =3D arg->lock_owner;
=20
     if (req->se->op.flush) {
         req->se->op.flush(req, nodeid, &fi);
@@ -1107,10 +1053,8 @@ static void do_release(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
     memset(&fi, 0, sizeof(fi));
     fi.flags =3D arg->flags;
     fi.fh =3D arg->fh;
-    if (req->se->conn.proto_minor >=3D 8) {
-        fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
-        fi.lock_owner =3D arg->lock_owner;
-    }
+    fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
+    fi.lock_owner =3D arg->lock_owner;
     if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
         fi.flock_release =3D 1;
         fi.lock_owner =3D arg->lock_owner;
@@ -1479,8 +1423,7 @@ static void do_ioctl(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
-    if (sizeof(void *) =3D=3D 4 && req->se->conn.proto_minor >=3D 16 &&
-        !(flags & FUSE_IOCTL_32BIT)) {
+    if (sizeof(void *) =3D=3D 4 && !(flags & FUSE_IOCTL_32BIT)) {
         req->ioctl_64bit =3D 1;
     }
=20
@@ -1605,7 +1548,7 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid=
, const void *inarg)
     outarg.major =3D FUSE_KERNEL_VERSION;
     outarg.minor =3D FUSE_KERNEL_MINOR_VERSION;
=20
-    if (arg->major < 7) {
+    if (arg->major < 7 || (arg->major =3D=3D 7 && arg->minor < 31)) {
         fuse_log(FUSE_LOG_ERR, "fuse: unsupported protocol version: %u.%u\=
n",
                  arg->major, arg->minor);
         fuse_reply_err(req, EPROTO);
@@ -1618,81 +1561,71 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
         return;
     }
=20
-    if (arg->minor >=3D 6) {
-        if (arg->max_readahead < se->conn.max_readahead) {
-            se->conn.max_readahead =3D arg->max_readahead;
-        }
-        if (arg->flags & FUSE_ASYNC_READ) {
-            se->conn.capable |=3D FUSE_CAP_ASYNC_READ;
-        }
-        if (arg->flags & FUSE_POSIX_LOCKS) {
-            se->conn.capable |=3D FUSE_CAP_POSIX_LOCKS;
-        }
-        if (arg->flags & FUSE_ATOMIC_O_TRUNC) {
-            se->conn.capable |=3D FUSE_CAP_ATOMIC_O_TRUNC;
-        }
-        if (arg->flags & FUSE_EXPORT_SUPPORT) {
-            se->conn.capable |=3D FUSE_CAP_EXPORT_SUPPORT;
-        }
-        if (arg->flags & FUSE_DONT_MASK) {
-            se->conn.capable |=3D FUSE_CAP_DONT_MASK;
-        }
-        if (arg->flags & FUSE_FLOCK_LOCKS) {
-            se->conn.capable |=3D FUSE_CAP_FLOCK_LOCKS;
-        }
-        if (arg->flags & FUSE_AUTO_INVAL_DATA) {
-            se->conn.capable |=3D FUSE_CAP_AUTO_INVAL_DATA;
-        }
-        if (arg->flags & FUSE_DO_READDIRPLUS) {
-            se->conn.capable |=3D FUSE_CAP_READDIRPLUS;
-        }
-        if (arg->flags & FUSE_READDIRPLUS_AUTO) {
-            se->conn.capable |=3D FUSE_CAP_READDIRPLUS_AUTO;
-        }
-        if (arg->flags & FUSE_ASYNC_DIO) {
-            se->conn.capable |=3D FUSE_CAP_ASYNC_DIO;
-        }
-        if (arg->flags & FUSE_WRITEBACK_CACHE) {
-            se->conn.capable |=3D FUSE_CAP_WRITEBACK_CACHE;
-        }
-        if (arg->flags & FUSE_NO_OPEN_SUPPORT) {
-            se->conn.capable |=3D FUSE_CAP_NO_OPEN_SUPPORT;
-        }
-        if (arg->flags & FUSE_PARALLEL_DIROPS) {
-            se->conn.capable |=3D FUSE_CAP_PARALLEL_DIROPS;
-        }
-        if (arg->flags & FUSE_POSIX_ACL) {
-            se->conn.capable |=3D FUSE_CAP_POSIX_ACL;
-        }
-        if (arg->flags & FUSE_HANDLE_KILLPRIV) {
-            se->conn.capable |=3D FUSE_CAP_HANDLE_KILLPRIV;
-        }
-        if (arg->flags & FUSE_NO_OPENDIR_SUPPORT) {
-            se->conn.capable |=3D FUSE_CAP_NO_OPENDIR_SUPPORT;
-        }
-        if (!(arg->flags & FUSE_MAX_PAGES)) {
-            size_t max_bufsize =3D
-                FUSE_DEFAULT_MAX_PAGES_PER_REQ * getpagesize() +
-                FUSE_BUFFER_HEADER_SIZE;
-            if (bufsize > max_bufsize) {
-                bufsize =3D max_bufsize;
-            }
+    if (arg->max_readahead < se->conn.max_readahead) {
+        se->conn.max_readahead =3D arg->max_readahead;
+    }
+    if (arg->flags & FUSE_ASYNC_READ) {
+        se->conn.capable |=3D FUSE_CAP_ASYNC_READ;
+    }
+    if (arg->flags & FUSE_POSIX_LOCKS) {
+        se->conn.capable |=3D FUSE_CAP_POSIX_LOCKS;
+    }
+    if (arg->flags & FUSE_ATOMIC_O_TRUNC) {
+        se->conn.capable |=3D FUSE_CAP_ATOMIC_O_TRUNC;
+    }
+    if (arg->flags & FUSE_EXPORT_SUPPORT) {
+        se->conn.capable |=3D FUSE_CAP_EXPORT_SUPPORT;
+    }
+    if (arg->flags & FUSE_DONT_MASK) {
+        se->conn.capable |=3D FUSE_CAP_DONT_MASK;
+    }
+    if (arg->flags & FUSE_FLOCK_LOCKS) {
+        se->conn.capable |=3D FUSE_CAP_FLOCK_LOCKS;
+    }
+    if (arg->flags & FUSE_AUTO_INVAL_DATA) {
+        se->conn.capable |=3D FUSE_CAP_AUTO_INVAL_DATA;
+    }
+    if (arg->flags & FUSE_DO_READDIRPLUS) {
+        se->conn.capable |=3D FUSE_CAP_READDIRPLUS;
+    }
+    if (arg->flags & FUSE_READDIRPLUS_AUTO) {
+        se->conn.capable |=3D FUSE_CAP_READDIRPLUS_AUTO;
+    }
+    if (arg->flags & FUSE_ASYNC_DIO) {
+        se->conn.capable |=3D FUSE_CAP_ASYNC_DIO;
+    }
+    if (arg->flags & FUSE_WRITEBACK_CACHE) {
+        se->conn.capable |=3D FUSE_CAP_WRITEBACK_CACHE;
+    }
+    if (arg->flags & FUSE_NO_OPEN_SUPPORT) {
+        se->conn.capable |=3D FUSE_CAP_NO_OPEN_SUPPORT;
+    }
+    if (arg->flags & FUSE_PARALLEL_DIROPS) {
+        se->conn.capable |=3D FUSE_CAP_PARALLEL_DIROPS;
+    }
+    if (arg->flags & FUSE_POSIX_ACL) {
+        se->conn.capable |=3D FUSE_CAP_POSIX_ACL;
+    }
+    if (arg->flags & FUSE_HANDLE_KILLPRIV) {
+        se->conn.capable |=3D FUSE_CAP_HANDLE_KILLPRIV;
+    }
+    if (arg->flags & FUSE_NO_OPENDIR_SUPPORT) {
+        se->conn.capable |=3D FUSE_CAP_NO_OPENDIR_SUPPORT;
+    }
+    if (!(arg->flags & FUSE_MAX_PAGES)) {
+        size_t max_bufsize =3D FUSE_DEFAULT_MAX_PAGES_PER_REQ * getpagesiz=
e() +
+                             FUSE_BUFFER_HEADER_SIZE;
+        if (bufsize > max_bufsize) {
+            bufsize =3D max_bufsize;
         }
-    } else {
-        se->conn.max_readahead =3D 0;
     }
-
-    if (se->conn.proto_minor >=3D 14) {
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
-        se->conn.capable |=3D FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE=
;
+    se->conn.capable |=3D FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
 #endif
-        se->conn.capable |=3D FUSE_CAP_SPLICE_READ;
+    se->conn.capable |=3D FUSE_CAP_SPLICE_READ;
 #endif
-    }
-    if (se->conn.proto_minor >=3D 18) {
-        se->conn.capable |=3D FUSE_CAP_IOCTL_DIR;
-    }
+    se->conn.capable |=3D FUSE_CAP_IOCTL_DIR;
=20
     /*
      * Default settings for modern filesystems.
@@ -1799,24 +1732,20 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     }
     outarg.max_readahead =3D se->conn.max_readahead;
     outarg.max_write =3D se->conn.max_write;
-    if (se->conn.proto_minor >=3D 13) {
-        if (se->conn.max_background >=3D (1 << 16)) {
-            se->conn.max_background =3D (1 << 16) - 1;
-        }
-        if (se->conn.congestion_threshold > se->conn.max_background) {
-            se->conn.congestion_threshold =3D se->conn.max_background;
-        }
-        if (!se->conn.congestion_threshold) {
-            se->conn.congestion_threshold =3D se->conn.max_background * 3 =
/ 4;
-        }
-
-        outarg.max_background =3D se->conn.max_background;
-        outarg.congestion_threshold =3D se->conn.congestion_threshold;
+    if (se->conn.max_background >=3D (1 << 16)) {
+        se->conn.max_background =3D (1 << 16) - 1;
+    }
+    if (se->conn.congestion_threshold > se->conn.max_background) {
+        se->conn.congestion_threshold =3D se->conn.max_background;
     }
-    if (se->conn.proto_minor >=3D 23) {
-        outarg.time_gran =3D se->conn.time_gran;
+    if (!se->conn.congestion_threshold) {
+        se->conn.congestion_threshold =3D se->conn.max_background * 3 / 4;
     }
=20
+    outarg.max_background =3D se->conn.max_background;
+    outarg.congestion_threshold =3D se->conn.congestion_threshold;
+    outarg.time_gran =3D se->conn.time_gran;
+
     if (se->debug) {
         fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major,
                  outarg.minor);
@@ -1830,11 +1759,6 @@ static void do_init(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
                  outarg.congestion_threshold);
         fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n", outarg.time_gran);
     }
-    if (arg->minor < 5) {
-        outargsize =3D FUSE_COMPAT_INIT_OUT_SIZE;
-    } else if (arg->minor < 23) {
-        outargsize =3D FUSE_COMPAT_22_INIT_OUT_SIZE;
-    }
=20
     send_reply_ok(req, &outarg, outargsize);
 }
@@ -1898,10 +1822,6 @@ int fuse_lowlevel_notify_inval_inode(struct fuse_ses=
sion *se, fuse_ino_t ino,
         return -EINVAL;
     }
=20
-    if (se->conn.proto_major < 6 || se->conn.proto_minor < 12) {
-        return -ENOSYS;
-    }
-
     outarg.ino =3D ino;
     outarg.off =3D off;
     outarg.len =3D len;
@@ -1922,10 +1842,6 @@ int fuse_lowlevel_notify_inval_entry(struct fuse_ses=
sion *se, fuse_ino_t parent,
         return -EINVAL;
     }
=20
-    if (se->conn.proto_major < 6 || se->conn.proto_minor < 12) {
-        return -ENOSYS;
-    }
-
     outarg.parent =3D parent;
     outarg.namelen =3D namelen;
     outarg.padding =3D 0;
@@ -1949,10 +1865,6 @@ int fuse_lowlevel_notify_delete(struct fuse_session =
*se, fuse_ino_t parent,
         return -EINVAL;
     }
=20
-    if (se->conn.proto_major < 6 || se->conn.proto_minor < 18) {
-        return -ENOSYS;
-    }
-
     outarg.parent =3D parent;
     outarg.child =3D child;
     outarg.namelen =3D namelen;
@@ -1980,10 +1892,6 @@ int fuse_lowlevel_notify_store(struct fuse_session *=
se, fuse_ino_t ino,
         return -EINVAL;
     }
=20
-    if (se->conn.proto_major < 6 || se->conn.proto_minor < 15) {
-        return -ENOSYS;
-    }
-
     out.unique =3D 0;
     out.error =3D FUSE_NOTIFY_STORE;
=20
--=20
2.23.0


