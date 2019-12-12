Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1FEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C311320637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf2+XyBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C311320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSuE-0000Zx-Ig
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX0-0007m3-UM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWy-0004lC-HJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWy-0004k6-Ag
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvKRuNvSUW8AajpGt7DaNMhKhAD4n3OM3d2xsR7efGw=;
 b=Jf2+XyBrlcHThTX+SWR72EwaRqovepk7y/vavG0Pp9DBF7z2Hk07QrDacHC5hpjGrrLZ/1
 BdyYTXCPWVcX0VT5I875VYUc7Wf4QTLewfKdTpVyrPtvioL4vYlpkpFytpKLl/yj2+GboI
 HNvdqJPS8/TRH5xIazrOWajN07AvWF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-9w_1ciaSMbKsmetRH5SlKQ-1; Thu, 12 Dec 2019 11:41:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 888698005B2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB2B460BE1;
 Thu, 12 Dec 2019 16:41:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
Date: Thu, 12 Dec 2019 16:38:53 +0000
Message-Id: <20191212163904.159893-94-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9w_1ciaSMbKsmetRH5SlKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

If thread A is using an inode it must not be deleted by thread B when
processing a FUSE_FORGET request.

The FUSE protocol itself already has a counter called nlookup that is
used in FUSE_FORGET messages.  We cannot trust this counter since the
untrusted client can manipulate it via FUSE_FORGET messages.

Introduce a new refcount to keep inodes alive for the required lifespan.
lo_inode_put() must be called to release a reference.  FUSE's nlookup
counter holds exactly one reference so that the inode stays alive as
long as the client still wants to remember it.

Note that the lo_inode->is_symlink field is moved to avoid creating a
hole in the struct due to struct field alignment.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 168 ++++++++++++++++++++++++++-----
 1 file changed, 145 insertions(+), 23 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index b19c9ee328..8f4ab8351c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -99,7 +99,13 @@ struct lo_key {
=20
 struct lo_inode {
     int fd;
-    bool is_symlink;
+
+    /*
+     * Atomic reference count for this object.  The nlookup field holds a
+     * reference and release it when nlookup reaches 0.
+     */
+    gint refcount;
+
     struct lo_key key;
=20
     /*
@@ -118,6 +124,8 @@ struct lo_inode {
     fuse_ino_t fuse_ino;
     pthread_mutex_t plock_mutex;
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
+
+    bool is_symlink;
 };
=20
 struct lo_cred {
@@ -473,6 +481,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t req, st=
ruct lo_inode *inode)
     return elem - lo_data(req)->ino_map.elems;
 }
=20
+static void lo_inode_put(struct lo_data *lo, struct lo_inode **inodep)
+{
+    struct lo_inode *inode =3D *inodep;
+
+    if (!inode) {
+        return;
+    }
+
+    *inodep =3D NULL;
+
+    if (g_atomic_int_dec_and_test(&inode->refcount)) {
+        close(inode->fd);
+        free(inode);
+    }
+}
+
+/* Caller must release refcount using lo_inode_put() */
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
     struct lo_data *lo =3D lo_data(req);
@@ -480,6 +505,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse_i=
no_t ino)
=20
     pthread_mutex_lock(&lo->mutex);
     elem =3D lo_map_get(&lo->ino_map, ino);
+    if (elem) {
+        g_atomic_int_inc(&elem->inode->refcount);
+    }
     pthread_mutex_unlock(&lo->mutex);
=20
     if (!elem) {
@@ -489,10 +517,23 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse=
_ino_t ino)
     return elem->inode;
 }
=20
+/*
+ * TODO Remove this helper and force callers to hold an inode refcount unt=
il
+ * they are done with the fd.  This will be done in a later patch to make
+ * review easier.
+ */
 static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 {
     struct lo_inode *inode =3D lo_inode(req, ino);
-    return inode ? inode->fd : -1;
+    int fd;
+
+    if (!inode) {
+        return -1;
+    }
+
+    fd =3D inode->fd;
+    lo_inode_put(lo_data(req), &inode);
+    return fd;
 }
=20
 static void lo_init(void *userdata, struct fuse_conn_info *conn)
@@ -547,6 +588,10 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
     fuse_reply_attr(req, &buf, lo->timeout);
 }
