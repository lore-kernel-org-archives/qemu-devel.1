Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E912FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC774214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex6YU7gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC774214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSTj-0004dj-E7
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWQ-0006yP-P7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWP-0003fc-9d
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWP-0003ek-4f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVR0S2kuSuY8E45IqUFeGJjMlxxCDS3mETFeqkFImwQ=;
 b=ex6YU7gSJw8i2agmLgbv6JtPIcJZmnQT4TjFOI5DKtYJPsB91F8tRiWJ/ePhqPuaF53n5a
 5/+zEyVxZxrAxImnshHq/++X5sbS/fvnDUJ6pYE2CQkVF7/rGEemY0dgEakxluj2Yft0Zk
 HzSy9+sqpGkxNRdkwMJVbJtYh6TWFTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-we4zCQytMyeXW5_PclPcVQ-1; Thu, 12 Dec 2019 11:40:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33FE6800D5A
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 581A860BF3;
 Thu, 12 Dec 2019 16:40:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 074/104] virtiofsd: passthrough_ll: use hashtable
Date: Thu, 12 Dec 2019 16:38:34 +0000
Message-Id: <20191212163904.159893-75-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: we4zCQytMyeXW5_PclPcVQ-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

Improve performance of inode lookup by using a hash table.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 81 ++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index cd26db74cf..bbc5f0981e 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -85,13 +85,15 @@ struct lo_map {
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
@@ -120,7 +122,8 @@ struct lo_data {
     int timeout_set;
     int readdirplus_set;
     int readdirplus_clear;
-    struct lo_inode root; /* protected by lo->mutex */
+    struct lo_inode root;
+    GHashTable *inodes; /* protected by lo->mutex */
     struct lo_map ino_map; /* protected by lo->mutex */
     struct lo_map dirp_map; /* protected by lo->mutex */
     struct lo_map fd_map; /* protected by lo->mutex */
@@ -574,7 +577,7 @@ retry:
         }
         goto fail_unref;
     }
-    if (stat.st_dev !=3D inode->dev || stat.st_ino !=3D inode->ino) {
+    if (stat.st_dev !=3D inode->key.dev || stat.st_ino !=3D inode->key.ino=
) {
         if (!retries) {
             fuse_log(FUSE_LOG_WARNING,
                      "lo_parent_and_name: failed to match last\n");
@@ -754,19 +757,20 @@ out_err:
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
@@ -811,8 +815,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         close(newfd);
         newfd =3D -1;
     } else {
-        struct lo_inode *prev, *next;
-
         saverr =3D ENOMEM;
         inode =3D calloc(1, sizeof(struct lo_inode));
         if (!inode) {
@@ -823,17 +825,12 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
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
@@ -1194,14 +1191,8 @@ static void unref_inode_lolocked(struct lo_data *lo,=
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
@@ -1401,7 +1392,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
=20
         /* Hide root's parent directory */
         if (dinode =3D=3D &lo->root && strcmp(name, "..") =3D=3D 0) {
-            e.attr.st_ino =3D lo->root.ino;
+            e.attr.st_ino =3D lo->root.key.ino;
             e.attr.st_mode =3D DT_DIR << 12;
         }
=20
@@ -2402,11 +2393,26 @@ static void setup_root(struct lo_data *lo, struct l=
o_inode *root)
     }
=20
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
@@ -2424,7 +2430,7 @@ int main(int argc, char *argv[])
     umask(0);
=20
     pthread_mutex_init(&lo.mutex, NULL);
-    lo.root.next =3D lo.root.prev =3D &lo.root;
+    lo.inodes =3D g_hash_table_new(lo_key_hash, lo_key_equal);
     lo.root.fd =3D -1;
     lo.root.fuse_ino =3D FUSE_ROOT_ID;
     lo.cache =3D CACHE_AUTO;
@@ -2562,6 +2568,9 @@ err_out2:
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
2.23.0


