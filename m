Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBEAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96ADE21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftcvfF76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ADE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRZA-0001uf-Su
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUs-0004t1-Vk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUo-0000pa-Hi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUo-0000nz-5d
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzOM6eGZnV0aoZEdRS5RE6InPK3sxKyglbF0uK+ldrs=;
 b=ftcvfF76rGlVEF9I4i1NT3rX9LZk/Lgg48/5wn4dP5VU6Exj5DDfGopg0XUnkNkROpDhv2
 rPExweb+9RpmRl1c1EtINcFdbEM/W1O5JXpAs9atM4KXaJiliCgoHnV3w7vtDitS/yTEwZ
 5I3rgPQFFwfqHDnLm2nuLNb0e/Z+ysU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-BiQvt73cOw2jRs5BGlz2mw-1; Thu, 12 Dec 2019 11:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A15311005510
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C535060BE1;
 Thu, 12 Dec 2019 16:39:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 005/104] virtiofsd: Add passthrough_ll
Date: Thu, 12 Dec 2019 16:37:25 +0000
Message-Id: <20191212163904.159893-6-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BiQvt73cOw2jRs5BGlz2mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

passthrough_ll is one of the examples in the upstream fuse project
and is the main part of our daemon here.  It passes through requests
from fuse to the underlying filesystem, using syscalls as directly
as possible.

