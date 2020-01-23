Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E3C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95ED20661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+mlvYtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95ED20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucr1-00041P-K6
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9D-0002Z0-6S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9B-0005GU-7B
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9B-0005GC-2y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFhPfwtVv7yoI9jiTVqFEbmigwfVon3/b2ojAgSPGX0=;
 b=E+mlvYtm+s4vRJFFpIkn35FbBjlngp8X6FRgUz+25kLnMNxHOJFGT3znWhBY81jHGeFrpt
 XA9/P2BFKbZmbc+OT1VUHDPHpN3lqOXwJys/BX+Bktlvgio6zPH5TXaCbG6vX6I/w3qO80
 VO9C4V6+gPVc/UHpojMbVsq2GicSfqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-hir1XKHVM7-RuN2NCK8DOA-1; Thu, 23 Jan 2020 06:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5D31088382
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3EB81CB;
 Thu, 23 Jan 2020 11:59:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 039/111] virtiofsd: passthrough_ll: add fallback for racy ops
Date: Thu, 23 Jan 2020 11:57:29 +0000
Message-Id: <20200123115841.138849-40-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hir1XKHVM7-RuN2NCK8DOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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

From: Miklos Szeredi <mszeredi@redhat.com>

We have two operations that cannot be done race-free on a symlink in
certain cases: utimes and link.

Add racy fallback for these if the race-free method doesn't work.  We do
our best to avoid races even in this case:

  - get absolute path by reading /proc/self/fd/NN symlink

  - lookup parent directory: after this we are safe against renames in
    ancestors

  - lookup name in parent directory, and verify that we got to the original
    inode,  if not retry the whole thing

Both utimes(2) and link(2) hold i_lock on the inode across the operation,
so a racing rename/delete by this fuse instance is not possible, only from
other entities changing the filesystem.

If the "norace" option is given, then disable the racy fallbacks.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c         |   5 +-
 tools/virtiofsd/passthrough_ll.c | 157 +++++++++++++++++++++++++++----
 2 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index b8ec5ac8dc..5531425223 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -142,7 +142,10 @@ void fuse_cmdline_help(void)
            "    --daemonize                run in background\n"
            "    -o max_idle_threads        the maximum number of idle work=
er "
            "threads\n"
