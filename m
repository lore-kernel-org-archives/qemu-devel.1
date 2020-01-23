Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D7C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8A824125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSdybYzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8A824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiJ4-00011L-44
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdl-0004lc-2m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdj-0006Rt-QJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdj-0006Rl-No
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRi6vYFNhs/j1llGXVOGVhSwK/ObAljmvQ/qv9tM0tY=;
 b=JSdybYzLKUn81jsl9DNBhNgjfQU/y4A8jhael0Y5oJ9WtJsuwkvAho4LBs/B2MBSb5vuzS
 Cd919+s9TRtxCNHySfW4+kukQF+WBg53ZrljjWopnXFpvLSunFWPs42s8sIcTvhDxpgjy9
 Sz4JE1A6OWwxrOF/ezpSeExj8cGEczQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-K0JJm_mFNjiBGk8LgEePBg-1; Thu, 23 Jan 2020 11:47:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13309107ACC4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EB3A19C69;
 Thu, 23 Jan 2020 16:47:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 034/108] virtiofsd: passthrough_ll: create new files in
 caller's context
Date: Thu, 23 Jan 2020 16:45:16 +0000
Message-Id: <20200123164630.91498-35-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: K0JJm_mFNjiBGk8LgEePBg-1
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
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 96 ++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index cd27c09f59..5e061797d4 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -50,6 +50,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/file.h>
+#include <sys/syscall.h>
 #include <sys/xattr.h>
 #include <unistd.h>
=20
@@ -83,6 +84,11 @@ struct lo_inode {
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
@@ -383,6 +389,69 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
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
@@ -391,12 +460,21 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
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
@@ -794,26 +872,34 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
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


