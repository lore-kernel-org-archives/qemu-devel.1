Received: from eggs.gnu.org ([2001:4830:134:3::10]:57336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dN6GC-0005D3-Ey
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dN6GA-00005N-Ss
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dN6GA-000057-Ix
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:06 -0400
Received: by mail-wr0-x244.google.com with SMTP id 77so15468688wrb.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:39:06 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Tue, 20 Jun 2017 01:37:18 +0200
Message-Id: <20170619233718.24959-2-tobleminer@gmail.com>
In-Reply-To: <20170619233718.24959-1-tobleminer@gmail.com>
References: <20170619233718.24959-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH v5 1/1] 9pfs: local: Add support for custom
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

In mapped security modes, files are created with very restrictive
permissions (600 for files and 700 for directories). This makes
file sharing between virtual machines and users on the host rather
complicated. Imagine eg. a group of users that need to access data
produced by processes on a virtual machine. Giving those users access
to the data will be difficult since the group access mode is always 0.

This patch makes the default mode for both files and directories
configurable. Existing setups that don't know about the new parameters
keep using the current secure behavior.

Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
---
 v5: Eliminate expandable variables, check mandatory commandline options
     first
 v4: Use OPT_NUMBER for file mode arguments, fix back to front naming,
     fix resource leak and add sanity checking for fmode/dmode arguments
 v3: Use unsigned types for umask
 v2: Adjust patch to QEMU code style

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++----
 hw/9pfs/9p.c            |  3 +++
 qemu-options.hx         | 20 ++++++++++++++++----
 5 files changed, 56 insertions(+), 8 deletions(-)

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
index 1e78b7c9e9..f1ce03b06a 100644
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
@@ -1467,6 +1467,23 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
         return -1;
     }
 
+    if (fse->export_flags & V9FS_SM_MAPPED ||
+        fse->export_flags & V9FS_SM_MAPPED_FILE) {
+        fse->fmode =
+            qemu_opt_get_number(opts, "fmode", SM_LOCAL_MODE_BITS) & 0777;
+        fse->dmode =
+            qemu_opt_get_number(opts, "dmode", SM_LOCAL_DIR_MODE_BITS) & 0777;
+    } else {
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
