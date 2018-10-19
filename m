Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDT33-0007IL-SV
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDT32-0006mv-Ql
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:34:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 19 Oct 2018 13:34:24 +0200
Message-Id: <20181019113424.25727-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Make more block drivers compile-time
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jeff@codyprime.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

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
---

Hmm, we got quite a few --enable-BLOCK-DRIVER now.  Perhaps a single
list-valued option similar --target-list would be better.  Could be
done on top.

 block/Makefile.objs | 22 ++++++++---
 configure           | 91 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/block/Makefile.objs b/block/Makefile.objs
index c8337bf186..1cad9fc4f1 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -1,10 +1,18 @@
-block-obj-y += raw-format.o qcow.o vdi.o vmdk.o cloop.o bochs.o vpc.o vvfat.o dmg.o
+block-obj-y += raw-format.o vmdk.o vpc.o
+block-obj-$(CONFIG_QCOW1) += qcow.o
+block-obj-$(CONFIG_VDI) += vdi.o
+block-obj-$(CONFIG_CLOOP) += cloop.o
+block-obj-$(CONFIG_BOCHS) += bochs.o
+block-obj-$(CONFIG_VVFAT) += vvfat.o
+block-obj-$(CONFIG_DMG) += dmg.o
+
 block-obj-y += qcow2.o qcow2-refcount.o qcow2-cluster.o qcow2-snapshot.o qcow2-cache.o qcow2-bitmap.o
-block-obj-y += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
-block-obj-y += qed-check.o
+block-obj-$(CONFIG_QED) += qed.o qed-l2-cache.o qed-table.o qed-cluster.o
+block-obj-$(CONFIG_QED) += qed-check.o
 block-obj-y += vhdx.o vhdx-endian.o vhdx-log.o
 block-obj-y += quorum.o
-block-obj-y += parallels.o blkdebug.o blkverify.o blkreplay.o
+block-obj-y += blkdebug.o blkverify.o blkreplay.o
+block-obj-$(CONFIG_PARALLELS) += parallels.o
 block-obj-y += blklogwrites.o
 block-obj-y += block-backend.o snapshot.o qapi.o
 block-obj-$(CONFIG_WIN32) += file-win32.o win32-aio.o
@@ -14,7 +22,8 @@ block-obj-y += null.o mirror.o commit.o io.o create.o
 block-obj-y += throttle-groups.o
 block-obj-$(CONFIG_LINUX) += nvme.o
 
-block-obj-y += nbd.o nbd-client.o sheepdog.o
+block-obj-y += nbd.o nbd-client.o
+block-obj-$(CONFIG_SHEEPDOG) += sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) += iscsi.o
 block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
 block-obj-$(CONFIG_LIBNFS) += nfs.o
@@ -45,7 +54,8 @@ gluster.o-libs     := $(GLUSTERFS_LIBS)
 vxhs.o-libs        := $(VXHS_LIBS)
 ssh.o-cflags       := $(LIBSSH2_CFLAGS)
 ssh.o-libs         := $(LIBSSH2_LIBS)
-block-obj-$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
+block-obj-dmg-bz2$(if $(CONFIG_BZIP2),m,n) += dmg-bz2.o
+block-obj-$(CONFIG_DMG) += $(block-obj-dmg-bz2-y)
 dmg-bz2.o-libs     := $(BZIP2_LIBS)
 qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
diff --git a/configure b/configure
index 9138af37f8..c413186c67 100755
--- a/configure
+++ b/configure
@@ -473,6 +473,15 @@ tcmalloc="no"
 jemalloc="no"
 replication="yes"
 vxhs=""
+bochs="yes"
+cloop="yes"
+dmg="yes"
+qcow1="yes"
+vdi="yes"
+vvfat="yes"
+qed="yes"
+parallels="yes"
+sheepdog="yes"
 libxml2=""
 docker="no"
 debug_mutex="no"
@@ -1413,6 +1422,42 @@ for opt do
   ;;
   --enable-vxhs) vxhs="yes"
   ;;
+  --disable-bochs) bochs="no"
+  ;;
+  --enable-bochs) bochs="yes"
+  ;;
+  --disable-cloop) cloop="no"
+  ;;
+  --enable-cloop) cloop="yes"
+  ;;
+  --disable-dmg) dmg="no"
+  ;;
+  --enable-dmg) dmg="yes"
+  ;;
+  --disable-qcow1) qcow1="no"
+  ;;
+  --enable-qcow1) qcow1="yes"
+  ;;
+  --disable-vdi) vdi="no"
+  ;;
+  --enable-vdi) vdi="yes"
+  ;;
+  --disable-vvfat) vvfat="no"
+  ;;
+  --enable-vvfat) vvfat="yes"
+  ;;
+  --disable-qed) qed="no"
+  ;;
+  --enable-qed) qed="yes"
+  ;;
+  --disable-parallels) parallels="no"
+  ;;
+  --enable-parallels) parallels="yes"
+  ;;
+  --disable-sheepdog) sheepdog="no"
+  ;;
+  --enable-sheepdog) sheepdog="yes"
+  ;;
   --disable-vhost-user) vhost_user="no"
   ;;
   --enable-vhost-user)
@@ -1714,6 +1759,15 @@ disabled with --disable-FEATURE, default is enabled if available:
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
@@ -6067,6 +6121,15 @@ echo "jemalloc support  $jemalloc"
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
@@ -6824,6 +6887,34 @@ if test "$libpmem" = "yes" ; then
   echo "CONFIG_LIBPMEM=y" >> $config_host_mak
 fi
 
+if test "$bochs" = "yes" ; then
+  echo "CONFIG_BOCHS=y" >> $config_host_mak
+fi
+if test "$cloop" = "yes" ; then
+  echo "CONFIG_CLOOP=y" >> $config_host_mak
+fi
+if test "$dmg" = "yes" ; then
+  echo "CONFIG_DMG=y" >> $config_host_mak
+fi
+if test "$qcow1" = "yes" ; then
+  echo "CONFIG_QCOW1=y" >> $config_host_mak
+fi
+if test "$vdi" = "yes" ; then
+  echo "CONFIG_VDI=y" >> $config_host_mak
+fi
+if test "$vvfat" = "yes" ; then
+  echo "CONFIG_VVFAT=y" >> $config_host_mak
+fi
+if test "$qed" = "yes" ; then
+  echo "CONFIG_QED=y" >> $config_host_mak
+fi
+if test "$parallels" = "yes" ; then
+  echo "CONFIG_PARALLELS=y" >> $config_host_mak
+fi
+if test "$sheepdog" = "yes" ; then
+  echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.17.2
