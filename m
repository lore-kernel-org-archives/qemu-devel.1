Received: from eggs.gnu.org ([2001:4830:134:3::10]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YR-0002L4-O0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4YP-0000qa-MM
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:27:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:26:56 +0100
Message-Id: <20181212132735.16080-3-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/41] configure: adding support to lzfse
 library.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Julio Faracco <jcfaracco@gmail.com>

This commit includes the support to lzfse opensource library. With this
library dmg block driver can decompress images with this type of
compression inside.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 configure           | 31 +++++++++++++++++++++++++++++++
 block/Makefile.objs |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/configure b/configure
index 0a3c6a72c3..f32d4fa925 100755
--- a/configure
+++ b/configure
@@ -434,6 +434,7 @@ capstone=3D""
 lzo=3D""
 snappy=3D""
 bzip2=3D""
+lzfse=3D""
 guest_agent=3D""
 guest_agent_with_vss=3D"no"
 guest_agent_ntddscsi=3D"no"
@@ -1310,6 +1311,10 @@ for opt do
   ;;
   --enable-bzip2) bzip2=3D"yes"
   ;;
+  --enable-lzfse) lzfse=3D"yes"
+  ;;
+  --disable-lzfse) lzfse=3D"no"
+  ;;
   --enable-guest-agent) guest_agent=3D"yes"
   ;;
   --disable-guest-agent) guest_agent=3D"no"
@@ -1745,6 +1750,8 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   snappy          support of snappy compression library
   bzip2           support of bzip2 compression library
                   (for reading bzip2-compressed dmg images)
+  lzfse           support of lzfse compression library
+                  (for reading lzfse-compressed dmg images)
   seccomp         seccomp support
   coroutine-pool  coroutine freelist (better performance)
   glusterfs       GlusterFS backend
@@ -2263,6 +2270,24 @@ EOF
     fi
 fi
=20
+##########################################
+# lzfse check
+
+if test "$lzfse" !=3D "no" ; then
+    cat > $TMPC << EOF
+#include <lzfse.h>
+int main(void) { lzfse_decode_scratch_size(); return 0; }
+EOF
+    if compile_prog "" "-llzfse" ; then
+        lzfse=3D"yes"
+    else
+        if test "$lzfse" =3D "yes"; then
+            feature_not_found "lzfse" "Install lzfse devel"
+        fi
+        lzfse=3D"no"
+    fi
+fi
+
 ##########################################
 # libseccomp check
=20
@@ -6090,6 +6115,7 @@ echo "Live block migration $live_block_migration"
 echo "lzo support       $lzo"
 echo "snappy support    $snappy"
 echo "bzip2 support     $bzip2"
+echo "lzfse support     $lzfse"
 echo "NUMA host support $numa"
 echo "libxml2           $libxml2"
 echo "tcmalloc support  $tcmalloc"
@@ -6612,6 +6638,11 @@ if test "$bzip2" =3D "yes" ; then
   echo "BZIP2_LIBS=3D-lbz2" >> $config_host_mak
 fi
=20
+if test "$lzfse" =3D "yes" ; then
+  echo "CONFIG_LZFSE=3Dy" >> $config_host_mak
+  echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
+fi
+
 if test "$libiscsi" =3D "yes" ; then
   echo "CONFIG_LIBISCSI=3Dm" >> $config_host_mak
   echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 46d585cfd0..7a81892a52 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -57,6 +57,8 @@ ssh.o-libs         :=3D $(LIBSSH2_LIBS)
 block-obj-dmg-bz2-$(CONFIG_BZIP2) +=3D dmg-bz2.o
 block-obj-$(if $(CONFIG_DMG),m,n) +=3D $(block-obj-dmg-bz2-y)
 dmg-bz2.o-libs     :=3D $(BZIP2_LIBS)
+block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
+dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
 qcow.o-libs        :=3D -lz
 linux-aio.o-libs   :=3D -laio
 parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
--=20
2.19.2
