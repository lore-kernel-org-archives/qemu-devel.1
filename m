Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD1721655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIibLvZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD1721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNblA-0001EO-K0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIF-0003p5-Bv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbID-00007J-BY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbID-00006W-7L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybIvLXARifCanoTHks1af93zgXi2Fkq9toNkp0Uvdtk=;
 b=NIibLvZ0sbnyhuScirC4qzmybPXDY5qaPfO3ZREG2vkS6o2YTiqUzqZS1/fNwOpkod9mhK
 j7HdbtbTfHMqFZV8seYPO1Zd8xKj1ubu7iXt5IyguHqxJ1Jjd7G/llOJN3fwDUVcgbYrY5
 sMWg8Xbh9IBhOrtmx/0Ic0Zjlx8iiIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-uJu0xQ7sN7mrcQGA0fkjGw-1; Thu, 24 Oct 2019 07:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBA1107AD31;
 Thu, 24 Oct 2019 11:28:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53A1F196B2;
 Thu, 24 Oct 2019 11:28:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 16/25] virtiofsd: sandbox mount namespace
Date: Thu, 24 Oct 2019 12:27:09 +0100
Message-Id: <20191024112718.34657-17-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uJu0xQ7sN7mrcQGA0fkjGw-1
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
 contrib/virtiofsd/passthrough_ll.c | 89 ++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 3ddf22d162..20a34d4d83 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -51,6 +51,7 @@
 #include <sys/file.h>
 #include <sys/syscall.h>
 #include <sys/xattr.h>
+#include <sys/mount.h>
=20
 #include "passthrough_helpers.h"
=20
@@ -1821,6 +1822,58 @@ static void print_capabilities(void)
 =09printf("}\n");
 }
=20
+/* This magic is based on lxc's lxc_pivot_root() */
+static void setup_pivot_root(const char *source)
+{
+=09int oldroot;
+=09int newroot;
+
+=09oldroot =3D open("/", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+=09if (oldroot < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "open(/): %m\n");
+=09=09exit(1);
+=09}
+
+=09newroot =3D open(source, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+=09if (newroot < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "open(%s): %m\n", source);
+=09=09exit(1);
+=09}
+
+=09if (fchdir(newroot) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fchdir(newroot): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (syscall(__NR_pivot_root, ".", ".") < 0){
+=09=09fuse_log(FUSE_LOG_ERR, "pivot_root(., .): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (fchdir(oldroot) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fchdir(oldroot): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (mount("", ".", "", MS_SLAVE | MS_REC, NULL) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "mount(., MS_SLAVE | MS_REC): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (umount2(".", MNT_DETACH) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "umount2(., MNT_DETACH): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (fchdir(newroot) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fchdir(newroot): %m\n");
+=09=09exit(1);
+=09}
+
+=09close(newroot);
+=09close(oldroot);
+}
+
 static void setup_proc_self_fd(struct lo_data *lo)
 {
 =09lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
@@ -1830,6 +1883,39 @@ static void setup_proc_self_fd(struct lo_data *lo)
 =09}
 }
=20
+/*
+ * Make the source directory our root so symlinks cannot escape and no oth=
er
+ * files are accessible.
+ */
+static void setup_mount_namespace(const char *source)
+{
+=09if (unshare(CLONE_NEWNS) !=3D 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNS): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_PRIVATE): %m\n");
+=09=09exit(1);
+=09}
+
+=09if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, sourc=
e);
+=09=09exit(1);
+=09}
+
+=09setup_pivot_root(source);
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
+=09setup_mount_namespace(lo->source);
+}
+
 int main(int argc, char *argv[])
 {
 =09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -1927,6 +2013,7 @@ int main(int argc, char *argv[])
 =09}
=20
 =09lo.root.fd =3D open(lo.source, O_PATH);
+
 =09if (lo.root.fd =3D=3D -1) {
 =09=09fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n",
 =09=09=09 lo.source);
@@ -1948,6 +2035,8 @@ int main(int argc, char *argv[])
 =09/* Must be after daemonize to get the right /proc/self/fd */
 =09setup_proc_self_fd(&lo);
=20
+=09setup_sandbox(&lo);
+
 =09/* Block until ctrl+c or fusermount -u */
 =09ret =3D virtio_loop(se);
=20
--=20
2.23.0


