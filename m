Received: from eggs.gnu.org ([2001:4830:134:3::10]:44013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwr2-00025I-Mv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwqx-000573-S2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwqx-00056y-Mz
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CA297DAC3
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:18:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:16 +0200
Message-Id: <20180618161729.334-14-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 13/26] contrib: add vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a vhost-user input backend example, based on virtio-input-host
device. It takes an evdev path as argument, and can be associated with a
vhost-user-backend object, ex:

-object vhost-user-backend,id=3Dvuid,cmd=3D"vhost-user-input /dev/input/e=
vent0"

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h  |   1 +
 contrib/vhost-user-input/main.c        | 364 +++++++++++++++++++++++++
 Makefile                               |   3 +
 Makefile.objs                          |   1 +
 configure                              |   3 +
 contrib/vhost-user-input/Makefile.objs |   1 +
 6 files changed, 373 insertions(+)
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4aa55b4d2d..40d7cbfc2a 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -91,6 +91,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
+    VHOST_USER_INPUT_GET_CONFIG,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/m=
ain.c
new file mode 100644
index 0000000000..fe12d1ce1f
--- /dev/null
+++ b/contrib/vhost-user-input/main.c
@@ -0,0 +1,364 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include <glib.h>
+#include <linux/input.h>
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/bswap.h"
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "contrib/libvhost-user/libvhost-user-glib.h"
+#include "standard-headers/linux/virtio_input.h"
+
+typedef struct virtio_input_event virtio_input_event;
+typedef struct virtio_input_config virtio_input_config;
+
+typedef struct VuInput {
+    VugDev dev;
+    GSource *evsrc;
+    int evdevfd;
+    GArray *config;
+    virtio_input_event *queue;
+    uint32_t qindex, qsize;
+} VuInput;
+
+static void vi_input_send(VuInput *vi, struct virtio_input_event *event)
+{
+    VuDev *dev =3D &vi->dev.parent;
+    VuVirtq *vq =3D vu_get_queue(dev, 0);
+    VuVirtqElement *elem;
+    unsigned have, need;
+    int i, len;
+
+    /* queue up events ... */
+    if (vi->qindex =3D=3D vi->qsize) {
+        vi->qsize++;
+        vi->queue =3D realloc(vi->queue, vi->qsize *
+                                sizeof(virtio_input_event));
+    }
+    vi->queue[vi->qindex++] =3D *event;
+
+    /* ... until we see a report sync ... */
+    if (event->type !=3D htole16(EV_SYN) ||
+        event->code !=3D htole16(SYN_REPORT)) {
+        return;
+    }
+
+    /* ... then check available space ... */
+    need =3D sizeof(virtio_input_event) * vi->qindex;
+    vu_queue_get_avail_bytes(dev, vq, &have, NULL, need, 0);
+    if (have < need) {
+        vi->qindex =3D 0;
+        g_warning("ENOSPC in vq, dropping events");
+        return;
+    }
+
+    /* ... and finally pass them to the guest */
+    for (i =3D 0; i < vi->qindex; i++) {
+        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
+            /* should not happen, we've checked for space beforehand */
+            g_warning("%s: Huh?  No vq elem available ...\n", __func__);
+            return;
+        }
+        len =3D iov_from_buf(elem->in_sg, elem->in_num,
+                           0, vi->queue + i, sizeof(virtio_input_event))=
;
+        vu_queue_push(dev, vq, elem, len);
+        g_free(elem);
+    }
+    vu_queue_notify(&vi->dev.parent, vq);
+    vi->qindex =3D 0;
+}
+
+static void
+vi_evdev_watch(VuDev *dev, int condition, void *data)
+{
+    VuInput *vi =3D data;
+    int fd =3D vi->evdevfd;
+
+    g_debug("Got evdev condition %x", condition);
+
+    struct virtio_input_event virtio;
+    struct input_event evdev;
+    int rc;
+
+    for (;;) {
+        rc =3D read(fd, &evdev, sizeof(evdev));
+        if (rc !=3D sizeof(evdev)) {
+            break;
+        }
+
+        g_debug("input %d %d %d", evdev.type, evdev.code, evdev.value);
+
+        virtio.type  =3D htole16(evdev.type);
+        virtio.code  =3D htole16(evdev.code);
+        virtio.value =3D htole32(evdev.value);
+        vi_input_send(vi, &virtio);
+    }
+}
+
+
+static void vi_handle_status(VuInput *vi, virtio_input_event *event)
+{
+    struct input_event evdev;
+    int rc;
+
+    if (gettimeofday(&evdev.time, NULL)) {
+        perror("vi_handle_status: gettimeofday");
+        return;
+    }
+
+    evdev.type =3D le16toh(event->type);
+    evdev.code =3D le16toh(event->code);
+    evdev.value =3D le32toh(event->value);
+
+    rc =3D write(vi->evdevfd, &evdev, sizeof(evdev));
+    if (rc =3D=3D -1) {
+        perror("vi_host_handle_status: write");
+    }
+}
+
+static void vi_handle_sts(VuDev *dev, int qidx)
+{
+    VuInput *vi =3D container_of(dev, VuInput, dev.parent);
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+    virtio_input_event event;
+    VuVirtqElement *elem;
+    int len;
+
+    g_debug("%s", G_STRFUNC);
+
+    for (;;) {
+        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
+            break;
+        }
+
+        memset(&event, 0, sizeof(event));
+        len =3D iov_to_buf(elem->out_sg, elem->out_num,
+                         0, &event, sizeof(event));
+        vi_handle_status(vi, &event);
+        vu_queue_push(dev, vq, elem, len);
+        g_free(elem);
+    }
+
+    vu_queue_notify(&vi->dev.parent, vq);
+}
+
+static void
+vi_panic(VuDev *dev, const char *msg)
+{
+    g_critical("%s\n", msg);
+    exit(1);
+}
+
+static void
+vi_queue_set_started(VuDev *dev, int qidx, bool started)
+{
+    VuInput *vi =3D container_of(dev, VuInput, dev.parent);
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+
+    g_debug("queue started %d:%d", qidx, started);
+
+    if (qidx =3D=3D 0) {
+        if (started && !vi->evsrc) {
+            vi->evsrc =3D vug_source_new(&vi->dev, vi->evdevfd,
+                                       G_IO_IN, vi_evdev_watch, vi);
+        } else if (!started) {
+            g_source_destroy(vi->evsrc);
+            vi->evsrc =3D NULL;
+        }
+    } else {
+        vu_set_queue_handler(dev, vq, started ? vi_handle_sts : NULL);
+    }
+}
+
+static int
+vi_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
+{
+    VuInput *vi =3D container_of(dev, VuInput, dev.parent);
+
+    switch (vmsg->request) {
+    case VHOST_USER_INPUT_GET_CONFIG:
+        vmsg->size =3D vi->config->len * sizeof(virtio_input_config);
+        vmsg->data =3D g_memdup(vi->config->data, vmsg->size);
+        *do_reply =3D true;
+        return 1;
+    default:
+        return 0;
+    }
+}
+
+static const VuDevIface vuiface =3D {
+    .queue_set_started =3D vi_queue_set_started,
+    .process_msg =3D vi_process_msg,
+};
+
+static void
+vi_bits_config(VuInput *vi, int type, int count)
+{
+    virtio_input_config bits;
+    int rc, i, size =3D 0;
+
+    memset(&bits, 0, sizeof(bits));
+    rc =3D ioctl(vi->evdevfd, EVIOCGBIT(type, count / 8), bits.u.bitmap)=
;
+    if (rc < 0) {
+        return;
+    }
+
+    for (i =3D 0; i < count / 8; i++) {
+        if (bits.u.bitmap[i]) {
+            size =3D i + 1;
+        }
+    }
+    if (size =3D=3D 0) {
+        return;
+    }
+
+    bits.select =3D VIRTIO_INPUT_CFG_EV_BITS;
+    bits.subsel =3D type;
+    bits.size   =3D size;
+    g_array_append_val(vi->config, bits);
+}
+
+static int unix_sock_new(char *path)
+{
+    int sock;
+    struct sockaddr_un un;
+    size_t len;
+
+    sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
+    if (sock <=3D 0) {
+        perror("socket");
+        return -1;
+    }
+
+    un.sun_family =3D AF_UNIX;
+    snprintf(un.sun_path, sizeof(un.sun_path), "%s", path);
+    len =3D sizeof(un.sun_family) + strlen(un.sun_path);
+
+    unlink(path);
+    if (bind(sock, (struct sockaddr *)&un, len) < 0) {
+        perror("bind");
+        goto fail;
+    }
+
+    if (listen(sock, 1) < 0) {
+        perror("listen");
+        goto fail;
+    }
+
+    return sock;
+
+fail:
+    close(sock);
+
+    return -1;
+}
+
+static char **opt_fname;
+static char *opt_socket_path;
+static gboolean opt_nograb;
+
+static GOptionEntry entries[] =3D {
+    { "no-grab", 'n', 0, G_OPTION_ARG_NONE, &opt_nograb,
+      "Don't grab device", NULL },
+    { "socket-path", 's', 0, G_OPTION_ARG_FILENAME, &opt_socket_path,
+      "Use UNIX socket path", "PATH" },
+    { G_OPTION_REMAINING, '\0', 0, G_OPTION_ARG_FILENAME_ARRAY, &opt_fna=
me,
+      "EVDEV filename", "..." },
+    { NULL, }
+};
+
+int
+main(int argc, char *argv[])
+{
+    GMainLoop *loop =3D NULL;
+    VuInput vi =3D { 0, };
+    int rc, ver, fd;
+    virtio_input_config id;
+    struct input_id ids;
+    GError *error =3D NULL;
+    GOptionContext *context;
+
+    context =3D g_option_context_new("EVDEV - vhost-user-input sample");
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &error)) {
+        g_printerr("Option parsing failed: %s\n", error->message);
+        exit(1);
+    }
+    if (!opt_fname || !opt_fname[0] || opt_fname[1]) {
+        g_printerr("Please specify a single EVDEV filename\n");
+        exit(1);
+    }
+
+    vi.evdevfd =3D open(opt_fname[0], O_RDWR);
+    if (vi.evdevfd < 0) {
+        g_printerr("Failed to open evdev: %s\n", g_strerror(errno));
+        exit(1);
+    }
+
+    rc =3D ioctl(vi.evdevfd, EVIOCGVERSION, &ver);
+    if (rc < 0) {
+        g_printerr("%s: is not an evdev device\n", argv[1]);
+        exit(1);
+    }
+
+    if (!opt_nograb) {
+        rc =3D ioctl(vi.evdevfd, EVIOCGRAB, 1);
+        if (rc < 0) {
+            g_printerr("Failed to grab device\n");
+            exit(1);
+        }
+    }
+
+    vi.config =3D g_array_new(false, false, sizeof(virtio_input_config))=
;
+    memset(&id, 0, sizeof(id));
+    ioctl(vi.evdevfd, EVIOCGNAME(sizeof(id.u.string) - 1), id.u.string);
+    id.select =3D VIRTIO_INPUT_CFG_ID_NAME;
+    id.size =3D strlen(id.u.string);
+    g_array_append_val(vi.config, id);
+
+    if (ioctl(vi.evdevfd, EVIOCGID, &ids) =3D=3D 0) {
+        memset(&id, 0, sizeof(id));
+        id.select =3D VIRTIO_INPUT_CFG_ID_DEVIDS;
+        id.size =3D sizeof(struct virtio_input_devids);
+        id.u.ids.bustype =3D cpu_to_le16(ids.bustype);
+        id.u.ids.vendor  =3D cpu_to_le16(ids.vendor);
+        id.u.ids.product =3D cpu_to_le16(ids.product);
+        id.u.ids.version =3D cpu_to_le16(ids.version);
+        g_array_append_val(vi.config, id);
+    }
+
+    vi_bits_config(&vi, EV_KEY, KEY_CNT);
+    vi_bits_config(&vi, EV_REL, REL_CNT);
+    vi_bits_config(&vi, EV_ABS, ABS_CNT);
+    vi_bits_config(&vi, EV_MSC, MSC_CNT);
+    vi_bits_config(&vi, EV_SW,  SW_CNT);
+    g_debug("config length: %u", vi.config->len);
+
+    if (opt_socket_path) {
+        int lsock =3D unix_sock_new(opt_socket_path);
+        fd =3D accept(lsock, NULL, NULL);
+        close(lsock);
+    } else {
+        fd =3D 3;
+    }
+    if (fd =3D=3D -1) {
+        g_printerr("Invalid socket");
+        exit(1);
+    }
+    vug_init(&vi.dev, fd, vi_panic, &vuiface);
+
+    loop =3D g_main_loop_new(NULL, FALSE);
+    g_main_loop_run(loop);
+    g_main_loop_unref(loop);
+
+    vug_deinit(&vi.dev);
+
+    return 0;
+}
diff --git a/Makefile b/Makefile
index e46f2b625a..1d4d9441b1 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ dummy :=3D $(call unnest-vars,, \
                 libvhost-user-obj-y \
                 vhost-user-scsi-obj-y \
                 vhost-user-blk-obj-y \
+                vhost-user-input-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -719,6 +720,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) li=
bvhost-user.a
 	$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 	$(call LINK, $^)
+vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a lib=
qemuutil.a
+	$(call LINK, $^)
=20
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.=
mak
 	$(call quiet-command,$(PYTHON) $< $@ \
diff --git a/Makefile.objs b/Makefile.objs
index 7a9828da28..b0f48d667c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -193,6 +193,7 @@ vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
 vhost-user-blk-obj-y =3D contrib/vhost-user-blk/
+vhost-user-input-obj-y =3D contrib/vhost-user-input/
=20
 ######################################################################
 trace-events-subdirs =3D
diff --git a/configure b/configure
index a8c4094c87..28aef55d06 100755
--- a/configure
+++ b/configure
@@ -5551,6 +5551,9 @@ if test "$want_tools" =3D "yes" ; then
   if [ "$ivshmem" =3D "yes" ]; then
     tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
+  if [ "$linux" =3D "yes" ] ; then
+    tools=3D"vhost-user-input\$(EXESUF) $tools"
+  fi
 fi
 if test "$softmmu" =3D yes ; then
   if test "$linux" =3D yes; then
diff --git a/contrib/vhost-user-input/Makefile.objs b/contrib/vhost-user-=
input/Makefile.objs
new file mode 100644
index 0000000000..b1fad90d51
--- /dev/null
+++ b/contrib/vhost-user-input/Makefile.objs
@@ -0,0 +1 @@
+vhost-user-input-obj-y =3D main.o
--=20
2.18.0.rc1
