Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C377C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8D7217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5BczDSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8D7217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituCt-0002pC-DU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itshV-0003EF-Tp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itshS-0004lZ-HD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itshS-0004lJ-DG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4i2JV2fD+s8Yfk7HUpjWz97xQirVh1BhB7DrDaCf0js=;
 b=R5BczDSJU0ENjVzYJU0NYmKFoOzErB7jceOT+GHjTUTT0TaLDnszPGWCGIt18PFcPWuNf4
 BqZZoRCUnHvp1We8qghj1FhYUDIgp6Y9zoK8NHEVbQqduGjdpNKo8Y3hedXdN4IX9pGpsJ
 5YvYZZTQDlb7ZI8jepyFGFcJHtGhshI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-gZAC8EWcP7K3L28Q8tKdpQ-1; Tue, 21 Jan 2020 07:32:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82AD190B2A2;
 Tue, 21 Jan 2020 12:32:03 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C548160BE0;
 Tue, 21 Jan 2020 12:31:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 091/109] virtiofsd: rename inode->refcount to inode->nlookup
Date: Tue, 21 Jan 2020 12:24:15 +0000
Message-Id: <20200121122433.50803-92-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gZAC8EWcP7K3L28Q8tKdpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This reference counter plays a specific role in the FUSE protocol.  It's
not a generic object reference counter and the FUSE kernel code calls it
"nlookup".

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 37 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e40268fce5..9f37829824 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -99,7 +99,20 @@ struct lo_inode {
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
@@ -568,7 +581,7 @@ retry:
     if (last =3D=3D path) {
         p =3D &lo->root;
         pthread_mutex_lock(&lo->mutex);
-        p->refcount++;
+        p->nlookup++;
         pthread_mutex_unlock(&lo->mutex);
     } else {
         *last =3D '\0';
@@ -786,8 +799,8 @@ static struct lo_inode *lo_find(struct lo_data *lo, str=
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
@@ -855,7 +868,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         }
=20
         inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
-        inode->refcount =3D 1;
+        inode->nlookup =3D 1;
         inode->fd =3D newfd;
         newfd =3D -1;
         inode->key.ino =3D e->attr.st_ino;
@@ -1112,7 +1125,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
     }
=20
     pthread_mutex_lock(&lo->mutex);
-    inode->refcount++;
+    inode->nlookup++;
     pthread_mutex_unlock(&lo->mutex);
     e.ino =3D inode->fuse_ino;
=20
@@ -1193,9 +1206,9 @@ static void unref_inode_lolocked(struct lo_data *lo, =
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
@@ -1216,7 +1229,7 @@ static int unref_all_inodes_cb(gpointer key, gpointer=
 value, gpointer user_data)
     struct lo_inode *inode =3D value;
     struct lo_data *lo =3D user_data;
=20
-    inode->refcount =3D 0;
+    inode->nlookup =3D 0;
     lo_map_remove(&lo->ino_map, inode->fuse_ino);
     close(inode->fd);
=20
@@ -1241,7 +1254,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
ino, uint64_t nlookup)
     }
=20
     fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
-             (unsigned long long)ino, (unsigned long long)inode->refcount,
+             (unsigned long long)ino, (unsigned long long)inode->nlookup,
              (unsigned long long)nlookup);
=20
     unref_inode_lolocked(lo, inode, nlookup);
@@ -2609,7 +2622,7 @@ static void setup_root(struct lo_data *lo, struct lo_=
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
2.24.1


