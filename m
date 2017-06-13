Received: from eggs.gnu.org ([2001:4830:134:3::10]:37992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJr-0006KH-Uy
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKsJq-0001Zb-A2
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:21:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 22:20:57 +0200
Message-Id: <20170613202107.10125-7-mreitz@redhat.com>
In-Reply-To: <20170613202107.10125-1-mreitz@redhat.com>
References: <20170613202107.10125-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/16] block/file-posix: Extract
 raw_regular_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This functionality is part of raw_create() which we will be able to
reuse nicely in raw_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 block/file-posix.c | 144 +++++++++++++++++++++++++++++------------------=
------
 1 file changed, 78 insertions(+), 66 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index a020198..bd02bfb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1624,6 +1624,81 @@ static void raw_close(BlockDriverState *bs)
     }
 }
=20
+static int raw_regular_truncate(int fd, int64_t offset, PreallocMode pre=
alloc,
+                                Error **errp)
+{
+    int result =3D 0;
+    char *buf;
+
+    switch (prealloc) {
+#ifdef CONFIG_POSIX_FALLOCATE
+    case PREALLOC_MODE_FALLOC:
+        /*
+         * Truncating before posix_fallocate() makes it about twice slow=
er on
+         * file systems that do not support fallocate(), trying to check=
 if a
+         * block is allocated before allocating it, so don't do that her=
e.
+         */
+        result =3D -posix_fallocate(fd, 0, offset);
+        if (result !=3D 0) {
+            /* posix_fallocate() doesn't set errno. */
+            error_setg_errno(errp, -result,
+                             "Could not preallocate data for the new fil=
e");
+        }
+        return result;
+#endif
+    case PREALLOC_MODE_FULL:
+    {
+        int64_t num =3D 0, left =3D offset;
+
+        /*
+         * Knowing the final size from the beginning could allow the fil=
e
+         * system driver to do less allocations and possibly avoid
+         * fragmentation of the file.
+         */
+        if (ftruncate(fd, offset) !=3D 0) {
+            result =3D -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+            return result;
+        }
+
+        buf =3D g_malloc0(65536);
+
+        while (left > 0) {
+            num =3D MIN(left, 65536);
+            result =3D write(fd, buf, num);
+            if (result < 0) {
+                result =3D -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not write to the new file");
+                break;
+            }
+            left -=3D result;
+        }
+        if (result >=3D 0) {
+            result =3D fsync(fd);
+            if (result < 0) {
+                result =3D -errno;
+                error_setg_errno(errp, -result,
+                                 "Could not flush new file to disk");
+            }
+        }
+        g_free(buf);
+        return result;
+    }
+    case PREALLOC_MODE_OFF:
+        if (ftruncate(fd, offset) !=3D 0) {
+            result =3D -errno;
+            error_setg_errno(errp, -result, "Could not resize file");
+        }
+        return result;
+    default:
+        result =3D -ENOTSUP;
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_lookup[prealloc]);
+        return result;
+    }
+}
+
 static int raw_truncate(BlockDriverState *bs, int64_t offset,
                         PreallocMode prealloc, Error **errp)
 {
@@ -1892,72 +1967,9 @@ static int raw_create(const char *filename, QemuOp=
ts *opts, Error **errp)
 #endif
     }
=20
-    switch (prealloc) {
-#ifdef CONFIG_POSIX_FALLOCATE
-    case PREALLOC_MODE_FALLOC:
-        /*
-         * Truncating before posix_fallocate() makes it about twice slow=
er on
-         * file systems that do not support fallocate(), trying to check=
 if a
-         * block is allocated before allocating it, so don't do that her=
e.
-         */
-        result =3D -posix_fallocate(fd, 0, total_size);
-        if (result !=3D 0) {
-            /* posix_fallocate() doesn't set errno. */
-            error_setg_errno(errp, -result,
-                             "Could not preallocate data for the new fil=
e");
-        }
-        break;
-#endif
-    case PREALLOC_MODE_FULL:
-    {
-        int64_t num =3D 0, left =3D total_size;
-
-        /*
-         * Knowing the final size from the beginning could allow the fil=
e
-         * system driver to do less allocations and possibly avoid
-         * fragmentation of the file.
-         */
-        if (ftruncate(fd, total_size) !=3D 0) {
-            result =3D -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-            goto out_close;
-        }
-
-        buf =3D g_malloc0(65536);
-
-        while (left > 0) {
-            num =3D MIN(left, 65536);
-            result =3D write(fd, buf, num);
-            if (result < 0) {
-                result =3D -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not write to the new file");
-                break;
-            }
-            left -=3D result;
-        }
-        if (result >=3D 0) {
-            result =3D fsync(fd);
-            if (result < 0) {
-                result =3D -errno;
-                error_setg_errno(errp, -result,
-                                 "Could not flush new file to disk");
-            }
-        }
-        g_free(buf);
-        break;
-    }
-    case PREALLOC_MODE_OFF:
-        if (ftruncate(fd, total_size) !=3D 0) {
-            result =3D -errno;
-            error_setg_errno(errp, -result, "Could not resize file");
-        }
-        break;
-    default:
-        result =3D -ENOTSUP;
-        error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_lookup[prealloc]);
-        break;
+    result =3D raw_regular_truncate(fd, total_size, prealloc, errp);
+    if (result < 0) {
+        goto out_close;
     }
=20
 out_close:
--=20
2.9.4
