Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1fixyZ-0007Ea-Bw
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1fixyY-0003pr-3n
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:19:51 -0400
From: Niels de Vos <ndevos@redhat.com>
Date: Fri, 27 Jul 2018 10:19:39 +0200
Message-Id: <20180727081939.28185-1-ndevos@redhat.com>
Subject: [Qemu-devel] [PATCH v3] block/gluster: Handle changed
 glfs_ftruncate signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Niels de Vos <ndevos@redhat.com>, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

New versions of Glusters libgfapi.so have an updated glfs_ftruncate()
function that returns additional 'struct stat' structures to enable
advanced caching of attributes. This is useful for file servers, not so
much for QEMU. Nevertheless, the API has changed and needs to be
adopted.

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Signed-off-by: Niels de Vos <ndevos@redhat.com>

---
v2: do a compile check as suggested by Eric Blake
v3: define old backwards compatible glfs_ftruncate() macro, from Eric Blake
---
 block/gluster.c | 11 +++++++++--
 configure       | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 4fd55a9cc5..9bd6525b41 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -20,6 +20,10 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 
+#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
+# define glfs_ftruncate(fd, offset, _u1, _u2) glfs_ftruncate(fd, offset)
+#endif
+
 #define GLUSTER_OPT_FILENAME        "filename"
 #define GLUSTER_OPT_VOLUME          "volume"
 #define GLUSTER_OPT_PATH            "path"
@@ -997,6 +1001,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
                                     PreallocMode prealloc, Error **errp)
 {
     int64_t current_length;
+    int ret;
 
     current_length = glfs_lseek(fd, 0, SEEK_END);
     if (current_length < 0) {
@@ -1024,7 +1029,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
 #endif /* CONFIG_GLUSTERFS_FALLOCATE */
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     case PREALLOC_MODE_FULL:
-        if (glfs_ftruncate(fd, offset)) {
+        ret = glfs_ftruncate(fd, offset, NULL, NULL);
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
@@ -1035,7 +1041,8 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
         break;
 #endif /* CONFIG_GLUSTERFS_ZEROFILL */
     case PREALLOC_MODE_OFF:
-        if (glfs_ftruncate(fd, offset)) {
+        ret = glfs_ftruncate(fd, offset, NULL, NULL);
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
diff --git a/configure b/configure
index 2a7796ea80..f3c0918d6b 100755
--- a/configure
+++ b/configure
@@ -451,6 +451,7 @@ glusterfs_xlator_opt="no"
 glusterfs_discard="no"
 glusterfs_fallocate="no"
 glusterfs_zerofill="no"
+glusterfs_legacy_ftruncate="no"
 gtk=""
 gtkabi=""
 gtk_gl="no"
@@ -3947,6 +3948,19 @@ if test "$glusterfs" != "no" ; then
       glusterfs_fallocate="yes"
       glusterfs_zerofill="yes"
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
+      glusterfs_legacy_ftruncate="yes"
+    fi
   else
     if test "$glusterfs" = "yes" ; then
       feature_not_found "GlusterFS backend support" \
@@ -6644,6 +6658,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
   echo "CONFIG_GLUSTERFS_ZEROFILL=y" >> $config_host_mak
 fi
 
+if test "$glusterfs_legacy_ftruncate" = "yes" ; then
+  echo "CONFIG_GLUSTERFS_LEGACY_FTRUNCATE=y" >> $config_host_mak
+fi
+
 if test "$libssh2" = "yes" ; then
   echo "CONFIG_LIBSSH2=m" >> $config_host_mak
   echo "LIBSSH2_CFLAGS=$libssh2_cflags" >> $config_host_mak
-- 
2.17.1
