Received: from eggs.gnu.org ([2001:4830:134:3::10]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfr-0000mr-7G
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfp-0007Jc-SG
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:58 +0100
Message-Id: <20181112170603.23986-10-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] block: Make more block drivers
 compile-time configurable
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

From: Jeff Cody <jcody@redhat.com>

This adds configure options to control the following block drivers:

* Bochs
* Cloop
* Dmg
* Qcow (V1)
* Vdi
* Vvfat
* qed
* parallels
* sheepdog

Each of these defaults to being enabled.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20181107063644.2254-1-armbru@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 configure           | 91 +++++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs | 22 ++++++++---
 2 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 74e313a810..5b1d83ea26 100755
--- a/configure
+++ b/configure
@@ -470,6 +470,15 @@ tcmalloc=3D"no"
 jemalloc=3D"no"
 replication=3D"yes"
 vxhs=3D""
+bochs=3D"yes"
+cloop=3D"yes"
+dmg=3D"yes"
+qcow1=3D"yes"
+vdi=3D"yes"
+vvfat=3D"yes"
+qed=3D"yes"
+parallels=3D"yes"
+sheepdog=3D"yes"
 libxml2=3D""
 docker=3D"no"
 debug_mutex=3D"no"
@@ -1416,6 +1425,42 @@ for opt do
   ;;
   --enable-vxhs) vxhs=3D"yes"
   ;;
+  --disable-bochs) bochs=3D"no"
+  ;;
+  --enable-bochs) bochs=3D"yes"
+  ;;
+  --disable-cloop) cloop=3D"no"
+  ;;
+  --enable-cloop) cloop=3D"yes"
+  ;;
+  --disable-dmg) dmg=3D"no"
+  ;;
+  --enable-dmg) dmg=3D"yes"
+  ;;
+  --disable-qcow1) qcow1=3D"no"
+  ;;
+  --enable-qcow1) qcow1=3D"yes"
+  ;;
+  --disable-vdi) vdi=3D"no"
+  ;;
+  --enable-vdi) vdi=3D"yes"
+  ;;
+  --disable-vvfat) vvfat=3D"no"
+  ;;
+  --enable-vvfat) vvfat=3D"yes"
+  ;;
+  --disable-qed) qed=3D"no"
+  ;;
+  --enable-qed) qed=3D"yes"
+  ;;
+  --disable-parallels) parallels=3D"no"
+  ;;
+  --enable-parallels) parallels=3D"yes"
+  ;;
+  --disable-sheepdog) sheepdog=3D"no"
+  ;;
+  --enable-sheepdog) sheepdog=3D"yes"
+  ;;
   --disable-vhost-user) vhost_user=3D"no"
   ;;
   --enable-vhost-user)
@@ -1718,6 +1763,15 @@ disabled with --disable-FEATURE, default is enable=
d if available:
   qom-cast-debug  cast debugging support
   tools           build qemu-io, qemu-nbd and qemu-image tools
   vxhs            Veritas HyperScale vDisk backend support
+  bochs           bochs image format support
+  cloop           cloop image format support
+  dmg             dmg image format support
+  qcow1           qcow v1 image format support
+  vdi             vdi image format support
+  vvfat           vvfat image format support
+  qed             qed image format support
+  parallels       parallels image format support
+  sheepdog        sheepdog block driver support
   crypto-afalg    Linux AF_ALG crypto backend driver
   vhost-user      vhost-user support
   capstone        capstone disassembler support
@@ -6043,6 +6097,15 @@ echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
+echo "bochs support     $bochs"
+echo "cloop support     $cloop"
+echo "dmg support       $dmg"
+echo "qcow v1 support   $qcow1"
+echo "vdi support       $vdi"
+echo "vvfat support     $vvfat"
+echo "qed support       $qed"
+echo "parallels support $parallels"
+echo "sheepdog support  $sheepdog"
 echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
@@ -6799,6 +6862,34 @@ if test "$libpmem" =3D "yes" ; then
   echo "CONFIG_LIBPMEM=3Dy" >> $config_host_mak
 fi
