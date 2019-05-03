Received: from eggs.gnu.org ([209.51.188.92]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXoI-0005Of-6D
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXoD-0000H8-Ao
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hMXo6-0000Df-OQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F5BD085D
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:00:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 May 2019 15:00:31 +0200
Message-Id: <20190503130034.24916-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190503130034.24916-1-marcandre.lureau@redhat.com>
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/6] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

Create a vhost-user-backend object that holds a connection to a
vhost-user backend (or "slave" process) and can be referenced from
virtio devices that support it. See later patches for input & gpu
usage.

Note: a previous iteration of this object made it user-creatable, and
allowed managed sub-process spawning, but that has been dropped for
now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/vhost-user-backend.h |  57 ++++++++
 backends/vhost-user.c               | 209 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   2 +
 backends/Makefile.objs              |   2 +
 4 files changed, 270 insertions(+)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c

diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
new file mode 100644
index 0000000000..9abf8f06a1
--- /dev/null
+++ b/include/sysemu/vhost-user-backend.h
@@ -0,0 +1,57 @@
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
+    char *chr_name;
+    CharBackend chr;
+    VhostUserState vhost_user;
+    struct vhost_dev dev;
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
index 0000000000..2b055544a7
--- /dev/null
+++ b/backends/vhost-user.c
@@ -0,0 +1,209 @@
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
+static void set_chardev(Object *obj, const char *value, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+    Chardev *chr;
+
+    if (b->completed) {
+        error_setg(errp, QERR_PERMISSION_DENIED);
+        return;
+    }
+
+    g_free(b->chr_name);
+    b->chr_name =3D g_strdup(value);
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
+    /* could call vhost_dev_init() so early message can be exchanged */
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
+}
+
+static const TypeInfo vhost_user_backend_info =3D {
+    .name =3D TYPE_VHOST_USER_BACKEND,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(VhostUserBackend),
+    .instance_init =3D vhost_user_backend_init,
+    .instance_finalize =3D vhost_user_backend_finalize,
+    .class_size =3D sizeof(VhostUserBackendClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&vhost_user_backend_info);
+}
+
+type_init(register_types);
diff --git a/MAINTAINERS b/MAINTAINERS
index 66ddbda9c9..2e40390ebc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1478,6 +1478,8 @@ F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
 F: docs/interop/vhost-user.txt
 F: contrib/vhost-user-*/
+F: backends/vhost-user.c
+F: include/sysemu/vhost-user-backend.h
=20
 virtio
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index ff619d31b4..981e8e122f 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -14,4 +14,6 @@ common-obj-y +=3D cryptodev-vhost.o
 common-obj-$(CONFIG_VHOST_CRYPTO) +=3D cryptodev-vhost-user.o
 endif
=20
+common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) +=3D vhost=
-user.o
+
 common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
--=20
2.21.0.777.g83232e3864
