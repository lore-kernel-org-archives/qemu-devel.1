Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D1C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032302464B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox678Zcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032302464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSmk-00079v-7P
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXH-00088s-KB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXG-0005Ix-B7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRXG-0005Hx-6v
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xe0Smz7KCQ1tatJhdpkcqF38kefQFyt1PnKLRIic9VM=;
 b=Ox678Zcm3W30XTIULXzipEAXhRYIFkmj0PUuM4I4BDnriFFlx3G5xLkKn9fnSQsOhH1io5
 5IovWGvGFmiUzQOGSjRoDKAAcDAGiPU9sKKC/ADWKKsWrpN6nIuJIDsDYFFIqJf1loBCvw
 +G84g7lkACFA8xEoyFC2W6JFxJSKYS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-39LhyZhmOcKAqfm8G6Cq2Q-1; Thu, 12 Dec 2019 11:41:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9EE9107ACC4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF27660BE1;
 Thu, 12 Dec 2019 16:41:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 104/104] virtiofsd: Convert lo_destroy to take the lo->mutex
 lock itself
Date: Thu, 12 Dec 2019 16:39:04 +0000
Message-Id: <20191212163904.159893-105-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 39LhyZhmOcKAqfm8G6Cq2Q-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

lo_destroy was relying on some implicit knowledge of the locking;
we can avoid this if we create an unref_inode that doesn't take
the lock and then grab it for the whole of the lo_destroy.

Suggested-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 38f4948e61..c37f57157e 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1328,14 +1328,13 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pa=
rent, const char *name)
     lo_inode_put(lo, &inode);
 }
=20
-static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
-                                 uint64_t n)
+/* To be called with lo->mutex held */
+static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n)
 {
     if (!inode) {
         return;
     }
=20
-    pthread_mutex_lock(&lo->mutex);
     assert(inode->nlookup >=3D n);
     inode->nlookup -=3D n;
     if (!inode->nlookup) {
@@ -1346,15 +1345,24 @@ static void unref_inode_lolocked(struct lo_data *lo=
, struct lo_inode *inode,
         }
         g_hash_table_destroy(inode->posix_locks);
         pthread_mutex_destroy(&inode->plock_mutex);
-        pthread_mutex_unlock(&lo->mutex);
=20
         /* Drop our refcount from lo_do_lookup() */
         lo_inode_put(lo, &inode);
-    } else {
-        pthread_mutex_unlock(&lo->mutex);
     }
 }
=20
+static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
+                                 uint64_t n)
+{
+    if (!inode) {
+        return;
+    }
+
+    pthread_mutex_lock(&lo->mutex);
+    unref_inode(lo, inode, n);
+    pthread_mutex_unlock(&lo->mutex);
+}
+
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
     struct lo_data *lo =3D lo_data(req);
@@ -2441,13 +2449,7 @@ static void lo_destroy(void *userdata)
 {
     struct lo_data *lo =3D (struct lo_data *)userdata;
=20
-    /*
-     * Normally lo->mutex must be taken when traversing lo->inodes but
-     * lo_destroy() is a serialized request so no races are possible here.
-     *
-     * In addition, we cannot acquire lo->mutex since unref_inode() takes =
it
-     * too and this would result in a recursive lock.
-     */
+    pthread_mutex_lock(&lo->mutex);
     while (true) {
         GHashTableIter iter;
         gpointer key, value;
@@ -2458,8 +2460,9 @@ static void lo_destroy(void *userdata)
         }
=20
         struct lo_inode *inode =3D value;
-        unref_inode_lolocked(lo, inode, inode->nlookup);
+        unref_inode(lo, inode, inode->nlookup);
     }
+    pthread_mutex_unlock(&lo->mutex);
 }
=20
 static struct fuse_lowlevel_ops lo_oper =3D {
--=20
2.23.0


