Received: from eggs.gnu.org ([209.51.188.92]:36653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4IQ-00030s-WF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4IO-00019R-NM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:26:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4IM-00016W-Jk
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:26:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D167C079C4C
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:26:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:55 +0100
Message-Id: <20190208112357.31615-12-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/13] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new virtio-input device, which connects to a vhost-user
backend.

vhost-user-input is similar to virtio-input-host, it is wrapped by
vhost-user-input-pci. Instead of reading configuration directly from
an input device / evdev, it reads it over vhost-user protocol with
INPUT_GET_CONFIG message. Then vhost-user-backend takes care of
interfacing the virtio device with the backend, for the queue & events
processing.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-input.h |  14 +++++
 hw/input/vhost-user-input.c      | 104 +++++++++++++++++++++++++++++++
 hw/virtio/vhost-user-input-pci.c |  53 ++++++++++++++++
 MAINTAINERS                      |   1 +
 default-configs/virtio.mak       |   1 +
 hw/input/Makefile.objs           |   1 +
 hw/virtio/Makefile.objs          |   1 +
 7 files changed, 175 insertions(+)
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 054c38836f..4fca03e796 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -2,6 +2,7 @@
 #define QEMU_VIRTIO_INPUT_H
=20
 #include "ui/input.h"
+#include "sysemu/vhost-user-backend.h"
=20
 /* ----------------------------------------------------------------- */
 /* virtio input protocol                                             */
@@ -42,11 +43,18 @@ typedef struct virtio_input_event virtio_input_event;
 #define VIRTIO_INPUT_HOST_GET_PARENT_CLASS(obj) \
         OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_INPUT_HOST)
=20
+#define TYPE_VHOST_USER_INPUT   "vhost-user-input"
+#define VHOST_USER_INPUT(obj)                              \
+    OBJECT_CHECK(VHostUserInput, (obj), TYPE_VHOST_USER_INPUT)
+#define VHOST_USER_INPUT_GET_PARENT_CLASS(obj)             \
+    OBJECT_GET_PARENT_CLASS(obj, TYPE_VHOST_USER_INPUT)
+
 typedef struct VirtIOInput VirtIOInput;
 typedef struct VirtIOInputClass VirtIOInputClass;
 typedef struct VirtIOInputConfig VirtIOInputConfig;
 typedef struct VirtIOInputHID VirtIOInputHID;
 typedef struct VirtIOInputHost VirtIOInputHost;