=20
+/*
+ * Increments parent->nlookup and caller must release refcount using
+ * lo_inode_put(&parent).
+ */
 static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
                               char path[PATH_MAX], struct lo_inode **paren=
t)
 {
@@ -584,6 +629,7 @@ retry:
         p =3D &lo->root;
         pthread_mutex_lock(&lo->mutex);
         p->nlookup++;
+        g_atomic_int_inc(&p->refcount);
         pthread_mutex_unlock(&lo->mutex);
     } else {
         *last =3D '\0';
@@ -665,6 +711,7 @@ fallback:
     if (res !=3D -1) {
         res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
         unref_inode_lolocked(lo, parent, 1);
+        lo_inode_put(lo, &parent);
     }
=20
     return res;
@@ -782,11 +829,13 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
             goto out_err;
         }
     }
+    lo_inode_put(lo, &inode);
=20
     return lo_getattr(req, ino, fi);
=20
 out_err:
     saverr =3D errno;
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
@@ -803,6 +852,7 @@ static struct lo_inode *lo_find(struct lo_data *lo, str=
uct stat *st)
     if (p) {
         assert(p->nlookup > 0);
         p->nlookup++;
+        g_atomic_int_inc(&p->refcount);
     }
     pthread_mutex_unlock(&lo->mutex);
=20
@@ -822,6 +872,10 @@ static void posix_locks_value_destroy(gpointer data)
     free(plock);
 }
=20
+/*
+ * Increments nlookup and caller must release refcount using
+ * lo_inode_put(&parent).
+ */
 static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
                         struct fuse_entry_param *e)
 {
@@ -829,7 +883,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     int res;
     int saverr;
     struct lo_data *lo =3D lo_data(req);
-    struct lo_inode *inode, *dir =3D lo_inode(req, parent);
+    struct lo_inode *inode =3D NULL;
+    struct lo_inode *dir =3D lo_inode(req, parent);
=20
     /*
      * name_to_handle_at() and open_by_handle_at() can reach here with fus=
e
@@ -870,6 +925,13 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
         }
=20
         inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
+
+        /*
+         * One for the caller and one for nlookup (released in
+         * unref_inode_lolocked())
+         */
+        g_atomic_int_set(&inode->refcount, 2);
+
         inode->nlookup =3D 1;
         inode->fd =3D newfd;
         newfd =3D -1;
@@ -885,6 +947,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         pthread_mutex_unlock(&lo->mutex);
     }
     e->ino =3D inode->fuse_ino;
+    lo_inode_put(lo, &inode);
+    lo_inode_put(lo, &dir);
=20
     fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n", (unsigned long long)pa=
rent,
              name, (unsigned long long)e->ino);
@@ -896,6 +960,8 @@ out_err:
     if (newfd !=3D -1) {
         close(newfd);
     }
+    lo_inode_put(lo, &inode);
+    lo_inode_put(lo, &dir);
     return saverr;
 }
=20
@@ -976,6 +1042,7 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
t parent,
 {
     int res;
     int saverr;
+    struct lo_data *lo =3D lo_data(req);
     struct lo_inode *dir;
     struct fuse_entry_param e;
     struct lo_cred old =3D {};
@@ -1017,9 +1084,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_in=
o_t parent,
              name, (unsigned long long)e.ino);
=20
     fuse_reply_entry(req, &e);
+    lo_inode_put(lo, &dir);
     return;
=20
 out:
+    lo_inode_put(lo, &dir);
     fuse_reply_err(req, saverr);
 }
=20
@@ -1070,6 +1139,7 @@ fallback:
     if (res !=3D -1) {
         res =3D linkat(parent->fd, path, dfd, name, 0);
         unref_inode_lolocked(lo, parent, 1);
+        lo_inode_put(lo, &parent);
     }
=20
     return res;
@@ -1080,6 +1150,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
 {
     int res;
     struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *parent_inode;
     struct lo_inode *inode;
     struct fuse_entry_param e;
     int saverr;
@@ -1089,17 +1160,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
         return;
     }
=20
+    parent_inode =3D lo_inode(req, parent);
     inode =3D lo_inode(req, ino);
