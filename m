Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F852CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE29320650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HX5vQRmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE29320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcD9-0003Oc-Id
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbII-0003wH-Pc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIH-00008K-Au
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIH-00008D-6c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLd7Tp/kvk7CtQEiJaNPsk+MgWDyOqf5yg0pdVj2peM=;
 b=HX5vQRmSmmi4XN22FdYRbOQI9xJauVn+Xb+a7P0e0E3ETHxnM5/IOpX5xubeXbEt9QupRM
 YUyz8pwfkH2J1RU4TJtJgeg/1kuvqjfDh5r6d1uieaMGLSsrz/RsVxgJjkyzuqdbuVrrO7
 qFwbK8NMSwEoKHGQ2NOAGPGshdqWGvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-ADKqlAH8Mw6L7dXLM_TJBQ-1; Thu, 24 Oct 2019 07:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57C1800D49;
 Thu, 24 Oct 2019 11:28:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE3652D5;
 Thu, 24 Oct 2019 11:28:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 18/25] virtiofsd: move to a new pid namespace
Date: Thu, 24 Oct 2019 12:27:11 +0100
Message-Id: <20191024112718.34657-19-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ADKqlAH8Mw6L7dXLM_TJBQ-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtiofsd needs access to /proc/self/fd.  Let's move to a new pid
namespace so that a compromised process cannot see another other
processes running on the system.

One wrinkle in this approach: unshare(CLONE_NEWPID) affects *child*
processes and not the current process.  Therefore we need to fork the
pid 1 process that will actually run virtiofsd and leave a parent in
waitpid(2).  This is not the same thing as daemonization and parent
processes should not notice a difference.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 76 ++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 58cf82a89f..c027db64e6 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -52,6 +52,8 @@
 #include <sys/syscall.h>
 #include <sys/xattr.h>
 #include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/wait.h>
=20
 #include "passthrough_helpers.h"
=20
@@ -1835,6 +1837,63 @@ static void setup_net_namespace(void)
 =09}
 }
=20
+/*
+ * Move to a new pid namespace to prevent access to other processes if thi=
s
+ * process is compromised.
+ */
+static void setup_pid_namespace(void)
+{
+=09pid_t child;
+
+=09/*
+=09 * Create a new pid namespace for *child* processes.  We'll have to
+=09 * fork in order to enter the new pid namespace.  A new mount namespace
+=09 * is also needed so that we can remount /proc for the new pid
+=09 * namespace.
+=09 */
+=09if (unshare(CLONE_NEWPID | CLONE_NEWNS) !=3D 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\n");
+=09=09exit(1);
+=09}
+
+=09child =3D fork();
+=09if (child < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
+=09=09exit(1);
+=09}
+=09if (child > 0) {
+=09=09pid_t waited;
+=09=09int wstatus;
+
+=09=09/* The parent waits for the child */
+=09=09do {
+=09=09=09waited =3D waitpid(child, &wstatus, 0);
+=09=09} while (waited < 0 && errno =3D=3D EINTR);
+
+=09=09if (WIFEXITED(wstatus)) {
+=09=09=09exit(WEXITSTATUS(wstatus));
+=09=09}
+
+=09=09exit(1);
+=09}
+
+=09/*
+=09 * If the mounts have shared propagation then we want to opt out so our
+=09 * mount changes don't affect the parent mount namespace.
+=09 */
+=09if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_SLAVE): %m\n");
+=09=09exit(1);
+=09}
+
+=09/* The child must remount /proc to use the new pid namespace */
+=09if (mount("proc", "/proc", "proc",
+=09=09  MS_NODEV | MS_NOEXEC | MS_NOSUID | MS_RELATIME, NULL) < 0) {
+=09=09fuse_log(FUSE_LOG_ERR, "mount(/proc): %m\n");
+=09=09exit(1);
+=09}
+}
+
 /* This magic is based on lxc's lxc_pivot_root() */
 static void setup_pivot_root(const char *source)
 {
@@ -1898,20 +1957,10 @@ static void setup_proc_self_fd(struct lo_data *lo)
=20
 /*
  * Make the source directory our root so symlinks cannot escape and no oth=
er
- * files are accessible.
+ * files are accessible.  Assumes unshare(CLONE_NEWNS) was already called.
  */
 static void setup_mount_namespace(const char *source)
 {
-=09if (unshare(CLONE_NEWNS) !=3D 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNS): %m\n");
-=09=09exit(1);
-=09}
-
-=09if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_PRIVATE): %m\n");
-=09=09exit(1);
-=09}
-
 =09if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
 =09=09fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, sourc=
e);
 =09=09exit(1);
@@ -1926,6 +1975,8 @@ static void setup_mount_namespace(const char *source)
  */
 static void setup_sandbox(struct lo_data *lo)
 {
+=09setup_pid_namespace();
+=09setup_proc_self_fd(lo);
 =09setup_net_namespace();
 =09setup_mount_namespace(lo->source);
 }
@@ -2046,9 +2097,6 @@ int main(int argc, char *argv[])
=20
 =09fuse_daemonize(opts.foreground);
=20
-=09/* Must be after daemonize to get the right /proc/self/fd */
-=09setup_proc_self_fd(&lo);
-
 =09setup_sandbox(&lo);
=20
 =09/* Block until ctrl+c or fusermount -u */
--=20
2.23.0


