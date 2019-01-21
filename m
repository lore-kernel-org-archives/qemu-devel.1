Received: from eggs.gnu.org ([209.51.188.92]:51508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-0004GK-Hh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldxz-00040d-Dk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxw-0003x5-PV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so11712220wmc.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:38 +0100
Message-Id: <1548093980-43088-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/49] vhost-net: revamp configure logic
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
index fca5861..868614e 100755
--- a/configure
+++ b/configure
@@ -365,10 +365,10 @@ libattr=""
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
@@ -780,6 +780,7 @@ case $targetos in
 MINGW32*)
   mingw32="yes"
   hax="yes"
+  vhost_user="no"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
     audio_drv_list="dsound"
@@ -880,10 +881,6 @@ Linux)
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
@@ -1257,11 +1254,7 @@ for opt do
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
@@ -1466,11 +1459,11 @@ for opt do
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
@@ -1502,14 +1495,6 @@ for opt do
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
@@ -1732,8 +1717,12 @@ disabled with --disable-FEATURE, default is enabled if available:
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
@@ -1759,7 +1748,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   jemalloc        jemalloc support
   avx2            AVX2 optimization support
   replication     replication support
-  vhost-vsock     virtio sockets device support
   opengl          opengl support
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
@@ -1776,7 +1764,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   parallels       parallels image format support
   sheepdog        sheepdog block driver support
   crypto-afalg    Linux AF_ALG crypto backend driver
-  vhost-user      vhost-user support
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
@@ -2167,6 +2154,45 @@ else
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
 
@@ -6566,6 +6592,9 @@ fi
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
index d8685a1..3d6cb92 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,8 +2,8 @@ ifeq ($(CONFIG_VIRTIO),y)
 common-obj-y += virtio-bus.o
 obj-y += virtio.o
 
-obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += vhost.o vhost-backend.o
-common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))) += vhost-stub.o
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) += vhost.o vhost-backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL))) += vhost-stub.o
 obj-$(CONFIG_VHOST_USER) += vhost-user.o
 
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index e0f0bb7..96b8d3c 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "standard-headers/linux/vhost_types.h"
 
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
 
@@ -275,7 +275,7 @@ int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
     int r = 0;
 
     switch (backend_type) {
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
     case VHOST_BACKEND_TYPE_KERNEL:
         dev->vhost_ops = &kernel_ops;
         break;
-- 
1.8.3.1