-    if (!inode) {
-        fuse_reply_err(req, EBADF);
-        return;
+    if (!parent_inode || !inode) {
+        errno =3D EBADF;
+        goto out_err;
     }
=20
     memset(&e, 0, sizeof(struct fuse_entry_param));
     e.attr_timeout =3D lo->timeout;
     e.entry_timeout =3D lo->timeout;
=20
-    res =3D linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name);
+    res =3D linkat_empty_nofollow(lo, inode, parent_inode->fd, name);
     if (res =3D=3D -1) {
         goto out_err;
     }
@@ -1118,13 +1190,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
              name, (unsigned long long)e.ino);
=20
     fuse_reply_entry(req, &e);
+    lo_inode_put(lo, &parent_inode);
+    lo_inode_put(lo, &inode);
     return;
=20
 out_err:
     saverr =3D errno;
+    lo_inode_put(lo, &parent_inode);
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
+/* Increments nlookup and caller must release refcount using lo_inode_put(=
) */
 static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
                                     const char *name)
 {
@@ -1161,6 +1238,7 @@ static void lo_rmdir(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
     unref_inode_lolocked(lo, inode, 1);
+    lo_inode_put(lo, &inode);
 }
=20
 static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1168,8 +1246,10 @@ static void lo_rename(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
                       unsigned int flags)
 {
     int res;
-    struct lo_inode *oldinode;
-    struct lo_inode *newinode;
+    struct lo_inode *parent_inode;
+    struct lo_inode *newparent_inode;
+    struct lo_inode *oldinode =3D NULL;
+    struct lo_inode *newinode =3D NULL;
     struct lo_data *lo =3D lo_data(req);
=20
     if (!is_safe_path_component(name) || !is_safe_path_component(newname))=
 {
@@ -1177,6 +1257,13 @@ static void lo_rename(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
         return;
     }
=20
+    parent_inode =3D lo_inode(req, parent);
+    newparent_inode =3D lo_inode(req, newparent);
+    if (!parent_inode || !newparent_inode) {
+        fuse_reply_err(req, EBADF);
+        goto out;
+    }
+
     oldinode =3D lookup_name(req, parent, name);
     newinode =3D lookup_name(req, newparent, newname);
=20
@@ -1189,8 +1276,8 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 #ifndef SYS_renameat2
         fuse_reply_err(req, EINVAL);
 #else
-        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
-                      lo_fd(req, newparent), newname, flags);
+        res =3D syscall(SYS_renameat2, parent_inode->fd, name,
+                      newparent_inode->fd, newname, flags);
         if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
             fuse_reply_err(req, EINVAL);
         } else {
@@ -1200,12 +1287,16 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
         goto out;
     }
=20
-    res =3D renameat(lo_fd(req, parent), name, lo_fd(req, newparent), newn=
ame);
+    res =3D renameat(parent_inode->fd, name, newparent_inode->fd, newname)=
;
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 out:
     unref_inode_lolocked(lo, oldinode, 1);
     unref_inode_lolocked(lo, newinode, 1);
+    lo_inode_put(lo, &oldinode);
+    lo_inode_put(lo, &newinode);
+    lo_inode_put(lo, &parent_inode);
+    lo_inode_put(lo, &newparent_inode);
 }
=20
 static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *name)
@@ -1229,6 +1320,7 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pare=
nt, const char *name)
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
     unref_inode_lolocked(lo, inode, 1);
+    lo_inode_put(lo, &inode);
 }
=20
 static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
@@ -1250,8 +1342,9 @@ static void unref_inode_lolocked(struct lo_data *lo, =
struct lo_inode *inode,
         g_hash_table_destroy(inode->posix_locks);
         pthread_mutex_destroy(&inode->plock_mutex);
         pthread_mutex_unlock(&lo->mutex);
-        close(inode->fd);
-        free(inode);
+
+        /* Drop our refcount from lo_do_lookup() */
+        lo_inode_put(lo, &inode);
     } else {
         pthread_mutex_unlock(&lo->mutex);
     }
@@ -1265,6 +1358,7 @@ static int unref_all_inodes_cb(gpointer key, gpointer=
 value, gpointer user_data)
     inode->nlookup =3D 0;
     lo_map_remove(&lo->ino_map, inode->fuse_ino);
     close(inode->fd);
+    lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
=20
     return TRUE;
 }
