Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802F821D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXzFHSXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802F821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui3Y-0001yY-As
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuff5-0006GI-6t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuff4-0000Hm-2F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuff3-0000GU-VZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+98uMcN3sW8ctnXMgx5BGrQgbfB+4mpGKnlt7qey/g=;
 b=VXzFHSXUnPsaP7jkQQnMdC2pjm0j/LRUDtIBNmv5pAGs9BPgHHewx8FOkhBvl/vgBKzALj
 nmtYs6TPrljgbM10+PYn4sLVOVIpmUHTRjOtlcko6LttHzfGZk7f59Ehpu+hRQL3JhEfc4
 6VbrCSSUUVMQkKa2hC0RMESJLiP231U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-grDRBGxYOUOuywAP0eFQtQ-1; Thu, 23 Jan 2020 11:48:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276B8100550E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76C5128993;
 Thu, 23 Jan 2020 16:48:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 103/108] virtiofsd: fix lo_destroy() resource leaks
Date: Thu, 23 Jan 2020 16:46:25 +0000
Message-Id: <20200123164630.91498-104-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: grDRBGxYOUOuywAP0eFQtQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Now that lo_destroy() is serialized we can call unref_inode() so that
all inode resources are freed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 41 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 79b8b71a4f..eb001b9d1e 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1371,26 +1371,6 @@ static void unref_inode_lolocked(struct lo_data *lo,=
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
@@ -2477,7 +2457,26 @@ static void lo_lseek(fuse_req_t req, fuse_ino_t ino,=
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
2.24.1


