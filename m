Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEAC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D99206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2C+iKLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D99206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittbV-0008NX-Kc
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgV-0002aL-2R
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsgN-0004MK-R6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsgN-0004MD-GR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbMS0kP6iKeNqu2Mv7H+soNaPN09g0beLkqrgUlqAWQ=;
 b=U2C+iKLjGFlTVGVzmExAo9PaB4ud5jJp/egn6l3carspsKBU5kUsent63gBS7ODYe9Xo/Q
 aAzfWAmc7CRVSfEqpIWSTrJmztLJ5+x/z2c+iubpdzpKCFG/t7lk9JK5JWe0GwZHYOELxt
 ivj/WRCbZfA+X2qgv+Z1RMS+RHV6ZUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-q6YIOOoyOnukdUWNzaMZZA-1; Tue, 21 Jan 2020 07:30:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 603428C7A53;
 Tue, 21 Jan 2020 12:30:56 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 933ED60BE0;
 Tue, 21 Jan 2020 12:30:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 073/109] virtiofsd: extract root inode init into
 setup_root()
Date: Tue, 21 Jan 2020 12:23:57 +0000
Message-Id: <20200121122433.50803-74-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: q6YIOOoyOnukdUWNzaMZZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miklos Szeredi <mszeredi@redhat.com>

Inititialize the root inode in a single place.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
dgilbert:
with fix suggested by Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/passthrough_ll.c | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 2d2c10ada9..f71085bf1b 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2351,6 +2351,30 @@ static void log_func(enum fuse_log_level level, cons=
t char *fmt, va_list ap)
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
+    root->is_symlink =3D false;
+    root->fd =3D fd;
+    root->ino =3D stat.st_ino;
+    root->dev =3D stat.st_dev;
+    root->refcount =3D 2;
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2426,8 +2450,6 @@ int main(int argc, char *argv[])
     if (lo.debug) {
         current_log_level =3D FUSE_LOG_DEBUG;
     }
-    lo.root.refcount =3D 2;
-
     if (lo.source) {
         struct stat stat;
         int res;
@@ -2446,7 +2468,6 @@ int main(int argc, char *argv[])
     } else {
         lo.source =3D "/";
     }
-    lo.root.is_symlink =3D false;
     if (!lo.timeout_set) {
         switch (lo.cache) {
         case CACHE_NEVER:
@@ -2466,13 +2487,6 @@ int main(int argc, char *argv[])
         exit(1);
     }
=20
-    lo.root.fd =3D open(lo.source, O_PATH);
-
-    if (lo.root.fd =3D=3D -1) {
-        fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n", lo.source);
-        exit(1);
-    }
-
     se =3D fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
     if (se =3D=3D NULL) {
         goto err_out1;
@@ -2495,6 +2509,7 @@ int main(int argc, char *argv[])
=20
     setup_sandbox(&lo, se, opts.syslog);
=20
+    setup_root(&lo, &lo.root);
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
--=20
2.24.1


