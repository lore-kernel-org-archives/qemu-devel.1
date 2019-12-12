Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D43205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EK+zpRg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D43205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS87-000828-K6
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVq-00061C-S1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVp-0002TV-Ih
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVp-0002So-DC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNzZKqJUsrE8SSGLz3sjbZqVFQobnUygsdjle8OWcRc=;
 b=EK+zpRg7jlea5eRCQ1E/JaRzswL/zdPhbZ4n6vr98RNvMvEkWbsfesJRVhW2XDMCWZpWxI
 TqpHYJ+pUnSghWRNYLL9frKAm/CCI63JW5oTnWnHssB9TDZe9S0ICP13dZSe2lA6XBGscJ
 mhuZ77kFPP63gLdqf34rY/VT2h2cE2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-oJvv-k8LOL-oIdbEh2wqQQ-1; Thu, 12 Dec 2019 11:40:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2860B189CD00
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:22 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D21760BE1;
 Thu, 12 Dec 2019 16:40:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 047/104] virtiofsd: sandbox mount namespace
Date: Thu, 12 Dec 2019 16:38:07 +0000
Message-Id: <20191212163904.159893-48-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oJvv-k8LOL-oIdbEh2wqQQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Use a mount namespace with the shared directory tree mounted at "/" and
no other mounts.

This prevents symlink escape attacks because symlink targets are
resolved only against the shared directory and cannot go outside it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 006908f25a..606824f002 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -49,6 +49,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/file.h>
+#include <sys/mount.h>
 #include <sys/syscall.h>
 #include <sys/xattr.h>
 #include <unistd.h>
@@ -1925,6 +1926,58 @@ static void print_capabilities(void)
     printf("}\n");
 }
=20
+/* This magic is based on lxc's lxc_pivot_root() */
+static void setup_pivot_root(const char *source)
+{
+    int oldroot;
+    int newroot;
+
+    oldroot =3D open("/", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+    if (oldroot < 0) {
+        fuse_log(FUSE_LOG_ERR, "open(/): %m\n");
+        exit(1);
+    }
+
+    newroot =3D open(source, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+    if (newroot < 0) {
+        fuse_log(FUSE_LOG_ERR, "open(%s): %m\n", source);
+        exit(1);
+    }
+
+    if (fchdir(newroot) < 0) {
+        fuse_log(FUSE_LOG_ERR, "fchdir(newroot): %m\n");
+        exit(1);
+    }
+
+    if (syscall(__NR_pivot_root, ".", ".") < 0) {
+        fuse_log(FUSE_LOG_ERR, "pivot_root(., .): %m\n");
+        exit(1);
+    }
+
+    if (fchdir(oldroot) < 0) {
+        fuse_log(FUSE_LOG_ERR, "fchdir(oldroot): %m\n");
+        exit(1);
+    }
+
+    if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
+        fuse_log(FUSE_LOG_ERR, "mount(., MS_SLAVE | MS_REC): %m\n");
+        exit(1);
+    }
+
+    if (umount2(".", MNT_DETACH) < 0) {
+        fuse_log(FUSE_LOG_ERR, "umount2(., MNT_DETACH): %m\n");
+        exit(1);
+    }
+
+    if (fchdir(newroot) < 0) {
+        fuse_log(FUSE_LOG_ERR, "fchdir(newroot): %m\n");
+        exit(1);
+    }
+
+    close(newroot);
+    close(oldroot);
+}
+
 static void setup_proc_self_fd(struct lo_data *lo)
 {
     lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
@@ -1934,6 +1987,39 @@ static void setup_proc_self_fd(struct lo_data *lo)
     }
 }
=20
+/*
+ * Make the source directory our root so symlinks cannot escape and no oth=
er
+ * files are accessible.
+ */
+static void setup_mount_namespace(const char *source)
+{
+    if (unshare(CLONE_NEWNS) !=3D 0) {
+        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNS): %m\n");
+        exit(1);
+    }
+
+    if (mount(NULL, "/", NULL, MS_REC | MS_SLAVE, NULL) < 0) {
+        fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_PRIVATE): %m\n");
+        exit(1);
+    }
+
+    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
+        fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, sou=
rce);
+        exit(1);
+    }
+
+    setup_pivot_root(source);
+}
+
+/*
+ * Lock down this process to prevent access to other processes or files ou=
tside
+ * source directory.  This reduces the impact of arbitrary code execution =
bugs.
+ */
+static void setup_sandbox(struct lo_data *lo)
+{
+    setup_mount_namespace(lo->source);
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2034,6 +2120,7 @@ int main(int argc, char *argv[])
     }
=20
     lo.root.fd =3D open(lo.source, O_PATH);
+
     if (lo.root.fd =3D=3D -1) {
         fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n", lo.source);
         exit(1);
@@ -2057,6 +2144,8 @@ int main(int argc, char *argv[])
     /* Must be after daemonize to get the right /proc/self/fd */
     setup_proc_self_fd(&lo);
=20
+    setup_sandbox(&lo);
+
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
--=20
2.23.0


