Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C39D21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHjME6zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C39D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbiP-0002dL-R0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHz-0003jE-Tb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHw-0008Ut-6d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHw-0008Un-0Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ui2Y+ocRQxzzkeIX5ySyCoXwG2tfJlsb/HVTFRvxaB0=;
 b=hHjME6zwXx1LKDlC/xt+ocqvqIOstHJdkA61rnzdgQtDV6qyzfiAlwcc09X6hOgKwydia7
 6RICN9Dvh7wuW89FUmlLc1EWvFU+I65UWoQ1WuNQV9tV3fqu/S6XygwSN2GzHJJS6MVeqb
 gBJZ29MvENs2gDsua4FKV+VoPtHMzyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-ZsT16eUzO9GvEtoYfm_RCg-1; Thu, 24 Oct 2019 07:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CC0A80183D;
 Thu, 24 Oct 2019 11:28:13 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EEF3196B2;
 Thu, 24 Oct 2019 11:28:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 12/25] virtiofsd: check input buffer size in fuse_lowlevel.c
 ops
Date: Thu, 24 Oct 2019 12:27:05 +0100
Message-Id: <20191024112718.34657-13-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ZsT16eUzO9GvEtoYfm_RCg-1
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

Each FUSE operation involves parsing the input buffer.  Currently the
code assumes the input buffer is large enough for the expected
arguments.  This patch uses fuse_mbuf_iter to check the size.

Most operations are simple to convert.  Some are more complicated due to
variable-length inputs or different sizes depending on the protocol
version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c | 621 +++++++++++++++++++++++-------
 1 file changed, 482 insertions(+), 139 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 7927348398..d032e411e1 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -15,6 +15,7 @@
 #include "fuse_misc.h"
 #include "fuse_virtio.h"
