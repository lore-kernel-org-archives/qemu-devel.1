Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNg-0005Am-Gs
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNb-0005oN-EQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005iP-On
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9CEC30DDBEB
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A78C42A2F8
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:11 +0200
Message-Id: <20181008173125.19678-18-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 17/31] vl: Clean up error reporting in
 parse_add_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() in a function that takes an Error ** argument
is suspicious.  parse_add_fd() does that, and then fails without
setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
with it, but clean it up anyway.

Also change call of cleanup_add_fd(), which can't fail, for symmetry.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 485c3fc008..7ce8299d9d 100644
--- a/vl.c
+++ b/vl.c
@@ -1059,12 +1059,12 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
     fd_opaque = qemu_opt_get(opts, "opaque");
 
     if (fd < 0) {
-        error_report("fd option is required and must be non-negative");
+        error_setg(errp, "fd option is required and must be non-negative");
         return -1;
     }
 
     if (fd <= STDERR_FILENO) {
-        error_report("fd cannot be a standard I/O stream");
+        error_setg(errp, "fd cannot be a standard I/O stream");
         return -1;
     }
 
@@ -1074,12 +1074,12 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
      */
     flags = fcntl(fd, F_GETFD);
     if (flags == -1 || (flags & FD_CLOEXEC)) {
-        error_report("fd is not valid or already in use");
+        error_setg(errp, "fd is not valid or already in use");
         return -1;
     }
 
     if (fdset_id < 0) {
-        error_report("set option is required and must be non-negative");
+        error_setg(errp, "set option is required and must be non-negative");
         return -1;
     }
 
@@ -1092,7 +1092,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
     }
 #endif
     if (dupfd == -1) {
-        error_report("error duplicating fd: %s", strerror(errno));
+        error_setg(errp, "error duplicating fd: %s", strerror(errno));
         return -1;
     }
 
@@ -3936,15 +3936,11 @@ int main(int argc, char **argv, char **envp)
     }
 
 #ifndef _WIN32
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          parse_add_fd, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("add-fd"),
+                      parse_add_fd, NULL, &error_fatal);
 
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          cleanup_add_fd, NULL, NULL)) {
-        exit(1);
-    }
+    qemu_opts_foreach(qemu_find_opts("add-fd"),
+                      cleanup_add_fd, NULL, &error_fatal);
 #endif
 
     current_machine = MACHINE(object_new(object_class_get_name(
-- 
2.17.1
