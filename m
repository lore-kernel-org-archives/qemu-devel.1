Received: from eggs.gnu.org ([2001:4830:134:3::10]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE7-0007uP-TF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE6-0003zL-Ou
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqE6-0003xz-Ge
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:38 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:18 +0100
Message-Id: <1543851204-41186-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/71] vhost-net: revamp configure logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

Detect all invalid configurations (e.g. mingw32 with vhost-user,
non-Linux with vhost-kernel).  As a collateral benefit, all vhost-kernel
backends can be now disabled if one wants to reduce the attack surface.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 | 89 +++++++++++++++++++++++++++++++----------=
------
 hw/virtio/Makefile.objs   |  4 +--
 hw/virtio/vhost-backend.c |  4 +--
 3 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/configure b/configure
index b3b4464..d2c0fd3 100755
--- a/configure
+++ b/configure
@@ -366,10 +366,10 @@ libattr=3D""
 xfs=3D""
 tcg=3D"yes"
 membarrier=3D""
-vhost_net=3D"no"
-vhost_crypto=3D"no"
-vhost_scsi=3D"no"
-vhost_vsock=3D"no"
+vhost_net=3D""
+vhost_crypto=3D""
+vhost_scsi=3D""
+vhost_vsock=3D""
 vhost_user=3D""
 kvm=3D"no"
 hax=3D"no"
@@ -774,6 +774,7 @@ case $targetos in
 MINGW32*)
   mingw32=3D"yes"
   hax=3D"yes"
+  vhost_user=3D"no"
   audio_possible_drivers=3D"dsound sdl"
   if check_include dsound.h; then
     audio_drv_list=3D"dsound"
@@ -874,10 +875,6 @@ Linux)
   linux=3D"yes"
   linux_user=3D"yes"
   kvm=3D"yes"
-  vhost_net=3D"yes"
-  vhost_crypto=3D"yes"
-  vhost_scsi=3D"yes"
-  vhost_vsock=3D"yes"
   QEMU_INCLUDES=3D"-I\$(SRC_PATH)/linux-headers -I$PWD/linux-headers $QE=
MU_INCLUDES"
   supported_os=3D"yes"
   libudev=3D"yes"
@@ -1258,11 +1255,7 @@ for opt do
   ;;
   --disable-vhost-crypto) vhost_crypto=3D"no"
   ;;
-  --enable-vhost-crypto)
-      vhost_crypto=3D"yes"
-      if test "$mingw32" =3D "yes"; then
-          error_exit "vhost-crypto isn't available on win32"
-      fi
+  --enable-vhost-crypto) vhost_crypto=3D"yes"
   ;;
   --disable-vhost-scsi) vhost_scsi=3D"no"
   ;;
@@ -1463,11 +1456,11 @@ for opt do
   ;;
   --disable-vhost-user) vhost_user=3D"no"
   ;;
-  --enable-vhost-user)
-      vhost_user=3D"yes"
-      if test "$mingw32" =3D "yes"; then
-          error_exit "vhost-user isn't available on win32"
-      fi
+  --enable-vhost-user) vhost_user=3D"yes"
+  ;;
+  --disable-vhost-kernel) vhost_kernel=3D"no"
+  ;;
+  --enable-vhost-kernel) vhost_kernel=3D"yes"
   ;;
   --disable-capstone) capstone=3D"no"
   ;;
@@ -1499,14 +1492,6 @@ for opt do
   esac
 done
=20
-if test "$vhost_user" =3D ""; then
-    if test "$mingw32" =3D "yes"; then
-        vhost_user=3D"no"
-    else
-        vhost_user=3D"yes"
-    fi
-fi
-
 case "$cpu" in
     ppc)
            CPU_CFLAGS=3D"-m32"
@@ -1731,8 +1716,12 @@ disabled with --disable-FEATURE, default is enable=
d if available:
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
@@ -1756,7 +1745,6 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   jemalloc        jemalloc support
   avx2            AVX2 optimization support
   replication     replication support
