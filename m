Received: from eggs.gnu.org ([2001:4830:134:3::10]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuP-0003CY-Cr
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuN-0007pc-Jb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOmuN-0007pU-EC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BFD4C12AD
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:28:07 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Jun 2018 18:27:41 +0200
Message-Id: <20180601162749.27406-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180601162749.27406-1-marcandre.lureau@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 04/12] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Create a vhost-user-backend object that holds a connection to a
vhost-user backend and can be referenced from virtio devices that
support it. See later patches for input & gpu usage.

A chardev can be specified to communicate with the vhost-user backend,
ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -object
vhost-user-backend,id=3Dvuid,chardev=3Dchar0.

Alternatively, an executable with its arguments may be given as 'cmd'
property, ex: -object
vhost-user-backend,id=3Dvui,cmd=3D"./vhost-user-input /dev/input..". The
executable is then spawn and, by convention, the vhost-user socket is
passed as fd=3D3. It may be considered a security breach to allow
creating processes that may execute arbitrary executables, so this may
be restricted to some known executables (via signature etc) or
directory.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/vhost-user-backend.h |  58 +++++
 backends/vhost-user.c               | 330 ++++++++++++++++++++++++++++
 vl.c                                |   3 +-
 backends/Makefile.objs              |   4 +
 4 files changed, 394 insertions(+), 1 deletion(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c

diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
new file mode 100644
index 0000000000..890db176fd
--- /dev/null
+++ b/include/sysemu/vhost-user-backend.h
@@ -0,0 +1,58 @@
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
index 0000000000..ae40dee373
--- /dev/null
+++ b/backends/vhost-user.c
@@ -0,0 +1,330 @@
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
+    b->vdev =3D vdev;
+    b->dev.nvqs =3D nvqs;
+    b->dev.vqs =3D g_new(struct vhost_virtqueue, nvqs);
+
+    ret =3D vhost_dev_init(&b->dev, &b->chr, VHOST_BACKEND_TYPE_USER, 0)=
;
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
+static int
+vhost_user_backend_spawn_cmd(VhostUserBackend *b, int vhostfd, Error **e=
rrp)
+{
+    int devnull =3D open("/dev/null", O_RDWR);
+    pid_t pid;
+
+    assert(!b->child);
+
+    if (!b->cmd) {
+        error_setg_errno(errp, errno, "Missing cmd property");
+        return -1;
+    }
+    if (devnull < 0) {
+        error_setg_errno(errp, errno, "Unable to open /dev/null");
+        return -1;
+    }
+
+    pid =3D qemu_fork(errp);
+    if (pid < 0) {
+        close(devnull);
+        return -1;
+    }
+
+    if (pid =3D=3D 0) { /* child */
+        int fd, maxfd =3D sysconf(_SC_OPEN_MAX);
+
+        dup2(devnull, STDIN_FILENO);
+        dup2(devnull, STDOUT_FILENO);
+        dup2(vhostfd, 3);
+
+        signal(SIGINT, SIG_IGN);
+
+        for (fd =3D 4; fd < maxfd; fd++) {
+            close(fd);
+        }
+
+        execlp("/bin/sh", "sh", "-c", b->cmd, NULL);
+        _exit(1);
+    }
+
+    b->child =3D QIO_CHANNEL(qio_channel_command_new_pid(devnull, devnul=
l, pid));
+
+    return 0;
+}
+
+static void
+vhost_user_backend_complete(UserCreatable *uc, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(uc);
+    Chardev *chr;
+
+    if (!!b->chr_name + !!b->cmd !=3D 1) {
+        error_setg(errp, "You may specificy only one of 'chardev' or 'cm=
d'.");
+        return;
+    }
+
+    if (b->chr_name) {
+        chr =3D qemu_chr_find(b->chr_name);
+        if (chr =3D=3D NULL) {
+            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
+                      "Chardev '%s' not found", b->chr_name);
+            return;
+        }
+
+        if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
+            return;
+        }
+    } else {
+        int sv[2];
+
+        if (socketpair(PF_UNIX, SOCK_STREAM, 0, sv) =3D=3D -1) {
+            error_setg_errno(errp, errno, "socketpair() failed");
+            return;
+        }
+
+        chr =3D CHARDEV(object_new(TYPE_CHARDEV_SOCKET));
+        if (!chr || qemu_chr_add_client(chr, sv[0]) =3D=3D -1) {
+            error_setg(errp, "Failed to make socket chardev");
+            object_unref(OBJECT(chr));
+            return;
+        }
+
+        if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
+            return;
+        }
+
+        vhost_user_backend_spawn_cmd(b, sv[1], errp);
+
+        close(sv[1]);
+    }
+
+    b->completed =3D true;
+    /* could vhost_dev_init() happen here, so early vhost-user message
+     * can be exchanged */
+}
+
+static char *get_cmd(Object *obj, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    return g_strdup(b->cmd);
+}
+
+static void set_cmd(Object *obj, const char *str, Error **errp)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    if (b->child) {
+        error_setg(errp, "cannot change property value");
+        return;
+    }
+
+    g_free(b->cmd);
+    b->cmd =3D g_strdup(str);
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
+    object_property_add_str(obj, "cmd", get_cmd, set_cmd, NULL);
+    object_property_add_str(obj, "chardev", get_chardev, set_chardev, NU=
LL);
+}
+
+static void vhost_user_backend_finalize(Object *obj)
+{
+    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
+
+    g_free(b->dev.vqs);
+    g_free(b->cmd);
+    g_free(b->chr_name);
+
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
index c4fe25560c..4ed094dd71 100644
--- a/vl.c
+++ b/vl.c
@@ -2833,7 +2833,8 @@ static bool object_create_initial(const char *type)
     }
=20
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
-    if (g_str_equal(type, "cryptodev-vhost-user")) {
+    if (g_str_equal(type, "cryptodev-vhost-user") ||
+        g_str_equal(type, "vhost-user-backend")) {
         return false;
     }
 #endif
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index ad7c0325ed..bac27de11b 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -16,3 +16,7 @@ common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LI=
NUX)) +=3D \
 endif
=20
 common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
+
+ifdef CONFIG_LINUX
+common-obj-$(CONFIG_VIRTIO) +=3D vhost-user.o
+endif
--=20
2.17.1.906.g10fd178552
