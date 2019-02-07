Received: from eggs.gnu.org ([209.51.188.92]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmy6-0004MM-Du
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmy4-0003Jh-OV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grmy4-0003J0-CW
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4C797F6C7
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 16:56:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:54:42 +0100
Message-Id: <20190207165449.6125-6-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165449.6125-1-marcandre.lureau@redhat.com>
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/12] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Create a vhost-user-backend object that holds a connection to a
vhost-user backend and can be referenced from virtio devices that
support it. See later patches for input & gpu usage.

A chardev must be specified to communicate with the vhost-user
backend, ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -object
vhost-user-backend,id=3Dvuid,chardev=3Dchar0.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/vhost-user-backend.h |  60 +++++++
 backends/vhost-user.c               | 244 ++++++++++++++++++++++++++++
 vl.c                                |   3 +-
 MAINTAINERS                         |   2 +
 backends/Makefile.objs              |   3 +-
 qemu-options.hx                     |  20 +++
 6 files changed, 330 insertions(+), 2 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c

diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
new file mode 100644
index 0000000000..60f811cae7
--- /dev/null
+++ b/include/sysemu/vhost-user-backend.h
@@ -0,0 +1,60 @@
+/*
+ * QEMU vhost-user backend
+ *
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_VHOST_USER_BACKEND_H
+#define QEMU_VHOST_USER_BACKEND_H
+
+#include "qom/object.h"
+#include "exec/memory.h"
+#include "qemu/option.h"
+#include "qemu/bitmap.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "chardev/char-fe.h"
+#include "io/channel.h"
+
+#define TYPE_VHOST_USER_BACKEND "vhost-user-backend"
+#define VHOST_USER_BACKEND(obj) \
+    OBJECT_CHECK(VhostUserBackend, (obj), TYPE_VHOST_USER_BACKEND)
+#define VHOST_USER_BACKEND_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(VhostUserBackendClass, (obj), TYPE_VHOST_USER_BACKE=
ND)
+#define VHOST_USER_BACKEND_CLASS(klass) \
+    OBJECT_CLASS_CHECK(VhostUserBackendClass, (klass), TYPE_VHOST_USER_B=
ACKEND)
+
+typedef struct VhostUserBackend VhostUserBackend;
+typedef struct VhostUserBackendClass VhostUserBackendClass;
+
+struct VhostUserBackendClass {
+    ObjectClass parent_class;
+};
+
+struct VhostUserBackend {
+    /* private */
+    Object parent;
+
+    char *cmd;
+    char *chr_name;
+
+    CharBackend chr;
+    VhostUserState vhost_user;
+    struct vhost_dev dev;
+    QIOChannel *child;
+    VirtIODevice *vdev;
+    bool started;
+    bool completed;
+};
+
+int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
+                                unsigned nvqs, Error **errp);
+void vhost_user_backend_start(VhostUserBackend *b);
+void vhost_user_backend_stop(VhostUserBackend *b);
+
+#endif
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
new file mode 100644
index 0000000000..bf39c0751d
--- /dev/null
+++ b/backends/vhost-user.c
@@ -0,0 +1,244 @@
+/*
+ * QEMU vhost-user backend
+ *
+ * Copyright (C) 2018 Red Hat Inc
+ *
+ * Authors:
+ *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qemu/error-report.h"
+#include "qom/object_interfaces.h"
+#include "sysemu/vhost-user-backend.h"
+#include "sysemu/kvm.h"
+#include "io/channel-command.h"
+#include "hw/virtio/virtio-bus.h"
+
+static bool
+ioeventfd_enabled(void)
+{
+    return kvm_enabled() && kvm_eventfds_enabled();
+}
+
+int
+vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
+                            unsigned nvqs, Error **errp)
+{
+    int ret;
+
+    assert(!b->vdev && vdev);
+
+    if (!ioeventfd_enabled()) {
+        error_setg(errp, "vhost initialization failed: requires kvm");
+        return -1;
+    }
+
+    if (!vhost_user_init(&b->vhost_user, &b->chr, errp)) {
+        return -1;
+    }
+
+    b->vdev =3D vdev;
+    b->dev.nvqs =3D nvqs;
+    b->dev.vqs =3D g_new(struct vhost_virtqueue, nvqs);
+
+    ret =3D vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vhost initialization failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+void
+vhost_user_backend_start(VhostUserBackend *b)
+{
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int ret, i ;
+
+    if (b->started) {
+        return;
+    }
+
+    if (!k->set_guest_notifiers) {
+        error_report("binding does not support guest notifiers");
+        return;
+    }
+
+    ret =3D vhost_dev_enable_notifiers(&b->dev, b->vdev);
+    if (ret < 0) {
+        return;
+    }
+
+    ret =3D k->set_guest_notifiers(qbus->parent, b->dev.nvqs, true);
+    if (ret < 0) {
+        error_report("Error binding guest notifier");
+        goto err_host_notifiers;
+    }
+
+    b->dev.acked_features =3D b->vdev->guest_features;
+    ret =3D vhost_dev_start(&b->dev, b->vdev);
+    if (ret < 0) {
+        error_report("Error start vhost dev");
+        goto err_guest_notifiers;
+    }
+
+    /* guest_notifier_mask/pending not used yet, so just unmask
+     * everything here.  virtio-pci will do the right thing by
+     * enabling/disabling irqfd.
+     */
+    for (i =3D 0; i < b->dev.nvqs; i++) {
+        vhost_virtqueue_mask(&b->dev, b->vdev,
+                             b->dev.vq_index + i, false);
+    }
+
+    b->started =3D true;
+    return;
+
+err_guest_notifiers:
+    k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false);
+err_host_notifiers:
+    vhost_dev_disable_notifiers(&b->dev, b->vdev);
+}
+
+void
+vhost_user_backend_stop(VhostUserBackend *b)
+{
+    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
+    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
+    int ret =3D 0;
+
+    if (!b->started) {
+        return;
+    }
+
+    vhost_dev_stop(&b->dev, b->vdev);
+
+    if (k->set_guest_notifiers) {
+        ret =3D k->set_guest_notifiers(qbus->parent,
+                                     b->dev.nvqs, false);
+        if (ret < 0) {
+            error_report("vhost guest notifier cleanup failed: %d", ret)=
;
+        }
+    }
+    assert(ret >=3D 0);
+
+    vhost_dev_disable_notifiers(&b->dev, b->vdev);
+    b->started =3D false;
+}
+
+static void
+vhost_user_backend_complete(UserCreatable *uc, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(uc);
+    Chardev *chr;
+
+    if (!b->chr_name) {
+        error_setg(errp, "You must specificy 'chardev'.");
+        return;
+    }
+
+    chr =3D qemu_chr_find(b->chr_name);
+    if (chr =3D=3D NULL) {
+        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                  "Chardev '%s' not found", b->chr_name);
+        return;
+    }
+
+    if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
+        return;
+    }
+
+    b->completed =3D true;
+    /* could vhost_dev_init() happen here, so early vhost-user message
+     * can be exchanged */
+}
+
+static void set_chardev(Object *obj, const char *value, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    if (b->completed) {
+        error_setg(errp, QERR_PERMISSION_DENIED);
+    } else {
+        g_free(b->chr_name);
+        b->chr_name =3D g_strdup(value);
+    }
+}
+
+static char *get_chardev(Object *obj, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+    Chardev *chr =3D qemu_chr_fe_get_driver(&b->chr);
+
+    if (chr && chr->label) {
+        return g_strdup(chr->label);
+    }
+
+    return NULL;
+}
+
+static void vhost_user_backend_init(Object *obj)
+{
+    object_property_add_str(obj, "chardev", get_chardev, set_chardev, NU=
LL);
+}
+
+static void vhost_user_backend_finalize(Object *obj)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    g_free(b->dev.vqs);
+    g_free(b->chr_name);
+
+    vhost_user_cleanup(&b->vhost_user);
+    qemu_chr_fe_deinit(&b->chr, true);
+
+    if (b->child) {
+        object_unref(OBJECT(b->child));
+    }
+}
+
+static bool
+vhost_user_backend_can_be_deleted(UserCreatable *uc)
+{
+    return true;
+}
+
+static void
+vhost_user_backend_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+
+    ucc->complete =3D vhost_user_backend_complete;
+    ucc->can_be_deleted =3D vhost_user_backend_can_be_deleted;
+}
+
+static const TypeInfo vhost_user_backend_info =3D {
+    .name =3D TYPE_VHOST_USER_BACKEND,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(VhostUserBackend),
+    .instance_init =3D vhost_user_backend_init,
+    .instance_finalize =3D vhost_user_backend_finalize,
+    .class_size =3D sizeof(VhostUserBackendClass),
+    .class_init =3D vhost_user_backend_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void register_types(void)
+{
+    type_register_static(&vhost_user_backend_info);
+}
+
+type_init(register_types);
diff --git a/vl.c b/vl.c
index 9e4dba7f92..43012ee6a3 100644
--- a/vl.c
+++ b/vl.c
@@ -2784,7 +2784,8 @@ static bool object_create_initial(const char *type,=
 QemuOpts *opts)
     }
