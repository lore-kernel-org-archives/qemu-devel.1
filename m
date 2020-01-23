Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719462077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRwetfnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719462077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuh24-0005gv-1n
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdr-0004rm-Rm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdp-0006US-E6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52257
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdp-0006U3-A0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+VVKDRlmqTDGzPtjtgvCNUXgFQKQoxArBYRD9NTEhQ=;
 b=gRwetfnzO3e3rH3clnj4GO8zDRVdZ4btjdACVUXBHHIox+YcsE1HwdoWdaN6gxkpT/myv7
 z4B0edCBDchhoZLzZbsHF8Rv5K6kINf6Zzffr/d7kT0aYiVLNY5CdoE1iZT0VKESjI4G4r
 ySjsTUZ8AYtOwgtq5uDkkv45moQ8SBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-ljTH89EvM66TNB5u1ebJbg-1; Thu, 23 Jan 2020 11:47:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 839806B2E7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C05828993;
 Thu, 23 Jan 2020 16:47:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 036/108] virtiofsd: passthrough_ll: add ino_map to hide
 lo_inode pointers
Date: Thu, 23 Jan 2020 16:45:18 +0000
Message-Id: <20200123164630.91498-37-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ljTH89EvM66TNB5u1ebJbg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

Do not expose lo_inode pointers to clients.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 144 ++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 30 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e83a976587..a3ebf74eab 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -57,8 +57,8 @@
 #include "passthrough_helpers.h"
=20
 /*
- * We are re-using pointers to our `struct lo_inode` and `struct
- * lo_dirp` elements as inodes. This means that we must be able to
+ * We are re-using pointers to our `struct lo_inode`
+ * elements as inodes. This means that we must be able to
  * store uintptr_t values in a fuse_ino_t variable. The following
  * incantation checks this condition at compile time.
  */
