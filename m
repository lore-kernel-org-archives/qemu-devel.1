Received: from eggs.gnu.org ([2001:4830:134:3::10]:45029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasanna.kalever@redhat.com>) id 1f6aDK-0002I0-8a
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasanna.kalever@redhat.com>) id 1f6aDG-0002Ov-8b
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:16:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasanna.kalever@redhat.com>)
	id 1f6aDG-0002Me-51
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44F3581A88A3
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:16:21 +0000 (UTC)
From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Date: Thu, 12 Apr 2018 16:46:14 +0530
Message-Id: <20180412111614.9724-1-prasanna.kalever@redhat.com>
Subject: [Qemu-devel] [PATCH] block/gluster: defend on legacy ftruncate api
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ndevos@redhat.com, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
---
 block/gluster.c | 15 +++++++++++++--
 configure       |  8 ++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 4adc1a875b..2474580ad6 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -996,6 +996,7 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
                                     PreallocMode prealloc, Error **errp)
 {
     int64_t current_length;
+    int ret;
 
     current_length = glfs_lseek(fd, 0, SEEK_END);
     if (current_length < 0) {
@@ -1023,7 +1024,12 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
 #endif /* CONFIG_GLUSTERFS_FALLOCATE */
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
     case PREALLOC_MODE_FULL:
-        if (glfs_ftruncate(fd, offset)) {
+#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
+        ret = glfs_ftruncate(fd, offset);
+#else
+        ret = glfs_ftruncate(fd, offset, NULL, NULL);
+#endif
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
@@ -1034,7 +1040,12 @@ static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
         break;
 #endif /* CONFIG_GLUSTERFS_ZEROFILL */
     case PREALLOC_MODE_OFF:
-        if (glfs_ftruncate(fd, offset)) {
+#ifdef CONFIG_GLUSTERFS_LEGACY_FTRUNCATE
+        ret = glfs_ftruncate(fd, offset);
+#else
+        ret = glfs_ftruncate(fd, offset, NULL, NULL);
+#endif
+        if (ret) {
             error_setg_errno(errp, errno, "Could not resize file");
             return -errno;
         }
diff --git a/configure b/configure
index 0a19b033bc..69827b0098 100755
--- a/configure
+++ b/configure
@@ -429,6 +429,7 @@ glusterfs_xlator_opt="no"
 glusterfs_discard="no"
 glusterfs_fallocate="no"
 glusterfs_zerofill="no"
+glusterfs_legacy_ftruncate="no"
 gtk=""
 gtkabi=""
 gtk_gl="no"
@@ -3856,6 +3857,9 @@ if test "$glusterfs" != "no" ; then
       glusterfs_fallocate="yes"
       glusterfs_zerofill="yes"
     fi
+    if ! $pkg_config --atleast-version=7.4 glusterfs-api; then
+      glusterfs_legacy_ftruncate="yes"
+    fi
   else
     if test "$glusterfs" = "yes" ; then
       feature_not_found "GlusterFS backend support" \
@@ -6502,6 +6506,10 @@ if test "$glusterfs_zerofill" = "yes" ; then
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
2.14.3
