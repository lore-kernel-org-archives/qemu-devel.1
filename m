Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E98B21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKZuGJFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E98B21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhSB-0007XV-5b
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufeR-0005Zj-O7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeQ-0007Ea-IS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeQ-0007CP-FP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPJvaYYTro8fIP26k9jZvtAbABFrmMApduG+kmA4D1c=;
 b=KKZuGJFS9luCoJgvriFobgzBqOLPFjtZUdUoxNB8ua13IaMUx8+m927DL7CdigXhv77DtC
 wn//MJKqBm+iV/mFiyfRxrH91vZsC2a1eG8z64HEQzjeFHvK7MnN0WGgZ7Tlz81ZAESmtv
 ug8omzB86QLLAPzFLR+8l3YN1DsLbnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-QBqiw0hzOsC3pksk0Psstw-1; Thu, 23 Jan 2020 11:48:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E36D3800D55
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3950A38F;
 Thu, 23 Jan 2020 16:48:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 070/108] virtiofsd: rename unref_inode() to
 unref_inode_lolocked()
Date: Thu, 23 Jan 2020 16:45:52 +0000
Message-Id: <20200123164630.91498-71-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QBqiw0hzOsC3pksk0Psstw-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 8b1784ff7b..de12e75a9e 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -148,8 +148,8 @@ static const struct fuse_opt lo_opts[] =3D {
 };
 static bool use_syslog =3D false;
 static int current_log_level;
-
-static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
+static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
+                                 uint64_t n);
=20
 static struct {
     pthread_mutex_t mutex;
@@ -586,7 +586,7 @@ retry:
     return 0;
=20
 fail_unref:
-    unref_inode(lo, p, 1);
+    unref_inode_lolocked(lo, p, 1);
 fail:
     if (retries) {
         retries--;
@@ -624,7 +624,7 @@ fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
     if (res !=3D -1) {
         res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
-        unref_inode(lo, parent, 1);
+        unref_inode_lolocked(lo, parent, 1);
     }
=20
     return res;
@@ -1027,7 +1027,7 @@ fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
     if (res !=3D -1) {
         res =3D linkat(parent->fd, path, dfd, name, 0);
-        unref_inode(lo, parent, 1);
+        unref_inode_lolocked(lo, parent, 1);
     }
=20
     return res;
@@ -1141,7 +1141,8 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pare=
nt, const char *name)
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
-static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n)
+static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inod=
e,
+                                 uint64_t n)
 {
     if (!inode) {
         return;
@@ -1181,7 +1182,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
ino, uint64_t nlookup)
              (unsigned long long)ino, (unsigned long long)inode->refcount,
              (unsigned long long)nlookup);
=20
-    unref_inode(lo, inode, nlookup);
+    unref_inode_lolocked(lo, inode, nlookup);
 }
=20
 static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
--=20
2.24.1


