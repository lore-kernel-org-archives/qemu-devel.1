Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4950C205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPzFDyta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4950C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSfN-0004F8-QL
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWa-0007C8-Cr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWY-0003wC-Ae
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWY-0003vQ-63
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CS1BBYoEu4V3QidGa9QQ3tOtKZoIZ4+d1fJrd9eP3OQ=;
 b=PPzFDytaS9364HOvKjM/wHG6B1oi7h6pu431dujMADvf2gmQLUJfztZCkB9fLLfTF+rcWP
 Sl+Wx3uxAeQwLtUckQYMUszeA/mY63BbYSjFGMDGyeDh5SZLWedF4WsPUYwdjqxXAwlqIo
 zX1GD6sRbStt5gVt+Y9yggWG/5QrYl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-2ra0CSFPO4G0L9pH4R_yHw-1; Thu, 12 Dec 2019 11:41:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF9A64A93
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C58460BF3;
 Thu, 12 Dec 2019 16:40:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 075/104] virtiofsd: Clean up inodes on destroy
Date: Thu, 12 Dec 2019 16:38:35 +0000
Message-Id: <20191212163904.159893-76-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2ra0CSFPO4G0L9pH4R_yHw-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Clear out our inodes and fd's on a 'destroy' - so we get rid
of them if we reboot the guest.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index bbc5f0981e..c526d6f4f6 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1201,6 +1201,25 @@ static void unref_inode_lolocked(struct lo_data *lo,=
 struct lo_inode *inode,
     }
 }
=20
+static int unref_all_inodes_cb(gpointer key, gpointer value, gpointer user=
_data)
+{
+    struct lo_inode *inode =3D value;
+    struct lo_data *lo =3D user_data;
+
+    inode->refcount =3D 0;
+    lo_map_remove(&lo->ino_map, inode->fuse_ino);
+    close(inode->fd);
+
+    return TRUE;
+}
+
+static void unref_all_inodes(struct lo_data *lo)
+{
+    pthread_mutex_lock(&lo->mutex);
+    g_hash_table_foreach_remove(lo->inodes, unref_all_inodes_cb, lo);
+    pthread_mutex_unlock(&lo->mutex);
+}
+
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
     struct lo_data *lo =3D lo_data(req);
@@ -2066,6 +2085,12 @@ static void lo_lseek(fuse_req_t req, fuse_ino_t ino,=
 off_t off, int whence,
     }
 }
=20
+static void lo_destroy(void *userdata)
+{
+    struct lo_data *lo =3D (struct lo_data *)userdata;
+    unref_all_inodes(lo);
+}
+
 static struct fuse_lowlevel_ops lo_oper =3D {
     .init =3D lo_init,
     .lookup =3D lo_lookup,
@@ -2104,6 +2129,7 @@ static struct fuse_lowlevel_ops lo_oper =3D {
     .copy_file_range =3D lo_copy_file_range,
 #endif
     .lseek =3D lo_lseek,
+    .destroy =3D lo_destroy,
 };
=20
 /* Print vhost-user.json backend program capabilities */
--=20
2.23.0


