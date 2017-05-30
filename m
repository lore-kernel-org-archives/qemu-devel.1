Received: from eggs.gnu.org ([2001:4830:134:3::10]:40436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOi-0007JR-6G
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOe-00024T-8O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45317
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOe-00024G-15
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDcgbZ123944
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:15 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2as7mre5ek-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:15 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:13 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:40 +0200
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
Message-Id: <1496151640-29919-12-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 11/11] 9pfs: local: metadata file for the
 VirtFS root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

When using the mapped-file security, credentials are stored in a metadata
directory located in the parent directory. This is okay for all paths with
the notable exception of the root path, since we don't want and probably
can't create a metadata directory above the virtfs directory on the host.

This patch introduces a dedicated metadata file, sitting in the virtfs root
for this purpose. It relies on the fact that the "." name necessarily refers
to the virtfs root.

As for the metadata directory, we don't want the client to see this file.
The current code only cares for readdir() but there are many other places
to fix actually. The filtering logic is hence put in a separate function.

Before:

# ls -ld
drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .
# chown root.root .
chown: changing ownership of '.': Is a directory
# ls -ld
drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .

After:

# ls -ld
drwxr-xr-x. 3 greg greg 4096 May  5 12:49 .
# chown root.root .
# ls -ld
drwxr-xr-x. 3 root root 4096 May  5 12:50 .

and from the host:

ls -al .virtfs_metadata_root
-rwx------. 1 greg greg 26 May  5 12:50 .virtfs_metadata_root
$ cat .virtfs_metadata_root
virtfs.uid=0
virtfs.gid=0

Reported-by: Leo Gaspard <leo@gaspard.io>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Leo Gaspard <leo@gaspard.io>
[groug: work around a patchew false positive in
        local_set_mapped_file_attrat()]
---
 hw/9pfs/9p-local.c | 86 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ddc5038cff39..1e78b7c9e961 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -107,6 +107,7 @@ static void unlinkat_preserve_errno(int dirfd, const char *path, int flags)
 }
 
 #define VIRTFS_META_DIR ".virtfs_metadata"
+#define VIRTFS_META_ROOT_FILE VIRTFS_META_DIR "_root"
 
 static FILE *local_fopenat(int dirfd, const char *name, const char *mode)
 {
@@ -143,13 +144,17 @@ static void local_mapped_file_attr(int dirfd, const char *name,
     char buf[ATTR_MAX];
     int map_dirfd;
 
-    map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
-    if (map_dirfd == -1) {
-        return;
-    }
+    if (strcmp(name, ".")) {
+        map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
+        if (map_dirfd == -1) {
+            return;
+        }
 
-    fp = local_fopenat(map_dirfd, name, "r");
-    close_preserve_errno(map_dirfd);
+        fp = local_fopenat(map_dirfd, name, "r");
+        close_preserve_errno(map_dirfd);
+    } else {
+        fp = local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "r");
+    }
     if (!fp) {
         return;
     }
@@ -227,26 +232,38 @@ static int local_set_mapped_file_attrat(int dirfd, const char *name,
     int ret;
     char buf[ATTR_MAX];
     int uid = -1, gid = -1, mode = -1, rdev = -1;
-    int map_dirfd;
-
-    ret = mkdirat(dirfd, VIRTFS_META_DIR, 0700);
-    if (ret < 0 && errno != EEXIST) {
-        return -1;
-    }
-
-    map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
-    if (map_dirfd == -1) {
-        return -1;
-    }
+    int map_dirfd = -1, map_fd;
+    bool is_root = !strcmp(name, ".");
+
+    if (is_root) {
+        fp = local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "r");
+        if (!fp) {
+            if (errno == ENOENT) {
+                goto update_map_file;
+            } else {
+                return -1;
+            }
+        }
+    } else {
+        ret = mkdirat(dirfd, VIRTFS_META_DIR, 0700);
+        if (ret < 0 && errno != EEXIST) {
+            return -1;
+        }
 
-    fp = local_fopenat(map_dirfd, name, "r");
-    if (!fp) {
-        if (errno == ENOENT) {
-            goto update_map_file;
-        } else {
-            close_preserve_errno(map_dirfd);
+        map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
+        if (map_dirfd == -1) {
             return -1;
         }
+
+        fp = local_fopenat(map_dirfd, name, "r");
+        if (!fp) {
+            if (errno == ENOENT) {
+                goto update_map_file;
+            } else {
+                close_preserve_errno(map_dirfd);
+                return -1;
+            }
+        }
     }
     memset(buf, 0, ATTR_MAX);
     while (fgets(buf, ATTR_MAX, fp)) {
@@ -264,12 +281,26 @@ static int local_set_mapped_file_attrat(int dirfd, const char *name,
     fclose(fp);
 
 update_map_file:
-    fp = local_fopenat(map_dirfd, name, "w");
-    close_preserve_errno(map_dirfd);
+    if (is_root) {
+        fp = local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "w");
+    } else {
+        fp = local_fopenat(map_dirfd, name, "w");
+        /* We can't go this far with map_dirfd not being a valid file descriptor
+         * but some versions of gcc aren't smart enough to see it.
+         */
+        if (map_dirfd != -1) {
+            close_preserve_errno(map_dirfd);
+        }
+    }
     if (!fp) {
         return -1;
     }
 
+    map_fd = fileno(fp);
+    assert(map_fd != -1);
+    ret = fchmod(map_fd, 0600);
+    assert(ret == 0);
+
     if (credp->fc_uid != -1) {
         uid = credp->fc_uid;
     }
@@ -478,7 +509,8 @@ static off_t local_telldir(FsContext *ctx, V9fsFidOpenState *fs)
 
 static bool local_is_mapped_file_metadata(FsContext *fs_ctx, const char *name)
 {
-    return !strcmp(name, VIRTFS_META_DIR);
+    return
+        !strcmp(name, VIRTFS_META_DIR) || !strcmp(name, VIRTFS_META_ROOT_FILE);
 }
 
 static struct dirent *local_readdir(FsContext *ctx, V9fsFidOpenState *fs)
@@ -495,7 +527,7 @@ again:
         entry->d_type = DT_UNKNOWN;
     } else if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         if (local_is_mapped_file_metadata(ctx, entry->d_name)) {
-            /* skip the meta data directory */
+            /* skip the meta data */
             goto again;
         }
         entry->d_type = DT_UNKNOWN;
-- 
2.7.5
