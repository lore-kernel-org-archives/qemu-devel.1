Received: from eggs.gnu.org ([2001:4830:134:3::10]:46513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDS-0007kH-7u
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDK-0001z3-Nf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:26 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQwDK-0001wo-AX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:18 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CA9F2B27B9
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:16:16 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 15:16:15 +0100
Message-ID: <151360657561.21833.11192135359551870162.stgit@bahia.lan>
In-Reply-To: <151360656934.21833.11316709584569537205.stgit@bahia.lan>
References: <151360656934.21833.11316709584569537205.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/2] fsdev: improve error handling of backend
 opts parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

This patch changes some error messages in the backend opts parsing
code and convert backends to propagate QEMU Error objects instead
of calling error_report().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h  |    2 +-
 fsdev/qemu-fsdev.c  |    4 +++-
 hw/9pfs/9p-handle.c |    3 ++-
 hw/9pfs/9p-local.c  |   34 ++++++++++++++++++++--------------
 hw/9pfs/9p-proxy.c  |   17 ++++++++++++++---
 5 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 474c79d003f6..74b7b677c21d 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -105,7 +105,7 @@ void cred_init(FsCred *);
 
 struct FileOperations
 {
-    int (*parse_opts)(QemuOpts *, struct FsDriverEntry *);
+    int (*parse_opts)(QemuOpts *, struct FsDriverEntry *, Error **errp);
     int (*init)(struct FsContext *);
     void (*cleanup)(struct FsContext *);
     int (*lstat)(FsContext *, V9fsPath *, struct stat *);
diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index 266e442b871a..941e3096574e 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -37,6 +37,7 @@ int qemu_fsdev_add(QemuOpts *opts)
     const char *fsdriver = qemu_opt_get(opts, "fsdriver");
     const char *writeout = qemu_opt_get(opts, "writeout");
     bool ro = qemu_opt_get_bool(opts, "readonly", 0);
+    Error *local_err = NULL;
 
     if (!fsdev_id) {
         error_report("fsdev: No id specified");
@@ -74,7 +75,8 @@ int qemu_fsdev_add(QemuOpts *opts)
     }
 
     if (fsle->fse.ops->parse_opts) {
-        if (fsle->fse.ops->parse_opts(opts, &fsle->fse)) {
+        if (fsle->fse.ops->parse_opts(opts, &fsle->fse, &local_err)) {
+            error_report_err(local_err);
             g_free(fsle->fse.fsdev_id);
             g_free(fsle);
             return -1;
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 9875f1894cc5..9eab01b10582 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -652,7 +652,8 @@ static void handle_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int handle_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
+static int handle_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse,
+                             Error **errp)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e51af87309c6..676d60e1a8ef 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1459,16 +1459,22 @@ static void local_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
+static void error_append_security_model_hint(Error **errp)
+{
+    error_append_hint(errp, "Valid options are: security_model="
+                      "[passthrough|mapped-xattr|mapped-file|none]\n");
+}
+
+static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse,
+                            Error **errp)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
-    Error *err = NULL;
+    Error *local_err = NULL;
 
     if (!sec_model) {
-        error_report("Security model not specified, local fs needs security model");
-        error_printf("valid options are:"
-                     "\tsecurity_model=[passthrough|mapped-xattr|mapped-file|none]\n");
+        error_setg(errp, "security_model property not set");
+        error_append_security_model_hint(errp);
         return -1;
     }
 
@@ -1482,20 +1488,20 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
     } else if (!strcmp(sec_model, "mapped-file")) {
         fse->export_flags |= V9FS_SM_MAPPED_FILE;
     } else {
-        error_report("Invalid security model %s specified", sec_model);
-        error_printf("valid options are:"
-                     "\t[passthrough|mapped-xattr|mapped-file|none]\n");
+        error_setg(errp, "invalid security_model property '%s'", sec_model);
+        error_append_security_model_hint(errp);
         return -1;
     }
 
     if (!path) {
-        error_report("fsdev: No path specified");
+        error_setg(errp, "path property not set");
         return -1;
     }
 
-    fsdev_throttle_parse_opts(opts, &fse->fst, &err);
-    if (err) {
-        error_reportf_err(err, "Throttle configuration is not valid: ");
+    fsdev_throttle_parse_opts(opts, &fse->fst, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "invalid throttle configuration: ");
         return -1;
     }
 
@@ -1507,11 +1513,11 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
             qemu_opt_get_number(opts, "dmode", SM_LOCAL_DIR_MODE_BITS) & 0777;
     } else {
         if (qemu_opt_find(opts, "fmode")) {
-            error_report("fmode is only valid for mapped 9p modes");
+            error_setg(errp, "fmode is only valid for mapped security modes");
             return -1;
         }
         if (qemu_opt_find(opts, "dmode")) {
-            error_report("dmode is only valid for mapped 9p modes");
+            error_setg(errp, "dmode is only valid for mapped security modes");
             return -1;
         }
     }
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 28b20a7c3dfa..186fe1d5a8eb 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1111,17 +1111,28 @@ static int connect_namedsocket(const char *path)
     return sockfd;
 }
 
-static int proxy_parse_opts(QemuOpts *opts, struct FsDriverEntry *fs)
+static void error_append_socket_sockfd_hint(Error **errp)
+{
+    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
+                      " points to a listening AF_UNIX socket or sock_fd=fd"
+                      " where fd is a file descriptor to a connected AF_UNIX"
+                      " socket\n");
+}
+
+static int proxy_parse_opts(QemuOpts *opts, struct FsDriverEntry *fs,
+                            Error **errp)
 {
     const char *socket = qemu_opt_get(opts, "socket");
     const char *sock_fd = qemu_opt_get(opts, "sock_fd");
 
     if (!socket && !sock_fd) {
-        error_report("Must specify either socket or sock_fd");
+        error_setg(errp, "both socket and sock_fd properties are missing");
+        error_append_socket_sockfd_hint(errp);
         return -1;
     }
     if (socket && sock_fd) {
-        error_report("Both socket and sock_fd options specified");
+        error_setg(errp, "both socket and sock_fd properties are set");
+        error_append_socket_sockfd_hint(errp);
         return -1;
     }
     if (socket) {
