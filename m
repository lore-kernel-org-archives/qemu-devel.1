Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86BF20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYUs7YPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86BF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittG9-00073O-9V
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsck-0007MU-Sl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itscj-0002dT-Ek
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itscj-0002dD-9M
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41maRYdOAgnuVtkLP4KNh1Q476RJJ+v2I3TKF5p7raI=;
 b=IYUs7YPZ9bvMHAsj41aT/xG7aWWkQo/+ZNNX+xh7KtFLOwCzpCocuWcJpNg78bt0naJ2Fb
 B+dVaXeOxaMFk6dKFh4IT5WMqtzgtg7h7YAcUPlwN9pN4OHQ7jsru3Ic1kREPRnD03gwcK
 NUwLpJ4HWAY2C5pNcp4AOPjUA/ylMq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-SMq60BD-MACQsUpLkXFERw-1; Tue, 21 Jan 2020 07:27:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A94B1005512;
 Tue, 21 Jan 2020 12:27:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C948060BE0;
 Tue, 21 Jan 2020 12:27:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 033/109] virtiofsd: passthrough_ll: create new files in
 caller's context
Date: Tue, 21 Jan 2020 12:23:17 +0000
Message-Id: <20200121122433.50803-34-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SMq60BD-MACQsUpLkXFERw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

We need to create files in the caller's context. Otherwise after
creating a file, the caller might not be able to do file operations on
that file.

Changed effective uid/gid to caller's uid/gid, create file and then
switch back to uid/gid 0.

Use syscall(setresuid, ...) otherwise glibc does some magic to change EUID
in all threads, which is not what we want.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 96 ++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 53ed56f2a9..3df7e01b35 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -49,6 +49,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/file.h>
+#include <sys/syscall.h>
 #include <sys/xattr.h>
 #include <unistd.h>
=20
@@ -82,6 +83,11 @@ struct lo_inode {
     uint64_t refcount; /* protected by lo->mutex */
 };
=20
+struct lo_cred {
+    uid_t euid;
+    gid_t egid;
+};
+
 enum {
     CACHE_NEVER,
     CACHE_NORMAL,
@@ -382,6 +388,69 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
     }
 }
=20
+/*
+ * On some archs, setres*id is limited to 2^16 but they
+ * provide setres*id32 variants that allow 2^32.
+ * Others just let setres*id do 2^32 anyway.
+ */
+#ifdef SYS_setresgid32
+#define OURSYS_setresgid SYS_setresgid32
+#else
+#define OURSYS_setresgid SYS_setresgid
+#endif
+
+#ifdef SYS_setresuid32
+#define OURSYS_setresuid SYS_setresuid32
+#else
+#define OURSYS_setresuid SYS_setresuid
+#endif
+
+/*
+ * Change to uid/gid of caller so that file is created with
+ * ownership of caller.
+ * TODO: What about selinux context?
+ */
+static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
+{
+    int res;
+
+    old->euid =3D geteuid();
+    old->egid =3D getegid();
+
+    res =3D syscall(OURSYS_setresgid, -1, fuse_req_ctx(req)->gid, -1);
+    if (res =3D=3D -1) {
+        return errno;
+    }
+
+    res =3D syscall(OURSYS_setresuid, -1, fuse_req_ctx(req)->uid, -1);
+    if (res =3D=3D -1) {
+        int errno_save =3D errno;
+
+        syscall(OURSYS_setresgid, -1, old->egid, -1);
+        return errno_save;
+    }
+
+    return 0;
+}
+
+/* Regain Privileges */
+static void lo_restore_cred(struct lo_cred *old)
+{
+    int res;
+
+    res =3D syscall(OURSYS_setresuid, -1, old->euid, -1);
+    if (res =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "seteuid(%u): %m\n", old->euid);
+        exit(1);
+    }
+
+    res =3D syscall(OURSYS_setresgid, -1, old->egid, -1);
+    if (res =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "setegid(%u): %m\n", old->egid);
+        exit(1);
+    }
+}
+
 static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
                              const char *name, mode_t mode, dev_t rdev,
                              const char *link)
@@ -390,12 +459,21 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
     int saverr;
     struct lo_inode *dir =3D lo_inode(req, parent);
     struct fuse_entry_param e;
+    struct lo_cred old =3D {};
=20
     saverr =3D ENOMEM;
=20
+    saverr =3D lo_change_cred(req, &old);
+    if (saverr) {
+        goto out;
+    }
+
     res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
=20
     saverr =3D errno;
+
+    lo_restore_cred(&old);
+
     if (res =3D=3D -1) {
         goto out;
     }
@@ -793,26 +871,34 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     struct lo_data *lo =3D lo_data(req);
     struct fuse_entry_param e;
     int err;
+    struct lo_cred old =3D {};
=20
     if (lo_debug(req)) {
         fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%=
s)\n",
                  parent, name);
     }
=20
+    err =3D lo_change_cred(req, &old);
+    if (err) {
+        goto out;
+    }
+
     fd =3D openat(lo_fd(req, parent), name, (fi->flags | O_CREAT) & ~O_NOF=
OLLOW,
                 mode);
-    if (fd =3D=3D -1) {
-        return (void)fuse_reply_err(req, errno);
-    }
+    err =3D fd =3D=3D -1 ? errno : 0;
+    lo_restore_cred(&old);
=20
-    fi->fh =3D fd;
+    if (!err) {
+        fi->fh =3D fd;
+        err =3D lo_do_lookup(req, parent, name, &e);
+    }
     if (lo->cache =3D=3D CACHE_NEVER) {
         fi->direct_io =3D 1;
     } else if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
     }
=20
-    err =3D lo_do_lookup(req, parent, name, &e);
+out:
     if (err) {
         fuse_reply_err(req, err);
     } else {
--=20
2.24.1


