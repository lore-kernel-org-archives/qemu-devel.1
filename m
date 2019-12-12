Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FE721655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSAZcqjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSCp-0006h4-3h
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWL-0006qR-8W
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWJ-0003UB-T4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29846
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWJ-0003TL-Oa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LGiWsjtc+mG4Z2KkVVm9zCyvoppc+vGenbblHdT9Tg=;
 b=YSAZcqjC/Uav34cVu0Jh53qrlQLsw3Z+ENMPo4LpBroTrA/SK8DSW4NV7Agh+YUjABjEXy
 kdiOwozwY+MLKAFhZR2gQZDlm+aBT9PCMZUjt1jsrEjxxbF7kdvphzl9Id62ARdJrxiJQj
 UdSVOaB9h/oxgeQmp1Wsowv0s+mxv0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-zSYFpsD5O7i9Jxq2LhFz3A-1; Thu, 12 Dec 2019 11:40:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FA0107B267
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DF4F60BE1;
 Thu, 12 Dec 2019 16:40:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 069/104] virtiofsd: rename unref_inode() to
 unref_inode_lolocked()
Date: Thu, 12 Dec 2019 16:38:29 +0000
Message-Id: <20191212163904.159893-70-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zSYFpsD5O7i9Jxq2LhFz3A-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index c3e8bde5cf..1618db5a92 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -149,8 +149,8 @@ static const struct fuse_opt lo_opts[] =3D {
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
@@ -587,7 +587,7 @@ retry:
     return 0;
=20
 fail_unref:
-    unref_inode(lo, p, 1);
+    unref_inode_lolocked(lo, p, 1);
 fail:
     if (retries) {
         retries--;
@@ -625,7 +625,7 @@ fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
     if (res !=3D -1) {
         res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
-        unref_inode(lo, parent, 1);
+        unref_inode_lolocked(lo, parent, 1);
     }
=20
     return res;
@@ -1011,7 +1011,7 @@ fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
     if (res !=3D -1) {
         res =3D linkat(parent->fd, path, dfd, name, 0);
-        unref_inode(lo, parent, 1);
+        unref_inode_lolocked(lo, parent, 1);
     }
=20
     return res;
@@ -1125,7 +1125,8 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t pare=
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
@@ -1165,7 +1166,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_t =
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
2.23.0


