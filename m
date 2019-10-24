Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBC5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C6620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzKC4FYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C6620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbuo-0001X6-5q
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHZ-0002WT-Mz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHY-0008Po-AI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26425
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHY-0008Pa-4Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzBHWGD/wm0Xuo70Lip4zEEYzbn0jIYX9uCmNj5m2Gw=;
 b=MzKC4FYgri1h9nNjJL6WQMfrC4jpKQdlqARVK1JPNvknX88a3e1vWd4Zl7FPIl2TpEd0o4
 d/d0uIoi75IRRWHMgjteRKQ3VJxT37HMGXbX6mA6TvYzCAW/e6+tJ133F7NRQiD0Y77oan
 1W7XgvxZvlxj7ibsNtZbG0eIyU29NbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-ioU2VeBKNk-ZApiHt0eEtw-1; Thu, 24 Oct 2019 07:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16586800D49;
 Thu, 24 Oct 2019 11:27:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CCBC196B2;
 Thu, 24 Oct 2019 11:27:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 07/25] virtiofsd: validate path components
Date: Thu, 24 Oct 2019 12:27:00 +0100
Message-Id: <20191024112718.34657-8-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ioU2VeBKNk-ZApiHt0eEtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 contrib/virtiofsd/passthrough_ll.c | 59 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 9f84419816..702fedc38a 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -146,6 +146,21 @@ static void unref_inode(struct lo_data *lo, struct lo_=
inode *inode, uint64_t n);
=20
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
=20
+static int is_dot_or_dotdot(const char *name)
+{
+=09return name[0] =3D=3D '.' && (name[1] =3D=3D '\0' ||
+=09=09=09=09  (name[1] =3D=3D '.' && name[2] =3D=3D '\0'));
+}
+
+/* Is `path` a single path component that is not "." or ".."? */
+static int is_safe_path_component(const char *path)
+{
+=09if (strchr(path, '/')) {
+=09=09return 0;
+=09}
+
+=09return !is_dot_or_dotdot(path);
+}
=20
 static struct lo_data *lo_data(fuse_req_t req)
 {
@@ -657,6 +672,14 @@ static void lo_lookup(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
 =09=09fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)=
\n",
 =09=09=09parent, name);
=20
+=09/* Don't use is_safe_path_component(), allow "." and ".." for NFS expor=
t
+=09 * support.
+=09 */
+=09if (strchr(name, '/')) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09err =3D lo_do_lookup(req, parent, name, &e);
 =09if (err)
 =09=09fuse_reply_err(req, err);
@@ -719,6 +742,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
t parent,
 =09struct fuse_entry_param e;
 =09struct lo_cred old =3D {};
=20
+=09if (!is_safe_path_component(name)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09dir =3D lo_inode(req, parent);
 =09if (!dir) {
 =09=09fuse_reply_err(req, EBADF);
@@ -815,6 +843,11 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fu=
se_ino_t parent,
 =09struct fuse_entry_param e;
 =09int saverr;
=20
+=09if (!is_safe_path_component(name)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
 =09=09fuse_reply_err(req, EBADF);
@@ -854,6 +887,10 @@ out_err:
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
 =09int res;
+=09if (!is_safe_path_component(name)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
=20
@@ -866,6 +903,12 @@ static void lo_rename(fuse_req_t req, fuse_ino_t paren=
t, const char *name,
 {
 =09int res;
=20
+=09if (!is_safe_path_component(name) ||
+=09=09!is_safe_path_component(newname)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09if (flags) {
 =09=09fuse_reply_err(req, EINVAL);
 =09=09return;
@@ -881,6 +924,11 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
 {
 =09int res;
=20
+=09if (!is_safe_path_component(name)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09res =3D unlinkat(lo_fd(req, parent), name, 0);
=20
 =09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
@@ -1031,12 +1079,6 @@ out_err:
 =09fuse_reply_err(req, error);
 }
=20
-static int is_dot_or_dotdot(const char *name)
-{
-=09return name[0] =3D=3D '.' && (name[1] =3D=3D '\0' ||
-=09=09=09=09  (name[1] =3D=3D '.' && name[2] =3D=3D '\0'));
-}
-
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
 =09=09=09  off_t offset, struct fuse_file_info *fi, int plus)
 {
@@ -1179,6 +1221,11 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
 =09=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)=
\n",
 =09=09=09parent, name);
=20
+=09if (!is_safe_path_component(name)) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09err =3D lo_change_cred(req, &old);
 =09if (err)
 =09=09goto out;
--=20
2.23.0


