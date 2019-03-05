Received: from eggs.gnu.org ([209.51.188.92]:38897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1CHO-0003oc-5l
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1h1CHN-000067-9O
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:46:54 -0500
From: Niels de Vos <ndevos@redhat.com>
Date: Tue,  5 Mar 2019 16:46:33 +0100
Message-Id: <20190305154634.4609-2-ndevos@redhat.com>
In-Reply-To: <20190305154634.4609-1-ndevos@redhat.com>
References: <20190305154634.4609-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/2] block/gluster: Handle changed
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

--
v5: pass default NULL arguments through macro (Daniel P. Berrang=C3=A9)
v4: rebase to current master branch
v3: define old backwards compatible glfs_ftruncate() macro, from Eric Bla=
ke
v2: do a compile check as suggested by Eric Blake
---
 block/gluster.c |  4 ++++
 configure       | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/block/gluster.c b/block/gluster.c
index af64330211..f853aa87f4 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -20,6 +20,10 @@
 #include "qemu/option.h"
 #include "qemu/cutils.h"
=20
+#ifdef CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT
+# define glfs_ftruncate(fd, offset) glfs_ftruncate(fd, offset, NULL, NUL=
L)
+#endif
+
 #define GLUSTER_OPT_FILENAME        "filename"
 #define GLUSTER_OPT_VOLUME          "volume"
 #define GLUSTER_OPT_PATH            "path"
diff --git a/configure b/configure
index cefeb8fcce..bbfe587b88 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ glusterfs_xlator_opt=3D"no"
 glusterfs_discard=3D"no"
 glusterfs_fallocate=3D"no"
 glusterfs_zerofill=3D"no"
+glusterfs_ftruncate_has_stat=3D"no"
 gtk=3D""
 gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
@@ -4083,6 +4084,19 @@ if test "$glusterfs" !=3D "no" ; then
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
+	return glfs_ftruncate(NULL, 0, NULL, NULL);
+}
+EOF
+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
+      glusterfs_ftruncate_has_stat=3D"yes"
+    fi
   else
     if test "$glusterfs" =3D "yes" ; then
       feature_not_found "GlusterFS backend support" \
@@ -6885,6 +6899,10 @@ if test "$glusterfs_zerofill" =3D "yes" ; then
   echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
 fi
=20
+if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
+  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
+fi
+
 if test "$libssh2" =3D "yes" ; then
   echo "CONFIG_LIBSSH2=3Dm" >> $config_host_mak
   echo "LIBSSH2_CFLAGS=3D$libssh2_cflags" >> $config_host_mak
--=20
2.20.1
