Received: from eggs.gnu.org ([209.51.188.92]:46534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qQZ-000757-Pr
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qQX-0004ji-2g
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:26:54 -0500
From: Niels de Vos <ndevos@redhat.com>
Date: Mon,  4 Mar 2019 17:21:02 +0100
Message-Id: <20190304162103.18912-2-ndevos@redhat.com>
In-Reply-To: <20190304162103.18912-1-ndevos@redhat.com>
References: <20190304162103.18912-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, integration@gluster.org, qemu-devel@nongnu.org, Niels de Vos <ndevos@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
function that returns additional 'struct stat' structures to enable
advanced caching of attributes. This is useful for file servers, not so
much for QEMU. Nevertheless, the API has changed and needs to be
adopted.

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Signed-off-by: Niels de Vos <ndevos@redhat.com>

---
v4: rebase to current master branch
v3: define old backwards compatible glfs_ftruncate() macro, from Eric Bla=
ke
v2: do a compile check as suggested by Eric Blake
---
 block/gluster.c | 11 +++++++++--
 configure       | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index af64330211..86e5278524 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -20,6 +20,10 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
=20
+#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
+# define glfs_ftruncate(fd, offset, _u1, _u2) glfs_ftruncate(fd, offset)
+#endif
+
 #define GLUSTER_OPT_FILENAME        "filename"
 #define GLUSTER_OPT_VOLUME          "volume"
 #define GLUSTER_OPT_PATH            "path"
@@ -1005,6 +1009,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd =
*fd, int64_t offset,
                                     PreallocMode prealloc, Error **errp)
 {
     int64_t current_length;
+    int ret;
=20
     current_length =3D glfs_lseek(fd, 0, SEEK_END);
     if (current_length < 0) {
@@ -1032,7 +1037,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd =
*fd, int64_t offset,
 #endif /* CONFIG_GLUSTERFS_FALLOCATE */
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     case PREALLOC_MODE_FULL:
-        if (glfs_ftruncate(fd, offset)) {
+        ret =3D glfs_ftruncate(fd, offset, NULL, NULL);
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
@@ -1043,7 +1049,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd =
*fd, int64_t offset,
         break;
 #endif /* CONFIG_GLUSTERFS_ZEROFILL */
     case PREALLOC_MODE_OFF:
-        if (glfs_ftruncate(fd, offset)) {
+        ret =3D glfs_ftruncate(fd, offset, NULL, NULL);
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
diff --git a/configure b/configure
index 540bee19ba..1d09bef1f9 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ glusterfs_xlator_opt=3D"no"
 glusterfs_discard=3D"no"
 glusterfs_fallocate=3D"no"
 glusterfs_zerofill=3D"no"
+glusterfs_legacy_ftruncate=3D"no"
 gtk=3D""
 gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
@@ -4057,6 +4058,19 @@ if test "$glusterfs" !=3D "no" ; then
       glusterfs_fallocate=3D"yes"
       glusterfs_zerofill=3D"yes"
     fi
+    cat > $TMPC << EOF
+#include <glusterfs/api/glfs.h>
+
+int
+main(void)
+{
+	/* new glfs_ftruncate() passes two additional args */
+	return glfs_ftruncate(NULL, 0 /*, NULL, NULL */);
+}
+EOF
+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
+      glusterfs_legacy_ftruncate=3D"yes"
+    fi
   else
     if test "$glusterfs" =3D "yes" ; then
       feature_not_found "GlusterFS backend support" \
@@ -6853,6 +6867,10 @@ if test "$glusterfs_zerofill" =3D "yes" ; then
   echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
 fi
=20
+if test "$glusterfs_legacy_ftruncate" =3D "yes" ; then
+  echo "CONFIG_GLUSTERFS_LEGACY_FTRUNCATE=3Dy" >> $config_host_mak
+fi
+
 if test "$libssh2" =3D "yes" ; then
   echo "CONFIG_LIBSSH2=3Dm" >> $config_host_mak
   echo "LIBSSH2_CFLAGS=3D$libssh2_cflags" >> $config_host_mak
--=20
2.20.1