=20
+if test "$bochs" =3D "yes" ; then
+  echo "CONFIG_BOCHS=3Dy" >> $config_host_mak
+fi
+if test "$cloop" =3D "yes" ; then
+  echo "CONFIG_CLOOP=3Dy" >> $config_host_mak
+fi
+if test "$dmg" =3D "yes" ; then
+  echo "CONFIG_DMG=3Dy" >> $config_host_mak
+fi
+if test "$qcow1" =3D "yes" ; then
+  echo "CONFIG_QCOW1=3Dy" >> $config_host_mak
+fi
+if test "$vdi" =3D "yes" ; then
+  echo "CONFIG_VDI=3Dy" >> $config_host_mak
+fi
+if test "$vvfat" =3D "yes" ; then
+  echo "CONFIG_VVFAT=3Dy" >> $config_host_mak
+fi
+if test "$qed" =3D "yes" ; then
+  echo "CONFIG_QED=3Dy" >> $config_host_mak
+fi
+if test "$parallels" =3D "yes" ; then
+  echo "CONFIG_PARALLELS=3Dy" >> $config_host_mak
+fi
+if test "$sheepdog" =3D "yes" ; then
+  echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" =3D "yes"; then
   QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" =3D "sparc64" ; then
diff --git a/block/Makefile.objs b/block/Makefile.objs
index c8337bf186..46d585cfd0 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,10 +1,18 @@
-block-obj-y +=3D raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o =
vvfat.o dmg.o
+block-obj-y +=3D raw-format.o vmdk.o vpc.o
+block-obj-$(CONFIG_QCOW1) +=3D qcow.o
+block-obj-$(CONFIG_VDI) +=3D vdi.o
+block-obj-$(CONFIG_CLOOP) +=3D cloop.o
+block-obj-$(CONFIG_BOCHS) +=3D bochs.o
+block-obj-$(CONFIG_VVFAT) +=3D vvfat.o
+block-obj-$(CONFIG_DMG) +=3D dmg.o
+
 block-obj-y +=3D qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot=
.o qcow2-cache.o qcow2-bitmap.o
-block-obj-y +=3D qed.o qed-l2-cache.o qed-table.o qed-cluster.o
-block-obj-y +=3D qed-check.o
+block-obj-$(CONFIG_QED) +=3D qed.o qed-l2-cache.o qed-table.o qed-cluste=
r.o
+block-obj-$(CONFIG_QED) +=3D qed-check.o
 block-obj-y +=3D vhdx.o vhdx-endian.o vhdx-log.o
 block-obj-y +=3D quorum.o
-block-obj-y +=3D parallels.o blkdebug.o blkverify.o blkreplay.o
+block-obj-y +=3D blkdebug.o blkverify.o blkreplay.o
+block-obj-$(CONFIG_PARALLELS) +=3D parallels.o
 block-obj-y +=3D blklogwrites.o
 block-obj-y +=3D block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) +=3D file-win32.o win32-aio.o
@@ -14,7 +22,8 @@ block-obj-y +=3D null.o mirror.o commit.o io.o create.o
 block-obj-y +=3D throttle-groups.o
 block-obj-$(CONFIG_LINUX) +=3D nvme.o
=20
-block-obj-y +=3D nbd.o nbd-client.o sheepdog.o
+block-obj-y +=3D nbd.o nbd-client.o
+block-obj-$(CONFIG_SHEEPDOG) +=3D sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) +=3D iscsi.o
 block-obj-$(if $(CONFIG_LIBISCSI),y,n) +=3D iscsi-opts.o
 block-obj-$(CONFIG_LIBNFS) +=3D nfs.o
@@ -45,7 +54,8 @@ gluster.o-libs     :=3D $(GLUSTERFS_LIBS)
 vxhs.o-libs        :=3D $(VXHS_LIBS)
 ssh.o-cflags       :=3D $(LIBSSH2_CFLAGS)
 ssh.o-libs         :=3D $(LIBSSH2_LIBS)
-block-obj-$(if $(CONFIG_BZIP2),m,n) +=3D dmg-bz2.o
+block-obj-dmg-bz2-$(CONFIG_BZIP2) +=3D dmg-bz2.o
+block-obj-$(if $(CONFIG_DMG),m,n) +=3D $(block-obj-dmg-bz2-y)
 dmg-bz2.o-libs     :=3D $(BZIP2_LIBS)
 qcow.o-libs        :=3D -lz
 linux-aio.o-libs   :=3D -laio
--=20
2.19.1