=20
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stddef.h>
@@ -27,7 +28,6 @@
=20
=20
=20
-#define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
 struct fuse_pollhandle {
@@ -705,9 +705,14 @@ int fuse_reply_poll(fuse_req_t req, unsigned revents)
 =09return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
-static void do_lookup(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_lookup(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09char *name =3D (char *) inarg;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.lookup)
 =09=09req->se->op.lookup(req, nodeid, name);
@@ -715,9 +720,16 @@ static void do_lookup(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_forget(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_forget(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_forget_in *arg =3D (struct fuse_forget_in *) inarg;
+=09struct fuse_forget_in *arg;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.forget)
 =09=09req->se->op.forget(req, nodeid, arg->nlookup);
@@ -726,20 +738,47 @@ static void do_forget(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 }
=20
 static void do_batch_forget(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg)
+=09=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_batch_forget_in *arg =3D (void *) inarg;
-=09struct fuse_forget_one *param =3D (void *) PARAM(arg);
-=09unsigned int i;
+=09struct fuse_batch_forget_in *arg;
+=09struct fuse_forget_data *forgets;
+=09size_t scount;
=20
 =09(void) nodeid;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_none(req);
+=09}
+
+=09/* Prevent integer overflow.  The compiler emits the following warning
+=09 * unless we use the scount local variable:
+=09 *
+=09 * error: comparison is always false due to limited range of data type
+=09 * [-Werror=3Dtype-limits]
+=09 *
+=09 * This may be true on 64-bit hosts but we need this check for 32-bit
+=09 * hosts.
+=09 */
+=09scount =3D arg->count;
+=09if (scount > SIZE_MAX / sizeof(forgets[0])) {
+=09=09fuse_reply_none(req);
+=09=09return;
+=09}
+
+=09forgets =3D fuse_mbuf_iter_advance(iter, arg->count *
+=09=09=09=09=09 sizeof(forgets[0]));
+=09if (!forgets) {
+=09=09fuse_reply_none(req);
+=09=09return;
+=09}
+
 =09if (req->se->op.forget_multi) {
-=09=09req->se->op.forget_multi(req, arg->count,
-=09=09=09=09     (struct fuse_forget_data *) param);
+=09=09req->se->op.forget_multi(req, arg->count, forgets);
 =09} else if (req->se->op.forget) {
+=09=09unsigned int i;
+
 =09=09for (i =3D 0; i < arg->count; i++) {
-=09=09=09struct fuse_forget_one *forget =3D &param[i];
 =09=09=09struct fuse_req *dummy_req;
=20
 =09=09=09dummy_req =3D fuse_ll_alloc_req(req->se);
@@ -750,8 +789,8 @@ static void do_batch_forget(fuse_req_t req, fuse_ino_t =
nodeid,
 =09=09=09dummy_req->ctx =3D req->ctx;
 =09=09=09dummy_req->ch =3D NULL;
=20
-=09=09=09req->se->op.forget(dummy_req, forget->nodeid,
-=09=09=09=09=09  forget->nlookup);
+=09=09=09req->se->op.forget(dummy_req, forgets[i].ino,
+=09=09=09=09=09   forgets[i].nlookup);
 =09=09}
 =09=09fuse_reply_none(req);
 =09} else {
@@ -759,13 +798,20 @@ static void do_batch_forget(fuse_req_t req, fuse_ino_=
t nodeid,
 =09}
 }
=20
-static void do_getattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_getattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
 =09struct fuse_file_info *fip =3D NULL;
 =09struct fuse_file_info fi;
=20
 =09if (req->se->conn.proto_minor >=3D 9) {
-=09=09struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *) inarg;
+=09=09struct fuse_getattr_in *arg;
+
+=09=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09=09if (!arg) {
+=09=09=09fuse_reply_err(req, EINVAL);
+=09=09=09return;
+=09=09}
=20
 =09=09if (arg->getattr_flags & FUSE_GETATTR_FH) {
 =09=09=09memset(&fi, 0, sizeof(fi));
@@ -780,14 +826,21 @@ static void do_getattr(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_setattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_setattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_setattr_in *arg =3D (struct fuse_setattr_in *) inarg;
-
 =09if (req->se->op.setattr) {
+=09=09struct fuse_setattr_in *arg;
 =09=09struct fuse_file_info *fi =3D NULL;
 =09=09struct fuse_file_info fi_store;
 =09=09struct stat stbuf;
+
+=09=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09=09if (!arg) {
+=09=09=09fuse_reply_err(req, EINVAL);
+=09=09=09return;
+=09=09}
+
 =09=09memset(&stbuf, 0, sizeof(stbuf));
 =09=09convert_attr(arg, &stbuf);
 =09=09if (arg->valid & FATTR_FH) {
@@ -812,9 +865,16 @@ static void do_setattr(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_access(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_access(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_access_in *arg =3D (struct fuse_access_in *) inarg;
+=09struct fuse_access_in *arg;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.access)
 =09=09req->se->op.access(req, nodeid, arg->mask);
@@ -822,9 +882,10 @@ static void do_access(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_readlink(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_readlink(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09struct fuse_mbuf_iter *iter)
 {
-=09(void) inarg;
+=09(void) iter;
=20
 =09if (req->se->op.readlink)
 =09=09req->se->op.readlink(req, nodeid);
@@ -832,15 +893,24 @@ static void do_readlink(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_mknod(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_mknod(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *) inarg;
-=09char *name =3D PARAM(arg);
+=09bool compat =3D req->se->conn.proto_minor < 12;
+=09struct fuse_mknod_in *arg;
+=09const char *name;
=20
-=09if (req->se->conn.proto_minor >=3D 12)
+=09arg =3D fuse_mbuf_iter_advance(iter,
+=09=09=09compat ? FUSE_COMPAT_MKNOD_IN_SIZE : sizeof(*arg));
+=09name =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09if (!compat) {
 =09=09req->ctx.umask =3D arg->umask;
-=09else
-=09=09name =3D (char *) inarg + FUSE_COMPAT_MKNOD_IN_SIZE;
+=09}
=20
 =09if (req->se->op.mknod)
 =09=09req->se->op.mknod(req, nodeid, name, arg->mode, arg->rdev);
@@ -848,22 +918,40 @@ static void do_mknod(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *) inarg;
+=09bool compat =3D req->se->conn.proto_minor < 12;
+=09struct fuse_mkdir_in *arg;
+=09const char *name;
=20
-=09if (req->se->conn.proto_minor >=3D 12)
+=09arg =3D fuse_mbuf_iter_advance(iter,
+=09=09=09compat ? sizeof(uint32_t) : sizeof(*arg));
+=09name =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09if (!compat) {
 =09=09req->ctx.umask =3D arg->umask;
+=09}
=20
 =09if (req->se->op.mkdir)
-=09=09req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
+=09=09req->se->op.mkdir(req, nodeid, name, arg->mode);
 =09else
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_unlink(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_unlink(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09char *name =3D (char *) inarg;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+=09if (!name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.unlink)
 =09=09req->se->op.unlink(req, nodeid, name);
@@ -871,9 +959,15 @@ static void do_unlink(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09char *name =3D (char *) inarg;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+=09if (!name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.rmdir)
 =09=09req->se->op.rmdir(req, nodeid, name);
@@ -881,10 +975,16 @@ static void do_rmdir(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_symlink(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_symlink(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09char *name =3D (char *) inarg;
-=09char *linkname =3D ((char *) inarg) + strlen((char *) inarg) + 1;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+=09const char *linkname =3D fuse_mbuf_iter_advance_str(iter);
+
+=09if (!name || !linkname) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.symlink)
 =09=09req->se->op.symlink(req, linkname, nodeid, name);
@@ -892,11 +992,20 @@ static void do_symlink(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_rename(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_rename(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_rename_in *arg =3D (struct fuse_rename_in *) inarg;
-=09char *oldname =3D PARAM(arg);
-=09char *newname =3D oldname + strlen(oldname) + 1;
+=09struct fuse_rename_in *arg;
+=09const char *oldname;
+=09const char *newname;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09oldname =3D fuse_mbuf_iter_advance_str(iter);
+=09newname =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !oldname || !newname) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.rename)
 =09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
@@ -905,11 +1014,20 @@ static void do_rename(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_rename2(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_rename2(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_rename2_in *arg =3D (struct fuse_rename2_in *) inarg;
-=09char *oldname =3D PARAM(arg);
-=09char *newname =3D oldname + strlen(oldname) + 1;
+=09struct fuse_rename2_in *arg;
+=09const char *oldname;
+=09const char *newname;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09oldname =3D fuse_mbuf_iter_advance_str(iter);
+=09newname =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !oldname || !newname) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.rename)
 =09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
@@ -918,42 +1036,65 @@ static void do_rename2(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_link(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_link(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_link_in *arg =3D (struct fuse_link_in *) inarg;
+=09struct fuse_link_in *arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg))=
;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+=09if (!arg || !name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.link)
-=09=09req->se->op.link(req, arg->oldnodeid, nodeid, PARAM(arg));
+=09=09req->se->op.link(req, arg->oldnodeid, nodeid, name);
 =09else
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_create(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_create(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_create_in *arg =3D (struct fuse_create_in *) inarg;
-
 =09if (req->se->op.create) {
+=09=09bool compat =3D req->se->conn.proto_minor < 12;
+=09=09struct fuse_create_in *arg;
 =09=09struct fuse_file_info fi;
-=09=09char *name =3D PARAM(arg);
+=09=09const char *name;
+
+=09=09arg =3D fuse_mbuf_iter_advance(iter, compat ?
+=09=09=09=09sizeof(struct fuse_open_in) :
+=09=09=09=09sizeof(*arg));
+=09=09name =3D fuse_mbuf_iter_advance_str(iter);
+=09=09if (!arg || !name) {
+=09=09=09fuse_reply_err(req, EINVAL);
+=09=09=09return;
+=09=09}
=20
 =09=09memset(&fi, 0, sizeof(fi));
 =09=09fi.flags =3D arg->flags;
=20
-=09=09if (req->se->conn.proto_minor >=3D 12)
+=09=09if (!compat) {
 =09=09=09req->ctx.umask =3D arg->umask;
-=09=09else
-=09=09=09name =3D (char *) inarg + sizeof(struct fuse_open_in);
+=09=09}
=20
 =09=09req->se->op.create(req, nodeid, name, arg->mode, &fi);
 =09} else
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_open(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_open(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
+=09struct fuse_open_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.flags =3D arg->flags;
=20
@@ -963,16 +1104,21 @@ static void do_open(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_open(req, &fi);
 }
=20
-static void do_read(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_read(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
-
 =09if (req->se->op.read) {
+=09=09bool compat =3D req->se->conn.proto_minor < 9;
+=09=09struct fuse_read_in *arg;
 =09=09struct fuse_file_info fi;
=20
+=09=09arg =3D fuse_mbuf_iter_advance(iter, compat ?
+=09=09=09=09offsetof(struct fuse_read_in, lock_owner) :
+=09=09=09=09sizeof(*arg));
+
 =09=09memset(&fi, 0, sizeof(fi));
 =09=09fi.fh =3D arg->fh;
-=09=09if (req->se->conn.proto_minor >=3D 9) {
+=09=09if (!compat) {
 =09=09=09fi.lock_owner =3D arg->lock_owner;
 =09=09=09fi.flags =3D arg->flags;
 =09=09}
@@ -981,22 +1127,34 @@ static void do_read(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_write(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_write(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
+=09bool compat =3D req->se->conn.proto_minor < 9;
+=09struct fuse_write_in *arg;
 =09struct fuse_file_info fi;
-=09char *param;
+=09const char *param;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, compat ?
+=09=09=09FUSE_COMPAT_WRITE_IN_SIZE : sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09param =3D fuse_mbuf_iter_advance(iter, arg->size);
+=09if (!param) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
=20
-=09if (req->se->conn.proto_minor < 9) {
-=09=09param =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-=09} else {
+=09if (!compat) {
 =09=09fi.lock_owner =3D arg->lock_owner;
 =09=09fi.flags =3D arg->flags;
-=09=09param =3D PARAM(arg);
 =09}
=20
 =09if (req->se->op.write)
@@ -1062,16 +1220,27 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid,
 =09se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
-static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_flush(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_flush_in *arg =3D (struct fuse_flush_in *) inarg;
+=09bool compat =3D req->se->conn.proto_minor < 7;
+=09struct fuse_flush_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, compat ?
+=09=09=09offsetof(struct fuse_flush_in, lock_owner) :
+=09=09=09sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.flush =3D 1;
-=09if (req->se->conn.proto_minor >=3D 7)
+=09if (!compat) {
 =09=09fi.lock_owner =3D arg->lock_owner;
+=09}
=20
 =09if (req->se->op.flush)
 =09=09req->se->op.flush(req, nodeid, &fi);
@@ -1079,21 +1248,31 @@ static void do_flush(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_release(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_release(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
+=09bool compat =3D req->se->conn.proto_minor < 8;
+=09struct fuse_release_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, compat ?
+=09=09=09offsetof(struct fuse_release_in, lock_owner) :
+=09=09=09sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.flags =3D arg->flags;
 =09fi.fh =3D arg->fh;
-=09if (req->se->conn.proto_minor >=3D 8) {
+=09if (!compat) {
 =09=09fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
 =09=09fi.lock_owner =3D arg->lock_owner;
-=09}
-=09if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
-=09=09fi.flock_release =3D 1;
-=09=09fi.lock_owner =3D arg->lock_owner;
+
+=09=09if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
+=09=09=09fi.flock_release =3D 1;
+=09=09}
 =09}
=20
 =09if (req->se->op.release)
@@ -1102,11 +1281,19 @@ static void do_release(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
 =09=09fuse_reply_err(req, 0);
 }
=20
-static void do_fsync(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_fsync(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
+=09struct fuse_fsync_in *arg;
 =09struct fuse_file_info fi;
-=09int datasync =3D arg->fsync_flags & 1;
+=09int datasync;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+=09datasync =3D arg->fsync_flags & 1;
=20
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
@@ -1120,11 +1307,18 @@ static void do_fsync(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_opendir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_opendir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
+=09struct fuse_open_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.flags =3D arg->flags;
=20
@@ -1134,11 +1328,18 @@ static void do_opendir(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
 =09=09fuse_reply_open(req, &fi);
 }
=20
-static void do_readdir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_readdir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
+=09struct fuse_read_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
=20
@@ -1148,11 +1349,18 @@ static void do_readdir(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
+static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09   struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
+=09struct fuse_read_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
=20
@@ -1162,11 +1370,18 @@ static void do_readdirplus(fuse_req_t req, fuse_ino=
_t nodeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
+static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09  struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
+=09struct fuse_release_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.flags =3D arg->flags;
 =09fi.fh =3D arg->fh;
@@ -1177,11 +1392,19 @@ static void do_releasedir(fuse_req_t req, fuse_ino_=
t nodeid, const void *inarg)
 =09=09fuse_reply_err(req, 0);
 }
=20
-static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
+=09struct fuse_fsync_in *arg;
 =09struct fuse_file_info fi;
-=09int datasync =3D arg->fsync_flags & 1;
+=09int datasync;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+=09datasync =3D arg->fsync_flags & 1;
=20
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
@@ -1192,10 +1415,11 @@ static void do_fsyncdir(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_statfs(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_statfs(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
 =09(void) nodeid;
-=09(void) inarg;
+=09(void) iter;
=20
 =09if (req->se->op.statfs)
 =09=09req->se->op.statfs(req, nodeid);
@@ -1208,11 +1432,25 @@ static void do_statfs(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
 =09}
 }
=20
-static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_setxattr_in *arg =3D (struct fuse_setxattr_in *) inarg;
-=09char *name =3D PARAM(arg);
-=09char *value =3D name + strlen(name) + 1;
+=09struct fuse_setxattr_in *arg;
+=09const char *name;
+=09const char *value;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09name =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09value =3D fuse_mbuf_iter_advance(iter, arg->size);
+=09if (!value) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.setxattr)
 =09=09req->se->op.setxattr(req, nodeid, name, value, arg->size,
@@ -1221,19 +1459,35 @@ static void do_setxattr(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
+=09struct fuse_getxattr_in *arg;
+=09const char *name;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09name =3D fuse_mbuf_iter_advance_str(iter);
+=09if (!arg || !name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.getxattr)
-=09=09req->se->op.getxattr(req, nodeid, PARAM(arg), arg->size);
+=09=09req->se->op.getxattr(req, nodeid, name, arg->size);
 =09else
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09 struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
+=09struct fuse_getxattr_in *arg;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.listxattr)
 =09=09req->se->op.listxattr(req, nodeid, arg->size);
@@ -1241,9 +1495,15 @@ static void do_listxattr(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
+static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09   struct fuse_mbuf_iter *iter)
 {
-=09char *name =3D (char *) inarg;
+=09const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+=09if (!name) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.removexattr)
 =09=09req->se->op.removexattr(req, nodeid, name);
@@ -1265,12 +1525,19 @@ static void convert_fuse_file_lock(struct fuse_file=
_lock *fl,
 =09flock->l_pid =3D fl->pid;
 }
=20
-static void do_getlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_getlk(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
+=09struct fuse_lk_in *arg;
 =09struct fuse_file_info fi;
 =09struct flock flock;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.lock_owner =3D arg->owner;
@@ -1283,12 +1550,18 @@ static void do_getlk(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 }
=20
 static void do_setlk_common(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg, int sleep)
+=09=09=09    struct fuse_mbuf_iter *iter, int sleep)
 {
-=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
+=09struct fuse_lk_in *arg;
 =09struct fuse_file_info fi;
 =09struct flock flock;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.lock_owner =3D arg->owner;
@@ -1323,14 +1596,16 @@ static void do_setlk_common(fuse_req_t req, fuse_in=
o_t nodeid,
 =09}
 }
=20
-static void do_setlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_setlk(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09do_setlk_common(req, nodeid, inarg, 0);
+=09do_setlk_common(req, nodeid, iter, 0);
 }
=20
-static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid,
+=09=09      struct fuse_mbuf_iter *iter)
 {
-=09do_setlk_common(req, nodeid, inarg, 1);
+=09do_setlk_common(req, nodeid, iter, 1);
 }
=20
 static int find_interrupted(struct fuse_session *se, struct fuse_req *req)
@@ -1372,12 +1647,20 @@ static int find_interrupted(struct fuse_session *se=
, struct fuse_req *req)
 =09return 0;
 }
=20
-static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09 struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_interrupt_in *arg =3D (struct fuse_interrupt_in *) inarg;
+=09struct fuse_interrupt_in *arg;
 =09struct fuse_session *se =3D req->se;
=20
 =09(void) nodeid;
+
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09if (se->debug)
 =09=09fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
 =09=09=09(unsigned long long) arg->unique);
@@ -1415,9 +1698,15 @@ static struct fuse_req *check_interrupt(struct fuse_=
session *se,
 =09=09return NULL;
 }
=20
-static void do_bmap(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_bmap(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_bmap_in *arg =3D (struct fuse_bmap_in *) inarg;
+=09struct fuse_bmap_in *arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg))=
;
+
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
=20
 =09if (req->se->op.bmap)
 =09=09req->se->op.bmap(req, nodeid, arg->blocksize, arg->block);
@@ -1425,19 +1714,35 @@ static void do_bmap(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid,
+=09=09     struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_ioctl_in *arg =3D (struct fuse_ioctl_in *) inarg;
-=09unsigned int flags =3D arg->flags;
-=09void *in_buf =3D arg->in_size ? PARAM(arg) : NULL;
+=09struct fuse_ioctl_in *arg;
+=09unsigned int flags;
+=09void *in_buf =3D NULL;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09flags =3D arg->flags;
 =09if (flags & FUSE_IOCTL_DIR &&
 =09    !(req->se->conn.want & FUSE_CAP_IOCTL_DIR)) {
 =09=09fuse_reply_err(req, ENOTTY);
 =09=09return;
 =09}
=20
+=09if (arg->in_size) {
+=09=09in_buf =3D fuse_mbuf_iter_advance(iter, arg->in_size);
+=09=09if (!in_buf) {
+=09=09=09fuse_reply_err(req, EINVAL);
+=09=09=09return;
+=09=09}
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
=20
@@ -1459,11 +1764,18 @@ void fuse_pollhandle_destroy(struct fuse_pollhandle=
 *ph)
 =09free(ph);
 }
=20
-static void do_poll(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_poll(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_poll_in *arg =3D (struct fuse_poll_in *) inarg;
+=09struct fuse_poll_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
 =09fi.poll_events =3D arg->events;
@@ -1487,11 +1799,18 @@ static void do_poll(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 =09}
 }
=20
-static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid,
+=09=09=09 struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_fallocate_in *arg =3D (struct fuse_fallocate_in *) inarg;
+=09struct fuse_fallocate_in *arg;
 =09struct fuse_file_info fi;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
=20
@@ -1501,11 +1820,18 @@ static void do_fallocate(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg)
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in, const=
 void *inarg)
+static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in,
+=09=09=09       struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_copy_file_range_in *arg =3D (struct fuse_copy_file_range_in=
 *) inarg;
+=09struct fuse_copy_file_range_in *arg;
 =09struct fuse_file_info fi_in, fi_out;
=20
+=09arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
 =09memset(&fi_in, 0, sizeof(fi_in));
 =09fi_in.fh =3D arg->fh_in;
=20
@@ -1522,15 +1848,34 @@ static void do_copy_file_range(fuse_req_t req, fuse=
_ino_t nodeid_in, const void
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
-static void do_init(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_init(fuse_req_t req, fuse_ino_t nodeid,
+=09=09    struct fuse_mbuf_iter *iter)
 {
-=09struct fuse_init_in *arg =3D (struct fuse_init_in *) inarg;
+=09size_t compat_size =3D offsetof(struct fuse_init_in, max_readahead);
+=09struct fuse_init_in *arg;
 =09struct fuse_init_out outarg;
 =09struct fuse_session *se =3D req->se;
 =09size_t bufsize =3D se->bufsize;
 =09size_t outargsize =3D sizeof(outarg);
=20
 =09(void) nodeid;
+
+=09/* First consume the old fields... */
+=09arg =3D fuse_mbuf_iter_advance(iter, compat_size);
+=09if (!arg) {
+=09=09fuse_reply_err(req, EINVAL);
+=09=09return;
+=09}
+
+=09/* ...and now consume the new fields. */
+=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
+=09=09if (!fuse_mbuf_iter_advance(iter, sizeof(*arg) -
+=09=09=09=09=09    compat_size)) {
+=09=09=09fuse_reply_err(req, EINVAL);
+=09=09=09return;
+=09=09}
+=09}
+
 =09if (se->debug) {
 =09=09fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
 =09=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
@@ -1744,12 +2089,13 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 =09send_reply_ok(req, &outarg, outargsize);
 }
=20
-static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_destroy(fuse_req_t req, fuse_ino_t nodeid,
+=09=09       struct fuse_mbuf_iter *iter)
 {
 =09struct fuse_session *se =3D req->se;
=20
 =09(void) nodeid;
-=09(void) inarg;
+=09(void) iter;
=20
 =09se->got_destroy =3D 1;
 =09if (se->op.destroy)
@@ -1934,7 +2280,7 @@ int fuse_req_interrupted(fuse_req_t req)
 }
=20
 static struct {
-=09void (*func)(fuse_req_t, fuse_ino_t, const void *);
+=09void (*func)(fuse_req_t, fuse_ino_t, struct fuse_mbuf_iter *);
 =09const char *name;
 } fuse_ll_ops[] =3D {
 =09[FUSE_LOOKUP]=09   =3D { do_lookup,      "LOOKUP"=09     },
@@ -2013,7 +2359,6 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
 =09const struct fuse_buf *buf =3D bufv->buf;
 =09struct fuse_mbuf_iter iter =3D FUSE_MBUF_ITER_INIT(buf);
 =09struct fuse_in_header *in;
-=09const void *inarg;
 =09struct fuse_req *req;
 =09int err;
=20
@@ -2086,12 +2431,10 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
 =09=09=09fuse_reply_err(intr, EAGAIN);
 =09}
=20
-=09inarg =3D (void *) &in[1];
 =09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
 =09=09do_write_buf(req, in->nodeid, &iter, bufv);
 =09else
-=09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
-
+=09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
 =09return;
=20
 reply_err:
--=20
2.23.0


