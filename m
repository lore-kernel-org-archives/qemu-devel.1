Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4202220704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ8Hc9dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4202220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudhf-000136-3S
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAq-0004LH-Go
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAp-0006kv-C1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAp-0006kL-7J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qShNWf35tmc6YSFybHWSCOvYBzhSa1CQWXZKP8VjPDE=;
 b=EQ8Hc9dQDZzK8ZfJLQ0EkCStuyytR1XY1hQplab8tSHw5CD3Yu3Gt4ixzG5rj2s70ECSwY
 OZ0ekaS1uAoYreW+PhvbZmIyzt/gK+1+lhT0/gyVtwsA4nxNdlpztk00jOfkfGRZVItRwz
 cG8M6nLMGsdhITUmbVhcIKOcLqHY0sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Vvn8wDZ4PbCObYEMDw0Gpw-1; Thu, 23 Jan 2020 07:01:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25E698010D0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:19 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 711721CB;
 Thu, 23 Jan 2020 12:01:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 108/111] virtiofsd: Convert lo_destroy to take the lo->mutex
 lock itself
Date: Thu, 23 Jan 2020 11:58:38 +0000
Message-Id: <20200123115841.138849-109-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vvn8wDZ4PbCObYEMDw0Gpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

lo_destroy was relying on some implicit knowledge of the locking;
we can avoid this if we create an unref_inode that doesn't take
the lock and then grab it for the whole of the lo_destroy.

Suggested-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index eb001b9d1e..fc15d61510 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1344,14 +1344,13 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pa=
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
@@ -1362,15 +1361,24 @@ static void unref_inode_lolocked(struct lo_data *lo=
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
@@ -2458,13 +2466,7 @@ static void lo_destroy(void *userdata)
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
@@ -2475,8 +2477,9 @@ static void lo_destroy(void *userdata)
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
2.24.1


