Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B29C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7ED21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DONXNLEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7ED21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSFD-0002Q0-PT
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWN-0006uS-Rz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWM-0003aE-KZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWM-0003ZD-G1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BsrckIFQW8QN2BqI6w7lFA0iLmZpO0tgnx4feiIVvE=;
 b=DONXNLEazK4jM90g0FPSXJ4JHdNZn/gDHZD0khUQPJjfGdzhuz3Fba/K5gObC55gX64pEa
 Ug5jqr/K6e4UtxKsV71xqWu65mG7r5pgYNyW2AniCAFL8eYQ6gV0xVEQccAbA/oMDnkPCv
 Pu3Gk3QT7N/GxcTrBEaFUC8x9+NSiJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-HKNKaFOoOAKgiAevhu-MHw-1; Thu, 12 Dec 2019 11:40:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6361005512
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 135CD60BF3;
 Thu, 12 Dec 2019 16:40:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
Date: Thu, 12 Dec 2019 16:38:32 +0000
Message-Id: <20191212163904.159893-73-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HKNKaFOoOAKgiAevhu-MHw-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 50 +++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 0f33c3c5e9..1b84d4f313 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1077,17 +1077,42 @@ out_err:
     fuse_reply_err(req, saverr);
 }
=20
+static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
+                                    const char *name)
+{
+    int res;
+    struct stat attr;
+
+    res =3D fstatat(lo_fd(req, parent), name, &attr,
+                  AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    if (res =3D=3D -1) {
+        return NULL;
+    }
+
+    return lo_find(lo_data(req), &attr);
+}
+
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
     int res;
+    struct lo_inode *inode;
+    struct lo_data *lo =3D lo_data(req);
+
     if (!is_safe_path_component(name)) {
         fuse_reply_err(req, EINVAL);
         return;
     }
=20
+    inode =3D lookup_name(req, parent, name);
+    if (!inode) {
+        fuse_reply_err(req, EIO);
+        return;
+    }
+
     res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    unref_inode_lolocked(lo, inode, 1);
 }
=20
 static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
@@ -1095,12 +1120,23 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
                       unsigned int flags)
 {
     int res;
+    struct lo_inode *oldinode;
+    struct lo_inode *newinode;
+    struct lo_data *lo =3D lo_data(req);
=20
     if (!is_safe_path_component(name) || !is_safe_path_component(newname))=
 {
         fuse_reply_err(req, EINVAL);
         return;
     }
=20
+    oldinode =3D lookup_name(req, parent, name);
+    newinode =3D lookup_name(req, newparent, newname);
+
+    if (!oldinode) {
+        fuse_reply_err(req, EIO);
+        goto out;
+    }
+
     if (flags) {
 #ifndef SYS_renameat2
         fuse_reply_err(req, EINVAL);
@@ -1113,26 +1149,38 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
             fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
         }
 #endif
-        return;
+        goto out;
     }
=20
     res =3D renameat(lo_fd(req, parent), name, lo_fd(req, newparent), newn=
ame);
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+out:
+    unref_inode_lolocked(lo, oldinode, 1);
+    unref_inode_lolocked(lo, newinode, 1);
 }
=20
 static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
     int res;
+    struct lo_inode *inode;
+    struct lo_data *lo =3D lo_data(req);
=20
     if (!is_safe_path_component(name)) {
         fuse_reply_err(req, EINVAL);
         return;
     }
=20
+    inode =3D lookup_name(req, parent, name);
+    if (!inode) {
+        fuse_reply_err(req, EIO);
+        return;
+    }
+
     res =3D unlinkat(lo_fd(req, parent), name, 0);
=20
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    unref_inode_lolocked(lo, inode, 1);
 }
=20
 static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
--=20
2.23.0


