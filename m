Received: from eggs.gnu.org ([209.51.188.92]:47539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qTm-0001BP-7a
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h0qTk-0001eu-7w
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:30:14 -0500
From: Niels de Vos <ndevos@redhat.com>
Date: Mon,  4 Mar 2019 17:21:03 +0100
Message-Id: <20190304162103.18912-3-ndevos@redhat.com>
In-Reply-To: <20190304162103.18912-1-ndevos@redhat.com>
References: <20190304162103.18912-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] gluster: the glfs_io_cbk callback function
 pointer adds pre/post stat args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, integration@gluster.org, qemu-devel@nongnu.org, Niels de Vos <ndevos@redhat.com>

The glfs_*_async() functions do a callback once finished. This callback
has changed its arguments, pre- and post-stat structures have been
added. This makes it possible to improve cashing, which is useful for
Samba and NFS-Ganesha, but not so much for QEMU. Gluster 6 is the first
release that includes these new arguments.

With an additional detection in ./configure, the new arguments can
conditionally get included in the glfs_io_cbk handler.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 block/gluster.c |  6 +++++-
 configure       | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/block/gluster.c b/block/gluster.c
index 86e5278524..7483c3b2aa 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -729,7 +729,11 @@ static struct glfs *qemu_gluster_init(BlockdevOption=
sGluster *gconf,
 /*
  * AIO callback routine called from GlusterFS thread.
  */
-static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret, void *=
arg)
+static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret,
+#ifdef CONFIG_GLUSTERFS_IOCB_HAS_STAT
+                                 struct glfs_stat *pre, struct glfs_stat=
 *post,
+#endif
+                                 void *arg)
 {
     GlusterAIOCB *acb =3D (GlusterAIOCB *)arg;
=20
diff --git a/configure b/configure
index 1d09bef1f9..d8ae8c2f50 100755
--- a/configure
+++ b/configure
@@ -457,6 +457,7 @@ glusterfs_discard=3D"no"
 glusterfs_fallocate=3D"no"
 glusterfs_zerofill=3D"no"
 glusterfs_legacy_ftruncate=3D"no"
+glusterfs_iocb_has_stat=3D"no"
 gtk=3D""
 gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
@@ -4071,6 +4072,25 @@ EOF
     if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
       glusterfs_legacy_ftruncate=3D"yes"
     fi
+    cat > $TMPC << EOF
+#include <glusterfs/api/glfs.h>
+
+/* new glfs_io_cbk() passes two additional glfs_stat structs */
+static void
+glusterfs_iocb(glfs_fd_t *fd, ssize_t ret, struct glfs_stat *prestat, st=
ruct glfs_stat *poststat, void *data)
+{}
+
+int
+main(void)
+{
+	glfs_io_cbk iocb =3D &glusterfs_iocb;
+	iocb(NULL, 0 , NULL, NULL, NULL);
+	return 0;
+}
+EOF
+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
+      glusterfs_iocb_has_stat=3D"yes"
+    fi
   else
     if test "$glusterfs" =3D "yes" ; then
       feature_not_found "GlusterFS backend support" \
@@ -6871,6 +6891,10 @@ if test "$glusterfs_legacy_ftruncate" =3D "yes" ; =
then
   echo "CONFIG_GLUSTERFS_LEGACY_FTRUNCATE=3Dy" >> $config_host_mak
 fi
=20
+if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
+  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
+fi
+
 if test "$libssh2" =3D "yes" ; then
   echo "CONFIG_LIBSSH2=3Dm" >> $config_host_mak
   echo "LIBSSH2_CFLAGS=3D$libssh2_cflags" >> $config_host_mak
--=20
2.20.1
