Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF915C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA442077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr9FQovz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA442077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuidM-0005IT-OH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufeX-0005gS-Cj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeV-0007WP-MY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeV-0007Vc-Iv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUS2SXabuzTnbWWfW9WfG206NGyKVphzTRYIpPi52s0=;
 b=Xr9FQovzuY/PEozBFsMoQJ7N00gEBtPbn5Ebd4Il0yLuRbyjVd0nR3IKM9h3WUNAkcrtYj
 IlrOAM+7uJRKzaHqW/ZjinSo6RxWKa4BOMHN3elkIg+uojKJcLUFFhb/vIbbfDasGQMzUS
 cscUeCqjXei/zuWATiRCMK8ZpVxLeOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Z5avmfMsM52mrSxLHWmKwQ-1; Thu, 23 Jan 2020 11:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3061803A3C
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ADE119C69;
 Thu, 23 Jan 2020 16:48:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 074/108] virtiofsd: passthrough_ll: use hashtable
Date: Thu, 23 Jan 2020 16:45:56 +0000
Message-Id: <20200123164630.91498-75-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Z5avmfMsM52mrSxLHWmKwQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Miklos Szeredi <mszeredi@redhat.com>

Improve performance of inode lookup by using a hash table.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 81 ++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index b40f2874a7..b176a314d6 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -84,13 +84,15 @@ struct lo_map {
     ssize_t freelist;
 };
=20
+struct lo_key {
+    ino_t ino;
+    dev_t dev;
+};
+
 struct lo_inode {
-    struct lo_inode *next; /* protected by lo->mutex */
-    struct lo_inode *prev; /* protected by lo->mutex */
     int fd;
     bool is_symlink;
-    ino_t ino;
-    dev_t dev;
+    struct lo_key key;
     uint64_t refcount; /* protected by lo->mutex */
     fuse_ino_t fuse_ino;
 };
@@ -119,7 +121,8 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
-    struct lo_inode root; /* protected by lo->mutex */
+    struct lo_inode root;
+    GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
     struct lo_map dirp_map; /* protected by lo->mutex */
     struct lo_map fd_map; /* protected by lo->mutex */
@@ -573,7 +576,7 @@ retry:
         }
         goto fail_unref;
     }
-    if (stat.st_dev !=3D inode->dev || stat.st_ino !=3D inode->ino) {
+    if (stat.st_dev !=3D inode->key.dev || stat.st_ino !=3D inode->key.ino=
) {
         if (!retries) {
             fuse_log(FUSE_LOG_WARNING,
                      "%s: failed to match last\n", __func__);
@@ -753,19 +756,20 @@ out_err:
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st)
 {
     struct lo_inode *p;
-    struct lo_inode *ret =3D NULL;
+    struct lo_key key =3D {
+        .ino =3D st->st_ino,
+        .dev =3D st->st_dev,
+    };
=20
     pthread_mutex_lock(&lo->mutex);
-    for (p =3D lo->root.next; p !=3D &lo->root; p =3D p->next) {
-        if (p->ino =3D=3D st->st_ino && p->dev =3D=3D st->st_dev) {
-            assert(p->refcount > 0);
-            ret =3D p;
-            ret->refcount++;
-            break;
-        }
+    p =3D g_hash_table_lookup(lo->inodes, &key);
+    if (p) {
+        assert(p->refcount > 0);
+        p->refcount++;
     }
     pthread_mutex_unlock(&lo->mutex);
-    return ret;
+
+    return p;
 }
=20
 static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
@@ -810,8 +814,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         close(newfd);
         newfd =3D -1;
     } else {
-        struct lo_inode *prev, *next;
-
         saverr =3D ENOMEM;
         inode =3D calloc(1, sizeof(struct lo_inode));
         if (!inode) {
@@ -822,17 +824,12 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
         inode->refcount =3D 1;
         inode->fd =3D newfd;
         newfd =3D -1;
-        inode->ino =3D e->attr.st_ino;
-        inode->dev =3D e->attr.st_dev;
+        inode->key.ino =3D e->attr.st_ino;
+        inode->key.dev =3D e->attr.st_dev;
=20
         pthread_mutex_lock(&lo->mutex);
         inode->fuse_ino =3D lo_add_inode_mapping(req, inode);
-        prev =3D &lo->root;
-        next =3D prev->next;
-        next->prev =3D inode;
-        inode->next =3D next;
-        inode->prev =3D prev;
-        prev->next =3D inode;
+        g_hash_table_insert(lo->inodes, &inode->key, inode);
         pthread_mutex_unlock(&lo->mutex);
     }
     e->ino =3D inode->fuse_ino;
@@ -1162,14 +1159,8 @@ static void unref_inode_lolocked(struct lo_data *lo,=
 struct lo_inode *inode,
     assert(inode->refcount >=3D n);
     inode->refcount -=3D n;
     if (!inode->refcount) {
-        struct lo_inode *prev, *next;
-
-        prev =3D inode->prev;
-        next =3D inode->next;
-        next->prev =3D prev;
-        prev->next =3D next;
-
         lo_map_remove(&lo->ino_map, inode->fuse_ino);
+        g_hash_table_remove(lo->inodes, &inode->key);
         pthread_mutex_unlock(&lo->mutex);
         close(inode->fd);
         free(inode);
@@ -1369,7 +1360,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
=20
         /* Hide root's parent directory */
         if (dinode =3D=3D &lo->root && strcmp(name, "..") =3D=3D 0) {
-            e.attr.st_ino =3D lo->root.ino;
+            e.attr.st_ino =3D lo->root.key.ino;
             e.attr.st_mode =3D DT_DIR << 12;
         }
=20
@@ -2370,11 +2361,26 @@ static void setup_root(struct lo_data *lo, struct l=
o_inode *root)
=20
     root->is_symlink =3D false;
     root->fd =3D fd;
-    root->ino =3D stat.st_ino;
-    root->dev =3D stat.st_dev;
+    root->key.ino =3D stat.st_ino;
+    root->key.dev =3D stat.st_dev;
     root->refcount =3D 2;
 }
=20
+static guint lo_key_hash(gconstpointer key)
+{
+    const struct lo_key *lkey =3D key;
+
+    return (guint)lkey->ino + (guint)lkey->dev;
+}
+
+static gboolean lo_key_equal(gconstpointer a, gconstpointer b)
+{
+    const struct lo_key *la =3D a;
+    const struct lo_key *lb =3D b;
+
+    return la->ino =3D=3D lb->ino && la->dev =3D=3D lb->dev;
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2392,7 +2398,7 @@ int main(int argc, char *argv[])
     umask(0);
=20
     pthread_mutex_init(&lo.mutex, NULL);
-    lo.root.next =3D lo.root.prev =3D &lo.root;
+    lo.inodes =3D g_hash_table_new(lo_key_hash, lo_key_equal);
     lo.root.fd =3D -1;
     lo.root.fuse_ino =3D FUSE_ROOT_ID;
     lo.cache =3D CACHE_AUTO;
@@ -2522,6 +2528,9 @@ err_out2:
 err_out1:
     fuse_opt_free_args(&args);
=20
+    if (lo.inodes) {
+        g_hash_table_destroy(lo.inodes);
+    }
     lo_map_destroy(&lo.fd_map);
     lo_map_destroy(&lo.dirp_map);
     lo_map_destroy(&lo.ino_map);
--=20
2.24.1


