Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A827C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78C621569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVkm74vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78C621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittPc-0001L0-7D
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itscw-0007UU-9a
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itscu-0002k5-M1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsct-0002jO-Rw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pEkkZ7XH2L3BLblUGK/p2Uzth+/Msrj8Lpi/38xr4y4=;
 b=jVkm74vkgaTWIMLjSjzCODSlB5WiHzfEf/FocclM9vleSJHN/+//YmkGEQxP3HdfB8xo3H
 510KpZPcSdY6+08iTocCiSU/xp8HLCfqPXNxslyimgf1sdwcolj78yHd1Da3bYqeTvv7Qw
 78S1ZZO5yIOXnSurHbKQtqOpIBZb6SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-NMf8nvETOpilnpe7e270kw-1; Tue, 21 Jan 2020 07:27:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15BDB190D340;
 Tue, 21 Jan 2020 12:27:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8B2560BE0;
 Tue, 21 Jan 2020 12:27:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 036/109] virtiofsd: passthrough_ll: add dirp_map to hide
 lo_dirp pointers
Date: Tue, 21 Jan 2020 12:23:20 +0000
Message-Id: <20200121122433.50803-37-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NMf8nvETOpilnpe7e270kw-1
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

Do not expose lo_dirp pointers to clients.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 103 +++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 27 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 6896875465..927473d74a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -55,27 +55,10 @@
=20
 #include "passthrough_helpers.h"
=20
-/*
- * We are re-using pointers to our `struct lo_inode`
- * elements as inodes. This means that we must be able to
- * store uintptr_t values in a fuse_ino_t variable. The following
- * incantation checks this condition at compile time.
- */
-#if defined(__GNUC__) &&                                      \
-    (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 6) && \
-    !defined __cplusplus
-_Static_assert(sizeof(fuse_ino_t) >=3D sizeof(uintptr_t),
-               "fuse_ino_t too small to hold uintptr_t values!");
-#else
-struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
-    unsigned _uintptr_to_must_hold_fuse_ino_t
-        : ((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1);
-};
-#endif
-
 struct lo_map_elem {
     union {
         struct lo_inode *inode;
+        struct lo_dirp *dirp;
         ssize_t freelist;
     };
     bool in_use;
@@ -122,6 +105,7 @@ struct lo_data {
     int timeout_set;
     struct lo_inode root; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
+    struct lo_map dirp_map; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -251,6 +235,20 @@ static void lo_map_remove(struct lo_map *map, size_t k=
ey)
     map->freelist =3D key;
 }
=20
+/* Assumes lo->mutex is held */
+static ssize_t lo_add_dirp_mapping(fuse_req_t req, struct lo_dirp *dirp)
+{
+    struct lo_map_elem *elem;
+
+    elem =3D lo_map_alloc_elem(&lo_data(req)->dirp_map);
+    if (!elem) {
+        return -1;
+    }
+
+    elem->dirp =3D dirp;
+    return elem - lo_data(req)->dirp_map.elems;
+}
+
 /* Assumes lo->mutex is held */
 static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode=
)
 {
@@ -860,9 +858,19 @@ struct lo_dirp {
     off_t offset;
 };
=20
-static struct lo_dirp *lo_dirp(struct fuse_file_info *fi)
+static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi)
 {
-    return (struct lo_dirp *)(uintptr_t)fi->fh;
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_map_elem *elem;
+
+    pthread_mutex_lock(&lo->mutex);
+    elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+    pthread_mutex_unlock(&lo->mutex);
+    if (!elem) {
+        return NULL;
+    }
+
+    return elem->dirp;
 }
=20
 static void lo_opendir(fuse_req_t req, fuse_ino_t ino,
@@ -872,6 +880,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino,
     struct lo_data *lo =3D lo_data(req);
     struct lo_dirp *d;
     int fd;
+    ssize_t fh;
=20
     d =3D calloc(1, sizeof(struct lo_dirp));
     if (d =3D=3D NULL) {
@@ -891,7 +900,14 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino,
     d->offset =3D 0;
     d->entry =3D NULL;
=20
-    fi->fh =3D (uintptr_t)d;
+    pthread_mutex_lock(&lo->mutex);
+    fh =3D lo_add_dirp_mapping(req, d);
+    pthread_mutex_unlock(&lo->mutex);
+    if (fh =3D=3D -1) {
+        goto out_err;
+    }
+
+    fi->fh =3D fh;
     if (lo->cache =3D=3D CACHE_ALWAYS) {
         fi->keep_cache =3D 1;
     }
@@ -902,6 +918,9 @@ out_errno:
     error =3D errno;
 out_err:
     if (d) {
+        if (d->dp) {
+            closedir(d->dp);
+        }
         if (fd !=3D -1) {
             close(fd);
         }
@@ -919,17 +938,21 @@ static int is_dot_or_dotdot(const char *name)
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
                           off_t offset, struct fuse_file_info *fi, int plu=
s)
 {
-    struct lo_dirp *d =3D lo_dirp(fi);
-    char *buf;
+    struct lo_dirp *d;
+    char *buf =3D NULL;
     char *p;
     size_t rem =3D size;
-    int err;
+    int err =3D ENOMEM;
=20
     (void)ino;
=20
+    d =3D lo_dirp(req, fi);
+    if (!d) {
+        goto error;
+    }
+
     buf =3D calloc(1, size);
     if (!buf) {
-        err =3D ENOMEM;
         goto error;
     }
     p =3D buf;
@@ -1027,8 +1050,21 @@ static void lo_readdirplus(fuse_req_t req, fuse_ino_=
t ino, size_t size,
 static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
                           struct fuse_file_info *fi)
 {
-    struct lo_dirp *d =3D lo_dirp(fi);
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_dirp *d;
+
     (void)ino;
+
+    d =3D lo_dirp(req, fi);
+    if (!d) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
+    pthread_mutex_lock(&lo->mutex);
+    lo_map_remove(&lo->dirp_map, fi->fh);
+    pthread_mutex_unlock(&lo->mutex);
+
     closedir(d->dp);
     free(d);
     fuse_reply_err(req, 0);
@@ -1080,8 +1116,18 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t i=
no, int datasync,
                         struct fuse_file_info *fi)
 {
     int res;
-    int fd =3D dirfd(lo_dirp(fi)->dp);
+    struct lo_dirp *d;
+    int fd;
+
     (void)ino;
+
+    d =3D lo_dirp(req, fi);
+    if (!d) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
+    fd =3D dirfd(d->dp);
     if (datasync) {
         res =3D fdatasync(fd);
     } else {
@@ -1613,6 +1659,8 @@ int main(int argc, char *argv[])
     root_elem =3D lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
     root_elem->inode =3D &lo.root;
=20
+    lo_map_init(&lo.dirp_map);
+
     if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
         return 1;
     }
@@ -1709,6 +1757,7 @@ err_out2:
 err_out1:
     fuse_opt_free_args(&args);
=20
+    lo_map_destroy(&lo.dirp_map);
     lo_map_destroy(&lo.ino_map);
=20
     if (lo.root.fd >=3D 0) {
--=20
2.24.1


