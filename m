Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F077DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B092051A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIrH+Cy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B092051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itt5i-000559-9U
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:57:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsdV-0008Dz-Tb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:28:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsdT-0002yl-Jm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:28:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsdT-0002yV-FY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/17aW0Q0bofy8iHDWlHkvxHrT0p1gn/bCgXb9a6R98=;
 b=LIrH+Cy+JEGKEaGD5eCd39SXMYzgWDl+rYEy03bs3kNyus5NSK2r9IX3oycm20+fjZXs4Q
 oj34UVQNAyiBF590GN/sISFrnvahXu9plIdrnuSIAmk3d7F9wpvTN09E3c1GJRw7OmJypm
 HRbUU1B+I6S3C3PWJ95XfRVC9Nfrtlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-LkMb_TSkNiWu_R_XMMIfqQ-1; Tue, 21 Jan 2020 07:27:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A7F8010C5;
 Tue, 21 Jan 2020 12:27:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41CD760BE0;
 Tue, 21 Jan 2020 12:27:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 039/109] virtiofsd: validate path components
Date: Tue, 21 Jan 2020 12:23:23 +0000
Message-Id: <20200121122433.50803-40-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LkMb_TSkNiWu_R_XMMIfqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Several FUSE requests contain single path components.  A correct FUSE
client sends well-formed path components but there is currently no input
validation in case something went wrong or the client is malicious.

Refuse ".", "..", and paths containing '/' when we expect a path
component.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 59 ++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index a207f7a97b..3aa26b4255 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -132,6 +132,21 @@ static void unref_inode(struct lo_data *lo, struct lo_=
inode *inode, uint64_t n);
=20
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
=20
+static int is_dot_or_dotdot(const char *name)
+{
+    return name[0] =3D=3D '.' &&
+           (name[1] =3D=3D '\0' || (name[1] =3D=3D '.' && name[2] =3D=3D '=
\0'));
+}
+
+/* Is `path` a single path component that is not "." or ".."? */
+static int is_safe_path_component(const char *path)
+{
+    if (strchr(path, '/')) {
+        return 0;
+    }
+
+    return !is_dot_or_dotdot(path);
+}
=20
 static struct lo_data *lo_data(fuse_req_t req)
 {
@@ -680,6 +695,15 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
                  parent, name);
     }
=20
+    /*
+     * Don't use is_safe_path_component(), allow "." and ".." for NFS expo=
rt
+     * support.
+     */
+    if (strchr(name, '/')) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     err =3D lo_do_lookup(req, parent, name, &e);
     if (err) {
         fuse_reply_err(req, err);
@@ -761,6 +785,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
t parent,
     struct fuse_entry_param e;
     struct lo_cred old =3D {};
=20
+    if (!is_safe_path_component(name)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     dir =3D lo_inode(req, parent);
     if (!dir) {
         fuse_reply_err(req, EBADF);
@@ -862,6 +891,11 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fu=
se_ino_t parent,
     struct fuse_entry_param e;
     int saverr;
=20
+    if (!is_safe_path_component(name)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     inode =3D lo_inode(req, ino);
     if (!inode) {
         fuse_reply_err(req, EBADF);
@@ -903,6 +937,10 @@ out_err:
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
     int res;
+    if (!is_safe_path_component(name)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
=20
@@ -915,6 +953,11 @@ static void lo_rename(fuse_req_t req, fuse_ino_t paren=
t, const char *name,
 {
     int res;
=20
+    if (!is_safe_path_component(name) || !is_safe_path_component(newname))=
 {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     if (flags) {
         fuse_reply_err(req, EINVAL);
         return;
@@ -929,6 +972,11 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
 {
     int res;
=20
+    if (!is_safe_path_component(name)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     res =3D unlinkat(lo_fd(req, parent), name, 0);
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
@@ -1092,12 +1140,6 @@ out_err:
     fuse_reply_err(req, error);
 }
=20
-static int is_dot_or_dotdot(const char *name)
-{
-    return name[0] =3D=3D '.' &&
-           (name[1] =3D=3D '\0' || (name[1] =3D=3D '.' && name[2] =3D=3D '=
\0'));
-}
-
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
                           off_t offset, struct fuse_file_info *fi, int plu=
s)
 {
@@ -1247,6 +1289,11 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
                  parent, name);
     }
=20
+    if (!is_safe_path_component(name)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     err =3D lo_change_cred(req, &old);
     if (err) {
         goto out;
--=20
2.24.1


