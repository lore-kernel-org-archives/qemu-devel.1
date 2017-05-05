Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f22-0001Of-KJ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f1z-0000si-BZ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:20:34 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:48754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6f1z-0000r0-1l
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:20:31 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A652EEC735
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:20:29 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:37:29 +0200
Message-ID: <149399504988.29022.13818395938763860712.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] 9pfs: local: metadata file for the VirtFS
 root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?L=C3=A9o?= Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

When using the mapped-file security, credentials are stored in a metadata
directory located in the parent directory. This is okay for all paths wit=
h
the notable exception of the root path, since we don't want and probably
can't create a metadata directory above the virtfs directory on the host.

This patch introduces a dedicated metadata file, sitting in the virtfs ro=
ot
for this purpose. It relies on the fact that the "." name necessarily ref=
er
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
# chown bin.bin .
# ls -ld
drwxr-xr-x. 3 root root 4096 May  5 12:50 .

and from the host:

ls -al .virtfs_metadata_root
-rwx------. 1 greg greg 26 May  5 12:50 .virtfs_metadata_root
$ cat .virtfs_metadata_root
virtfs.uid=3D0
virtfs.gid=3D0

Reported-by: L=C3=A9o Gaspard <leo@gaspard.io>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   88 ++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index bb6e296df317..b427d2928800 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -78,6 +78,7 @@ static void unlinkat_preserve_errno(int dirfd, const ch=
ar *path, int flags)
 }
=20
 #define VIRTFS_META_DIR ".virtfs_metadata"
+#define VIRTFS_META_ROOT_FILE VIRTFS_META_DIR "_root"
=20
 static FILE *local_fopenat(int dirfd, const char *name, const char *mode=
)
 {
@@ -114,13 +115,17 @@ static void local_mapped_file_attr(int dirfd, const=
 char *name,
     char buf[ATTR_MAX];
     int map_dirfd;
=20
-    map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
-    if (map_dirfd =3D=3D -1) {
-        return;
-    }
+    if (strcmp(name, ".")) {
+        map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
+        if (map_dirfd =3D=3D -1) {
+            return;
+        }
=20
-    fp =3D local_fopenat(map_dirfd, name, "r");
-    close_preserve_errno(map_dirfd);
+        fp =3D local_fopenat(map_dirfd, name, "r");
+        close_preserve_errno(map_dirfd);
+    } else {
+        fp =3D local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "r");
+    }
     if (!fp) {
         return;
     }
@@ -198,26 +203,38 @@ static int local_set_mapped_file_attrat(int dirfd, =
const char *name,
     int ret;
     char buf[ATTR_MAX];
     int uid =3D -1, gid =3D -1, mode =3D -1, rdev =3D -1;
-    int map_dirfd;
-
-    ret =3D mkdirat(dirfd, VIRTFS_META_DIR, 0700);
-    if (ret < 0 && errno !=3D EEXIST) {
-        return -1;
-    }
-
-    map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
-    if (map_dirfd =3D=3D -1) {
-        return -1;
-    }
+    int map_dirfd, map_fd;
+    bool is_root =3D !strcmp(name, ".");
+
+    if (is_root) {
+        fp =3D local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "r");
+        if (!fp) {
+            if (errno =3D=3D ENOENT) {
+                goto update_map_file;
+            } else {
+                return -1;
+            }
+        }
+    } else {
+        ret =3D mkdirat(dirfd, VIRTFS_META_DIR, 0700);
+        if (ret < 0 && errno !=3D EEXIST) {
+            return -1;
+        }
=20
-    fp =3D local_fopenat(map_dirfd, name, "r");
-    if (!fp) {
-        if (errno =3D=3D ENOENT) {
-            goto update_map_file;
-        } else {
-            close_preserve_errno(map_dirfd);
+        map_dirfd =3D openat_dir(dirfd, VIRTFS_META_DIR);
+        if (map_dirfd =3D=3D -1) {
             return -1;
         }
+
+        fp =3D local_fopenat(map_dirfd, name, "r");
+        if (!fp) {
+            if (errno =3D=3D ENOENT) {
+                goto update_map_file;
+            } else {
+                close_preserve_errno(map_dirfd);
+                return -1;
+            }
+        }
     }
     memset(buf, 0, ATTR_MAX);
     while (fgets(buf, ATTR_MAX, fp)) {
@@ -235,12 +252,21 @@ static int local_set_mapped_file_attrat(int dirfd, =
const char *name,
     fclose(fp);
=20
 update_map_file:
-    fp =3D local_fopenat(map_dirfd, name, "w");
-    close_preserve_errno(map_dirfd);
+    if (is_root) {
+        fp =3D local_fopenat(dirfd, VIRTFS_META_ROOT_FILE, "w");
+    } else {
+        fp =3D local_fopenat(map_dirfd, name, "w");
+        close_preserve_errno(map_dirfd);
+    }
     if (!fp) {
         return -1;
     }
=20
+    map_fd =3D fileno(fp);
+    assert(map_fd !=3D -1);
+    ret =3D fchmod(map_fd, 0700);
+    assert(ret =3D=3D 0);
+
     if (credp->fc_uid !=3D -1) {
         uid =3D credp->fc_uid;
     }
@@ -447,6 +473,14 @@ static off_t local_telldir(FsContext *ctx, V9fsFidOp=
enState *fs)
     return telldir(fs->dir.stream);
 }
=20
+static bool local_must_skip_metadata(FsContext *fs_ctx, const char *name=
)
+{
+    return
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        (!strcmp(name, VIRTFS_META_DIR) ||
+         !strcmp(name, VIRTFS_META_ROOT_FILE));
+}
+
 static struct dirent *local_readdir(FsContext *ctx, V9fsFidOpenState *fs=
)
 {
     struct dirent *entry;
@@ -460,8 +494,8 @@ again:
     if (ctx->export_flags & V9FS_SM_MAPPED) {
         entry->d_type =3D DT_UNKNOWN;
     } else if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        if (!strcmp(entry->d_name, VIRTFS_META_DIR)) {
-            /* skp the meta data directory */
+        if (local_must_skip_metadata(ctx, entry->d_name)) {
+            /* skip the meta data stuff */
             goto again;
         }
         entry->d_type =3D DT_UNKNOWN;