+typedef struct VHostUserInput VHostUserInput;
=20
 struct VirtIOInputConfig {
     virtio_input_config               config;
@@ -98,6 +106,12 @@ struct VirtIOInputHost {
     int                               fd;
 };
=20
+struct VHostUserInput {
+    VirtIOInput                       parent_obj;
+
+    VhostUserBackend                  *vhost;
+};
+
 void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event);
 void virtio_input_init_config(VirtIOInput *vinput,
                               virtio_input_config *config);
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
new file mode 100644
index 0000000000..2ea1e50ab7
--- /dev/null
+++ b/hw/input/vhost-user-input.c
@@ -0,0 +1,104 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+
+#include "hw/qdev.h"
+#include "hw/virtio/virtio-input.h"
+
+static void vhost_input_realize(DeviceState *dev, Error **errp)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    virtio_input_config *config;
+    int i, ret;
+
+    if (!vhi->vhost) {
+        error_setg(errp, "'vhost-user' property is required");
+        return;
+    }
+
+    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) =3D=3D -1=
) {
+        return;
+    }
+
+    ret =3D vhost_user_input_get_config(&vhi->vhost->dev, &config);
+    if (ret < 0) {
+        error_setg(errp, "failed to get input config");
+        return;
+    }
+    for (i =3D 0; i < ret; i++) {
+        virtio_input_add_config(vinput, &config[i]);
+    }
+    g_free(config);
+}
+
+static void vhost_input_change_active(VirtIOInput *vinput)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(vinput);
+
+    if (vinput->active) {
+        vhost_user_backend_start(vhi->vhost);
+    } else {
+        vhost_user_backend_stop(vhi->vhost);
+    }
+}
+
+static const VMStateDescription vmstate_vhost_input =3D {
+    .name =3D "vhost-user-input",
+    .unmigratable =3D 1,
+};
+
+static void vhost_input_class_init(ObjectClass *klass, void *data)
+{
+    VirtIOInputClass *vic =3D VIRTIO_INPUT_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd           =3D &vmstate_vhost_input;
+    vic->realize       =3D vhost_input_realize;
+    vic->change_active =3D vhost_input_change_active;
+}
+
+static void vhost_input_init(Object *obj)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(obj);
+    struct virtio_input_config vhost_input_config[] =3D { { /* empty lis=
t */ } };
+
+    virtio_input_init_config(vinput, vhost_input_config);
+
+    vhi->vhost =3D VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND=
));
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(vhi->vhost), "chardev", &error_abor=
t);
+}
+
+static void vhost_input_finalize(Object *obj)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
+
+    object_unref(OBJECT(vhi->vhost));
+}
+
+static const TypeInfo vhost_input_info =3D {
+    .name          =3D TYPE_VHOST_USER_INPUT,
+    .parent        =3D TYPE_VIRTIO_INPUT,
+    .instance_size =3D sizeof(VHostUserInput),
+    .instance_init =3D vhost_input_init,
+    .instance_finalize =3D vhost_input_finalize,
+    .class_init    =3D vhost_input_class_init,
+};
+
+/* ----------------------------------------------------------------- */
+
+static void vhost_input_register_types(void)
+{
+    type_register_static(&vhost_input_info);
+}
+
+type_init(vhost_input_register_types)
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-inpu=
t-pci.c
new file mode 100644
index 0000000000..3d1b7a85fd
--- /dev/null
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -0,0 +1,53 @@
+/*
+ * This work is licensed under the terms of the GNU LGPL, version 2 or
+ * later.  See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-input.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "virtio-pci.h"
+
+typedef struct VHostUserInputPCI VHostUserInputPCI;
+
+#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci-base"
+
+#define VHOST_USER_INPUT_PCI(obj) \
+    OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
+
+struct VHostUserInputPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserInput vhi;
+};
+
+static void vhost_user_input_pci_instance_init(Object *obj)
+{
+    VHostUserInputPCI *dev =3D VHOST_USER_INPUT_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
+                                TYPE_VHOST_USER_INPUT);
+
+    object_property_add_alias(obj, "chardev",
+                              OBJECT(&dev->vhi), "chardev",
+                              &error_abort);
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info =3D {
+    .base_name =3D TYPE_VHOST_USER_INPUT_PCI,
+    .generic_name =3D "vhost-user-input-pci",
+    .transitional_name =3D "vhost-user-input-pci-transitional",
+    .non_transitional_name =3D "vhost-user-input-pci-non-transitional",
+    .parent =3D TYPE_VIRTIO_INPUT_PCI,
+    .instance_size =3D sizeof(VHostUserInputPCI),
+    .instance_init =3D vhost_user_input_pci_instance_init,
+};
+
+static void vhost_user_input_pci_register(void)
+{
+    virtio_pci_types_register(&vhost_user_input_pci_info);
+}
+
+type_init(vhost_user_input_pci_register)
diff --git a/MAINTAINERS b/MAINTAINERS
index e077fe788d..5dfc9531bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1467,6 +1467,7 @@ L: qemu-s390x@nongnu.org
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
=20
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index ecb4420e74..5f5266ef8b 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -13,3 +13,4 @@ CONFIG_SCSI=3Dy
 CONFIG_VIRTIO_SCSI=3Dy
 CONFIG_VIRTIO_SERIAL=3Dy
 CONFIG_VIRTIO_INPUT_HOST=3D$(CONFIG_LINUX)
+CONFIG_VHOST_USER_INPUT=3D$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRT=
IO_INPUT))
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index c8b00f71ec..9511e3102f 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
 ifeq ($(CONFIG_LINUX),y)
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
+common-obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input.o
 endif
=20
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index d335dd0a6a..7462051ba3 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
 ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
+obj-$(CONFIG_VHOST_USER_INPUT) +=3D vhost-user-input-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-user-scsi-pci.o
 obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
--=20
2.20.1.519.g8feddda32c