@@ -1291,6 +1385,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
ino, uint64_t nlookup)
              (unsigned long long)nlookup);
=20
     unref_inode_lolocked(lo, inode, nlookup);
+    lo_inode_put(lo, &inode);
 }
=20
 static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
@@ -1522,6 +1617,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
     err =3D 0;
 error:
     lo_dirp_put(&d);
+    lo_inode_put(lo, &dinode);
=20
     /*
      * If there's an error, we can only signal it if we haven't stored
@@ -1580,6 +1676,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 {
     int fd;
     struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *parent_inode;
     struct fuse_entry_param e;
     int err;
     struct lo_cred old =3D {};
@@ -1592,12 +1689,18 @@ static void lo_create(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
         return;
     }
=20
+    parent_inode =3D lo_inode(req, parent);
+    if (!parent_inode) {
+        fuse_reply_err(req, EBADF);
+        return;
+    }
+
     err =3D lo_change_cred(req, &old);
     if (err) {
         goto out;
     }
=20
-    fd =3D openat(lo_fd(req, parent), name, (fi->flags | O_CREAT) & ~O_NOF=
OLLOW,
+    fd =3D openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOL=
LOW,
                 mode);
     err =3D fd =3D=3D -1 ? errno : 0;
     lo_restore_cred(&old);
@@ -1610,8 +1713,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         pthread_mutex_unlock(&lo->mutex);
         if (fh =3D=3D -1) {
             close(fd);
-            fuse_reply_err(req, ENOMEM);
-            return;
+            err =3D ENOMEM;
+            goto out;
         }
=20
         fi->fh =3D fh;
@@ -1624,6 +1727,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     }
=20
 out:
+    lo_inode_put(lo, &parent_inode);
+
     if (err) {
         fuse_reply_err(req, err);
     } else {
@@ -1697,16 +1802,18 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi,
     plock =3D
         lookup_create_plock_ctx(lo, inode, fi->lock_owner, lock->l_pid, &r=
et);
     if (!plock) {
-        pthread_mutex_unlock(&inode->plock_mutex);
-        fuse_reply_err(req, ret);
-        return;
+        saverr =3D ret;
+        goto out;
     }
=20
     ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
     if (ret =3D=3D -1) {
         saverr =3D errno;
     }
+
+out:
     pthread_mutex_unlock(&inode->plock_mutex);
+    lo_inode_put(lo, &inode);
=20
     if (saverr) {
         fuse_reply_err(req, saverr);
@@ -1746,9 +1853,8 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi,
         lookup_create_plock_ctx(lo, inode, fi->lock_owner, lock->l_pid, &r=
et);
=20
     if (!plock) {
-        pthread_mutex_unlock(&inode->plock_mutex);
-        fuse_reply_err(req, ret);
-        return;
+        saverr =3D ret;
+        goto out;
     }
=20
     /* TODO: Is it alright to modify flock? */
@@ -1757,7 +1863,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,=
 struct fuse_file_info *fi,
     if (ret =3D=3D -1) {
         saverr =3D errno;
     }
+
+out:
     pthread_mutex_unlock(&inode->plock_mutex);
+    lo_inode_put(lo, &inode);
+
     fuse_reply_err(req, saverr);
 }
=20
@@ -1883,6 +1993,7 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
     pthread_mutex_unlock(&inode->plock_mutex);
=20
     res =3D close(dup(lo_fi_fd(req, fi)));
+    lo_inode_put(lo_data(req), &inode);
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
@@ -2099,11 +2210,14 @@ out_free:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     return;
=20
 out_err:
     saverr =3D errno;
 out:
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
@@ -2174,11 +2288,14 @@ out_free:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     return;
=20
 out_err:
     saverr =3D errno;
 out:
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
     goto out_free;
 }
@@ -2227,6 +2344,8 @@ out:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
@@ -2273,6 +2392,8 @@ out:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
@@ -2656,6 +2777,7 @@ static void setup_root(struct lo_data *lo, struct lo_=
inode *root)
     root->key.ino =3D stat.st_ino;
     root->key.dev =3D stat.st_dev;
     root->nlookup =3D 2;
+    g_atomic_int_set(&root->refcount, 2);
 }
=20
 static guint lo_key_hash(gconstpointer key)
--=20
2.23.0


