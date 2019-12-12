Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45622067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpqgfPDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45622067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSZv-00034p-Vy
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWM-0006sx-Uy
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWL-0003Xq-Jf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWL-0003Wx-FS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rW2XGe5T1gT7ap3lFIinyIujzfUTI6CCW9PjxWRgvA=;
 b=bpqgfPDGgpa8ffK5QrZbYRONgoK+mjEmJNlwRkmwlGiUb16SeskGrpMbuGZiwCt98wPA+y
 F+70UzQtU5D6F3B/vST9ozWWhqC1p2OEhqByw3quGjHcb5hDzgBB6uVclZuUeYOczmcZJO
 u8bcEY0b9N5KY0jCriadWNtQWCEsQlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-FAW7eAaIOciGzmf4_aE3dg-1; Thu, 12 Dec 2019 11:40:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD821102C85E
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5E1460BE1;
 Thu, 12 Dec 2019 16:40:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 071/104] virtiofsd: extract root inode init into setup_root()
Date: Thu, 12 Dec 2019 16:38:31 +0000
Message-Id: <20191212163904.159893-72-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FAW7eAaIOciGzmf4_aE3dg-1
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

Inititialize the root inode in a single place.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ef8b88e3d1..0f33c3c5e9 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2336,6 +2336,29 @@ static void log_func(enum fuse_log_level level, cons=
t char *_fmt, va_list ap)
     }
 }
=20
+static void setup_root(struct lo_data *lo, struct lo_inode *root)
+{
+    int fd, res;
+    struct stat stat;
+
+    fd =3D open("/", O_PATH);
+    if (fd =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", lo->source);
+        exit(1);
+    }
+
+    res =3D fstatat(fd, "", &stat, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+    if (res =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "fstatat(%s): %m\n", lo->source);
+        exit(1);
+    }
+
+    root->fd =3D fd;
+    root->ino =3D stat.st_ino;
+    root->dev =3D stat.st_dev;
+    root->refcount =3D 2;
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2411,8 +2434,6 @@ int main(int argc, char *argv[])
     if (lo.debug) {
         current_log_level =3D FUSE_LOG_DEBUG;
     }
-    lo.root.refcount =3D 2;
-
     if (lo.source) {
         struct stat stat;
         int res;
@@ -2480,6 +2501,7 @@ int main(int argc, char *argv[])
=20
     setup_sandbox(&lo, se, opts.syslog);
=20
+    setup_root(&lo, &lo.root);
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
--=20
2.23.0


