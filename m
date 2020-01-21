Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7317C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 917532070C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLPqA0oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917532070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittui-0006Ei-Bu
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itshj-0003MT-4k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itshe-0004qA-RT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itshe-0004pn-Ga
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsSJVK11T/53cqjqamyOliF6NOZlvvTUhBhXO+LW0eA=;
 b=RLPqA0oIyBRHyQDfAfxvN2v74x0UHHdNXgOE+/o9SCOLyuSk375H4qsAEn4KUc5RhGy8GV
 BNuAHRTkpFXGqEtCTWJhI9ASvNPkt3thXcBghZ2iJUVIivvf1e0v1yvPuzX1F0bhG00n0E
 WaGfDJj/RVjBb8a2xOoVsGorxJC19Aw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-xABsAJv6NKCnUrcxlnl8Dg-1; Tue, 21 Jan 2020 07:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E30B8017CC;
 Tue, 21 Jan 2020 12:32:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9BA260BE0;
 Tue, 21 Jan 2020 12:32:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 095/109] virtiofsd: introduce inode refcount to prevent
 use-after-free
Date: Tue, 21 Jan 2020 12:24:19 +0000
Message-Id: <20200121122433.50803-96-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: xABsAJv6NKCnUrcxlnl8Dg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
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
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 169 ++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 23 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 0dc3011919..820172308f 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -97,7 +97,13 @@ struct lo_key {
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
@@ -116,6 +122,8 @@ struct lo_inode {
     fuse_ino_t fuse_ino;
     pthread_mutex_t plock_mutex;
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
+
+    bool is_symlink;
 };
=20
 struct lo_cred {
@@ -471,6 +479,23 @@ static ssize_t lo_add_inode_mapping(fuse_req_t req, st=
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
@@ -478,6 +503,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse_i=
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
@@ -487,10 +515,23 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse=
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
@@ -545,6 +586,10 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
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
@@ -582,6 +627,7 @@ retry:
         p =3D &lo->root;
         pthread_mutex_lock(&lo->mutex);
         p->nlookup++;
+        g_atomic_int_inc(&p->refcount);
         pthread_mutex_unlock(&lo->mutex);
     } else {
         *last =3D '\0';
@@ -625,6 +671,7 @@ retry:
=20
 fail_unref:
     unref_inode_lolocked(lo, p, 1);
+    lo_inode_put(lo, &p);
 fail:
     if (retries) {
         retries--;
@@ -663,6 +710,7 @@ fallback:
     if (res !=3D -1) {
         res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
         unref_inode_lolocked(lo, parent, 1);
+        lo_inode_put(lo, &parent);
     }
=20
     return res;
@@ -780,11 +828,13 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
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
@@ -801,6 +851,7 @@ static struct lo_inode *lo_find(struct lo_data *lo, str=
uct stat *st)
     if (p) {
         assert(p->nlookup > 0);
         p->nlookup++;
+        g_atomic_int_inc(&p->refcount);
     }
     pthread_mutex_unlock(&lo->mutex);
=20
@@ -820,6 +871,10 @@ static void posix_locks_value_destroy(gpointer data)
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
@@ -827,7 +882,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
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
@@ -868,6 +924,13 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
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
@@ -883,6 +946,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
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
@@ -894,6 +959,8 @@ out_err:
     if (newfd !=3D -1) {
         close(newfd);
     }
+    lo_inode_put(lo, &inode);
+    lo_inode_put(lo, &dir);
     return saverr;
 }
=20
@@ -991,6 +1058,7 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino_=
t parent,
 {
     int res;
     int saverr;
+    struct lo_data *lo =3D lo_data(req);
     struct lo_inode *dir;
     struct fuse_entry_param e;
     struct lo_cred old =3D {};
@@ -1032,9 +1100,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_in=
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
@@ -1085,6 +1155,7 @@ fallback:
     if (res !=3D -1) {
         res =3D linkat(parent->fd, path, dfd, name, 0);
         unref_inode_lolocked(lo, parent, 1);
+        lo_inode_put(lo, &parent);
     }
=20
     return res;
@@ -1095,6 +1166,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
 {
     int res;
     struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *parent_inode;
     struct lo_inode *inode;
     struct fuse_entry_param e;
     int saverr;
@@ -1104,17 +1176,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
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
@@ -1133,13 +1206,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
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
@@ -1176,6 +1254,7 @@ static void lo_rmdir(fuse_req_t req, fuse_ino_t paren=
t, const char *name)
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
     unref_inode_lolocked(lo, inode, 1);
+    lo_inode_put(lo, &inode);
 }
=20
 static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1183,8 +1262,10 @@ static void lo_rename(fuse_req_t req, fuse_ino_t par=
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
@@ -1192,6 +1273,13 @@ static void lo_rename(fuse_req_t req, fuse_ino_t par=
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
@@ -1204,8 +1292,8 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 #ifndef SYS_renameat2
         fuse_reply_err(req, EINVAL);
 #else
-        res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
-                       lo_fd(req, newparent), newname, flags);
+        res =3D syscall(SYS_renameat2, parent_inode->fd, name,
+                        newparent_inode->fd, newname, flags);
         if (res =3D=3D -1 && errno =3D=3D ENOSYS) {
             fuse_reply_err(req, EINVAL);
         } else {
@@ -1215,12 +1303,16 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pa=
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
@@ -1244,6 +1336,7 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pare=
nt, const char *name)
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
     unref_inode_lolocked(lo, inode, 1);
+    lo_inode_put(lo, &inode);
 }
=20
 static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
@@ -1265,8 +1358,9 @@ static void unref_inode_lolocked(struct lo_data *lo, =
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
@@ -1280,6 +1374,7 @@ static int unref_all_inodes_cb(gpointer key, gpointer=
 value, gpointer user_data)
     inode->nlookup =3D 0;
     lo_map_remove(&lo->ino_map, inode->fuse_ino);
     close(inode->fd);
+    lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
=20
     return TRUE;
 }
@@ -1306,6 +1401,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
ino, uint64_t nlookup)
              (unsigned long long)nlookup);
=20
     unref_inode_lolocked(lo, inode, nlookup);
+    lo_inode_put(lo, &inode);
 }
=20
 static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
@@ -1537,6 +1633,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
     err =3D 0;
 error:
     lo_dirp_put(&d);
+    lo_inode_put(lo, &dinode);
=20
     /*
      * If there's an error, we can only signal it if we haven't stored
@@ -1595,6 +1692,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 {
     int fd;
     struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *parent_inode;
     struct fuse_entry_param e;
     int err;
     struct lo_cred old =3D {};
@@ -1607,12 +1705,18 @@ static void lo_create(fuse_req_t req, fuse_ino_t pa=
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
@@ -1625,8 +1729,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
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
@@ -1639,6 +1743,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
     }
=20
 out:
+    lo_inode_put(lo, &parent_inode);
+
     if (err) {
         fuse_reply_err(req, err);
     } else {
@@ -1712,16 +1818,18 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t ino=
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
@@ -1761,9 +1869,8 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino, =
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
@@ -1772,7 +1879,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,=
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
@@ -1898,6 +2009,7 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
     pthread_mutex_unlock(&inode->plock_mutex);
=20
     res =3D close(dup(lo_fi_fd(req, fi)));
+    lo_inode_put(lo_data(req), &inode);
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
@@ -2115,11 +2227,14 @@ out_free:
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
@@ -2190,11 +2305,14 @@ out_free:
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
@@ -2243,6 +2361,8 @@ out:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
@@ -2289,6 +2409,8 @@ out:
     if (fd >=3D 0) {
         close(fd);
     }
+
+    lo_inode_put(lo, &inode);
     fuse_reply_err(req, saverr);
 }
=20
@@ -2671,6 +2793,7 @@ static void setup_root(struct lo_data *lo, struct lo_=
inode *root)
     root->key.ino =3D stat.st_ino;
     root->key.dev =3D stat.st_dev;
     root->nlookup =3D 2;
+    g_atomic_int_set(&root->refcount, 2);
 }
=20
 static guint lo_key_hash(gconstpointer key)
--=20
2.24.1


