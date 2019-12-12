Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49ADC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B2A2253D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI25YA53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B2A2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS1O-0000AT-9u
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVn-0005yP-RX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVj-0002M9-Oh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVj-0002LO-Gh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/k2Kkg+F22rORchvytoG+1DsaAbun0fKNxKknWwDxTE=;
 b=WI25YA53sFpd3+IXfzV6AboINtruSi36V8vN06gSxhAWqOmBq3p/QUizOWZKMqmIbX3nKD
 9Aju1fm2FWOQnPkX3lye2NVVhSRZwirL3E6R5BRslzsCZE0Rj4QpZ3tqWoU4tvMFcHdAsp
 8jQ+yXbthr8EAQmM3Ylmy7CBgcn57EI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-vw0Ja8VFPtSVmMoigProQg-1; Thu, 12 Dec 2019 11:40:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85F81800D42
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E41DE60BE1;
 Thu, 12 Dec 2019 16:40:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 043/104] virtiofsd: check input buffer size in fuse_lowlevel.c
 ops
Date: Thu, 12 Dec 2019 16:38:03 +0000
Message-Id: <20191212163904.159893-44-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vw0Ja8VFPtSVmMoigProQg-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Each FUSE operation involves parsing the input buffer.  Currently the
code assumes the input buffer is large enough for the expected
arguments.  This patch uses fuse_mbuf_iter to check the size.

Most operations are simple to convert.  Some are more complicated due to
variable-length inputs or different sizes depending on the protocol
version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 581 +++++++++++++++++++++++++-------
 1 file changed, 456 insertions(+), 125 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 4b1777b991..bd5ca2f157 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -18,6 +18,7 @@
 #include <assert.h>
 #include <errno.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -26,7 +27,6 @@
 #include <unistd.h>
