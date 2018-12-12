Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6NB-0001P7-2A
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N6-0000hL-Fp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:29 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N6-0000XH-5D
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so5559419wml.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:06 +0100
Message-Id: <1544628195-37728-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 45/54] vhost-net: revamp configure logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Detect all invalid configurations (e.g. mingw32 with vhost-user,
non-Linux with vhost-kernel).  As a collateral benefit, all vhost-kernel
backends can be now disabled if one wants to reduce the attack surface.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543851204-41186-6-git-send-email-pbonzini@redhat.com>
---
 configure                 | 89 +++++++++++++++++++++++++++++++----------------
 hw/virtio/Makefile.objs   |  4 +--
 hw/virtio/vhost-backend.c |  4 +--
 3 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/configure b/configure
index b26e4de..b076b43 100755
--- a/configure
+++ b/configure
@@ -366,10 +366,10 @@ libattr=""
 xfs=""
 tcg="yes"
 membarrier=""
-vhost_net="no"
-vhost_crypto="no"
-vhost_scsi="no"
-vhost_vsock="no"
+vhost_net=""
+vhost_crypto=""
+vhost_scsi=""
+vhost_vsock=""
 vhost_user=""
 kvm="no"
 hax="no"
@@ -774,6 +774,7 @@ case $targetos in
 MINGW32*)
   mingw32="yes"
   hax="yes"
+  vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
     audio_drv_list="dsound"
@@ -874,10 +875,6 @@ Linux)
   linux="yes"
   linux_user="yes"
   kvm="yes"
-  vhost_net="yes"
-  vhost_crypto="yes"
-  vhost_scsi="yes"
-  vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
@@ -1255,11 +1252,7 @@ for opt do
   ;;
   --disable-vhost-crypto) vhost_crypto="no"
   ;;
-  --enable-vhost-crypto)
-      vhost_crypto="yes"
-      if test "$mingw32" = "yes"; then
-          error_exit "vhost-crypto isn't available on win32"
-      fi
+  --enable-vhost-crypto) vhost_crypto="yes"
   ;;
   --disable-vhost-scsi) vhost_scsi="no"
   ;;
@@ -1460,11 +1453,11 @@ for opt do
   ;;
   --disable-vhost-user) vhost_user="no"
   ;;
-  --enable-vhost-user)
-      vhost_user="yes"
-      if test "$mingw32" = "yes"; then
-          error_exit "vhost-user isn't available on win32"
-      fi
+  --enable-vhost-user) vhost_user="yes"
+  ;;
+  --disable-vhost-kernel) vhost_kernel="no"
+  ;;
+  --enable-vhost-kernel) vhost_kernel="yes"
   ;;
   --disable-capstone) capstone="no"
   ;;
@@ -1496,14 +1489,6 @@ for opt do
   esac
 done
 
-if test "$vhost_user" = ""; then
-    if test "$mingw32" = "yes"; then
-        vhost_user="no"
-    else
-        vhost_user="yes"
-    fi
-fi
-
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
@@ -1728,8 +1713,12 @@ disabled with --disable-FEATURE, default is enabled if available:
   linux-aio       Linux AIO support
   cap-ng          libcap-ng support
   attr            attr and xattr support
-  vhost-net       vhost-net acceleration support
-  vhost-crypto    vhost-crypto acceleration support
+  vhost-net       vhost-net kernel acceleration support
+  vhost-vsock     virtio sockets device support
+  vhost-scsi      vhost-scsi kernel target support
+  vhost-crypto    vhost-user-crypto backend support
+  vhost-kernel    vhost kernel backend support
+  vhost-user      vhost-user backend support
   spice           spice
   rbd             rados block device (rbd)
   libiscsi        iscsi support
@@ -1753,7 +1742,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   jemalloc        jemalloc support
   avx2            AVX2 optimization support
   replication     replication support
-  vhost-vsock     virtio sockets device support
   opengl          opengl support
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
@@ -1770,7 +1758,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   parallels       parallels image format support
   sheepdog        sheepdog block driver support
   crypto-afalg    Linux AF_ALG crypto backend driver
-  vhost-user      vhost-user support
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
@@ -2157,6 +2144,45 @@ else
   l2tpv3=no
 fi
 
+#########################################
+# vhost interdependencies and host support
+
+# vhost backends
+test "$vhost_user" = "" && vhost_user=yes
+if test "$vhost_user" = "yes" && test "$mingw32" = "yes"; then
+  error_exit "vhost-user isn't available on win32"
+fi
+test "$vhost_kernel" = "" && vhost_kernel=$linux
+if test "$vhost_kernel" = "yes" && test "$linux" != "yes"; then
+  error_exit "vhost-kernel is only available on Linux"
+fi
+
+# vhost-kernel devices
+test "$vhost_scsi" = "" && vhost_scsi=$vhost_kernel
+if test "$vhost_scsi" = "yes" && test "$vhost_kernel" != "yes"; then
+  error_exit "--enable-vhost-scsi requires --enable-vhost-kernel"
+fi
+test "$vhost_vsock" = "" && vhost_vsock=$vhost_kernel
+if test "$vhost_vsock" = "yes" && test "$vhost_kernel" != "yes"; then
+  error_exit "--enable-vhost-vsock requires --enable-vhost-kernel"
+fi
+
+# vhost-user backends
+test "$vhost_net_user" = "" && vhost_net_user=$vhost_user
+if test "$vhost_net_user" = "yes" && test "$vhost_user" = "no"; then
+  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
+fi
+test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
+if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
+  error_exit "--enable-vhost-crypto requires --enable-vhost-user"
+fi
+
+# OR the vhost-kernel and vhost-user values for simplicity
+if test "$vhost_net" = ""; then
+  test "$vhost_net_user" = "yes" && vhost_net=yes
+  test "$vhost_kernel" = "yes" && vhost_net=yes
+fi
+
 ##########################################
 # MinGW / Mingw-w64 localtime_r/gmtime_r check
 
@@ -6526,6 +6552,9 @@ fi
 if test "$vhost_vsock" = "yes" ; then
   echo "CONFIG_VHOST_VSOCK=y" >> $config_host_mak
 fi
+if test "$vhost_kernel" = "yes" ; then
+  echo "CONFIG_VHOST_KERNEL=y" >> $config_host_mak
+fi
 if test "$vhost_user" = "yes" ; then
   echo "CONFIG_VHOST_USER=y" >> $config_host_mak
 fi
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index e8eff80..87402d1 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,8 +11,8 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
 
 obj-$(CONFIG_VHOST_USER) += vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
-obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))) += vhost-stub.o
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) += vhost.o vhost-backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL))) += vhost-stub.o
 endif
 
 common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index b5d2e30..46d388b 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -13,7 +13,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
 
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 
@@ -274,7 +274,7 @@ int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
     int r = 0;
 
     switch (backend_type) {
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
     case VHOST_BACKEND_TYPE_KERNEL:
         dev->vhost_ops = &kernel_ops;
         break;
-- 
1.8.3.1
