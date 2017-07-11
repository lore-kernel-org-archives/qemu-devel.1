Received: from eggs.gnu.org ([2001:4830:134:3::10]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmT-0002J4-BS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmS-0007PJ-2Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:05 +0200
Message-Id: <20170711160814.20941-77-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 76/85] block/file-posix: Generalize
 raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Currently, raw_regular_truncate() is intended for setting the size of a
newly created file. However, we also want to use it for truncating an
existing file in which case only the newly added space (when growing)
should be preallocated.

This also means that if resizing failed, we should try to restore the
original file size. This is important when using preallocation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-8-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----=
------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index deefd6e..59154ea 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1624,11 +1624,31 @@ static void raw_close(BlockDriverState *bs)
     }
 }
=20
+/**
+ * Truncates the given regular file @fd to @offset and, when growing, fi=
lls the
+ * new space according to @prealloc.
+ *
+ * Returns: 0 on success, -errno on failure.
+ */
 static int raw_regular_truncate(int fd, int64_t offset, PreallocMode pre=
alloc,
                                 Error **errp)
 {
     int result =3D 0;
-    char *buf;
+    int64_t current_length =3D 0;
+    char *buf =3D NULL;
+    struct stat st;
+
+    if (fstat(fd, &st) < 0) {
+        result =3D -errno;
+        error_setg_errno(errp, -result, "Could not stat file");
+        return result;
+    }
+
+    current_length =3D st.st_size;
+    if (current_length > offset && prealloc !=3D PREALLOC_MODE_OFF) {
+        error_setg(errp, "Cannot use preallocation for shrinking files")=
;
+        return -ENOTSUP;
+    }
=20
     switch (prealloc) {
 #ifdef CONFIG_POSIX_FALLOCATE
@@ -1638,17 +1658,17 @@ static int raw_regular_truncate(int fd, int64_t o=
ffset, PreallocMode prealloc,
          * file systems that do not support fallocate(), trying to check=
 if a
          * block is allocated before allocating it, so don't do that her=
e.
          */
-        result =3D -posix_fallocate(fd, 0, offset);
+        result =3D -posix_fallocate(fd, current_length, offset - current=
_length);
         if (result !=3D 0) {
             /* posix_fallocate() doesn't set errno. */
             error_setg_errno(errp, -result,
-                             "Could not preallocate data for the new fil=
e");
+                             "Could not preallocate new data");
         }
-        return result;
+        goto out;
 #endif
     case PREALLOC_MODE_FULL:
     {
-        int64_t num =3D 0, left =3D offset;
+        int64_t num =3D 0, left =3D offset - current_length;
=20
         /*
          * Knowing the final size from the beginning could allow the fil=
e
@@ -1658,19 +1678,27 @@ static int raw_regular_truncate(int fd, int64_t o=
ffset, PreallocMode prealloc,
         if (ftruncate(fd, offset) !=3D 0) {
             result =3D -errno;
             error_setg_errno(errp, -result, "Could not resize file");
-            return result;
+            goto out;
         }
=20
         buf =3D g_malloc0(65536);
=20
+        result =3D lseek(fd, current_length, SEEK_SET);
+        if (result < 0) {
+            result =3D -errno;
+            error_setg_errno(errp, -result,
+                             "Failed to seek to the old end of file");
+            goto out;
+        }
+
         while (left > 0) {
             num =3D MIN(left, 65536);
             result =3D write(fd, buf, num);
             if (result < 0) {
                 result =3D -errno;
                 error_setg_errno(errp, -result,
-                                 "Could not write to the new file");
-                break;
+                                 "Could not write zeros for preallocatio=
n");
+                goto out;
             }
             left -=3D result;
         }
@@ -1679,11 +1707,11 @@ static int raw_regular_truncate(int fd, int64_t o=
ffset, PreallocMode prealloc,
             if (result < 0) {
                 result =3D -errno;
                 error_setg_errno(errp, -result,
-                                 "Could not flush new file to disk");
+                                 "Could not flush file to disk");
+                goto out;
             }
         }
-        g_free(buf);
-        return result;
+        goto out;
     }
     case PREALLOC_MODE_OFF:
         if (ftruncate(fd, offset) !=3D 0) {
@@ -1697,6 +1725,17 @@ static int raw_regular_truncate(int fd, int64_t of=
fset, PreallocMode prealloc,
                    PreallocMode_lookup[prealloc]);
         return result;
     }
+
+out:
+    if (result < 0) {
+        if (ftruncate(fd, current_length) < 0) {
+            error_report("Failed to restore old file length: %s",
+                         strerror(errno));
+        }
+    }
+
+    g_free(buf);
+    return result;
 }
=20
 static int raw_truncate(BlockDriverState *bs, int64_t offset,
--=20
2.9.4