-  vhost-vsock     virtio sockets device support
   opengl          opengl support
   virglrenderer   virgl rendering support
   xfsctl          xfsctl support
@@ -1773,7 +1761,6 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   parallels       parallels image format support
   sheepdog        sheepdog block driver support
   crypto-afalg    Linux AF_ALG crypto backend driver
-  vhost-user      vhost-user support
   capstone        capstone disassembler support
   debug-mutex     mutex debugging support
   libpmem         libpmem support
@@ -2150,6 +2137,45 @@ else
   l2tpv3=3Dno
 fi
=20
+#########################################
+# vhost interdependencies and host support
+
+# vhost backends
+test "$vhost_user" =3D "" && vhost_user=3Dyes
+if test "$vhost_user" =3D "yes" && test "$mingw32" =3D "yes"; then
+  error_exit "vhost-user isn't available on win32"
+fi
+test "$vhost_kernel" =3D "" && vhost_kernel=3D$linux
+if test "$vhost_kernel" =3D "yes" && test "$linux" !=3D "yes"; then
+  error_exit "vhost-kernel is only available on Linux"
+fi
+
+# vhost-kernel devices
+test "$vhost_scsi" =3D "" && vhost_scsi=3D$vhost_kernel
+if test "$vhost_scsi" =3D "yes" && test "$vhost_kernel" !=3D "yes"; then
+  error_exit "--enable-vhost-scsi requires --enable-vhost-kernel"
+fi
+test "$vhost_vsock" =3D "" && vhost_vsock=3D$vhost_kernel
+if test "$vhost_vsock" =3D "yes" && test "$vhost_kernel" !=3D "yes"; the=
n
+  error_exit "--enable-vhost-vsock requires --enable-vhost-kernel"
+fi
+
+# vhost-user backends
+test "$vhost_net_user" =3D "" && vhost_net_user=3D$vhost_user
+if test "$vhost_net_user" =3D "yes" && test "$vhost_user" =3D "no"; then
+  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
+fi
+test "$vhost_crypto" =3D "" && vhost_crypto=3D$vhost_user
+if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; then
+  error_exit "--enable-vhost-crypto requires --enable-vhost-user"
+fi
+
+# OR the vhost-kernel and vhost-user values for simplicity
+if test "$vhost_net" =3D ""; then
+  test "$vhost_net_user" =3D "yes" && vhost_net=3Dyes
+  test "$vhost_kernel" =3D "yes" && vhost_net=3Dyes
+fi
+
 ##########################################
 # MinGW / Mingw-w64 localtime_r/gmtime_r check
=20
@@ -6524,6 +6550,9 @@ fi
 if test "$vhost_vsock" =3D "yes" ; then
   echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak
 fi
+if test "$vhost_kernel" =3D "yes" ; then
+  echo "CONFIG_VHOST_KERNEL=3Dy" >> $config_host_mak
+fi
 if test "$vhost_user" =3D "yes" ; then
   echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
 fi
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index e8eff80..87402d1 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,8 +11,8 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO=
_PCI)) +=3D virtio-crypto-p
=20
 obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
-obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) +=3D vhost.o vhost-=
backend.o
-common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)))=
 +=3D vhost-stub.o
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost.o=
 vhost-backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KE=
RNEL))) +=3D vhost-stub.o
 endif
=20
 common-obj-$(CONFIG_ALL) +=3D vhost-stub.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index b5d2e30..46d388b 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -13,7 +13,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
=20
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
 #include <linux/vhost.h>
 #include <sys/ioctl.h>
=20
@@ -274,7 +274,7 @@ int vhost_set_backend_type(struct vhost_dev *dev, Vho=
stBackendType backend_type)
     int r =3D 0;
=20
     switch (backend_type) {
-#ifdef CONFIG_LINUX
+#ifdef CONFIG_VHOST_KERNEL
     case VHOST_BACKEND_TYPE_KERNEL:
         dev->vhost_ops =3D &kernel_ops;
         break;
--=20
1.8.3.1
