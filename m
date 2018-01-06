Received: from eggs.gnu.org ([2001:4830:134:3::10]:56734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy5-0007Dt-25
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy3-0006LT-7v
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcy2-0006Im-SM
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614a8v051203
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:08:10 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fajpmba04-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:08:09 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:08:07 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:39 +0100
In-Reply-To: <20180106010739.18201-1-groug@kaod.org>
References: <20180106010739.18201-1-groug@kaod.org>
Message-Id: <20180106010739.18201-13-groug@kaod.org>
Subject: [Qemu-devel] [PULL 12/12] fsdev: improve error handling of backend
 init
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

This patch changes some error messages in the backend init code and
convert backends to propagate QEMU Error objects instead of calling
error_report().

One notable improvement is that the local backend now provides a more
detailed error report when it fails to open the shared directory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h  |  2 +-
 hw/9pfs/9p-handle.c |  2 +-
 hw/9pfs/9p-local.c  |  3 ++-
 hw/9pfs/9p-proxy.c  | 14 +++++++-------
 hw/9pfs/9p-synth.c  |  2 +-
 hw/9pfs/9p.c        |  6 +++---
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index e7f9e1872129..f871c963eecb 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -104,7 +104,7 @@ void cred_init(FsCred *);
 struct FileOperations
 {
     int (*parse_opts)(QemuOpts *, FsDriverEntry *, Error **errp);
-    int (*init)(FsContext *);
+    int (*init)(FsContext *, Error **errp);
     void (*cleanup)(FsContext *);
     int (*lstat)(FsContext *, V9fsPath *, struct stat *);
     ssize_t (*readlink)(FsContext *, V9fsPath *, char *, size_t);
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index e50941075bda..c5adfe6f3a96 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -604,7 +604,7 @@ static int handle_ioc_getversion(FsContext *ctx, V9fsPath *path,
 #endif
 }
 
-static int handle_init(FsContext *ctx)
+static int handle_init(FsContext *ctx, Error **errp)
 {
     int ret, mnt_id;
     struct statfs stbuf;
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e1a4b844a527..b25c185ff030 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1400,13 +1400,14 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 #endif
 }
 
-static int local_init(FsContext *ctx)
+static int local_init(FsContext *ctx, Error **errp)
 {
     struct statfs stbuf;
     LocalData *data = g_malloc(sizeof(*data));
 
     data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
     if (data->mountfd == -1) {
+        error_setg_errno(errp, errno, "failed to open '%s'", ctx->fs_root);
         goto err;
     }
 
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index f6fb7a408fd1..f030c6a42844 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1083,25 +1083,25 @@ static int proxy_ioc_getversion(FsContext *fs_ctx, V9fsPath *path,
     return err;
 }
 
-static int connect_namedsocket(const char *path)
+static int connect_namedsocket(const char *path, Error **errp)
 {
     int sockfd, size;
     struct sockaddr_un helper;
 
     if (strlen(path) >= sizeof(helper.sun_path)) {
-        error_report("Socket name too long");
+        error_setg(errp, "socket name too long");
         return -1;
     }
     sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
     if (sockfd < 0) {
-        error_report("Failed to create socket: %s", strerror(errno));
+        error_setg_errno(errp, errno, "failed to create client socket");
         return -1;
     }
     strcpy(helper.sun_path, path);
     helper.sun_family = AF_UNIX;
     size = strlen(helper.sun_path) + sizeof(helper.sun_family);
     if (connect(sockfd, (struct sockaddr *)&helper, size) < 0) {
-        error_report("Failed to connect to %s: %s", path, strerror(errno));
+        error_setg_errno(errp, errno, "failed to connect to '%s'", path);
         close(sockfd);
         return -1;
     }
@@ -1144,17 +1144,17 @@ static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs, Error **errp)
     return 0;
 }
 
-static int proxy_init(FsContext *ctx)
+static int proxy_init(FsContext *ctx, Error **errp)
 {
     V9fsProxy *proxy = g_malloc(sizeof(V9fsProxy));
     int sock_id;
 
     if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
-        sock_id = connect_namedsocket(ctx->fs_root);
+        sock_id = connect_namedsocket(ctx->fs_root, errp);
     } else {
         sock_id = atoi(ctx->fs_root);
         if (sock_id < 0) {
-            error_report("Socket descriptor not initialized");
+            error_setg(errp, "socket descriptor not initialized");
         }
     }
     if (sock_id < 0) {
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index df0a8de08aed..8f255e91c00f 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -514,7 +514,7 @@ static int synth_unlinkat(FsContext *ctx, V9fsPath *dir,
     return -1;
 }
 
-static int synth_init(FsContext *ctx)
+static int synth_init(FsContext *ctx, Error **errp)
 {
     QLIST_INIT(&synth_root.child);
     qemu_mutex_init(&synth_mutex);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 1e4ebbe57687..909a61139405 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3542,9 +3542,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
     s->fid_list = NULL;
     qemu_co_rwlock_init(&s->rename_lock);
 
-    if (s->ops->init(&s->ctx) < 0) {
-        error_setg(errp, "9pfs Failed to initialize fs-driver with id:%s"
-                   " and export path:%s", s->fsconf.fsdev_id, s->ctx.fs_root);
+    if (s->ops->init(&s->ctx, errp) < 0) {
+        error_prepend(errp, "cannot initialize fsdev '%s': ",
+                      s->fsconf.fsdev_id);
         goto out;
     }
 
-- 
2.13.6
