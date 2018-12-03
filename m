Received: from eggs.gnu.org ([2001:4830:134:3::10]:51508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE4-0007q6-3I
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE3-0003uJ-08
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqE2-0003tB-Lu
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:34 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:16 +0100
Message-Id: <1543851204-41186-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/71] vhost: restrict Linux dependency to
 kernel vhost
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

vhost-user does not depend on Linux; it can run on any POSIX system.  Res=
trict
vhost-kernel to Linux in hw/virtio/vhost-backend.c, everything else can b=
e
compiled on all POSIX systems.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/Makefile.objs     |  5 ++---
 default-configs/virtio.mak |  4 ++--
 hw/net/vhost_net.c         |  2 +-
 hw/virtio/Makefile.objs    |  5 +++--
 hw/virtio/vhost-backend.c  | 11 +++++++++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 717fcbd..ff619d3 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -9,10 +9,9 @@ common-obj-$(CONFIG_POSIX) +=3D hostmem-file.o
 common-obj-y +=3D cryptodev.o
 common-obj-y +=3D cryptodev-builtin.o
=20
-ifeq ($(CONFIG_VIRTIO),y)
+ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
 common-obj-y +=3D cryptodev-vhost.o
-common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) +=3D \
-    cryptodev-vhost-user.o
+common-obj-$(CONFIG_VHOST_CRYPTO) +=3D cryptodev-vhost-user.o
 endif
=20
 common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 1304849..340050a 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,5 @@
-CONFIG_VHOST_USER_SCSI=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX=
))
-CONFIG_VHOST_USER_BLK=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)=
)
+CONFIG_VHOST_USER_SCSI=3D$(CONFIG_VHOST_USER)
+CONFIG_VHOST_USER_BLK=3D$(CONFIG_VHOST_USER)
 CONFIG_VIRTIO=3Dy
 CONFIG_VIRTIO_9P=3Dy
 CONFIG_VIRTIO_BALLOON=3Dy
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fe6202a..2a300ee 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -193,7 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *opt=
ions)
     }
=20
     /* Set sane init value. Override when guest acks. */
-#ifdef CONFIG_VHOST_USER
+#ifdef CONFIG_VHOST_NET_USER
     if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_USER) {
         features =3D vhost_user_get_acked_features(net->nc);
         if (~net->dev.features & features) {
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 1b2799c..e8eff80 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -9,9 +9,10 @@ obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D virti=
o-crypto-pci.o
=20
-obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
+obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) +=3D vhost.o vhost-=
backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)))=
 +=3D vhost-stub.o
 endif
=20
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) +=3D=
 vhost-stub.o
 common-obj-$(CONFIG_ALL) +=3D vhost-stub.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..b5d2e30 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -9,12 +9,14 @@
  */
=20
 #include "qemu/osdep.h"
-#include <linux/vhost.h>
-#include <sys/ioctl.h>
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
=20
+#ifdef CONFIG_LINUX
+#include <linux/vhost.h>
+#include <sys/ioctl.h>
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int re=
quest,
                              void *arg)
 {
@@ -265,18 +267,23 @@ static const VhostOps kernel_ops =3D {
         .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callback,
         .vhost_send_device_iotlb_msg =3D vhost_kernel_send_device_iotlb_=
msg,
 };
+#endif
=20
 int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backe=
nd_type)
 {
     int r =3D 0;
=20
     switch (backend_type) {
+#ifdef CONFIG_LINUX
     case VHOST_BACKEND_TYPE_KERNEL:
         dev->vhost_ops =3D &kernel_ops;
         break;
+#endif
+#ifdef CONFIG_VHOST_USER
     case VHOST_BACKEND_TYPE_USER:
         dev->vhost_ops =3D &user_ops;
         break;
+#endif
     default:
         error_report("Unknown vhost backend type");
         r =3D -1;
--=20
1.8.3.1
