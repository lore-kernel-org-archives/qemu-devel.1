Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02181C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57DC21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEJylLAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57DC21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiPB-0007xP-To
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdv-0004w2-4j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdt-0006WX-R0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdt-0006WF-O0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ql3iZhOCDYYWCFp4jJc0tlyutsrGTcwOVUXiZ06+mF4=;
 b=OEJylLArAAyARZWQjTG7Mw2P0zyEsMLc1W5CNwCNTi/sMm+AVtqJVAlRZtswwSm3yS+VVX
 xnkdlsYWMvwuMzUvBv4sp4APQe2LNQbLvy37L66zgCTLHc3T9YvcIqrjvmr7bwlf4f5qU0
 F9HhrKM7qEYMloqHt7RW1Y5RTD+EMA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-4n2jWFx6PAKY29oxGfpgDQ-1; Thu, 23 Jan 2020 11:47:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ACB519057CF
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:37 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C976E28998;
 Thu, 23 Jan 2020 16:47:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 040/108] virtiofsd: validate path components
Date: Thu, 23 Jan 2020 16:45:22 +0000
Message-Id: <20200123164630.91498-41-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4n2jWFx6PAKY29oxGfpgDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 59 ++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ac380efcb1..e375406160 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -133,6 +133,21 @@ static void unref_inode(struct lo_data *lo, struct lo_=
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
@@ -681,6 +696,15 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
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
@@ -762,6 +786,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
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
@@ -863,6 +892,11 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fu=
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
@@ -904,6 +938,10 @@ out_err:
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
@@ -916,6 +954,11 @@ static void lo_rename(fuse_req_t req, fuse_ino_t paren=
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
@@ -930,6 +973,11 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t paren=
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
@@ -1093,12 +1141,6 @@ out_err:
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
@@ -1248,6 +1290,11 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
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


