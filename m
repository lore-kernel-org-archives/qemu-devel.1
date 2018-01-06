Received: from eggs.gnu.org ([2001:4830:134:3::10]:56794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy6-0007Ef-V0
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy3-0006Lp-A4
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45674
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcy3-0006K5-1P
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614Zd1007286
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:08:08 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fak5jabm1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:08:07 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:08:06 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:38 +0100
In-Reply-To: <20180106010739.18201-1-groug@kaod.org>
References: <20180106010739.18201-1-groug@kaod.org>
Message-Id: <20180106010739.18201-12-groug@kaod.org>
Subject: [Qemu-devel] [PULL 11/12] fsdev: improve error handling of backend
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

This patch changes some error messages in the backend opts parsing
code and convert backends to propagate QEMU Error objects instead
of calling error_report().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h  |  2 +-
 fsdev/qemu-fsdev.c  |  4 +++-
 hw/9pfs/9p-handle.c |  2 +-
 hw/9pfs/9p-local.c  | 33 +++++++++++++++++++--------------
 hw/9pfs/9p-proxy.c  | 16 +++++++++++++---
 5 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 63d19a6dcd0e..e7f9e1872129 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -103,7 +103,7 @@ void cred_init(FsCred *);
 
 struct FileOperations
 {
-    int (*parse_opts)(QemuOpts *, FsDriverEntry *);
+    int (*parse_opts)(QemuOpts *, FsDriverEntry *, Error **errp);
     int (*init)(FsContext *);
     void (*cleanup)(FsContext *);
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
index 26ac90fc5ce3..e50941075bda 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -652,7 +652,7 @@ static void handle_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
+static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 155834db28e1..e1a4b844a527 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1459,16 +1459,21 @@ static void local_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
+static void error_append_security_model_hint(Error **errp)
+{
+    error_append_hint(errp, "Valid options are: security_model="
+                      "[passthrough|mapped-xattr|mapped-file|none]\n");
+}
+
+static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
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
 
@@ -1482,20 +1487,20 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
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
 
@@ -1507,11 +1512,11 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
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
index 652940726e72..f6fb7a408fd1 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1111,17 +1111,27 @@ static int connect_namedsocket(const char *path)
     return sockfd;
 }
 
-static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs)
+static void error_append_socket_sockfd_hint(Error **errp)
+{
+    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
+                      " points to a listening AF_UNIX socket or sock_fd=fd"
+                      " where fd is a file descriptor to a connected AF_UNIX"
+                      " socket\n");
+}
+
+static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs, Error **errp)
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
-- 
2.13.6
