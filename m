Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5184FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6D22067D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6D22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlrb-0001aK-Gu
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iKlkp-0003xL-Oy
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iKlko-0008Gx-9U
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iKlko-0008GW-1g
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D1F63DE04
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 16:02:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6E5E5C1D6;
 Wed, 16 Oct 2019 16:02:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtiofsd: move to a new pid namespace
Date: Wed, 16 Oct 2019 17:01:57 +0100
Message-Id: <20191016160157.12414-3-stefanha@redhat.com>
In-Reply-To: <20191016160157.12414-1-stefanha@redhat.com>
References: <20191016160157.12414-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 16 Oct 2019 16:02:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
 contrib/virtiofsd/passthrough_ll.c | 95 ++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index c27ff7d800..b6ee9b2e90 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -56,9 +56,12 @@
 #include <sys/xattr.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
+#include <sys/types.h>
 #include <sys/un.h>
+#include <sys/wait.h>
 #include <sys/capability.h>
=20
+
 #include "ireg.h"
 #include <sys/mount.h>
 #include <sys/resource.h>
@@ -2749,6 +2752,72 @@ static void setup_net_namespace(void)
 	}
 }
=20
+/*
+ * Move to a new pid namespace to prevent access to other processes if t=
his
+ * process is compromised.
+ */
+static void setup_pid_namespace(void)
+{
+	pid_t child;
+
+	/*
+	 * Create a new pid namespace for *child* processes.  We'll have to
+	 * fork in order to enter the new pid namespace.  A new mount namespace
+	 * is also needed so that we can remount /proc for the new pid
+	 * namespace.
+	 */
+	if (unshare(CLONE_NEWPID | CLONE_NEWNS) !=3D 0) {
+		fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\n");
+		exit(1);
+	}
+
+	child =3D fork();
+	if (child < 0) {
+		fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
+		exit(1);
+	}
+	if (child > 0) {
+		pid_t waited;
+		int wstatus;
+
+		/* The parent waits for the child */
+		do {
+			waited =3D waitpid(child, &wstatus, 0);
+		} while (waited < 0 && errno =3D=3D EINTR);
+
+		if (WIFEXITED(wstatus)) {
+			exit(WEXITSTATUS(wstatus));
+		}
+
+		exit(1);
+	}
+
+	/*
+	 * If the mounts have shared propagation then we want to opt out so our
+	 * mount changes don't affect the parent mount namespace.
+	 */
+	if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
+		fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_SLAVE): %m\n");
+		exit(1);
+	}
+
+	/* The child must remount /proc to use the new pid namespace */
+	if (mount("proc", "/proc", "proc",
+		  MS_NODEV | MS_NOEXEC | MS_NOSUID | MS_RELATIME, NULL) < 0) {
+		fuse_log(FUSE_LOG_ERR, "mount(/proc): %m\n");
+		exit(1);
+	}
+}
+
+static void setup_proc_self_fd(struct lo_data *lo)
+{
+	lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
+	if (lo->proc_self_fd =3D=3D -1) {
+		fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
+		exit(1);
+	}
+}
+
 /* This magic is based on lxc's lxc_pivot_root() */
 static void setup_pivot_root(const char *source)
 {
@@ -2803,20 +2872,10 @@ static void setup_pivot_root(const char *source)
=20
 /*
  * Make the source directory our root so symlinks cannot escape and no o=
ther
- * files are accessible.
+ * files are accessible.  Assumes unshare(CLONE_NEWNS) was already calle=
d.
  */
 static void setup_mount_namespace(const char *source)
 {
-	if (unshare(CLONE_NEWNS) !=3D 0) {
-		fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNS): %m\n");
-		exit(1);
-	}
-
-	if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
-		fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_PRIVATE): %m\n");
-		exit(1);
-	}
-
 	if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
 		fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", source, source)=
;
 		exit(1);
@@ -2831,6 +2890,8 @@ static void setup_mount_namespace(const char *sourc=
e)
  */
 static void setup_sandbox(struct lo_data *lo, bool enable_syslog)
 {
+	setup_pid_namespace();
+	setup_proc_self_fd(lo);
 	setup_net_namespace();
 	setup_mount_namespace(lo->source);
 	setup_seccomp(enable_syslog);
@@ -2860,15 +2921,6 @@ static void setup_root(struct lo_data *lo, struct =
lo_inode *root)
 	g_atomic_int_set(&root->refcount, 2);
 }
=20
-static void setup_proc_self_fd(struct lo_data *lo)
-{
-	lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
-	if (lo->proc_self_fd =3D=3D -1) {
-		fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
-		exit(1);
-	}
-}
-
 /* Raise the maximum number of open file descriptors to the system limit=
 */
 static void setup_nofile_rlimit(void)
 {
@@ -3110,9 +3162,6 @@ int main(int argc, char *argv[])
 		get_shared(&lo, &lo.root);
 	}
=20
-	/* Must be after daemonize to get the right /proc/self/fd */
-	setup_proc_self_fd(&lo);
-
 	setup_sandbox(&lo, opts.syslog);
=20
 	setup_root(&lo, &lo.root);
--=20
2.21.0


