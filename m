Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BF020679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQDHu1Y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BF020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbSK-0004L0-2O
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHF-0001Ue-Qr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHE-0008GM-Gz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHE-0008FM-Cn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FPgYQFbJ3wa5Enj07AEd7Fjkhsti21C0RndqxjWCWY=;
 b=VQDHu1Y969YbchyvyxlB7wz7ksDIH1spQ1hPTT5s3EbRIhOX0c+g+GjrOHizYqjcPupuNI
 ybKNQiDQNQdGuoZf5zL10HuryfQ8ak6BDadakIdGhjezD2vcUK9IW/1/n0mxOUVDVHwf2U
 3vEWXUJtJJCdLAX2mnXa1n5j2YObV/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-Yg2AnGDPMAGt8oGVVt1gXA-1; Thu, 24 Oct 2019 07:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E164100550E;
 Thu, 24 Oct 2019 11:27:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E86224524;
 Thu, 24 Oct 2019 11:27:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 01/25] virtiofsd: passthrough_ll: create new files in caller's
 context
Date: Thu, 24 Oct 2019 12:26:54 +0100
Message-Id: <20191024112718.34657-2-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Yg2AnGDPMAGt8oGVVt1gXA-1
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

From: Vivek Goyal <vgoyal@redhat.com>

We need to create files in callers context. Otherwise afer creating file,
caller himself might not be able to do file operations on that file.

Changed effective uid/gid to caller's uid/gid, create file and then
switch backto uid/gid 0.

Use syscall(setresuid, ...) otherwise glibc does some magic to change EUID
in all threads, which is not what we want.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 75 ++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 2a1a880224..2de35d4d3d 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -49,6 +49,7 @@
 #include <inttypes.h>
 #include <pthread.h>
 #include <sys/file.h>
+#include <sys/syscall.h>
 #include <sys/xattr.h>
=20
 #include "passthrough_helpers.h"
@@ -78,6 +79,11 @@ struct lo_inode {
 =09uint64_t refcount; /* protected by lo->mutex */
 };
=20
+struct lo_cred {
+=09uid_t euid;
+=09gid_t egid;
+};
+
 enum {
 =09CACHE_NEVER,
 =09CACHE_NORMAL,
@@ -376,6 +382,51 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
 =09=09fuse_reply_entry(req, &e);
 }
=20
+/*
+ * Change to uid/gid of caller so that file is created with
+ * ownership of caller.
+ * TODO: What about selinux context?
+ */
+static int lo_change_cred(fuse_req_t req, struct lo_cred *old)
+{
+=09int res;
+
+=09old->euid =3D geteuid();
+=09old->egid =3D getegid();
+
+=09res =3D syscall(SYS_setresgid, -1,fuse_req_ctx(req)->gid, -1);
+=09if (res =3D=3D -1)
+=09=09return errno;
+
+=09res =3D syscall(SYS_setresuid, -1, fuse_req_ctx(req)->uid, -1);
+=09if (res =3D=3D -1) {
+=09=09int errno_save =3D errno;
+
+=09=09syscall(SYS_setresgid, -1, old->egid, -1);
+=09=09return errno_save;
+=09}
+
+=09return 0;
+}
+
+/* Regain Privileges */
+static void lo_restore_cred(struct lo_cred *old)
+{
+=09int res;
+
+=09res =3D syscall(SYS_setresuid, -1, old->euid, -1);
+=09if (res =3D=3D -1) {
+=09=09fuse_log(FUSE_LOG_ERR, "seteuid(%u): %m\n", old->euid);
+=09=09exit(1);
+=09}
+
+=09res =3D syscall(SYS_setresgid, -1, old->egid, -1);
+=09if (res =3D=3D -1) {
+=09=09fuse_log(FUSE_LOG_ERR, "setegid(%u): %m\n", old->egid);
+=09=09exit(1);
+=09}
+}
+
 static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
 =09=09=09     const char *name, mode_t mode, dev_t rdev,
 =09=09=09     const char *link)
@@ -384,12 +435,20 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
 =09int saverr;
 =09struct lo_inode *dir =3D lo_inode(req, parent);
 =09struct fuse_entry_param e;
+=09struct lo_cred old =3D {};
=20
 =09saverr =3D ENOMEM;
=20
+=09saverr =3D lo_change_cred(req, &old);
+=09if (saverr)
+=09=09goto out;
+
 =09res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
=20
 =09saverr =3D errno;
+
+=09lo_restore_cred(&old);
+
 =09if (res =3D=3D -1)
 =09=09goto out;
=20
@@ -768,23 +827,31 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 =09struct lo_data *lo =3D lo_data(req);
 =09struct fuse_entry_param e;
 =09int err;
+=09struct lo_cred old =3D {};
=20
 =09if (lo_debug(req))
 =09=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)=
\n",
 =09=09=09parent, name);
=20
+=09err =3D lo_change_cred(req, &old);
+=09if (err)
+=09=09goto out;
+
 =09fd =3D openat(lo_fd(req, parent), name,
 =09=09    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
-=09if (fd =3D=3D -1)
-=09=09return (void) fuse_reply_err(req, errno);
+=09err =3D fd =3D=3D -1 ? errno : 0;
+=09lo_restore_cred(&old);
=20
-=09fi->fh =3D fd;
+=09if (!err) {
+=09=09fi->fh =3D fd;
+=09=09err =3D lo_do_lookup(req, parent, name, &e);
+=09}
 =09if (lo->cache =3D=3D CACHE_NEVER)
 =09=09fi->direct_io =3D 1;
 =09else if (lo->cache =3D=3D CACHE_ALWAYS)
 =09=09fi->keep_cache =3D 1;
=20
-=09err =3D lo_do_lookup(req, parent, name, &e);
+out:
 =09if (err)
 =09=09fuse_reply_err(req, err);
 =09else
--=20
2.23.0


