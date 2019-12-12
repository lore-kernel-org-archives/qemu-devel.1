Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4D5206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpVcdvX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4D5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSoT-0000nx-Fs
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWw-0007f5-L7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWu-0004cQ-TU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27286
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWu-0004ad-MH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pFimZR1BYdladtA1U9aTlDqAqMh5G97ToPYyf5Yk4g=;
 b=WpVcdvX3oeDWRGeazC57Il8fprjopmpO0NedNXORA23RDRB+uZNmz5OXr7PXGE120Orw29
 bhoiyv4iTvsmQuKQzvLD+BSzNUnmnm1Or6a0SZ0bM7SBAu8iUQbRx+kec5k2Ri8eZz+tJk
 /jmWrFe1pqay+Gwn39GtNLkf76rn3MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-NygvIv8QNZaRKLkkirzHfQ-1; Thu, 12 Dec 2019 11:41:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BF161183E0D
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4228F60BE1;
 Thu, 12 Dec 2019 16:41:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 090/104] virtiofsd: rename inode->refcount to inode->nlookup
Date: Thu, 12 Dec 2019 16:38:50 +0000
Message-Id: <20191212163904.159893-91-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NygvIv8QNZaRKLkkirzHfQ-1
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

This reference counter plays a specific role in the FUSE protocol.  It's
not a generic object reference counter and the FUSE kernel code calls it
"nlookup".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 37 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 7663e574d8..b19c9ee328 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -101,7 +101,20 @@ struct lo_inode {
     int fd;
     bool is_symlink;
     struct lo_key key;
-    uint64_t refcount; /* protected by lo->mutex */
+
+    /*
+     * This counter keeps the inode alive during the FUSE session.
+     * Incremented when the FUSE inode number is sent in a reply
+     * (FUSE_LOOKUP, FUSE_READDIRPLUS, etc).  Decremented when an inode is
+     * released by requests like FUSE_FORGET, FUSE_RMDIR, FUSE_RENAME, etc=
.
+     *
+     * Note that this value is untrusted because the client can manipulate
+     * it arbitrarily using FUSE_FORGET requests.
+     *
+     * Protected by lo->mutex.
+     */
+    uint64_t nlookup;
+
     fuse_ino_t fuse_ino;
     pthread_mutex_t plock_mutex;
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
@@ -570,7 +583,7 @@ retry:
     if (last =3D=3D path) {
         p =3D &lo->root;
         pthread_mutex_lock(&lo->mutex);
-        p->refcount++;
+        p->nlookup++;
         pthread_mutex_unlock(&lo->mutex);
     } else {
         *last =3D '\0';
@@ -788,8 +801,8 @@ static struct lo_inode *lo_find(struct lo_data *lo, str=
uct stat *st)
     pthread_mutex_lock(&lo->mutex);
     p =3D g_hash_table_lookup(lo->inodes, &key);
     if (p) {
-        assert(p->refcount > 0);
-        p->refcount++;
+        assert(p->nlookup > 0);
+        p->nlookup++;
     }
     pthread_mutex_unlock(&lo->mutex);
=20
@@ -857,7 +870,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         }
=20
         inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
-        inode->refcount =3D 1;
+        inode->nlookup =3D 1;
         inode->fd =3D newfd;
         newfd =3D -1;
         inode->key.ino =3D e->attr.st_ino;
@@ -1097,7 +1110,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
     }
=20
     pthread_mutex_lock(&lo->mutex);
-    inode->refcount++;
+    inode->nlookup++;
     pthread_mutex_unlock(&lo->mutex);
     e.ino =3D inode->fuse_ino;
=20
@@ -1226,9 +1239,9 @@ static void unref_inode_lolocked(struct lo_data *lo, =
struct lo_inode *inode,
     }
=20
     pthread_mutex_lock(&lo->mutex);
-    assert(inode->refcount >=3D n);
-    inode->refcount -=3D n;
-    if (!inode->refcount) {
+    assert(inode->nlookup >=3D n);
+    inode->nlookup -=3D n;
+    if (!inode->nlookup) {
         lo_map_remove(&lo->ino_map, inode->fuse_ino);
         g_hash_table_remove(lo->inodes, &inode->key);
         if (g_hash_table_size(inode->posix_locks)) {
@@ -1249,7 +1262,7 @@ static int unref_all_inodes_cb(gpointer key, gpointer=
 value, gpointer user_data)
     struct lo_inode *inode =3D value;
     struct lo_data *lo =3D user_data;
=20
-    inode->refcount =3D 0;
+    inode->nlookup =3D 0;
     lo_map_remove(&lo->ino_map, inode->fuse_ino);
     close(inode->fd);
=20
@@ -1274,7 +1287,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
ino, uint64_t nlookup)
     }
=20
     fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
-             (unsigned long long)ino, (unsigned long long)inode->refcount,
+             (unsigned long long)ino, (unsigned long long)inode->nlookup,
              (unsigned long long)nlookup);
=20
     unref_inode_lolocked(lo, inode, nlookup);
@@ -2642,7 +2655,7 @@ static void setup_root(struct lo_data *lo, struct lo_=
inode *root)
     root->fd =3D fd;
     root->key.ino =3D stat.st_ino;
     root->key.dev =3D stat.st_dev;
-    root->refcount =3D 2;
+    root->nlookup =3D 2;
 }
=20
 static guint lo_key_hash(gconstpointer key)
--=20
2.23.0