=20
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    if (g_str_equal(type, "cryptodev-vhost-user")) {
+    if (g_str_equal(type, "cryptodev-vhost-user") ||
+        g_str_equal(type, "vhost-user-backend")) {
         return false;
     }
 #endif
diff --git a/MAINTAINERS b/MAINTAINERS
index 16b6264412..e077fe788d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1424,6 +1424,8 @@ F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
 F: docs/interop/vhost-user.txt
 F: contrib/vhost-user-*/
+F: backends/vhost-user.c
+F: include/sysemu/vhost-user-backend.h
=20
 virtio
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 717fcbdae4..a5ec0bf907 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -12,7 +12,8 @@ common-obj-y +=3D cryptodev-builtin.o
 ifeq ($(CONFIG_VIRTIO),y)
 common-obj-y +=3D cryptodev-vhost.o
 common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) +=3D \
-    cryptodev-vhost-user.o
+    cryptodev-vhost-user.o \
+    vhost-user.o
 endif
=20
 common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
diff --git a/qemu-options.hx b/qemu-options.hx
index 06ef1a7c5c..24315a4cda 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4203,6 +4203,26 @@ secondary:
 If you want to know the detail of above command line, you can read
 the colo-compare git log.
=20
+@item -object vhost-user-backend,id=3Did=3D@var{id},chardev=3D@var{chard=
evid}
+
+Create a vhost-user-backend object that holds a connection to a
+vhost-user backend and can be referenced from virtio/vhost-user
+devices that support it.
+
+The @var{id} parameter is a unique ID that will be used to reference
+this vhost-user backend from the @option{vhost-user} device. The
+@var{chardev} parameter is the unique ID of a character device backend
+that provides the connection to the vhost-user slave process. (Since 3.2=
)
+
+@example
+
+ # qemu-system-x86_64 \
+   [...] \
+   -object vhost-user-backend,id=3Dvuid,chardev=3Dchar0 \
+   -device vhost-user-input-pci,vhost-user=3Dvuid
+   [...]
+@end example
+
 @item -object cryptodev-backend-builtin,id=3D@var{id}[,queues=3D@var{que=
ues}]
=20
 Creates a cryptodev backend which executes crypto opreation from
--=20
2.20.1.519.g8feddda32c
