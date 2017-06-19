Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMxiT-0007qA-QF
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMxiS-0005tE-Ga
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:45 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dMxiS-0005sT-6u
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:31:44 -0400
Received: by mail-wr0-x243.google.com with SMTP id z45so13883935wrb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 07:31:44 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Mon, 19 Jun 2017 16:28:48 +0200
Message-Id: <20170619142848.14258-2-tobleminer@gmail.com>
In-Reply-To: <20170619142848.14258-1-tobleminer@gmail.com>
References: <20170619142848.14258-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH v4 1/1] 9pfs: local: Add support for custom
 fmode/dmode in 9ps mapped security modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, el13635@mail.ntua.gr, Tobias Schramm <tobleminer@gmail.com>

Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
---
 v4: Use OPT_NUMBER for file mode arguments, fix back to front naming,
     fix resource leak and add sanity checking for fmode/dmode arguments
 v3: Use unsigned types for umask
 v2: Adjust patch to QEMU code style

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 34 +++++++++++++++++++++++++---------
 hw/9pfs/9p.c            |  3 +++
 qemu-options.hx         | 20 ++++++++++++++++----
 5 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 0844a403dc..474c79d003 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -76,6 +76,8 @@ typedef struct FsDriverEntry {
     int export_flags;
     FileOperations *ops;
     FsThrottle fst;
+    mode_t fmode;
+    mode_t dmode;
 } FsDriverEntry;
 
 typedef struct FsContext
@@ -88,6 +90,8 @@ typedef struct FsContext
     FsThrottle *fst;
     /* fs driver specific data */
     void *private;
+    mode_t fmode;
+    mode_t dmode;
 } FsContext;
 
 typedef struct V9fsPath {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index bf5713008a..7c31ffffaf 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -38,6 +38,12 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "fmode",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "dmode",
+            .type = QEMU_OPT_NUMBER,
         },
 
         THROTTLE_OPTS,
@@ -75,6 +81,12 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "fmode",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "dmode",
+            .type = QEMU_OPT_NUMBER,
         },
 
         { /*End of list */ }
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1e78b7c9e9..696e2b75dc 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -633,7 +633,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
+        err = mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
         if (err == -1) {
             goto out;
         }
@@ -685,7 +685,7 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = mkdirat(dirfd, name, SM_LOCAL_DIR_MODE_BITS);
+        err = mkdirat(dirfd, name, fs_ctx->dmode);
         if (err == -1) {
             goto out;
         }
@@ -786,7 +786,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     /* Determine the security model */
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        fd = openat_file(dirfd, name, flags, SM_LOCAL_MODE_BITS);
+        fd = openat_file(dirfd, name, flags, fs_ctx->fmode);
         if (fd == -1) {
             goto out;
         }
@@ -849,7 +849,7 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
         ssize_t oldpath_size, write_size;
 
         fd = openat_file(dirfd, name, O_CREAT | O_EXCL | O_RDWR,
-                         SM_LOCAL_MODE_BITS);
+                         fs_ctx->fmode);
         if (fd == -1) {
             goto out;
         }
@@ -1431,6 +1431,8 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
+    uint64_t fmode = qemu_opt_get_number(opts, "fmode", SM_LOCAL_MODE_BITS);
+    uint64_t dmode = qemu_opt_get_number(opts, "dmode", SM_LOCAL_DIR_MODE_BITS);
     Error *err = NULL;
 
     if (!sec_model) {
@@ -1456,17 +1458,31 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
         return -1;
     }
 
-    if (!path) {
-        error_report("fsdev: No path specified");
-        return -1;
-    }
-
     fsdev_throttle_parse_opts(opts, &fse->fst, &err);
     if (err) {
         error_reportf_err(err, "Throttle configuration is not valid: ");
         return -1;
     }
 
+    if (!(fse->export_flags & (V9FS_SM_MAPPED | V9FS_SM_MAPPED_FILE))) {
+        if (qemu_opt_find(opts, "fmode")) {
+            error_report("fmode is only valid for mapped 9p modes");
+            return -1;
+        }
+        if (qemu_opt_find(opts, "dmode")) {
+            error_report("dmode is only valid for mapped 9p modes");
+            return -1;
+        }
+    }
+
+    fse->fmode = ((mode_t)fmode) & 0777;
+    fse->dmode = ((mode_t)dmode) & 0777;
+
+    if (!path) {
+        error_report("fsdev: No path specified");
+        return -1;
+    }
+
     fse->path = g_strdup(path);
 
     return 0;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 96d2683348..a0ae98f7ca 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3533,6 +3533,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
 
     s->ops = fse->ops;
 
+    s->ctx.fmode = fse->fmode;
+    s->ctx.dmode = fse->dmode;
+
     s->fid_list = NULL;
     qemu_co_rwlock_init(&s->rename_lock);
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 30c4f9850f..5999719720 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -847,7 +847,7 @@ ETEXI
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
     "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
-    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n"
+    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n"
     " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
     " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
     " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
@@ -857,7 +857,7 @@ DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
 
 STEXI
 
-@item -fsdev @var{fsdriver},id=@var{id},path=@var{path},[security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}]
+@item -fsdev @var{fsdriver},id=@var{id},path=@var{path},[security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
 @findex -fsdev
 Define a new file system device. Valid options are:
 @table @option
@@ -898,6 +898,12 @@ with virtfs-proxy-helper
 Enables proxy filesystem driver to use passed socket descriptor for
 communicating with virtfs-proxy-helper. Usually a helper like libvirt
 will create socketpair and pass one of the fds as sock_fd
+@item fmode=@var{fmode}
+Specifies the default mode for newly created files on the host. Works only
+with security models "mapped-xattr" and "mapped-file".
+@item dmode=@var{dmode}
+Specifies the default mode for newly created directories on the host. Works
+only with security models "mapped-xattr" and "mapped-file".
 @end table
 
 -fsdev option is used along with -device driver "virtio-9p-pci".
@@ -914,12 +920,12 @@ ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
     "-virtfs local,path=path,mount_tag=tag,security_model=[mapped-xattr|mapped-file|passthrough|none]\n"
-    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd]\n",
+    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}]
+@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
 @findex -virtfs
 
 The general form of a Virtual File system pass-through options are:
@@ -961,6 +967,12 @@ will create socketpair and pass one of the fds as sock_fd
 @item sock_fd
 Enables proxy filesystem driver to use passed 'sock_fd' as the socket
 descriptor for interfacing with virtfs-proxy-helper
+@item fmode=@var{fmode}
+Specifies the default mode for newly created files on the host. Works only
+with security models "mapped-xattr" and "mapped-file".
+@item dmode=@var{dmode}
+Specifies the default mode for newly created directories on the host. Works
+only with security models "mapped-xattr" and "mapped-file".
 @end table
 ETEXI
 
-- 
2.13.1
