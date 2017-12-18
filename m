Received: from eggs.gnu.org ([2001:4830:134:3::10]:46605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDY-0007p7-Px
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQwDS-00026I-LA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:32 -0500
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:38807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQwDS-00025M-Bi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:16:26 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E8E25B27DF
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:16:22 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 15:16:21 +0100
Message-ID: <151360658178.21833.10761644150673770398.stgit@bahia.lan>
In-Reply-To: <151360656934.21833.11316709584569537205.stgit@bahia.lan>
References: <151360656934.21833.11316709584569537205.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/2] fsdev: improve error handling of backend
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
Cc: Greg Kurz <groug@kaod.org>

This patch changes some error messages in the backend init code and
convert backends to propagate QEMU Error objects instead of calling
error_report().

One notable improvement is that the local backend now provides a more
detailed error report when it fails to open the shared directory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/file-op-9p.h  |    2 +-
 hw/9pfs/9p-handle.c |    2 +-
 hw/9pfs/9p-local.c  |    3 ++-
 hw/9pfs/9p-proxy.c  |   14 +++++++-------
 hw/9pfs/9p-synth.c  |    2 +-
 hw/9pfs/9p.c        |    6 +++---
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 74b7b677c21d..ac7113cfc712 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -106,7 +106,7 @@ void cred_init(FsCred *);
 struct FileOperations
 {
     int (*parse_opts)(QemuOpts *, struct FsDriverEntry *, Error **errp);
-    int (*init)(struct FsContext *);
+    int (*init)(struct FsContext *, Error **errp);
     void (*cleanup)(struct FsContext *);
     int (*lstat)(FsContext *, V9fsPath *, struct stat *);
     ssize_t (*readlink)(FsContext *, V9fsPath *, char *, size_t);
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 9eab01b10582..86b7de1187b5 100644
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
index 676d60e1a8ef..b1d546447ed8 100644
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
index 186fe1d5a8eb..ead2df221e4d 100644
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
@@ -1145,17 +1145,17 @@ static int proxy_parse_opts(QemuOpts *opts, struct FsDriverEntry *fs,
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
index 52d46632fe15..73cb3e1646ac 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3544,9 +3544,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
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
 