-           "                               allowed (default: 10)\n");
+           "                               allowed (default: 10)\n"
+           "    -o norace                  disable racy fallback\n"
+           "                               default: false\n"
+          );
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 9815bfa5c5..ac380efcb1 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -98,6 +98,7 @@ enum {
 struct lo_data {
     pthread_mutex_t mutex;
     int debug;
+    int norace;
     int writeback;
     int flock;
     int xattr;
@@ -124,10 +125,15 @@ static const struct fuse_opt lo_opts[] =3D {
     { "cache=3Dnever", offsetof(struct lo_data, cache), CACHE_NEVER },
     { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
     { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS },
-
+    { "norace", offsetof(struct lo_data, norace), 1 },
     FUSE_OPT_END
 };
=20
+static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
+
+static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
+
+
 static struct lo_data *lo_data(fuse_req_t req)
 {
     return (struct lo_data *)fuse_req_userdata(req);
@@ -347,23 +353,127 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t in=
o,
     fuse_reply_attr(req, &buf, lo->timeout);
 }
=20
-static int utimensat_empty_nofollow(struct lo_inode *inode,
-                                    const struct timespec *tv)
+static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
+                              char path[PATH_MAX], struct lo_inode **paren=
t)
 {
-    int res;
     char procname[64];
+    char *last;
+    struct stat stat;
+    struct lo_inode *p;
+    int retries =3D 2;
+    int res;
+
+retry:
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+    res =3D readlink(procname, path, PATH_MAX);
+    if (res < 0) {
+        fuse_log(FUSE_LOG_WARNING, "%s: readlink failed: %m\n", __func__);
+        goto fail_noretry;
+    }
+
+    if (res >=3D PATH_MAX) {
+        fuse_log(FUSE_LOG_WARNING, "%s: readlink overflowed\n", __func__);
+        goto fail_noretry;
+    }
+    path[res] =3D '\0';
+
+    last =3D strrchr(path, '/');
+    if (last =3D=3D NULL) {
+        /* Shouldn't happen */
+        fuse_log(
+            FUSE_LOG_WARNING,
+            "%s: INTERNAL ERROR: bad path read from proc\n", __func__);
+        goto fail_noretry;
+    }
+    if (last =3D=3D path) {
+        p =3D &lo->root;
+        pthread_mutex_lock(&lo->mutex);
+        p->refcount++;
+        pthread_mutex_unlock(&lo->mutex);
+    } else {
+        *last =3D '\0';
+        res =3D fstatat(AT_FDCWD, last =3D=3D path ? "/" : path, &stat, 0)=
;
+        if (res =3D=3D -1) {
+            if (!retries) {
+                fuse_log(FUSE_LOG_WARNING,
+                         "%s: failed to stat parent: %m\n", __func__);
+            }
+            goto fail;
+        }
+        p =3D lo_find(lo, &stat);
+        if (p =3D=3D NULL) {
+            if (!retries) {
+                fuse_log(FUSE_LOG_WARNING,
+                         "%s: failed to find parent\n", __func__);
+            }
+            goto fail;
+        }
+    }
+    last++;
+    res =3D fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
+    if (res =3D=3D -1) {
+        if (!retries) {
+            fuse_log(FUSE_LOG_WARNING,
+                     "%s: failed to stat last\n", __func__);
+        }
+        goto fail_unref;
+    }
+    if (stat.st_dev !=3D inode->dev || stat.st_ino !=3D inode->ino) {
+        if (!retries) {
+            fuse_log(FUSE_LOG_WARNING,
+                     "%s: failed to match last\n", __func__);
+        }
+        goto fail_unref;
+    }
+    *parent =3D p;
+    memmove(path, last, strlen(last) + 1);
+
+    return 0;
+
+fail_unref:
+    unref_inode(lo, p, 1);
+fail:
+    if (retries) {
+        retries--;
+        goto retry;
+    }
+fail_noretry:
+    errno =3D EIO;
+    return -1;
+}
+
+static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
+                           const struct timespec *tv)
+{
+    int res;
+    struct lo_inode *parent;
+    char path[PATH_MAX];
=20
     if (inode->is_symlink) {
-        res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH | AT_SYMLINK_NO=
FOLLOW);
+        res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
         if (res =3D=3D -1 && errno =3D=3D EINVAL) {
             /* Sorry, no race free way to set times on symlink. */
-            errno =3D EPERM;
+            if (lo->norace) {
+                errno =3D EPERM;
+            } else {
+                goto fallback;
+            }
         }
         return res;
     }
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(path, "/proc/self/fd/%i", inode->fd);
=20
-    return utimensat(AT_FDCWD, procname, tv, 0);
+    return utimensat(AT_FDCWD, path, tv, 0);
+
+fallback:
+    res =3D lo_parent_and_name(lo, inode, path, &parent);
+    if (res !=3D -1) {
+        res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
+        unref_inode(lo, parent, 1);
+    }
+
+    return res;
 }
=20
 static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
@@ -387,6 +497,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 {
     int saverr;
     char procname[64];
+    struct lo_data *lo =3D lo_data(req);
     struct lo_inode *inode;
     int ifd;
     int res;
@@ -459,7 +570,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
         if (fi) {
             res =3D futimens(fd, tv);
         } else {
-            res =3D utimensat_empty_nofollow(inode, tv);
+            res =3D utimensat_empty(lo, inode, tv);
         }
         if (res =3D=3D -1) {
             goto out_err;
@@ -709,24 +820,38 @@ static void lo_symlink(fuse_req_t req, const char *li=
nk, fuse_ino_t parent,
     lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
 }
=20
-static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
-                                 const char *name)
+static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *inod=
e,
+                                 int dfd, const char *name)
 {
     int res;
-    char procname[64];
+    struct lo_inode *parent;
+    char path[PATH_MAX];
=20
     if (inode->is_symlink) {
         res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
         if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL))=
 {
             /* Sorry, no race free way to hard-link a symlink. */
-            errno =3D EPERM;
+            if (lo->norace) {
+                errno =3D EPERM;
+            } else {
+                goto fallback;
+            }
         }
         return res;
     }
=20
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(path, "/proc/self/fd/%i", inode->fd);
+
+    return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
+
+fallback:
+    res =3D lo_parent_and_name(lo, inode, path, &parent);
+    if (res !=3D -1) {
+        res =3D linkat(parent->fd, path, dfd, name, 0);
+        unref_inode(lo, parent, 1);
+    }
=20
-    return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
+    return res;
 }
=20
 static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
@@ -748,7 +873,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fus=
e_ino_t parent,
     e.attr_timeout =3D lo->timeout;
     e.entry_timeout =3D lo->timeout;
=20
-    res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
+    res =3D linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name);
     if (res =3D=3D -1) {
         goto out_err;
     }
--=20
2.24.1


