Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA3B20B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA3B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEUc-0004vh-3e
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1htEQh-0002Dq-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1htEQg-0000Cz-Qn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1htELl-0005T7-U9
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 256613149676;
 Thu,  1 Aug 2019 16:54:36 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67D0B608C2;
 Thu,  1 Aug 2019 16:54:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 17:54:08 +0100
Message-Id: <20190801165409.20121-4-stefanha@redhat.com>
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 16:54:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] virtiofsd: fix lo_destroy() resource leaks
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that lo_destroy() is serialized we can call unref_inode() so that
all inode resources are freed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 43 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index a81c01d0d1..02a5e97326 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1340,28 +1340,6 @@ static void unref_inode(struct lo_data *lo, struct=
 lo_inode *inode, uint64_t n)
 	}
 }
=20
-static int unref_all_inodes_cb(gpointer key, gpointer value,
-			       gpointer user_data)
-{
-	struct lo_inode *inode  =3D value;
-	struct lo_data *lo =3D user_data;
-
-	inode->nlookup =3D 0;
-	lo_map_remove(&lo->ino_map, inode->fuse_ino);
-	close(inode->fd);
-	lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
-
-	return TRUE;
-}
-
-static void unref_all_inodes(struct lo_data *lo)
-{
-	pthread_mutex_lock(&lo->mutex);
-	g_hash_table_foreach_remove(lo->inodes, unref_all_inodes_cb, lo);
-	pthread_mutex_unlock(&lo->mutex);
-
-}
-
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlook=
up)
 {
 	struct lo_data *lo =3D lo_data(req);
@@ -2462,6 +2440,18 @@ static void lo_removemapping(fuse_req_t req, struc=
t fuse_session *se,
 	fuse_reply_err(req, ret);
 }
=20
+static int destroy_inode_cb(gpointer key, gpointer value, gpointer user_=
data)
+{
+        struct lo_inode *inode =3D value;
+        struct lo_data *lo =3D user_data;
+
+        /* inode->nlookup is normally protected by lo->mutex but see the
+         * comment in lo_destroy().
+         */
+        unref_inode(lo, inode, inode->nlookup);
+        return TRUE;
+}
+
 static void lo_destroy(void *userdata, struct fuse_session *se)
 {
 	struct lo_data *lo =3D (struct lo_data*) userdata;
@@ -2475,7 +2465,14 @@ static void lo_destroy(void *userdata, struct fuse=
_session *se)
                         fuse_err("%s: unmap during destroy failed\n", __=
func__);
                 }
         }
-	unref_all_inodes(lo);
+
+        /* Normally lo->mutex must be taken when traversing lo->inodes b=
ut
+         * lo_destroy() is a serialized request so no races are possible=
 here.
+         *
+         * In addition, we cannot acquire lo->mutex since destroy_inode_=
cb() takes it
+         * too and this would result in a recursive lock.
+         */
+        g_hash_table_foreach_remove(lo->inodes, destroy_inode_cb, lo);
 }
=20
 static struct fuse_lowlevel_ops lo_oper =3D {
--=20
2.21.0