=20
=20
-#define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
 struct fuse_pollhandle {
@@ -708,9 +708,14 @@ int fuse_reply_lseek(fuse_req_t req, off_t off)
     return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
-static void do_lookup(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_lookup(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    char *name =3D (char *)inarg;
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+    if (!name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.lookup) {
         req->se->op.lookup(req, nodeid, name);
@@ -719,9 +724,16 @@ static void do_lookup(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_forget(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_forget(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    struct fuse_forget_in *arg =3D (struct fuse_forget_in *)inarg;
+    struct fuse_forget_in *arg;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.forget) {
         req->se->op.forget(req, nodeid, arg->nlookup);
@@ -731,20 +743,48 @@ static void do_forget(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 }
=20
 static void do_batch_forget(fuse_req_t req, fuse_ino_t nodeid,
-                            const void *inarg)
+                            struct fuse_mbuf_iter *iter)
 {
-    struct fuse_batch_forget_in *arg =3D (void *)inarg;
-    struct fuse_forget_one *param =3D (void *)PARAM(arg);
-    unsigned int i;
+    struct fuse_batch_forget_in *arg;
+    struct fuse_forget_data *forgets;
+    size_t scount;
=20
     (void)nodeid;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_none(req);
+        return;
+    }
+
+    /*
+     * Prevent integer overflow.  The compiler emits the following warning
+     * unless we use the scount local variable:
+     *
+     * error: comparison is always false due to limited range of data type
+     * [-Werror=3Dtype-limits]
+     *
+     * This may be true on 64-bit hosts but we need this check for 32-bit
+     * hosts.
+     */
+    scount =3D arg->count;
+    if (scount > SIZE_MAX / sizeof(forgets[0])) {
+        fuse_reply_none(req);
+        return;
+    }
+
+    forgets =3D fuse_mbuf_iter_advance(iter, arg->count * sizeof(forgets[0=
]));
+    if (!forgets) {
+        fuse_reply_none(req);
+        return;
+    }
+
     if (req->se->op.forget_multi) {
-        req->se->op.forget_multi(req, arg->count,
-                                 (struct fuse_forget_data *)param);
+        req->se->op.forget_multi(req, arg->count, forgets);
     } else if (req->se->op.forget) {
+        unsigned int i;
+
         for (i =3D 0; i < arg->count; i++) {
-            struct fuse_forget_one *forget =3D &param[i];
             struct fuse_req *dummy_req;
=20
             dummy_req =3D fuse_ll_alloc_req(req->se);
@@ -756,7 +796,7 @@ static void do_batch_forget(fuse_req_t req, fuse_ino_t =
nodeid,
             dummy_req->ctx =3D req->ctx;
             dummy_req->ch =3D NULL;
=20
-            req->se->op.forget(dummy_req, forget->nodeid, forget->nlookup)=
;
+            req->se->op.forget(dummy_req, forgets[i].ino, forgets[i].nlook=
up);
         }
         fuse_reply_none(req);
     } else {
@@ -764,12 +804,19 @@ static void do_batch_forget(fuse_req_t req, fuse_ino_=
t nodeid,
     }
 }
=20
-static void do_getattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_getattr(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
     struct fuse_file_info *fip =3D NULL;
     struct fuse_file_info fi;
=20
-    struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *)inarg;
+    struct fuse_getattr_in *arg;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (arg->getattr_flags & FUSE_GETATTR_FH) {
         memset(&fi, 0, sizeof(fi));
@@ -784,14 +831,21 @@ static void do_getattr(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_setattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_setattr(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    struct fuse_setattr_in *arg =3D (struct fuse_setattr_in *)inarg;
-
     if (req->se->op.setattr) {
+        struct fuse_setattr_in *arg;
         struct fuse_file_info *fi =3D NULL;
         struct fuse_file_info fi_store;
         struct stat stbuf;
+
+        arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+        if (!arg) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+
         memset(&stbuf, 0, sizeof(stbuf));
         convert_attr(arg, &stbuf);
         if (arg->valid & FATTR_FH) {
@@ -812,9 +866,16 @@ static void do_setattr(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     }
 }
=20
-static void do_access(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_access(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    struct fuse_access_in *arg =3D (struct fuse_access_in *)inarg;
+    struct fuse_access_in *arg;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.access) {
         req->se->op.access(req, nodeid, arg->mask);
@@ -823,9 +884,10 @@ static void do_access(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_readlink(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_readlink(fuse_req_t req, fuse_ino_t nodeid,
+                        struct fuse_mbuf_iter *iter)
 {
-    (void)inarg;
+    (void)iter;
=20
     if (req->se->op.readlink) {
         req->se->op.readlink(req, nodeid);
@@ -834,10 +896,18 @@ static void do_readlink(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
     }
 }
=20
-static void do_mknod(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_mknod(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *)inarg;
-    char *name =3D PARAM(arg);
+    struct fuse_mknod_in *arg;
+    const char *name;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    name =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     req->ctx.umask =3D arg->umask;
=20
@@ -848,22 +918,37 @@ static void do_mknod(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *)inarg;
+    struct fuse_mkdir_in *arg;
+    const char *name;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    name =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     req->ctx.umask =3D arg->umask;
=20
     if (req->se->op.mkdir) {
-        req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
+        req->se->op.mkdir(req, nodeid, name, arg->mode);
     } else {
         fuse_reply_err(req, ENOSYS);
     }
 }
=20
-static void do_unlink(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_unlink(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    char *name =3D (char *)inarg;
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+    if (!name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.unlink) {
         req->se->op.unlink(req, nodeid, name);
@@ -872,9 +957,15 @@ static void do_unlink(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    char *name =3D (char *)inarg;
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+    if (!name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.rmdir) {
         req->se->op.rmdir(req, nodeid, name);
@@ -883,10 +974,16 @@ static void do_rmdir(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_symlink(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_symlink(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    char *name =3D (char *)inarg;
-    char *linkname =3D ((char *)inarg) + strlen((char *)inarg) + 1;
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+    const char *linkname =3D fuse_mbuf_iter_advance_str(iter);
+
+    if (!name || !linkname) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.symlink) {
         req->se->op.symlink(req, linkname, nodeid, name);
@@ -895,11 +992,20 @@ static void do_symlink(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_rename(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_rename(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    struct fuse_rename_in *arg =3D (struct fuse_rename_in *)inarg;
-    char *oldname =3D PARAM(arg);
-    char *newname =3D oldname + strlen(oldname) + 1;
+    struct fuse_rename_in *arg;
+    const char *oldname;
+    const char *newname;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    oldname =3D fuse_mbuf_iter_advance_str(iter);
+    newname =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !oldname || !newname) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.rename) {
         req->se->op.rename(req, nodeid, oldname, arg->newdir, newname, 0);
@@ -908,11 +1014,20 @@ static void do_rename(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_rename2(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_rename2(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    struct fuse_rename2_in *arg =3D (struct fuse_rename2_in *)inarg;
-    char *oldname =3D PARAM(arg);
-    char *newname =3D oldname + strlen(oldname) + 1;
+    struct fuse_rename2_in *arg;
+    const char *oldname;
+    const char *newname;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    oldname =3D fuse_mbuf_iter_advance_str(iter);
+    newname =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !oldname || !newname) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.rename) {
         req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
@@ -922,24 +1037,38 @@ static void do_rename2(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
     }
 }
=20
-static void do_link(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_link(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_link_in *arg =3D (struct fuse_link_in *)inarg;
+    struct fuse_link_in *arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg)=
);
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+    if (!arg || !name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.link) {
-        req->se->op.link(req, arg->oldnodeid, nodeid, PARAM(arg));
+        req->se->op.link(req, arg->oldnodeid, nodeid, name);
     } else {
         fuse_reply_err(req, ENOSYS);
     }
 }
=20
-static void do_create(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_create(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    struct fuse_create_in *arg =3D (struct fuse_create_in *)inarg;
-
     if (req->se->op.create) {
+        struct fuse_create_in *arg;
         struct fuse_file_info fi;
-        char *name =3D PARAM(arg);
+        const char *name;
+
+        arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+        name =3D fuse_mbuf_iter_advance_str(iter);
+        if (!arg || !name) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
=20
         memset(&fi, 0, sizeof(fi));
         fi.flags =3D arg->flags;
@@ -952,11 +1081,18 @@ static void do_create(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_open(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_open(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_open_in *arg =3D (struct fuse_open_in *)inarg;
+    struct fuse_open_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.flags =3D arg->flags;
=20
@@ -967,13 +1103,15 @@ static void do_open(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_read(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_read(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
-
     if (req->se->op.read) {
+        struct fuse_read_in *arg;
         struct fuse_file_info fi;
=20
+        arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+
         memset(&fi, 0, sizeof(fi));
         fi.fh =3D arg->fh;
         fi.lock_owner =3D arg->lock_owner;
@@ -984,11 +1122,24 @@ static void do_read(fuse_req_t req, fuse_ino_t nodei=
d, const void *inarg)
     }
 }
=20
-static void do_write(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_write(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_write_in *arg =3D (struct fuse_write_in *)inarg;
+    struct fuse_write_in *arg;
     struct fuse_file_info fi;
-    char *param;
+    const char *param;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    param =3D fuse_mbuf_iter_advance(iter, arg->size);
+    if (!param) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
@@ -996,7 +1147,6 @@ static void do_write(fuse_req_t req, fuse_ino_t nodeid=
, const void *inarg)
=20
     fi.lock_owner =3D arg->lock_owner;
     fi.flags =3D arg->flags;
-    param =3D PARAM(arg);
=20
     if (req->se->op.write) {
         req->se->op.write(req, nodeid, param, arg->size, arg->offset, &fi)=
;
@@ -1054,11 +1204,18 @@ static void do_write_buf(fuse_req_t req, fuse_ino_t=
 nodeid,
     se->op.write_buf(req, nodeid, pbufv, arg->offset, &fi);
 }
=20
-static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_flush(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_flush_in *arg =3D (struct fuse_flush_in *)inarg;
+    struct fuse_flush_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.flush =3D 1;
@@ -1071,19 +1228,26 @@ static void do_flush(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_release(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_release(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    struct fuse_release_in *arg =3D (struct fuse_release_in *)inarg;
+    struct fuse_release_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.flags =3D arg->flags;
     fi.fh =3D arg->fh;
     fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
     fi.lock_owner =3D arg->lock_owner;
+
     if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
         fi.flock_release =3D 1;
-        fi.lock_owner =3D arg->lock_owner;
     }
=20
     if (req->se->op.release) {
@@ -1093,11 +1257,19 @@ static void do_release(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
     }
 }
=20
-static void do_fsync(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_fsync(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *)inarg;
+    struct fuse_fsync_in *arg;
     struct fuse_file_info fi;
-    int datasync =3D arg->fsync_flags & 1;
+    int datasync;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+    datasync =3D arg->fsync_flags & 1;
=20
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
@@ -1113,11 +1285,18 @@ static void do_fsync(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_opendir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_opendir(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    struct fuse_open_in *arg =3D (struct fuse_open_in *)inarg;
+    struct fuse_open_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.flags =3D arg->flags;
=20
@@ -1128,11 +1307,18 @@ static void do_opendir(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
     }
 }
=20
-static void do_readdir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_readdir(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
-    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
+    struct fuse_read_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
@@ -1143,11 +1329,18 @@ static void do_readdir(fuse_req_t req, fuse_ino_t n=
odeid, const void *inarg)
     }
 }
=20
-static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
+static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid,
+                           struct fuse_mbuf_iter *iter)
 {
-    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
+    struct fuse_read_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
@@ -1158,11 +1351,18 @@ static void do_readdirplus(fuse_req_t req, fuse_ino=
_t nodeid, const void *inarg)
     }
 }
=20
-static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
+static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid,
+                          struct fuse_mbuf_iter *iter)
 {
-    struct fuse_release_in *arg =3D (struct fuse_release_in *)inarg;
+    struct fuse_release_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.flags =3D arg->flags;
     fi.fh =3D arg->fh;
@@ -1174,11 +1374,19 @@ static void do_releasedir(fuse_req_t req, fuse_ino_=
t nodeid, const void *inarg)
     }
 }
=20
-static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid,
+                        struct fuse_mbuf_iter *iter)
 {
-    struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *)inarg;
+    struct fuse_fsync_in *arg;
     struct fuse_file_info fi;
-    int datasync =3D arg->fsync_flags & 1;
+    int datasync;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+    datasync =3D arg->fsync_flags & 1;
=20
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
@@ -1190,10 +1398,11 @@ static void do_fsyncdir(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
     }
 }
=20
-static void do_statfs(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_statfs(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
     (void)nodeid;
-    (void)inarg;
+    (void)iter;
=20
     if (req->se->op.statfs) {
         req->se->op.statfs(req, nodeid);
@@ -1206,11 +1415,25 @@ static void do_statfs(fuse_req_t req, fuse_ino_t no=
deid, const void *inarg)
     }
 }
=20
-static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid,
+                        struct fuse_mbuf_iter *iter)
 {
-    struct fuse_setxattr_in *arg =3D (struct fuse_setxattr_in *)inarg;
-    char *name =3D PARAM(arg);
-    char *value =3D name + strlen(name) + 1;
+    struct fuse_setxattr_in *arg;
+    const char *name;
+    const char *value;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    name =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    value =3D fuse_mbuf_iter_advance(iter, arg->size);
+    if (!value) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.setxattr) {
         req->se->op.setxattr(req, nodeid, name, value, arg->size, arg->fla=
gs);
@@ -1219,20 +1442,36 @@ static void do_setxattr(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
     }
 }
=20
-static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
+static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid,
+                        struct fuse_mbuf_iter *iter)
 {
-    struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *)inarg;
+    struct fuse_getxattr_in *arg;
+    const char *name;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    name =3D fuse_mbuf_iter_advance_str(iter);
+    if (!arg || !name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.getxattr) {
-        req->se->op.getxattr(req, nodeid, PARAM(arg), arg->size);
+        req->se->op.getxattr(req, nodeid, name, arg->size);
     } else {
         fuse_reply_err(req, ENOSYS);
     }
 }
=20
-static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid,
+                         struct fuse_mbuf_iter *iter)
 {
-    struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *)inarg;
+    struct fuse_getxattr_in *arg;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.listxattr) {
         req->se->op.listxattr(req, nodeid, arg->size);
@@ -1241,9 +1480,15 @@ static void do_listxattr(fuse_req_t req, fuse_ino_t =
nodeid, const void *inarg)
     }
 }
=20
-static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
+static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid,
+                           struct fuse_mbuf_iter *iter)
 {
-    char *name =3D (char *)inarg;
+    const char *name =3D fuse_mbuf_iter_advance_str(iter);
+
+    if (!name) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.removexattr) {
         req->se->op.removexattr(req, nodeid, name);
@@ -1267,12 +1512,19 @@ static void convert_fuse_file_lock(struct fuse_file=
_lock *fl,
     flock->l_pid =3D fl->pid;
 }
=20
-static void do_getlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_getlk(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_lk_in *arg =3D (struct fuse_lk_in *)inarg;
+    struct fuse_lk_in *arg;
     struct fuse_file_info fi;
     struct flock flock;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.lock_owner =3D arg->owner;
@@ -1286,12 +1538,18 @@ static void do_getlk(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
 }
=20
 static void do_setlk_common(fuse_req_t req, fuse_ino_t nodeid,
-                            const void *inarg, int sleep)
+                            struct fuse_mbuf_iter *iter, int sleep)
 {
-    struct fuse_lk_in *arg =3D (struct fuse_lk_in *)inarg;
+    struct fuse_lk_in *arg;
     struct fuse_file_info fi;
     struct flock flock;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.lock_owner =3D arg->owner;
@@ -1329,14 +1587,16 @@ static void do_setlk_common(fuse_req_t req, fuse_in=
o_t nodeid,
     }
 }
=20
-static void do_setlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_setlk(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    do_setlk_common(req, nodeid, inarg, 0);
+    do_setlk_common(req, nodeid, iter, 0);
 }
=20
-static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
+static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid,
+                      struct fuse_mbuf_iter *iter)
 {
-    do_setlk_common(req, nodeid, inarg, 1);
+    do_setlk_common(req, nodeid, iter, 1);
 }
=20
 static int find_interrupted(struct fuse_session *se, struct fuse_req *req)
@@ -1381,12 +1641,20 @@ static int find_interrupted(struct fuse_session *se=
, struct fuse_req *req)
     return 0;
 }
=20
-static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid,
+                         struct fuse_mbuf_iter *iter)
 {
-    struct fuse_interrupt_in *arg =3D (struct fuse_interrupt_in *)inarg;
+    struct fuse_interrupt_in *arg;
     struct fuse_session *se =3D req->se;
=20
     (void)nodeid;
+
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     if (se->debug) {
         fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
                  (unsigned long long)arg->unique);
@@ -1427,9 +1695,15 @@ static struct fuse_req *check_interrupt(struct fuse_=
session *se,
     }
 }
=20
-static void do_bmap(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_bmap(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_bmap_in *arg =3D (struct fuse_bmap_in *)inarg;
+    struct fuse_bmap_in *arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg)=
);
+
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
     if (req->se->op.bmap) {
         req->se->op.bmap(req, nodeid, arg->blocksize, arg->block);
@@ -1438,18 +1712,34 @@ static void do_bmap(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     }
 }
=20
-static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_ioctl_in *arg =3D (struct fuse_ioctl_in *)inarg;
-    unsigned int flags =3D arg->flags;
-    void *in_buf =3D arg->in_size ? PARAM(arg) : NULL;
+    struct fuse_ioctl_in *arg;
+    unsigned int flags;
+    void *in_buf =3D NULL;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    flags =3D arg->flags;
     if (flags & FUSE_IOCTL_DIR && !(req->se->conn.want & FUSE_CAP_IOCTL_DI=
R)) {
         fuse_reply_err(req, ENOTTY);
         return;
     }
=20
+    if (arg->in_size) {
+        in_buf =3D fuse_mbuf_iter_advance(iter, arg->in_size);
+        if (!in_buf) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
@@ -1470,11 +1760,18 @@ void fuse_pollhandle_destroy(struct fuse_pollhandle=
 *ph)
     free(ph);
 }
=20
-static void do_poll(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_poll(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_poll_in *arg =3D (struct fuse_poll_in *)inarg;
+    struct fuse_poll_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
     fi.poll_events =3D arg->events;
@@ -1498,11 +1795,18 @@ static void do_poll(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     }
 }
=20
-static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
+static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid,
+                         struct fuse_mbuf_iter *iter)
 {
-    struct fuse_fallocate_in *arg =3D (struct fuse_fallocate_in *)inarg;
+    struct fuse_fallocate_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
@@ -1515,12 +1819,17 @@ static void do_fallocate(fuse_req_t req, fuse_ino_t=
 nodeid, const void *inarg)
 }
=20
 static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in,
-                               const void *inarg)
+                               struct fuse_mbuf_iter *iter)
 {
-    struct fuse_copy_file_range_in *arg =3D
-        (struct fuse_copy_file_range_in *)inarg;
+    struct fuse_copy_file_range_in *arg;
     struct fuse_file_info fi_in, fi_out;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
     memset(&fi_in, 0, sizeof(fi_in));
     fi_in.fh =3D arg->fh_in;
=20
@@ -1537,11 +1846,17 @@ static void do_copy_file_range(fuse_req_t req, fuse=
_ino_t nodeid_in,
     }
 }
=20
-static void do_lseek(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_lseek(fuse_req_t req, fuse_ino_t nodeid,
+                     struct fuse_mbuf_iter *iter)
 {
-    struct fuse_lseek_in *arg =3D (struct fuse_lseek_in *)inarg;
+    struct fuse_lseek_in *arg;
     struct fuse_file_info fi;
=20
+    arg =3D fuse_mbuf_iter_advance(iter, sizeof(*arg));
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
     memset(&fi, 0, sizeof(fi));
     fi.fh =3D arg->fh;
=20
@@ -1552,15 +1867,33 @@ static void do_lseek(fuse_req_t req, fuse_ino_t nod=
eid, const void *inarg)
     }
 }
=20
-static void do_init(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+static void do_init(fuse_req_t req, fuse_ino_t nodeid,
+                    struct fuse_mbuf_iter *iter)
 {
-    struct fuse_init_in *arg =3D (struct fuse_init_in *)inarg;
+    size_t compat_size =3D offsetof(struct fuse_init_in, max_readahead);
+    struct fuse_init_in *arg;
     struct fuse_init_out outarg;
     struct fuse_session *se =3D req->se;
     size_t bufsize =3D se->bufsize;
     size_t outargsize =3D sizeof(outarg);
=20
     (void)nodeid;
+
+    /* First consume the old fields... */
+    arg =3D fuse_mbuf_iter_advance(iter, compat_size);
+    if (!arg) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    /* ...and now consume the new fields. */
+    if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
+        if (!fuse_mbuf_iter_advance(iter, sizeof(*arg) - compat_size)) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+    }
+
     if (se->debug) {
         fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
         if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
@@ -1793,12 +2126,13 @@ static void do_init(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
     send_reply_ok(req, &outarg, outargsize);
 }
=20
-static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
+static void do_destroy(fuse_req_t req, fuse_ino_t nodeid,
+                       struct fuse_mbuf_iter *iter)
 {
     struct fuse_session *se =3D req->se;
=20
     (void)nodeid;
-    (void)inarg;
+    (void)iter;
=20
     se->got_destroy =3D 1;
     if (se->op.destroy) {
@@ -1979,7 +2313,7 @@ int fuse_req_interrupted(fuse_req_t req)
 }
=20
 static struct {
-    void (*func)(fuse_req_t, fuse_ino_t, const void *);
+    void (*func)(fuse_req_t, fuse_ino_t, struct fuse_mbuf_iter *);
     const char *name;
 } fuse_ll_ops[] =3D {
     [FUSE_LOOKUP] =3D { do_lookup, "LOOKUP" },
@@ -2063,7 +2397,6 @@ void fuse_session_process_buf_int(struct fuse_session=
 *se,
     const struct fuse_buf *buf =3D bufv->buf;
     struct fuse_mbuf_iter iter =3D FUSE_MBUF_ITER_INIT(buf);
     struct fuse_in_header *in;
-    const void *inarg;
     struct fuse_req *req;
     int err;
=20
@@ -2141,13 +2474,11 @@ void fuse_session_process_buf_int(struct fuse_sessi=
on *se,
         }
     }
=20
-    inarg =3D (void *)&in[1];
     if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf) {
         do_write_buf(req, in->nodeid, &iter, bufv);
     } else {
-        fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
+        fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
     }
-
     return;
=20
 reply_err:
--=20
2.23.0


