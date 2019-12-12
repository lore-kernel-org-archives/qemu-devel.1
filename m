Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C514206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKJkDTZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C514206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSjI-0002YI-Ry
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXC-00082F-C8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRXB-00059j-3V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRXA-00058x-V5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFXzRnUUfN49Blvfmm9LqBuOUa1ZI4A1nWCoxa8Wcjs=;
 b=UKJkDTZA7MuD7D5Paf0Tb+xaHJ0sXstX4MVYR1Zo7iPZ61udEdXh0zcyqGHr/3KmUwbol7
 dYvicjCr34wxdoGMGzCymPnT6q5VluW7RG6PuTy2qJfoYE6cH2Qwzi7BJ+6kmZs04G4fM5
 Bej3AfciizgvS01KARCzVNMAywvB/s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-7FKnJ5RHOTCq64rgankW6A-1; Thu, 12 Dec 2019 11:41:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BFD107ACCC
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A04460BE1;
 Thu, 12 Dec 2019 16:41:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 102/104] virtiofsd: fix lo_destroy() resource leaks
Date: Thu, 12 Dec 2019 16:39:02 +0000
Message-Id: <20191212163904.159893-103-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7FKnJ5RHOTCq64rgankW6A-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Now that lo_destroy() is serialized we can call unref_inode() so that
all inode resources are freed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 41 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 1bf251a91d..38f4948e61 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1355,26 +1355,6 @@ static void unref_inode_lolocked(struct lo_data *lo,=
 struct lo_inode *inode,
     }
 }
=20
-static int unref_all_inodes_cb(gpointer key, gpointer value, gpointer user=
_data)
-{
-    struct lo_inode *inode =3D value;
-    struct lo_data *lo =3D user_data;
-
-    inode->nlookup =3D 0;
-    lo_map_remove(&lo->ino_map, inode->fuse_ino);
-    close(inode->fd);
-    lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
-
-    return TRUE;
-}
-
-static void unref_all_inodes(struct lo_data *lo)
-{
-    pthread_mutex_lock(&lo->mutex);
-    g_hash_table_foreach_remove(lo->inodes, unref_all_inodes_cb, lo);
-    pthread_mutex_unlock(&lo->mutex);
-}
-
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
     struct lo_data *lo =3D lo_data(req);
@@ -2460,7 +2440,26 @@ static void lo_lseek(fuse_req_t req, fuse_ino_t ino,=
 off_t off, int whence,
 static void lo_destroy(void *userdata)
 {
     struct lo_data *lo =3D (struct lo_data *)userdata;
-    unref_all_inodes(lo);
+
+    /*
+     * Normally lo->mutex must be taken when traversing lo->inodes but
+     * lo_destroy() is a serialized request so no races are possible here.
+     *
+     * In addition, we cannot acquire lo->mutex since unref_inode() takes =
it
+     * too and this would result in a recursive lock.
+     */
+    while (true) {
+        GHashTableIter iter;
+        gpointer key, value;
+
+        g_hash_table_iter_init(&iter, lo->inodes);
+        if (!g_hash_table_iter_next(&iter, &key, &value)) {
+            break;
+        }
+
+        struct lo_inode *inode =3D value;
+        unref_inode_lolocked(lo, inode, inode->nlookup);
+    }
 }
=20
 static struct fuse_lowlevel_ops lo_oper =3D {
--=20
2.23.0