From libfuse fuse-3.8.0

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 1338 ++++++++++++++++++++++++++++++
 1 file changed, 1338 insertions(+)
 create mode 100644 tools/virtiofsd/passthrough_ll.c

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
new file mode 100644
index 0000000000..5372d02934
--- /dev/null
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -0,0 +1,1338 @@
+/*
+  FUSE: Filesystem in Userspace
+  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+
+  This program can be distributed under the terms of the GNU GPL.
+  See the file COPYING.
+*/
+
+/** @file
+ *
+ * This file system mirrors the existing file system hierarchy of the
+ * system, starting at the root file system. This is implemented by
+ * just "passing through" all requests to the corresponding user-space
+ * libc functions. In contrast to passthrough.c and passthrough_fh.c,
+ * this implementation uses the low-level API. Its performance should
+ * be the least bad among the three, but many operations are not
+ * implemented. In particular, it is not possible to remove files (or
+ * directories) because the code necessary to defer actual removal
+ * until the file is not opened anymore would make the example much
+ * more complicated.
+ *
+ * When writeback caching is enabled (-o writeback mount option), it
+ * is only possible to write to files for which the mounting user has
+ * read permissions. This is because the writeback cache requires the
+ * kernel to be able to issue read requests for all files (which the
+ * passthrough filesystem cannot satisfy if it can't read the file in
+ * the underlying filesystem).
+ *
+ * Compile with:
+ *
+ *     gcc -Wall passthrough_ll.c `pkg-config fuse3 --cflags --libs` -o pa=
ssthrough_ll
+ *
+ * ## Source code ##
+ * \include passthrough_ll.c
+ */
+
+#define _GNU_SOURCE
+#define FUSE_USE_VERSION 31
+
+#include "config.h"
+
+#include <fuse_lowlevel.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <stdbool.h>
+#include <string.h>
+#include <limits.h>
+#include <dirent.h>
+#include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <sys/file.h>
+#include <sys/xattr.h>
+
+#include "passthrough_helpers.h"
+
+/* We are re-using pointers to our `struct lo_inode` and `struct
+   lo_dirp` elements as inodes. This means that we must be able to
+   store uintptr_t values in a fuse_ino_t variable. The following
+   incantation checks this condition at compile time. */
+#if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
+_Static_assert(sizeof(fuse_ino_t) >=3D sizeof(uintptr_t),
+=09       "fuse_ino_t too small to hold uintptr_t values!");
+#else
+struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct \
+=09{ unsigned _uintptr_to_must_hold_fuse_ino_t:
+=09=09=09((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1); };
+#endif
+
+struct lo_inode {
+=09struct lo_inode *next; /* protected by lo->mutex */
+=09struct lo_inode *prev; /* protected by lo->mutex */
+=09int fd;
+=09bool is_symlink;
+=09ino_t ino;
+=09dev_t dev;
+=09uint64_t refcount; /* protected by lo->mutex */
+};
+
+enum {
+=09CACHE_NEVER,
+=09CACHE_NORMAL,
+=09CACHE_ALWAYS,
+};
+
+struct lo_data {
+=09pthread_mutex_t mutex;
+=09int debug;
+=09int writeback;
+=09int flock;
+=09int xattr;
+=09const char *source;
+=09double timeout;
+=09int cache;
+=09int timeout_set;
+=09struct lo_inode root; /* protected by lo->mutex */
+};
+
+static const struct fuse_opt lo_opts[] =3D {
+=09{ "writeback",
+=09  offsetof(struct lo_data, writeback), 1 },
+=09{ "no_writeback",
+=09  offsetof(struct lo_data, writeback), 0 },
+=09{ "source=3D%s",
+=09  offsetof(struct lo_data, source), 0 },
+=09{ "flock",
+=09  offsetof(struct lo_data, flock), 1 },
+=09{ "no_flock",
+=09  offsetof(struct lo_data, flock), 0 },
+=09{ "xattr",
+=09  offsetof(struct lo_data, xattr), 1 },
+=09{ "no_xattr",
+=09  offsetof(struct lo_data, xattr), 0 },
+=09{ "timeout=3D%lf",
+=09  offsetof(struct lo_data, timeout), 0 },
+=09{ "timeout=3D",
+=09  offsetof(struct lo_data, timeout_set), 1 },
+=09{ "cache=3Dnever",
+=09  offsetof(struct lo_data, cache), CACHE_NEVER },
+=09{ "cache=3Dauto",
+=09  offsetof(struct lo_data, cache), CACHE_NORMAL },
+=09{ "cache=3Dalways",
+=09  offsetof(struct lo_data, cache), CACHE_ALWAYS },
+
+=09FUSE_OPT_END
+};
+
+static struct lo_data *lo_data(fuse_req_t req)
+{
+=09return (struct lo_data *) fuse_req_userdata(req);
+}
+
+static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
+{
+=09if (ino =3D=3D FUSE_ROOT_ID)
+=09=09return &lo_data(req)->root;
+=09else
+=09=09return (struct lo_inode *) (uintptr_t) ino;
+}
+
+static int lo_fd(fuse_req_t req, fuse_ino_t ino)
+{
+=09return lo_inode(req, ino)->fd;
+}
+
+static bool lo_debug(fuse_req_t req)
+{
+=09return lo_data(req)->debug !=3D 0;
+}
+
+static void lo_init(void *userdata,
+=09=09    struct fuse_conn_info *conn)
+{
+=09struct lo_data *lo =3D (struct lo_data*) userdata;
+
+=09if(conn->capable & FUSE_CAP_EXPORT_SUPPORT)
+=09=09conn->want |=3D FUSE_CAP_EXPORT_SUPPORT;
+
+=09if (lo->writeback &&
+=09    conn->capable & FUSE_CAP_WRITEBACK_CACHE) {
+=09=09if (lo->debug)
+=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
+=09=09conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
+=09}
+=09if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
+=09=09if (lo->debug)
+=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
+=09=09conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
+=09}
+}
+
+static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
+=09=09=09     struct fuse_file_info *fi)
+{
+=09int res;
+=09struct stat buf;
+=09struct lo_data *lo =3D lo_data(req);
+
+=09(void) fi;
+
+=09res =3D fstatat(lo_fd(req, ino), "", &buf, AT_EMPTY_PATH | AT_SYMLINK_N=
OFOLLOW);
+=09if (res =3D=3D -1)
+=09=09return (void) fuse_reply_err(req, errno);
+
+=09fuse_reply_attr(req, &buf, lo->timeout);
+}
+
+static int utimensat_empty_nofollow(struct lo_inode *inode,
+=09=09=09=09    const struct timespec *tv)
+{
+=09int res;
+=09char procname[64];
+
+=09if (inode->is_symlink) {
+=09=09res =3D utimensat(inode->fd, "", tv,
+=09=09=09=09AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+=09=09if (res =3D=3D -1 && errno =3D=3D EINVAL) {
+=09=09=09/* Sorry, no race free way to set times on symlink. */
+=09=09=09errno =3D EPERM;
+=09=09}
+=09=09return res;
+=09}
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09return utimensat(AT_FDCWD, procname, tv, 0);
+}
+
+static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
+=09=09       int valid, struct fuse_file_info *fi)
+{
+=09int saverr;
+=09char procname[64];
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09int ifd =3D inode->fd;
+=09int res;
+
+=09if (valid & FUSE_SET_ATTR_MODE) {
+=09=09if (fi) {
+=09=09=09res =3D fchmod(fi->fh, attr->st_mode);
+=09=09} else {
+=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
+=09=09=09res =3D chmod(procname, attr->st_mode);
+=09=09}
+=09=09if (res =3D=3D -1)
+=09=09=09goto out_err;
+=09}
+=09if (valid & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID)) {
+=09=09uid_t uid =3D (valid & FUSE_SET_ATTR_UID) ?
+=09=09=09attr->st_uid : (uid_t) -1;
+=09=09gid_t gid =3D (valid & FUSE_SET_ATTR_GID) ?
+=09=09=09attr->st_gid : (gid_t) -1;
+
+=09=09res =3D fchownat(ifd, "", uid, gid,
+=09=09=09       AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+=09=09if (res =3D=3D -1)
+=09=09=09goto out_err;
+=09}
+=09if (valid & FUSE_SET_ATTR_SIZE) {
+=09=09if (fi) {
+=09=09=09res =3D ftruncate(fi->fh, attr->st_size);
+=09=09} else {
+=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
+=09=09=09res =3D truncate(procname, attr->st_size);
+=09=09}
+=09=09if (res =3D=3D -1)
+=09=09=09goto out_err;
+=09}
+=09if (valid & (FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME)) {
+=09=09struct timespec tv[2];
+
+=09=09tv[0].tv_sec =3D 0;
+=09=09tv[1].tv_sec =3D 0;
+=09=09tv[0].tv_nsec =3D UTIME_OMIT;
+=09=09tv[1].tv_nsec =3D UTIME_OMIT;
+
+=09=09if (valid & FUSE_SET_ATTR_ATIME_NOW)
+=09=09=09tv[0].tv_nsec =3D UTIME_NOW;
+=09=09else if (valid & FUSE_SET_ATTR_ATIME)
+=09=09=09tv[0] =3D attr->st_atim;
+
+=09=09if (valid & FUSE_SET_ATTR_MTIME_NOW)
+=09=09=09tv[1].tv_nsec =3D UTIME_NOW;
+=09=09else if (valid & FUSE_SET_ATTR_MTIME)
+=09=09=09tv[1] =3D attr->st_mtim;
+
+=09=09if (fi)
+=09=09=09res =3D futimens(fi->fh, tv);
+=09=09else
+=09=09=09res =3D utimensat_empty_nofollow(inode, tv);
+=09=09if (res =3D=3D -1)
+=09=09=09goto out_err;
+=09}
+
+=09return lo_getattr(req, ino, fi);
+
+out_err:
+=09saverr =3D errno;
+=09fuse_reply_err(req, saverr);
+}
+
+static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st)
+{
+=09struct lo_inode *p;
+=09struct lo_inode *ret =3D NULL;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09for (p =3D lo->root.next; p !=3D &lo->root; p =3D p->next) {
+=09=09if (p->ino =3D=3D st->st_ino && p->dev =3D=3D st->st_dev) {
+=09=09=09assert(p->refcount > 0);
+=09=09=09ret =3D p;
+=09=09=09ret->refcount++;
+=09=09=09break;
+=09=09}
+=09}
+=09pthread_mutex_unlock(&lo->mutex);
+=09return ret;
+}
+
+static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
+=09=09=09 struct fuse_entry_param *e)
+{
+=09int newfd;
+=09int res;
+=09int saverr;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_inode *inode;
+
+=09memset(e, 0, sizeof(*e));
+=09e->attr_timeout =3D lo->timeout;
+=09e->entry_timeout =3D lo->timeout;
+
+=09newfd =3D openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
+=09if (newfd =3D=3D -1)
+=09=09goto out_err;
+
+=09res =3D fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLO=
W);
+=09if (res =3D=3D -1)
+=09=09goto out_err;
+
+=09inode =3D lo_find(lo_data(req), &e->attr);
+=09if (inode) {
+=09=09close(newfd);
+=09=09newfd =3D -1;
+=09} else {
+=09=09struct lo_inode *prev, *next;
+
+=09=09saverr =3D ENOMEM;
+=09=09inode =3D calloc(1, sizeof(struct lo_inode));
+=09=09if (!inode)
+=09=09=09goto out_err;
+
+=09=09inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
+=09=09inode->refcount =3D 1;
+=09=09inode->fd =3D newfd;
+=09=09inode->ino =3D e->attr.st_ino;
+=09=09inode->dev =3D e->attr.st_dev;
+
+=09=09pthread_mutex_lock(&lo->mutex);
+=09=09prev =3D &lo->root;
+=09=09next =3D prev->next;
+=09=09next->prev =3D inode;
+=09=09inode->next =3D next;
+=09=09inode->prev =3D prev;
+=09=09prev->next =3D inode;
+=09=09pthread_mutex_unlock(&lo->mutex);
+=09}
+=09e->ino =3D (uintptr_t) inode;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09=09(unsigned long long) parent, name, (unsigned long long) e->ino);
+
+=09return 0;
+
+out_err:
+=09saverr =3D errno;
+=09if (newfd !=3D -1)
+=09=09close(newfd);
+=09return saverr;
+}
+
+static void lo_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+=09struct fuse_entry_param e;
+=09int err;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)=
\n",
+=09=09=09parent, name);
+
+=09err =3D lo_do_lookup(req, parent, name, &e);
+=09if (err)
+=09=09fuse_reply_err(req, err);
+=09else
+=09=09fuse_reply_entry(req, &e);
+}
+
+static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
+=09=09=09     const char *name, mode_t mode, dev_t rdev,
+=09=09=09     const char *link)
+{
+=09int res;
+=09int saverr;
+=09struct lo_inode *dir =3D lo_inode(req, parent);
+=09struct fuse_entry_param e;
+
+=09saverr =3D ENOMEM;
+
+=09res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
+
+=09saverr =3D errno;
+=09if (res =3D=3D -1)
+=09=09goto out;
+
+=09saverr =3D lo_do_lookup(req, parent, name, &e);
+=09if (saverr)
+=09=09goto out;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09=09(unsigned long long) parent, name, (unsigned long long) e.ino);
+
+=09fuse_reply_entry(req, &e);
+=09return;
+
+out:
+=09fuse_reply_err(req, saverr);
+}
+
+static void lo_mknod(fuse_req_t req, fuse_ino_t parent,
+=09=09     const char *name, mode_t mode, dev_t rdev)
+{
+=09lo_mknod_symlink(req, parent, name, mode, rdev, NULL);
+}
+
+static void lo_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09     mode_t mode)
+{
+=09lo_mknod_symlink(req, parent, name, S_IFDIR | mode, 0, NULL);
+}
+
+static void lo_symlink(fuse_req_t req, const char *link,
+=09=09       fuse_ino_t parent, const char *name)
+{
+=09lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
+}
+
+static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
+=09=09=09=09 const char *name)
+{
+=09int res;
+=09char procname[64];
+
+=09if (inode->is_symlink) {
+=09=09res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
+=09=09if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
+=09=09=09/* Sorry, no race free way to hard-link a symlink. */
+=09=09=09errno =3D EPERM;
+=09=09}
+=09=09return res;
+=09}
+
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
+}
+
+static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
+=09=09    const char *name)
+{
+=09int res;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct fuse_entry_param e;
+=09int saverr;
+
+=09memset(&e, 0, sizeof(struct fuse_entry_param));
+=09e.attr_timeout =3D lo->timeout;
+=09e.entry_timeout =3D lo->timeout;
+
+=09res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
+=09if (res =3D=3D -1)
+=09=09goto out_err;
+
+=09res =3D fstatat(inode->fd, "", &e.attr, AT_EMPTY_PATH | AT_SYMLINK_NOFO=
LLOW);
+=09if (res =3D=3D -1)
+=09=09goto out_err;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09inode->refcount++;
+=09pthread_mutex_unlock(&lo->mutex);
+=09e.ino =3D (uintptr_t) inode;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+=09=09=09(unsigned long long) parent, name,
+=09=09=09(unsigned long long) e.ino);
+
+=09fuse_reply_entry(req, &e);
+=09return;
+
+out_err:
+=09saverr =3D errno;
+=09fuse_reply_err(req, saverr);
+}
+
+static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+=09int res;
+
+=09res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
+
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09      fuse_ino_t newparent, const char *newname,
+=09=09      unsigned int flags)
+{
+=09int res;
+
+=09if (flags) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09res =3D renameat(lo_fd(req, parent), name,
+=09=09=09lo_fd(req, newparent), newname);
+
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *name)
+{
+=09int res;
+
+=09res =3D unlinkat(lo_fd(req, parent), name, 0);
+
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n)
+{
+=09if (!inode)
+=09=09return;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09assert(inode->refcount >=3D n);
+=09inode->refcount -=3D n;
+=09if (!inode->refcount) {
+=09=09struct lo_inode *prev, *next;
+
+=09=09prev =3D inode->prev;
+=09=09next =3D inode->next;
+=09=09next->prev =3D prev;
+=09=09prev->next =3D next;
+
+=09=09pthread_mutex_unlock(&lo->mutex);
+=09=09close(inode->fd);
+=09=09free(inode);
+
+=09} else {
+=09=09pthread_mutex_unlock(&lo->mutex);
+=09}
+}
+
+static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
+{
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+
+=09if (lo_debug(req)) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
+=09=09=09(unsigned long long) ino,
+=09=09=09(unsigned long long) inode->refcount,
+=09=09=09(unsigned long long) nlookup);
+=09}
+
+=09unref_inode(lo, inode, nlookup);
+}
+
+static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
+{
+=09lo_forget_one(req, ino, nlookup);
+=09fuse_reply_none(req);
+}
+
+static void lo_forget_multi(fuse_req_t req, size_t count,
+=09=09=09=09struct fuse_forget_data *forgets)
+{
+=09int i;
+
+=09for (i =3D 0; i < count; i++)
+=09=09lo_forget_one(req, forgets[i].ino, forgets[i].nlookup);
+=09fuse_reply_none(req);
+}
+
+static void lo_readlink(fuse_req_t req, fuse_ino_t ino)
+{
+=09char buf[PATH_MAX + 1];
+=09int res;
+
+=09res =3D readlinkat(lo_fd(req, ino), "", buf, sizeof(buf));
+=09if (res =3D=3D -1)
+=09=09return (void) fuse_reply_err(req, errno);
+
+=09if (res =3D=3D sizeof(buf))
+=09=09return (void) fuse_reply_err(req, ENAMETOOLONG);
+
+=09buf[res] =3D '\0';
+
+=09fuse_reply_readlink(req, buf);
+}
+
+struct lo_dirp {
+=09DIR *dp;
+=09struct dirent *entry;
+=09off_t offset;
+};
+
+static struct lo_dirp *lo_dirp(struct fuse_file_info *fi)
+{
+=09return (struct lo_dirp *) (uintptr_t) fi->fh;
+}
+
+static void lo_opendir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
+{
+=09int error =3D ENOMEM;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_dirp *d;
+=09int fd;
+
+=09d =3D calloc(1, sizeof(struct lo_dirp));
+=09if (d =3D=3D NULL)
+=09=09goto out_err;
+
+=09fd =3D openat(lo_fd(req, ino), ".", O_RDONLY);
+=09if (fd =3D=3D -1)
+=09=09goto out_errno;
+
+=09d->dp =3D fdopendir(fd);
+=09if (d->dp =3D=3D NULL)
+=09=09goto out_errno;
+
+=09d->offset =3D 0;
+=09d->entry =3D NULL;
+
+=09fi->fh =3D (uintptr_t) d;
+=09if (lo->cache =3D=3D CACHE_ALWAYS)
+=09=09fi->keep_cache =3D 1;
+=09fuse_reply_open(req, fi);
+=09return;
+
+out_errno:
+=09error =3D errno;
+out_err:
+=09if (d) {
+=09=09if (fd !=3D -1)
+=09=09=09close(fd);
+=09=09free(d);
+=09}
+=09fuse_reply_err(req, error);
+}
+
+static int is_dot_or_dotdot(const char *name)
+{
+=09return name[0] =3D=3D '.' && (name[1] =3D=3D '\0' ||
+=09=09=09=09  (name[1] =3D=3D '.' && name[2] =3D=3D '\0'));
+}
+
+static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
+=09=09=09  off_t offset, struct fuse_file_info *fi, int plus)
+{
+=09struct lo_dirp *d =3D lo_dirp(fi);
+=09char *buf;
+=09char *p;
+=09size_t rem =3D size;
+=09int err;
+
+=09(void) ino;
+
+=09buf =3D calloc(1, size);
+=09if (!buf) {
+=09=09err =3D ENOMEM;
+=09=09goto error;
+=09}
+=09p =3D buf;
+
+=09if (offset !=3D d->offset) {
+=09=09seekdir(d->dp, offset);
+=09=09d->entry =3D NULL;
+=09=09d->offset =3D offset;
+=09}
+=09while (1) {
+=09=09size_t entsize;
+=09=09off_t nextoff;
+=09=09const char *name;
+
+=09=09if (!d->entry) {
+=09=09=09errno =3D 0;
+=09=09=09d->entry =3D readdir(d->dp);
+=09=09=09if (!d->entry) {
+=09=09=09=09if (errno) {  // Error
+=09=09=09=09=09err =3D errno;
+=09=09=09=09=09goto error;
+=09=09=09=09} else {  // End of stream
+=09=09=09=09=09break;=20
+=09=09=09=09}
+=09=09=09}
+=09=09}
+=09=09nextoff =3D d->entry->d_off;
+=09=09name =3D d->entry->d_name;
+=09=09fuse_ino_t entry_ino =3D 0;
+=09=09if (plus) {
+=09=09=09struct fuse_entry_param e;
+=09=09=09if (is_dot_or_dotdot(name)) {
+=09=09=09=09e =3D (struct fuse_entry_param) {
+=09=09=09=09=09.attr.st_ino =3D d->entry->d_ino,
+=09=09=09=09=09.attr.st_mode =3D d->entry->d_type << 12,
+=09=09=09=09};
+=09=09=09} else {
+=09=09=09=09err =3D lo_do_lookup(req, ino, name, &e);
+=09=09=09=09if (err)
+=09=09=09=09=09goto error;
+=09=09=09=09entry_ino =3D e.ino;
+=09=09=09}
+
+=09=09=09entsize =3D fuse_add_direntry_plus(req, p, rem, name,
+=09=09=09=09=09=09=09 &e, nextoff);
+=09=09} else {
+=09=09=09struct stat st =3D {
+=09=09=09=09.st_ino =3D d->entry->d_ino,
+=09=09=09=09.st_mode =3D d->entry->d_type << 12,
+=09=09=09};
+=09=09=09entsize =3D fuse_add_direntry(req, p, rem, name,
+=09=09=09=09=09=09    &st, nextoff);
+=09=09}
+=09=09if (entsize > rem) {
+=09=09=09if (entry_ino !=3D 0)=20
+=09=09=09=09lo_forget_one(req, entry_ino, 1);
+=09=09=09break;
+=09=09}
+=09=09
+=09=09p +=3D entsize;
+=09=09rem -=3D entsize;
+
+=09=09d->entry =3D NULL;
+=09=09d->offset =3D nextoff;
+=09}
+
+    err =3D 0;
+error:
+    // If there's an error, we can only signal it if we haven't stored
+    // any entries yet - otherwise we'd end up with wrong lookup
+    // counts for the entries that are already in the buffer. So we
+    // return what we've collected until that point.
+    if (err && rem =3D=3D size)
+=09    fuse_reply_err(req, err);
+    else
+=09    fuse_reply_buf(req, buf, size - rem);
+    free(buf);
+}
+
+static void lo_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
+=09=09       off_t offset, struct fuse_file_info *fi)
+{
+=09lo_do_readdir(req, ino, size, offset, fi, 0);
+}
+
+static void lo_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
+=09=09=09   off_t offset, struct fuse_file_info *fi)
+{
+=09lo_do_readdir(req, ino, size, offset, fi, 1);
+}
+
+static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_file=
_info *fi)
+{
+=09struct lo_dirp *d =3D lo_dirp(fi);
+=09(void) ino;
+=09closedir(d->dp);
+=09free(d);
+=09fuse_reply_err(req, 0);
+}
+
+static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
+=09=09      mode_t mode, struct fuse_file_info *fi)
+{
+=09int fd;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct fuse_entry_param e;
+=09int err;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)=
\n",
+=09=09=09parent, name);
+
+=09fd =3D openat(lo_fd(req, parent), name,
+=09=09    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
+=09if (fd =3D=3D -1)
+=09=09return (void) fuse_reply_err(req, errno);
+
+=09fi->fh =3D fd;
+=09if (lo->cache =3D=3D CACHE_NEVER)
+=09=09fi->direct_io =3D 1;
+=09else if (lo->cache =3D=3D CACHE_ALWAYS)
+=09=09fi->keep_cache =3D 1;
+
+=09err =3D lo_do_lookup(req, parent, name, &e);
+=09if (err)
+=09=09fuse_reply_err(req, err);
+=09else
+=09=09fuse_reply_create(req, &e, fi);
+}
+
+static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
+=09=09=09struct fuse_file_info *fi)
+{
+=09int res;
+=09int fd =3D dirfd(lo_dirp(fi)->dp);
+=09(void) ino;
+=09if (datasync)
+=09=09res =3D fdatasync(fd);
+=09else
+=09=09res =3D fsync(fd);
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi)
+{
+=09int fd;
+=09char buf[64];
+=09struct lo_data *lo =3D lo_data(req);
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n",
+=09=09=09ino, fi->flags);
+
+=09/* With writeback cache, kernel may send read requests even
+=09   when userspace opened write-only */
+=09if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
+=09=09fi->flags &=3D ~O_ACCMODE;
+=09=09fi->flags |=3D O_RDWR;
+=09}
+
+=09/* With writeback cache, O_APPEND is handled by the kernel.
+=09   This breaks atomicity (since the file may change in the
+=09   underlying filesystem, so that the kernel's idea of the
+=09   end of the file isn't accurate anymore). In this example,
+=09   we just accept that. A more rigorous filesystem may want
+=09   to return an error here */
+=09if (lo->writeback && (fi->flags & O_APPEND))
+=09=09fi->flags &=3D ~O_APPEND;
+
+=09sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
+=09fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
+=09if (fd =3D=3D -1)
+=09=09return (void) fuse_reply_err(req, errno);
+
+=09fi->fh =3D fd;
+=09if (lo->cache =3D=3D CACHE_NEVER)
+=09=09fi->direct_io =3D 1;
+=09else if (lo->cache =3D=3D CACHE_ALWAYS)
+=09=09fi->keep_cache =3D 1;
+=09fuse_reply_open(req, fi);
+}
+
+static void lo_release(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
+{
+=09(void) ino;
+
+=09close(fi->fh);
+=09fuse_reply_err(req, 0);
+}
+
+static void lo_flush(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info=
 *fi)
+{
+=09int res;
+=09(void) ino;
+=09res =3D close(dup(fi->fh));
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
+=09=09     struct fuse_file_info *fi)
+{
+=09int res;
+=09(void) ino;
+=09if (datasync)
+=09=09res =3D fdatasync(fi->fh);
+=09else
+=09=09res =3D fsync(fi->fh);
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_read(fuse_req_t req, fuse_ino_t ino, size_t size,
+=09=09    off_t offset, struct fuse_file_info *fi)
+{
+=09struct fuse_bufvec buf =3D FUSE_BUFVEC_INIT(size);
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
+=09=09=09"off=3D%lu)\n", ino, size, (unsigned long) offset);
+
+=09buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
+=09buf.buf[0].fd =3D fi->fh;
+=09buf.buf[0].pos =3D offset;
+
+=09fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
+}
+
+static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
+=09=09=09 struct fuse_bufvec *in_buf, off_t off,
+=09=09=09 struct fuse_file_info *fi)
+{
+=09(void) ino;
+=09ssize_t res;
+=09struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
+
+=09out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
+=09out_buf.buf[0].fd =3D fi->fh;
+=09out_buf.buf[0].pos =3D off;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_write(ino=3D%" PRIu64 ", size=3D%zd, of=
f=3D%lu)\n",
+=09=09=09ino, out_buf.buf[0].size, (unsigned long) off);
+
+=09res =3D fuse_buf_copy(&out_buf, in_buf, 0);
+=09if(res < 0)
+=09=09fuse_reply_err(req, -res);
+=09else
+=09=09fuse_reply_write(req, (size_t) res);
+}
+
+static void lo_statfs(fuse_req_t req, fuse_ino_t ino)
+{
+=09int res;
+=09struct statvfs stbuf;
+
+=09res =3D fstatvfs(lo_fd(req, ino), &stbuf);
+=09if (res =3D=3D -1)
+=09=09fuse_reply_err(req, errno);
+=09else
+=09=09fuse_reply_statfs(req, &stbuf);
+}
+
+static void lo_fallocate(fuse_req_t req, fuse_ino_t ino, int mode,
+=09=09=09 off_t offset, off_t length, struct fuse_file_info *fi)
+{
+=09int err =3D EOPNOTSUPP;
+=09(void) ino;
+
+#ifdef HAVE_FALLOCATE
+=09err =3D fallocate(fi->fh, mode, offset, length);
+=09if (err < 0)
+=09=09err =3D errno;
+
+#elif defined(HAVE_POSIX_FALLOCATE)
+=09if (mode) {
+=09=09fuse_reply_err(req, EOPNOTSUPP);
+=09=09return;
+=09}
+
+=09err =3D posix_fallocate(fi->fh, offset, length);
+#endif
+
+=09fuse_reply_err(req, err);
+}
+
+static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info=
 *fi,
