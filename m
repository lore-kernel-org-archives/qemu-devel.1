Received: from eggs.gnu.org ([2001:4830:134:3::10]:47911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfmSk-0007QP-2I
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfmSg-000450-PV
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:21:18 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:40606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfmSg-00044I-FR
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:21:14 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C4EE0863A5
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 14:21:10 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 10 Aug 2017 14:21:04 +0200
Message-ID: <150236766413.25933.15038553262682443771.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [for-2.10 PATCH v6] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This function has to ensure it doesn't follow a symlink that could be use=
d
to escape the virtfs directory. This could be easily achieved if fchmodat=
()
on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
it doesn't. There was a tentative to implement a new fchmodat2() syscall
with the correct semantics:

https://patchwork.kernel.org/patch/9596301/

but it didn't gain much momentum. Also it was suggested to look at an O_P=
ATH
based solution in the first place.

The current implementation covers most use-cases, but it notably fails if=
:
- the target path has access rights equal to 0000 (openat() returns EPERM=
),
  =3D> once you've done chmod(0000) on a file, you can never chmod() agai=
n
- the target path is UNIX domain socket (openat() returns ENXIO)
  =3D> bind() of UNIX domain sockets fails if the file is on 9pfs

The solution is to use O_PATH: openat() now succeeds in both cases, and w=
e
can ensure the path isn't a symlink with fstat(). The associated entry in
"/proc/self/fd" can hence be safely passed to the regular chmod() syscall=
.

The previous behavior is kept for older systems that don't have O_PATH.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Zhi Yong Wu <zhiyong.wu@ucloud.cn>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v6: - refactored some code as suggested by Philippe

v5: - added missing fd =3D=3D -1 check

v4: - fixed #if condition
    - moved out: label above #endif
    - fixed typo in changelog
    - added Eric's r-b

v3: - O_PATH in a separate block of code
    - added a reference to the fchmodat2() tentative in the changelog

v2: - renamed OPENAT_DIR_O_PATH to O_PATH_9P_UTIL and use it as a replace=
ment
      for O_PATH to avoid build breaks on O_PATH-less systems
    - keep current behavior for O_PATH-less systems
    - added comments
    - TODO in 2.11: add _nofollow suffix to openat_dir() and openat_file(=
)
---
 hw/9pfs/9p-local.c |   42 +++++++++++++++++++++++++++++++++++-------
 hw/9pfs/9p-util.h  |   24 +++++++++++++++---------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6e478f4765ef..efb0b79a74bf 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -333,17 +333,27 @@ update_map_file:
=20
 static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
 {
+    struct stat stbuf;
     int fd, ret;
=20
     /* FIXME: this should be handled with fchmodat(AT_SYMLINK_NOFOLLOW).
-     * Unfortunately, the linux kernel doesn't implement it yet. As an
-     * alternative, let's open the file and use fchmod() instead. This
-     * may fail depending on the permissions of the file, but it is the
-     * best we can do to avoid TOCTTOU. We first try to open read-only
-     * in case name points to a directory. If that fails, we try write-o=
nly
-     * in case name doesn't point to a directory.
+     * Unfortunately, the linux kernel doesn't implement it yet.
      */
-    fd =3D openat_file(dirfd, name, O_RDONLY, 0);
+
+     /* First, we clear non-racing symlinks out of the way. */
+    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW)) {
+        return -1;
+    }
+    if (S_ISLNK(stbuf.st_mode)) {
+        errno =3D ELOOP;
+        return -1;
+    }
+
+    /* Access modes are ignored when O_PATH is supported. We try O_RDONL=
Y and
+     * O_WRONLY for old-systems that don't support O_PATH.
+     */
+    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
+#if O_PATH_9P_UTIL =3D=3D 0
     if (fd =3D=3D -1) {
         /* In case the file is writable-only and isn't a directory. */
         if (errno =3D=3D EACCES) {
@@ -357,6 +367,24 @@ static int fchmodat_nofollow(int dirfd, const char *=
name, mode_t mode)
         return -1;
     }
     ret =3D fchmod(fd, mode);
+#else
+    if (fd =3D=3D -1) {
+        return -1;
+    }
+
+    /* Now we handle racing symlinks. */
+    ret =3D fstat(fd, &stbuf);
+    if (!ret) {
+        if (S_ISLNK(stbuf.st_mode)) {
+            errno =3D ELOOP;
+            ret =3D -1;
+        } else {
+            char *proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
+            ret =3D chmod(proc_path, mode);
+            g_free(proc_path);
+        }
+    }
+#endif
     close_preserve_errno(fd);
     return ret;
 }
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 91299a24b8af..dc0d2e29aa3b 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -13,6 +13,12 @@
 #ifndef QEMU_9P_UTIL_H
 #define QEMU_9P_UTIL_H
=20
+#ifdef O_PATH
+#define O_PATH_9P_UTIL O_PATH
+#else
+#define O_PATH_9P_UTIL 0
+#endif
+
 static inline void close_preserve_errno(int fd)
 {
     int serrno =3D errno;
@@ -22,13 +28,8 @@ static inline void close_preserve_errno(int fd)
=20
 static inline int openat_dir(int dirfd, const char *name)
 {
-#ifdef O_PATH
-#define OPENAT_DIR_O_PATH O_PATH
-#else
-#define OPENAT_DIR_O_PATH 0
-#endif
     return openat(dirfd, name,
-                  O_DIRECTORY | O_RDONLY | O_NOFOLLOW | OPENAT_DIR_O_PAT=
H);
+                  O_DIRECTORY | O_RDONLY | O_NOFOLLOW | O_PATH_9P_UTIL);
 }
=20
 static inline int openat_file(int dirfd, const char *name, int flags,
@@ -43,9 +44,14 @@ static inline int openat_file(int dirfd, const char *n=
ame, int flags,
     }
=20
     serrno =3D errno;
-    /* O_NONBLOCK was only needed to open the file. Let's drop it. */
-    ret =3D fcntl(fd, F_SETFL, flags);
-    assert(!ret);
+    /* O_NONBLOCK was only needed to open the file. Let's drop it. We do=
n't
+     * do that with O_PATH since fcntl(F_SETFL) isn't supported, and ope=
nat()
+     * ignored it anyway.
+     */
+    if (!(flags & O_PATH_9P_UTIL)) {
+        ret =3D fcntl(fd, F_SETFL, flags);
+        assert(!ret);
+    }
     errno =3D serrno;
     return fd;
 }
