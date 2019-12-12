Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF34DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F44D205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtppkQ6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F44D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS9H-0001T4-8s
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVg-0005qH-MZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVf-0002E1-Ej
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60925
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVf-0002BP-52
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDtoPLNQ3V8oD+vwQyOcLXH0VziNW1yt0dVfeNFT2To=;
 b=FtppkQ6+YxFxamPuWfxgkWVkbbaYC3kPch6jwgjG2zvg80ey0TZFWZTGappCq3P5AxBNZ0
 vVB5GdbzjqibLclov/LshpffMD76hCVJsrCIdI4z4Y1VExN/lTEOZcRYVJX6PYhAPIRSeD
 JFspBE+vUbq+K93zidAvoUDlySX7FU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-sdirObqENcmXeZrnGGaZSQ-1; Thu, 12 Dec 2019 11:40:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 068881005510
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DF460BE1;
 Thu, 12 Dec 2019 16:40:09 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 038/104] virtiofsd: validate path components
Date: Thu, 12 Dec 2019 16:37:58 +0000
Message-Id: <20191212163904.159893-39-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sdirObqENcmXeZrnGGaZSQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Several FUSE requests contain single path components.  A correct FUSE
client sends well-formed path components but there is currently no input
validation in case something went wrong or the client is malicious.

Refuse ".", "..", and paths containing '/' when we expect a path
component.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 59 ++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 1faae2753f..84e9d8916f 100644
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
@@ -745,6 +769,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
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
@@ -846,6 +875,11 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fu=
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
@@ -887,6 +921,10 @@ out_err:
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
@@ -899,6 +937,11 @@ static void lo_rename(fuse_req_t req, fuse_ino_t paren=
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
@@ -913,6 +956,11 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t paren=
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
@@ -1076,12 +1124,6 @@ out_err:
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
@@ -1231,6 +1273,11 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
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
2.23.0