+=09=09     int op)
+{
+=09int res;
+=09(void) ino;
+
+=09res =3D flock(fi->fh, op);
+
+=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+}
+
+static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+=09=09=09size_t size)
+{
+=09char *value =3D NULL;
+=09char procname[64];
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09ssize_t ret;
+=09int saverr;
+
+=09saverr =3D ENOSYS;
+=09if (!lo_data(req)->xattr)
+=09=09goto out;
+
+=09if (lo_debug(req)) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s s=
ize=3D%zd)\n",
+=09=09=09ino, name, size);
+=09}
+
+=09if (inode->is_symlink) {
+=09=09/* Sorry, no race free way to getxattr on symlink. */
+=09=09saverr =3D EPERM;
+=09=09goto out;
+=09}
+
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09if (size) {
+=09=09value =3D malloc(size);
+=09=09if (!value)
+=09=09=09goto out_err;
+
+=09=09ret =3D getxattr(procname, name, value, size);
+=09=09if (ret =3D=3D -1)
+=09=09=09goto out_err;
+=09=09saverr =3D 0;
+=09=09if (ret =3D=3D 0)
+=09=09=09goto out;
+
+=09=09fuse_reply_buf(req, value, ret);
+=09} else {
+=09=09ret =3D getxattr(procname, name, NULL, 0);
+=09=09if (ret =3D=3D -1)
+=09=09=09goto out_err;
+
+=09=09fuse_reply_xattr(req, ret);
+=09}
+out_free:
+=09free(value);
+=09return;
+
+out_err:
+=09saverr =3D errno;
+out:
+=09fuse_reply_err(req, saverr);
+=09goto out_free;
+}
+
+static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
+{
+=09char *value =3D NULL;
+=09char procname[64];
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09ssize_t ret;
+=09int saverr;
+
+=09saverr =3D ENOSYS;
+=09if (!lo_data(req)->xattr)
+=09=09goto out;
+
+=09if (lo_debug(req)) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd=
)\n",
+=09=09=09ino, size);
+=09}
+
+=09if (inode->is_symlink) {
+=09=09/* Sorry, no race free way to listxattr on symlink. */
+=09=09saverr =3D EPERM;
+=09=09goto out;
+=09}
+
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09if (size) {
+=09=09value =3D malloc(size);
+=09=09if (!value)
+=09=09=09goto out_err;
+
+=09=09ret =3D listxattr(procname, value, size);
+=09=09if (ret =3D=3D -1)
+=09=09=09goto out_err;
+=09=09saverr =3D 0;
+=09=09if (ret =3D=3D 0)
+=09=09=09goto out;
+
+=09=09fuse_reply_buf(req, value, ret);
+=09} else {
+=09=09ret =3D listxattr(procname, NULL, 0);
+=09=09if (ret =3D=3D -1)
+=09=09=09goto out_err;
+
+=09=09fuse_reply_xattr(req, ret);
+=09}
+out_free:
+=09free(value);
+=09return;
+
+out_err:
+=09saverr =3D errno;
+out:
+=09fuse_reply_err(req, saverr);
+=09goto out_free;
+}
+
+static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
+=09=09=09const char *value, size_t size, int flags)
+{
+=09char procname[64];
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09ssize_t ret;
+=09int saverr;
+
+=09saverr =3D ENOSYS;
+=09if (!lo_data(req)->xattr)
+=09=09goto out;
+
+=09if (lo_debug(req)) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64 ", name=3D%s v=
alue=3D%s size=3D%zd)\n",
+=09=09=09ino, name, value, size);
+=09}
+
+=09if (inode->is_symlink) {
+=09=09/* Sorry, no race free way to setxattr on symlink. */
+=09=09saverr =3D EPERM;
+=09=09goto out;
+=09}
+
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09ret =3D setxattr(procname, name, value, size, flags);
+=09saverr =3D ret =3D=3D -1 ? errno : 0;
+
+out:
+=09fuse_reply_err(req, saverr);
+}
+
+static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
+{
+=09char procname[64];
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09ssize_t ret;
+=09int saverr;
+
+=09saverr =3D ENOSYS;
+=09if (!lo_data(req)->xattr)
+=09=09goto out;
+
+=09if (lo_debug(req)) {
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%=
s)\n",
+=09=09=09ino, name);
+=09}
+
+=09if (inode->is_symlink) {
+=09=09/* Sorry, no race free way to setxattr on symlink. */
+=09=09saverr =3D EPERM;
+=09=09goto out;
+=09}
+
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09ret =3D removexattr(procname, name);
+=09saverr =3D ret =3D=3D -1 ? errno : 0;
+
+out:
+=09fuse_reply_err(req, saverr);
+}
+
+#ifdef HAVE_COPY_FILE_RANGE
+static void lo_copy_file_range(fuse_req_t req, fuse_ino_t ino_in, off_t of=
f_in,
+=09=09=09       struct fuse_file_info *fi_in,
+=09=09=09       fuse_ino_t ino_out, off_t off_out,
+=09=09=09       struct fuse_file_info *fi_out, size_t len,
+=09=09=09       int flags)
+{
+=09ssize_t res;
+
+=09if (lo_debug(req))
+=09=09fuse_log(FUSE_LOG_DEBUG, "lo_copy_file_range(ino=3D%" PRIu64 "/fd=3D=
%lu, "
+=09=09=09=09"off=3D%lu, ino=3D%" PRIu64 "/fd=3D%lu, "
+=09=09=09=09"off=3D%lu, size=3D%zd, flags=3D0x%x)\n",
+=09=09=09ino_in, fi_in->fh, off_in, ino_out, fi_out->fh, off_out,
+=09=09=09len, flags);
+
+=09res =3D copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len,
+=09=09=09      flags);
+=09if (res < 0)
+=09=09fuse_reply_err(req, -errno);
+=09else
+=09=09fuse_reply_write(req, res);
+}
+#endif
+
+static void lo_lseek(fuse_req_t req, fuse_ino_t ino, off_t off, int whence=
,
+=09=09     struct fuse_file_info *fi)
+{
+=09off_t res;
+
+=09(void)ino;
+=09res =3D lseek(fi->fh, off, whence);
+=09if (res !=3D -1)
+=09=09fuse_reply_lseek(req, res);
+=09else
+=09=09fuse_reply_err(req, errno);
+}
+
+static struct fuse_lowlevel_ops lo_oper =3D {
+=09.init=09=09=3D lo_init,
+=09.lookup=09=09=3D lo_lookup,
+=09.mkdir=09=09=3D lo_mkdir,
+=09.mknod=09=09=3D lo_mknod,
+=09.symlink=09=3D lo_symlink,
+=09.link=09=09=3D lo_link,
+=09.unlink=09=09=3D lo_unlink,
+=09.rmdir=09=09=3D lo_rmdir,
+=09.rename=09=09=3D lo_rename,
+=09.forget=09=09=3D lo_forget,
+=09.forget_multi=09=3D lo_forget_multi,
+=09.getattr=09=3D lo_getattr,
+=09.setattr=09=3D lo_setattr,
+=09.readlink=09=3D lo_readlink,
+=09.opendir=09=3D lo_opendir,
+=09.readdir=09=3D lo_readdir,
+=09.readdirplus=09=3D lo_readdirplus,
+=09.releasedir=09=3D lo_releasedir,
+=09.fsyncdir=09=3D lo_fsyncdir,
+=09.create=09=09=3D lo_create,
+=09.open=09=09=3D lo_open,
+=09.release=09=3D lo_release,
+=09.flush=09=09=3D lo_flush,
+=09.fsync=09=09=3D lo_fsync,
+=09.read=09=09=3D lo_read,
+=09.write_buf      =3D lo_write_buf,
+=09.statfs=09=09=3D lo_statfs,
+=09.fallocate=09=3D lo_fallocate,
+=09.flock=09=09=3D lo_flock,
+=09.getxattr=09=3D lo_getxattr,
+=09.listxattr=09=3D lo_listxattr,
+=09.setxattr=09=3D lo_setxattr,
+=09.removexattr=09=3D lo_removexattr,
+#ifdef HAVE_COPY_FILE_RANGE
+=09.copy_file_range =3D lo_copy_file_range,
+#endif
+=09.lseek=09=09=3D lo_lseek,
+};
+
+int main(int argc, char *argv[])
+{
+=09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
+=09struct fuse_session *se;
+=09struct fuse_cmdline_opts opts;
+=09struct lo_data lo =3D { .debug =3D 0,
+=09                      .writeback =3D 0 };
+=09int ret =3D -1;
+
+=09/* Don't mask creation mode, kernel already did that */
+=09umask(0);
+
+=09pthread_mutex_init(&lo.mutex, NULL);
+=09lo.root.next =3D lo.root.prev =3D &lo.root;
+=09lo.root.fd =3D -1;
+=09lo.cache =3D CACHE_NORMAL;
+
+=09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
+=09=09return 1;
+=09if (opts.show_help) {
+=09=09printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
+=09=09fuse_cmdline_help();
+=09=09fuse_lowlevel_help();
+=09=09ret =3D 0;
+=09=09goto err_out1;
+=09} else if (opts.show_version) {
+=09=09printf("FUSE library version %s\n", fuse_pkgversion());
+=09=09fuse_lowlevel_version();
+=09=09ret =3D 0;
+=09=09goto err_out1;
+=09}
+
+=09if(opts.mountpoint =3D=3D NULL) {
+=09=09printf("usage: %s [options] <mountpoint>\n", argv[0]);
+=09=09printf("       %s --help\n", argv[0]);
+=09=09ret =3D 1;
+=09=09goto err_out1;
+=09}
+
+=09if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
+=09=09return 1;
+
+=09lo.debug =3D opts.debug;
+=09lo.root.refcount =3D 2;
+=09if (lo.source) {
+=09=09struct stat stat;
+=09=09int res;
+
+=09=09res =3D lstat(lo.source, &stat);
+=09=09if (res =3D=3D -1) {
+=09=09=09fuse_log(FUSE_LOG_ERR, "failed to stat source (\"%s\"): %m\n",
+=09=09=09=09 lo.source);
+=09=09=09exit(1);
+=09=09}
+=09=09if (!S_ISDIR(stat.st_mode)) {
+=09=09=09fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
+=09=09=09exit(1);
+=09=09}
+
+=09} else {
+=09=09lo.source =3D "/";
+=09}
+=09lo.root.is_symlink =3D false;
+=09if (!lo.timeout_set) {
+=09=09switch (lo.cache) {
+=09=09case CACHE_NEVER:
+=09=09=09lo.timeout =3D 0.0;
+=09=09=09break;
+
+=09=09case CACHE_NORMAL:
+=09=09=09lo.timeout =3D 1.0;
+=09=09=09break;
+
+=09=09case CACHE_ALWAYS:
+=09=09=09lo.timeout =3D 86400.0;
+=09=09=09break;
+=09=09}
+=09} else if (lo.timeout < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "timeout is negative (%lf)\n",
+=09=09=09 lo.timeout);
+=09=09exit(1);
+=09}
+
+=09lo.root.fd =3D open(lo.source, O_PATH);
+=09if (lo.root.fd =3D=3D -1) {
+=09=09fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n",
+=09=09=09 lo.source);
+=09=09exit(1);
+=09}
+
+=09se =3D fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
+=09if (se =3D=3D NULL)
+=09    goto err_out1;
+
+=09if (fuse_set_signal_handlers(se) !=3D 0)
+=09    goto err_out2;
+
+=09if (fuse_session_mount(se, opts.mountpoint) !=3D 0)
+=09    goto err_out3;
+
+=09fuse_daemonize(opts.foreground);
+
+=09/* Block until ctrl+c or fusermount -u */
+=09if (opts.singlethread)
+=09=09ret =3D fuse_session_loop(se);
+=09else
+=09=09ret =3D fuse_session_loop_mt(se, opts.clone_fd);
+
+=09fuse_session_unmount(se);
+err_out3:
+=09fuse_remove_signal_handlers(se);
+err_out2:
+=09fuse_session_destroy(se);
+err_out1:
+=09free(opts.mountpoint);
+=09fuse_opt_free_args(&args);
+
+=09if (lo.root.fd >=3D 0)
+=09=09close(lo.root.fd);
+
+=09return ret ? 1 : 0;
+}
--=20
2.23.0