@@ -76,7 +76,7 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
=20
 struct lo_map_elem {
     union {
-        /* Element values will go here... */
+        struct lo_inode *inode;
         ssize_t freelist;
     };
     bool in_use;
@@ -97,6 +97,7 @@ struct lo_inode {
     ino_t ino;
     dev_t dev;
     uint64_t refcount; /* protected by lo->mutex */
+    fuse_ino_t fuse_ino;
 };
=20
 struct lo_cred {
@@ -121,6 +122,7 @@ struct lo_data {
     int cache;
     int timeout_set;
     struct lo_inode root; /* protected by lo->mutex */
+    struct lo_map ino_map; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -145,14 +147,14 @@ static struct lo_data *lo_data(fuse_req_t req)
     return (struct lo_data *)fuse_req_userdata(req);
 }
=20
-__attribute__((unused)) static void lo_map_init(struct lo_map *map)
+static void lo_map_init(struct lo_map *map)
 {
     map->elems =3D NULL;
     map->nelems =3D 0;
     map->freelist =3D -1;
 }
=20
-__attribute__((unused)) static void lo_map_destroy(struct lo_map *map)
+static void lo_map_destroy(struct lo_map *map)
 {
     free(map->elems);
 }
@@ -183,8 +185,7 @@ static int lo_map_grow(struct lo_map *map, size_t new_n=
elems)
     return 1;
 }
=20
-__attribute__((unused)) static struct lo_map_elem *
-lo_map_alloc_elem(struct lo_map *map)
+static struct lo_map_elem *lo_map_alloc_elem(struct lo_map *map)
 {
     struct lo_map_elem *elem;
=20
@@ -200,8 +201,7 @@ lo_map_alloc_elem(struct lo_map *map)
     return elem;
 }
=20
-__attribute__((unused)) static struct lo_map_elem *
-lo_map_reserve(struct lo_map *map, size_t key)
+static struct lo_map_elem *lo_map_reserve(struct lo_map *map, size_t key)
 {
     ssize_t *prev;
=20
@@ -222,8 +222,7 @@ lo_map_reserve(struct lo_map *map, size_t key)
     return NULL;
 }
=20
-__attribute__((unused)) static struct lo_map_elem *
-lo_map_get(struct lo_map *map, size_t key)
+static struct lo_map_elem *lo_map_get(struct lo_map *map, size_t key)
 {
     if (key >=3D map->nelems) {
         return NULL;
@@ -234,8 +233,7 @@ lo_map_get(struct lo_map *map, size_t key)
     return &map->elems[key];
 }
=20
-__attribute__((unused)) static void lo_map_remove(struct lo_map *map,
-                                                  size_t key)
+static void lo_map_remove(struct lo_map *map, size_t key)
 {
     struct lo_map_elem *elem;
=20
@@ -254,18 +252,40 @@ __attribute__((unused)) static void lo_map_remove(str=
uct lo_map *map,
     map->freelist =3D key;
 }
=20
+/* Assumes lo->mutex is held */
+static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode=
)
+{
+    struct lo_map_elem *elem;
+
+    elem =3D lo_map_alloc_elem(&lo_data(req)->ino_map);
+    if (!elem) {
+        return -1;
+    }
+
+    elem->inode =3D inode;
+    return elem - lo_data(req)->ino_map.elems;
+}
+
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
-    if (ino =3D=3D FUSE_ROOT_ID) {
-        return &lo_data(req)->root;
-    } else {
-        return (struct lo_inode *)(uintptr_t)ino;
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_map_elem *elem;
+
+    pthread_mutex_lock(&lo->mutex);
+    elem =3D lo_map_get(&lo->ino_map, ino);
+    pthread_mutex_unlock(&lo->mutex);
+
+    if (!elem) {
+        return NULL;
     }
+
+    return elem->inode;
 }
=20
 static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 {
-    return lo_inode(req, ino)->fd;
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    return inode ? inode->fd : -1;
 }
=20
 static bool lo_debug(fuse_req_t req)
@@ -337,10 +357,18 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
 {
     int saverr;
     char procname[64];
-    struct lo_inode *inode =3D lo_inode(req, ino);
-    int ifd =3D inode->fd;
+    struct lo_inode *inode;
+    int ifd;
     int res;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
+    ifd =3D inode->fd;
+
     if (valid & FUSE_SET_ATTR_MODE) {
         if (fi) {
             res =3D fchmod(fi->fh, attr->st_mode);
@@ -470,6 +498,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         inode->dev =3D e->attr.st_dev;
=20
         pthread_mutex_lock(&lo->mutex);
+        inode->fuse_ino =3D lo_add_inode_mapping(req, inode);
         prev =3D &lo->root;
         next =3D prev->next;
         next->prev =3D inode;
@@ -478,7 +507,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         prev->next =3D inode;
         pthread_mutex_unlock(&lo->mutex);
     }
-    e->ino =3D (uintptr_t)inode;
+    e->ino =3D inode->fuse_ino;
=20
     if (lo_debug(req)) {
         fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
@@ -582,10 +611,16 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
 {
     int res;
     int saverr;
-    struct lo_inode *dir =3D lo_inode(req, parent);
+    struct lo_inode *dir;
     struct fuse_entry_param e;
     struct lo_cred old =3D {};
=20
+    dir =3D lo_inode(req, parent);
+    if (!dir) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     saverr =3D ENOMEM;
=20
     saverr =3D lo_change_cred(req, &old);
@@ -663,10 +698,16 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
 {
     int res;
     struct lo_data *lo =3D lo_data(req);
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
     struct fuse_entry_param e;
     int saverr;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     memset(&e, 0, sizeof(struct fuse_entry_param));
     e.attr_timeout =3D lo->timeout;
     e.entry_timeout =3D lo->timeout;
@@ -684,7 +725,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fus=
e_ino_t parent,
     pthread_mutex_lock(&lo->mutex);
     inode->refcount++;
     pthread_mutex_unlock(&lo->mutex);
-    e.ino =3D (uintptr_t)inode;
+    e.ino =3D inode->fuse_ino;
=20
     if (lo_debug(req)) {
         fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
@@ -750,10 +791,10 @@ static void unref_inode(struct lo_data *lo, struct lo=
_inode *inode, uint64_t n)
         next->prev =3D prev;
         prev->next =3D next;
=20
+        lo_map_remove(&lo->ino_map, inode->fuse_ino);
         pthread_mutex_unlock(&lo->mutex);
         close(inode->fd);
         free(inode);
-
     } else {
         pthread_mutex_unlock(&lo->mutex);
     }
@@ -762,7 +803,12 @@ static void unref_inode(struct lo_data *lo, struct lo_=
inode *inode, uint64_t n)
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
     struct lo_data *lo =3D lo_data(req);
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
+
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        return;
+    }
=20
     if (lo_debug(req)) {
         fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
@@ -1244,10 +1290,16 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
 {
     char *value =3D NULL;
     char procname[64];
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
     ssize_t ret;
     int saverr;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     saverr =3D ENOSYS;
     if (!lo_data(req)->xattr) {
         goto out;
@@ -1306,10 +1358,16 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
 {
     char *value =3D NULL;
     char procname[64];
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
     ssize_t ret;
     int saverr;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     saverr =3D ENOSYS;
     if (!lo_data(req)->xattr) {
         goto out;
@@ -1367,10 +1425,16 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
                         const char *value, size_t size, int flags)
 {
     char procname[64];
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
     ssize_t ret;
     int saverr;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     saverr =3D ENOSYS;
     if (!lo_data(req)->xattr) {
         goto out;
@@ -1400,10 +1464,16 @@ out:
 static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
 {
     char procname[64];
-    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_inode *inode;
     ssize_t ret;
     int saverr;
=20
+    inode =3D lo_inode(req, ino);
+    if (!inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     saverr =3D ENOSYS;
     if (!lo_data(req)->xattr) {
         goto out;
@@ -1522,6 +1592,7 @@ int main(int argc, char *argv[])
     struct fuse_session *se;
     struct fuse_cmdline_opts opts;
     struct lo_data lo =3D { .debug =3D 0, .writeback =3D 0 };
+    struct lo_map_elem *root_elem;
     int ret =3D -1;
=20
     /* Don't mask creation mode, kernel already did that */
@@ -1530,8 +1601,19 @@ int main(int argc, char *argv[])
     pthread_mutex_init(&lo.mutex, NULL);
     lo.root.next =3D lo.root.prev =3D &lo.root;
     lo.root.fd =3D -1;
+    lo.root.fuse_ino =3D FUSE_ROOT_ID;
     lo.cache =3D CACHE_NORMAL;
=20
+    /*
+     * Set up the ino map like this:
+     * [0] Reserved (will not be used)
+     * [1] Root inode
+     */
+    lo_map_init(&lo.ino_map);
+    lo_map_reserve(&lo.ino_map, 0)->in_use =3D false;
+    root_elem =3D lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
+    root_elem->inode =3D &lo.root;
+
     if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
         return 1;
     }
@@ -1628,6 +1710,8 @@ err_out2:
 err_out1:
     fuse_opt_free_args(&args);
=20
+    lo_map_destroy(&lo.ino_map);
+
     if (lo.root.fd >=3D 0) {
         close(lo.root.fd);
     }
--=20
2.24.1


