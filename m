Received: from eggs.gnu.org ([2001:4830:134:3::10]:46446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArl-0002wp-0v
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDArg-0008Lo-Oi
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49316
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDArg-0008Lg-I1
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NETe8v017089
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2amf9axqjn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:32:47 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 23 May 2017 10:32:47 -0400
From: Greg Kurz <groug@kaod.org>
Date: Tue, 23 May 2017 16:32:42 +0200
In-Reply-To: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/4] 9pfs: local: metadata file for the
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
Cc: Leo Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

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
---
v2: - changed metadata file mode bits to 0600
    - fixed typo in commit message
    - rebased
---
 hw/9pfs/9p-local.c |   81 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b30f68f91026..8babd5542f06 100644
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
+    int map_dirfd, map_fd;
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
@@ -264,12 +281,21 @@ static int local_set_mapped_file_attrat(int dirfd, const char *name,
     fclose(fp);
 
 update_map_file:
-    fp = local_fopenat(map_dirfd, name, "w");
-    close_preserve_errno(map_dirfd);
+    if (is_root) {
+        fp = local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "w");
+    } else {
+        fp = local_fopenat(map_dirfd, name, "w");
+        close_preserve_errno(map_dirfd);
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
@@ -478,7 +504,8 @@ static off_t local_telldir(FsContext *ctx, V9fsFidOpenState *fs)
 
 static bool local_is_mapped_file_metadata(FsContext *fs_ctx, const char *name)
 {
-    return !strcmp(name, VIRTFS_META_DIR);
+    return
+        !strcmp(name, VIRTFS_META_DIR) || !strcmp(name, VIRTFS_META_ROOT_FILE);
 }
 
 static struct dirent *local_readdir(FsContext *ctx, V9fsFidOpenState *fs)
@@ -495,7 +522,7 @@ again:
         entry->d_type = DT_UNKNOWN;
     } else if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         if (local_is_mapped_file_metadata(ctx, entry->d_name)) {
-            /* skip the meta data directory */
+            /* skip the meta data */
             goto again;
         }
         entry->d_type = DT_UNKNOWN;
