Received: from eggs.gnu.org ([2001:4830:134:3::10]:41205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpZ-00044j-FG
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpX-0003Mj-9t
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpX-0003JK-3H
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8B3B8185343
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:02 +0200
Message-Id: <20180713130916.4153-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/29] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new virtio-input device, which connects to a vhost-user
backend. Usage:

-object vhost-user-backend,id=3Dvuid \
-device vhost-user-input-pci,vhost-user=3Dvuid

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio-pci.h           |  10 +++
 include/hw/virtio/virtio-input.h |  14 ++++
 hw/input/vhost-user-input.c      | 110 +++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c           |  20 ++++++
 MAINTAINERS                      |   1 +
 hw/input/Makefile.objs           |   1 +
 6 files changed, 156 insertions(+)
 create mode 100644 hw/input/vhost-user-input.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..c7e28e1b9c 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -54,6 +54,7 @@ typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
+typedef struct VHostUserInputPCI VHostUserInputPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VHostVSockPCI VHostVSockPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
@@ -376,6 +377,15 @@ struct VirtIOInputHostPCI {
=20
 #endif
=20
+#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"
+#define VHOST_USER_INPUT_PCI(obj)                                    \
+    OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
+
+struct VHostUserInputPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostUserInput vhi;
+};
+
 /*
  * virtio-gpu-pci: This extends VirtioPCIProxy.
  */
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
index 0000000000..ef1b23a8b2
--- /dev/null
+++ b/hw/input/vhost-user-input.c
@@ -0,0 +1,110 @@
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
+static void vhost_input_is_busy(const Object *obj, const char *name,
+                                Object *val, Error **errp)
+{
+    VHostUserInput *vhi =3D VHOST_USER_INPUT(obj);
+
+    if (vhi->vhost) {
+        error_setg(errp, "can't use already busy vhost-user");
+    } else {
+        qdev_prop_allow_set_link_before_realize(obj, name, val, errp);
+    }
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
+    object_property_add_link(obj, "vhost-user", TYPE_VHOST_USER_BACKEND,
+                             (Object **)&vhi->vhost,
+                             vhost_input_is_busy,
+                             OBJ_PROP_LINK_STRONG,
+                             &error_abort);
+}
+
+static const TypeInfo vhost_input_info =3D {
+    .name          =3D TYPE_VHOST_USER_INPUT,
+    .parent        =3D TYPE_VIRTIO_INPUT,
+    .instance_size =3D sizeof(VHostUserInput),
+    .instance_init =3D vhost_input_init,
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
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..6bb0575257 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2645,6 +2645,25 @@ static const TypeInfo virtio_host_pci_info =3D {
 };
 #endif
=20
+static void vhost_input_pci_initfn(Object *obj)
+{
+    VHostUserInputPCI *dev =3D VHOST_USER_INPUT_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
+                                TYPE_VHOST_USER_INPUT);
+
+    object_property_add_alias(obj, "vhost-user",
+                              OBJECT(&dev->vhi), "vhost-user",
+                              &error_abort);
+}
+
+static const TypeInfo vhost_input_pci_info =3D {
+    .name          =3D TYPE_VHOST_USER_INPUT_PCI,
+    .parent        =3D TYPE_VIRTIO_INPUT_PCI,
+    .instance_size =3D sizeof(VHostUserInputPCI),
+    .instance_init =3D vhost_input_pci_initfn,
+};
+
 /* virtio-pci-bus */
=20
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2701,6 +2720,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_LINUX
     type_register_static(&virtio_host_pci_info);
 #endif
+    type_register_static(&vhost_input_pci_info);
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
diff --git a/MAINTAINERS b/MAINTAINERS
index ee13fe9ef1..50ace65b3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,7 @@ L: qemu-s390x@nongnu.org
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
+F: hw/input/vhost-user-input.c
 F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index c8b00f71ec..6adc308cdd 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input.o
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-hid.o
 ifeq ($(CONFIG_LINUX),y)
 common-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-host.o
+common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO_INPUT)) +=3D=
 vhost-user-input.o
 endif
=20
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-softusb.o
--=20
2.18.0.129.ge3331758f1
