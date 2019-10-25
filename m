Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A06120578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtYmabqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A06120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwl2-0003b8-1h
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNwRC-0002DL-4s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006JO-U0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006DQ-LQ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEiJLaIDLLC4oXF/+Pb+mvROnN/JAAxO/m2hAhGux1s=;
 b=FtYmabqwfKlgEQiIQmuHMW1mhadgojGEK7HLQppHv8VDH8aGCYfPdF75pr+5+bPcb15pai
 7wNCYqc044w2OEDD2hfkv+rox/6PQs7JDGfGvDkOxDuOvldkKvDOIrn4x33Cjsr4mCYjkg
 UTc8VH5N8xd69113rueJKHSuUSpdvCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-p9oj9GvgPw6UY4RT7pZUvQ-1; Fri, 25 Oct 2019 06:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871C3107AD31
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:02:35 +0000 (UTC)
Received: from localhost (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 036B65C1B5;
 Fri, 25 Oct 2019 10:02:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 3/3] tests/vhost-user-fs-test: add vhost-user-fs test case
Date: Fri, 25 Oct 2019 12:01:52 +0200
Message-Id: <20191025100152.6638-4-stefanha@redhat.com>
In-Reply-To: <20191025100152.6638-1-stefanha@redhat.com>
References: <20191025100152.6638-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: p9oj9GvgPw6UY4RT7pZUvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test case for the vhost-user-fs device.  There are two
limitations:

1. This test only runs when invoked as root.  The virtiofsd vhost-user
   device backend currently requires root in order to maintain accurate
   file system ownership information (uid/gid).

2. Cross-endian is not supported because virtiofsd currently only
   supports same-endian configurations.

This test uses FUSE_INIT, FUSE_LOOKUP, FUSE_OPEN, FUSE_CREATE,
FUSE_READ, FUSE_WRITE, FUSE_RELEASE, and FUSE_FORGET messages to perform
basic sanity testing.

This test can be expanded on in the future to perform low-level
virtio-fs testing, including invalid FUSE messages that are hard to
generate from a real guest.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/Makefile.include     |   8 +-
 tests/libqos/virtio-fs.h   |  46 +++
 tests/libqos/virtio-fs.c   | 104 ++++++
 tests/vhost-user-fs-test.c | 660 +++++++++++++++++++++++++++++++++++++
 4 files changed, 816 insertions(+), 2 deletions(-)
 create mode 100644 tests/libqos/virtio-fs.h
 create mode 100644 tests/libqos/virtio-fs.c
 create mode 100644 tests/vhost-user-fs-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fde8a0c5ef..0472565d96 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -718,6 +718,7 @@ qos-test-obj-y +=3D tests/libqos/sdhci.o
 qos-test-obj-y +=3D tests/libqos/tpci200.o
 qos-test-obj-y +=3D tests/libqos/virtio.o
 qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
+qos-test-obj-$(CONFIG_VHOST_USER_FS) +=3D tests/libqos/virtio-fs.o
 qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
 qos-test-obj-y +=3D tests/libqos/virtio-blk.o
 qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
@@ -759,6 +760,7 @@ qos-test-obj-y +=3D tests/spapr-phb-test.o
 qos-test-obj-y +=3D tests/tmp105-test.o
 qos-test-obj-y +=3D tests/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
 qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/vhost-user-test.o $(chard=
ev-obj-y) $(test-io-obj-y)
+qos-test-obj-$(CONFIG_VHOST_USER_FS) +=3D tests/vhost-user-fs-test.o
 qos-test-obj-y +=3D tests/virtio-test.o
 qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/virtio-9p-test.o
 qos-test-obj-y +=3D tests/virtio-blk-test.o
@@ -907,7 +909,8 @@ endef
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/a=
ll $(check-qtest-y)
 =09$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
-=09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
+=09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
+=09  QTEST_VIRTIOFSD=3Dvirtiofsd$(EXESUF))
=20
 check-unit: $(check-unit-y)
 =09$(call do_test_human, $^)
@@ -920,7 +923,8 @@ check-speed: $(check-speed-y)
 $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qt=
est-%.tap: %-softmmu/all $(check-qtest-y)
 =09$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
-=09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
+=09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
+=09  QTEST_VIRTIOFSD=3Dvirtiofsd$(EXESUF))
=20
 check-report-unit.tap: $(check-unit-y)
 =09$(call do_test_tap,$^)
diff --git a/tests/libqos/virtio-fs.h b/tests/libqos/virtio-fs.h
new file mode 100644
index 0000000000..40289ba283
--- /dev/null
+++ b/tests/libqos/virtio-fs.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifer: GPL-2.0-or-later */
+/*
+ * libqos virtio-fs device driver
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ */
+
+#ifndef TESTS_LIBQOS_VIRTIO_FS_H
+#define TESTS_LIBQOS_VIRTIO_FS_H
+
+#include "libqos/virtio-pci.h"
+
+#define VIRTIO_FS_TAG "myfs"
+
+typedef struct {
+    QVirtioDevice *vdev;
+    QGuestAllocator *alloc;
+    QVirtQueue *hiprio_vq;
+    QVirtQueue *request_vq;
+    uint64_t unique_counter;
+} QVirtioFS;
+
+typedef struct {
+    QVirtioPCIDevice pci_vdev;
+    QVirtioFS vfs;
+} QVirtioFSPCI;
+
+typedef struct {
+    QOSGraphObject obj;
+    QVirtioFS vfs;
+} QVirtioFSDevice;
+
+static inline uint64_t virtio_fs_get_unique(QVirtioFS *vfs)
+{
+    /*
+     * Interrupt requests share the unique ID of the request, except the
+     * least-significant bit.
+     *
+     * Note that unique ID 0 is invalid so we increment right away.
+     */
+    vfs->unique_counter +=3D 2;
+
+    return vfs->unique_counter;
+}
+
+#endif /* TESTS_LIBQOS_VIRTIO_FS_H */
diff --git a/tests/libqos/virtio-fs.c b/tests/libqos/virtio-fs.c
new file mode 100644
index 0000000000..47f22d50b9
--- /dev/null
+++ b/tests/libqos/virtio-fs.c
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifer: GPL-2.0-or-later */
+/*
+ * libqos virtio-fs device driver
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/virtio_fs.h"
+#include "libqos/virtio-fs.h"
+
+static void virtio_fs_cleanup(QVirtioFS *vfs)
+{
+    QVirtioDevice *vdev =3D vfs->vdev;
+
+    qvirtqueue_cleanup(vdev->bus, vfs->hiprio_vq, vfs->alloc);
+    qvirtqueue_cleanup(vdev->bus, vfs->request_vq, vfs->alloc);
+    vfs->hiprio_vq =3D NULL;
+    vfs->request_vq =3D NULL;
+}
+
+static void virtio_fs_setup(QVirtioFS *vfs)
+{
+    QVirtioDevice *vdev =3D vfs->vdev;
+    uint64_t features;
+
+    features =3D qvirtio_get_features(vdev);
+    features &=3D ~(QVIRTIO_F_BAD_FEATURE |
+                  (1ull << VIRTIO_RING_F_EVENT_IDX));
+    qvirtio_set_features(vdev, features);
+
+    vfs->hiprio_vq =3D qvirtqueue_setup(vdev, vfs->alloc, 0);
+    vfs->request_vq =3D qvirtqueue_setup(vdev, vfs->alloc, 1);
+
+    qvirtio_set_driver_ok(vdev);
+}
+
+static void vhost_user_fs_pci_destructor(QOSGraphObject *obj)
+{
+    QVirtioFSPCI *vfs_pci =3D (QVirtioFSPCI *)obj;
+    QVirtioFS *vfs =3D &vfs_pci->vfs;
+
+    virtio_fs_cleanup(vfs);
+    qvirtio_pci_destructor(&vfs_pci->pci_vdev.obj);
+}
+
+static void vhost_user_fs_pci_start_hw(QOSGraphObject *obj)
+{
+    QVirtioFSPCI *vfs_pci =3D (QVirtioFSPCI *)obj;
+    QVirtioFS *vfs =3D &vfs_pci->vfs;
+
+    qvirtio_pci_start_hw(&vfs_pci->pci_vdev.obj);
+    virtio_fs_setup(vfs);
+}
+
+static void *vhost_user_fs_pci_get_driver(void *object, const char *interf=
ace)
+{
+    QVirtioFSPCI *vfs_pci =3D object;
+
+    if (g_strcmp0(interface, "virtio-fs") =3D=3D 0) {
+        return &vfs_pci->vfs;
+    }
+
+    fprintf(stderr, "%s not present in virtio-fs\n", interface);
+    g_assert_not_reached();
+}
+
+static void *vhost_user_fs_pci_create(void *pci_bus, QGuestAllocator *allo=
c, void *addr)
+{
+    QVirtioFSPCI *vfs_pci =3D g_new0(QVirtioFSPCI, 1);
+    QVirtioFS *vfs =3D &vfs_pci->vfs;
+    QOSGraphObject *obj =3D &vfs_pci->pci_vdev.obj;
+
+    virtio_pci_init(&vfs_pci->pci_vdev, pci_bus, addr);
+    vfs->vdev =3D &vfs_pci->pci_vdev.vdev;
+    vfs->alloc =3D alloc;
+
+    g_assert_cmphex(vfs->vdev->device_type, =3D=3D, VIRTIO_ID_FS);
+
+    obj->destructor =3D vhost_user_fs_pci_destructor;
+    obj->start_hw =3D vhost_user_fs_pci_start_hw;
+    obj->get_driver =3D vhost_user_fs_pci_get_driver;
+
+    return obj;
+}
+
+static void virtio_fs_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts =3D {
+        .extra_device_opts =3D "chardev=3Dchar-virtio-fs,addr=3D04.0,tag=
=3D" VIRTIO_FS_TAG,
+        .before_cmd_line =3D "-m 512M -object memory-backend-file,id=3Dmem=
,"
+            "size=3D512M,mem-path=3D/dev/shm,share=3Don -numa node,memdev=
=3Dmem",
+    };
+    QPCIAddress addr =3D {
+        .devfn =3D QPCI_DEVFN(4, 0),
+    };
+
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("vhost-user-fs-pci", vhost_user_fs_pci_create);
+    qos_node_consumes("vhost-user-fs-pci", "pci-bus", &opts);
+    qos_node_produces("vhost-user-fs-pci", "virtio-fs");
+}
+
+libqos_init(virtio_fs_register_nodes);
diff --git a/tests/vhost-user-fs-test.c b/tests/vhost-user-fs-test.c
new file mode 100644
index 0000000000..76394adee6
--- /dev/null
+++ b/tests/vhost-user-fs-test.c
@@ -0,0 +1,660 @@
+/* SPDX-License-Identifer: GPL-2.0-or-later */
+/*
+ * vhost-user-fs device test
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/iov.h"
+#include "standard-headers/linux/virtio_fs.h"
+#include "standard-headers/linux/fuse.h"
+#include "libqos/virtio-fs.h"
+#include "libqtest-single.h"
+
+#define TIMEOUT_US (30 * 1000 * 1000)
+
+#ifdef HOST_WORDS_BIGENDIAN
+static const bool host_is_big_endian =3D true;
+#else
+static const bool host_is_big_endian; /* false */
+#endif
+
+/*
+ * This macro skips tests when run in a cross-endian configuration.
+ * virtiofsd does not byte-swap FUSE messages and therefore does not suppo=
rt
+ * cross-endian.
+ */
+#define SKIP_TEST_IF_CROSS_ENDIAN() { \
+    if (host_is_big_endian !=3D qtest_big_endian(global_qtest)) { \
+        g_test_skip("cross-endian is not supported by virtiofsd yet"); \
+        return; \
+    } \
+}
+
+static char *socket_path;
+static char *shared_dir;
+
+static bool remove_dir_and_children(const char *path)
+{
+    GDir *dir;
+    const gchar *name;
+
+    dir =3D g_dir_open(path, 0, NULL);
+    if (!dir) {
+        return false;
+    }
+
+    while ((name =3D g_dir_read_name(dir)) !=3D NULL) {
+        g_autofree gchar *child =3D g_strdup_printf("%s/%s", path, name);
+
+        g_test_message("unlinking %s", child);
+
+        if (unlink(child) =3D=3D -1 && errno =3D=3D EISDIR) {
+            remove_dir_and_children(child);
+        }
+    }
+
+    g_dir_close(dir);
+
+    g_test_message("rmdir %s", path);
+    return rmdir(path) =3D=3D 0;
+}
+
+static void after_test(void *arg G_GNUC_UNUSED)
+{
+    unlink(socket_path);
+
+    remove_dir_and_children(shared_dir);
+
+    /*
+     * Both QEMU and virtiofsd need to be restarted after each test and th=
e
+     * shared directory will be recreated.  This ensures isolation between=
 test
+     * runs.
+     */
+    qos_invalidate_command_line();
+}
+
+/* Called on SIGABRT */
+static void abrt_handler(void *arg G_GNUC_UNUSED)
+{
+    after_test(NULL);
+}
+
+static int create_socket(const char *path)
+{
+    union {
+        struct sockaddr sa;
+        struct sockaddr_un un;
+    } sa;
+    int fd;
+
+    fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        g_test_message("socket failed (errno=3D%d)", errno);
+        abort();
+    }
+
+    unlink(path); /* in case it already exists */
+
+    sa.un.sun_family =3D AF_UNIX;
+    snprintf(sa.un.sun_path, sizeof(sa.un.sun_path), "%s", path);
+
+    if (bind(fd, &sa.sa, sizeof(sa.un)) < 0) {
+        g_test_message("bind failed (errno=3D%d)", errno);
+        abort();
+    }
+
+    if (listen(fd, 1) < 0) {
+        g_test_message("listen failed (errno=3D%d)", errno);
+        abort();
+    }
+
+    return fd;
+}
+
+static const char *qtest_virtiofsd(void)
+{
+    const char *virtiofsd_binary;
+
+    virtiofsd_binary =3D getenv("QTEST_VIRTIOFSD");
+    if (!virtiofsd_binary) {
+        fprintf(stderr, "Environment variable QTEST_VIRTIOFSD required\n")=
;
+        exit(1);
+    }
+
+    return virtiofsd_binary;
+}
+
+/* Launch virtiofsd before each test with an empty shared directory */
+static void *before_test(GString *cmd_line G_GNUC_UNUSED, void *arg)
+{
+    g_autofree char *command =3D NULL;
+    char *virtiofsd_path;
+    int fd;
+    pid_t pid;
+
+    fd =3D create_socket(socket_path);
+
+    if (mkdir(shared_dir, 0777) < 0) {
+        g_message("mkdir failed (errno=3D%d)", errno);
+        abort();
+    }
+
+    virtiofsd_path =3D realpath(qtest_virtiofsd(), NULL);
+    g_assert_nonnull(virtiofsd_path);
+
+    command =3D g_strdup_printf("exec %s --fd=3D%d -o source=3D%s",
+                              virtiofsd_path,
+                              fd,
+                              shared_dir);
+    free(virtiofsd_path);
+    g_test_message("starting virtiofsd: %s", command);
+
+    /* virtiofsd terminates when QEMU closes the vhost-user socket connect=
ion,
+     * so there is no need to kill it explicitly later on.
+     */
+    pid =3D fork();
+    g_assert_cmpint(pid, >=3D, 0);
+    if (pid =3D=3D 0) {
+        execlp("/bin/sh", "sh", "-c", command, NULL);
+        exit(1);
+    }
+
+    close(fd);
+
+    return arg;
+}
+
+/*
+ * Send scatter-gather lists on the request virtqueue and return the numbe=
r of
+ * bytes filled by the device.
+ *
+ * Note that in/out have opposite meanings in FUSE and VIRTIO.  This funct=
ion
+ * uses VIRTIO terminology (out - to device, in - from device).
+ */
+static uint32_t do_request(QVirtioFS *vfs, QTestState *qts,
+                           struct iovec *sg_out, unsigned out_num,
+                           struct iovec *sg_in, unsigned in_num)
+{
+    QVirtioDevice *dev =3D vfs->vdev;
+    QVirtQueue *vq =3D vfs->request_vq;
+    size_t out_bytes =3D iov_size(sg_out, out_num);
+    size_t in_bytes =3D iov_size(sg_in, in_num);
+    uint64_t out_addr;
+    uint64_t in_addr;
+    uint64_t addr;
+    uint32_t head =3D 0;
+    uint32_t nfilled;
+    unsigned i;
+
+    g_assert_cmpint(out_num, >, 0);
+    g_assert_cmpint(in_num, >, 0);
+
+    /* Add out buffers */
+    addr =3D out_addr =3D guest_alloc(vfs->alloc, out_bytes);
+    for (i =3D 0; i < out_num; i++) {
+        size_t len =3D sg_out[i].iov_len;
+        uint32_t desc_idx;
+        bool first =3D i =3D=3D 0;
+
+        qtest_memwrite(qts, addr, sg_out[i].iov_base, len);
+        desc_idx =3D qvirtqueue_add(qts, vq, addr, len, false, true);
+
+        if (first) {
+            head =3D desc_idx;
+        }
+
+        addr +=3D len;
+    }
+
+    /* Add in buffers */
+    addr =3D in_addr =3D guest_alloc(vfs->alloc, in_bytes);
+    for (i =3D 0; i < in_num; i++) {
+        size_t len =3D sg_in[i].iov_len;
+        bool next =3D i !=3D in_num - 1;
+
+        qvirtqueue_add(qts, vq, addr, len, true, next);
+
+        addr +=3D len;
+    }
+
+    /* Process the request */
+    qvirtqueue_kick(qts, dev, vq, head);
+    qvirtio_wait_used_elem(qts, dev, vq, head, &nfilled, TIMEOUT_US);
+
+    /* Copy in buffers back */
+    addr =3D in_addr;
+    for (i =3D 0; i < in_num; i++) {
+        size_t len =3D sg_in[i].iov_len;
+
+        qtest_memread(qts, addr, sg_in[i].iov_base, len);
+        addr +=3D len;
+    }
+
+    guest_free(vfs->alloc, in_addr);
+    guest_free(vfs->alloc, out_addr);
+
+    return nfilled;
+}
+
+/* Byte-swap values if host endianness differs from guest */
+static uint32_t guest32(uint32_t val)
+{
+    if (qtest_big_endian(global_qtest) !=3D host_is_big_endian) {
+        return bswap32(val);
+    }
+    return val;
+}
+
+static uint64_t guest64(uint64_t val)
+{
+    if (qtest_big_endian(global_qtest) !=3D host_is_big_endian) {
+        return bswap64(val);
+    }
+    return val;
+}
+
+/* Make a FUSE_INIT request */
+static void fuse_init(QVirtioFS *vfs)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_INIT),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+    };
+    struct fuse_init_in in =3D {
+        .major =3D guest32(FUSE_KERNEL_VERSION),
+        .minor =3D guest32(FUSE_KERNEL_MINOR_VERSION),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+    };
+    struct fuse_out_header out_hdr;
+    struct fuse_init_out out;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
+    };
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    g_assert_cmpint(guest32(out_hdr.error), =3D=3D, 0);
+    g_assert_cmpint(guest32(out.major), =3D=3D, FUSE_KERNEL_VERSION);
+}
+
+/* Look up a directory entry by name using FUSE_LOOKUP */
+static int32_t fuse_lookup(QVirtioFS *vfs, uint64_t parent, const char *na=
me,
+                           struct fuse_entry_out *entry)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_LOOKUP),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+        .nodeid =3D guest64(parent),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D (void *)name, .iov_len =3D strlen(name) + 1 },
+    };
+    struct fuse_out_header out_hdr;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D entry, .iov_len =3D sizeof(*entry) },
+    };
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    return guest32(out_hdr.error);
+}
+
+/* Open a file by nodeid using FUSE_OPEN */
+static int32_t fuse_open(QVirtioFS *vfs, uint64_t nodeid, uint32_t flags,
+                         uint64_t *fh)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_OPEN),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+        .nodeid =3D guest64(nodeid),
+    };
+    struct fuse_open_in in =3D {
+        .flags =3D guest32(flags),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+    };
+    struct fuse_out_header out_hdr;
+    struct fuse_open_out out;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
+    };
+    int32_t error;
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    error =3D guest32(out_hdr.error);
+    if (!error) {
+        *fh =3D guest64(out.fh);
+    } else {
+        *fh =3D 0;
+    }
+    return error;
+}
+
+/* Create a file using FUSE_CREATE */
+static int32_t fuse_create(QVirtioFS *vfs, uint64_t parent, const char *na=
me,
+                           uint32_t mode, uint32_t flags,
+                           uint64_t *nodeid, uint64_t *fh)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_CREATE),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+        .nodeid =3D guest64(parent),
+    };
+    struct fuse_create_in in =3D {
+        .flags =3D guest32(flags),
+        .mode =3D guest32(mode),
+        .umask =3D guest32(0002),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+        { .iov_base =3D (void *)name, .iov_len =3D strlen(name) + 1 },
+    };
+    struct fuse_out_header out_hdr;
+    struct fuse_entry_out entry;
+    struct fuse_open_out out;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D &entry, .iov_len =3D sizeof(entry) },
+        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
+    };
+    int32_t error;
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    error =3D guest32(out_hdr.error);
+    if (!error) {
+        *nodeid =3D guest64(entry.nodeid);
+        *fh =3D guest64(out.fh);
+    } else {
+        *nodeid =3D 0;
+        *fh =3D 0;
+    }
+    return error;
+}
+
+/* Read bytes from a file using FILE_READ */
+static ssize_t fuse_read(QVirtioFS *vfs, uint64_t fh, uint64_t offset,
+                         void *buf, size_t len)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_READ),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+    };
+    struct fuse_read_in in =3D {
+        .fh =3D guest64(fh),
+        .offset =3D guest64(offset),
+        .size =3D guest32(len),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+    };
+    struct fuse_out_header out_hdr;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D buf, .iov_len =3D len },
+    };
+    uint32_t nread;
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    nread =3D do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+                       sg_out, G_N_ELEMENTS(sg_out));
+    g_assert_cmpint(guest32(out_hdr.error), =3D=3D, 0);
+
+    return nread - sizeof(out_hdr);
+}
+
+/* Write bytes to a file using FILE_WRITE */
+static ssize_t fuse_write(QVirtioFS *vfs, uint64_t fh, uint64_t offset,
+                          const void *buf, size_t len)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_WRITE),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+    };
+    struct fuse_write_in in =3D {
+        .fh =3D guest64(fh),
+        .offset =3D guest64(offset),
+        .size =3D guest32(len),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+        { .iov_base =3D (void *)buf, .iov_len =3D len },
+    };
+    struct fuse_out_header out_hdr;
+    struct fuse_write_out out;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
+    };
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+    g_assert_cmpint(guest32(out_hdr.error), =3D=3D, 0);
+
+    return guest32(out.size);
+}
+
+/* Close a file handle using FUSE_RELEASE */
+static void fuse_release(QVirtioFS *vfs, uint64_t fh)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_RELEASE),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+    };
+    struct fuse_release_in in =3D {
+        .fh =3D guest64(fh),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+    };
+    struct fuse_out_header out_hdr;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+    };
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    g_assert_cmpint(guest32(out_hdr.error), =3D=3D, 0);
+}
+
+/* Drop an inode reference using FUSE_FORGET */
+static void fuse_forget(QVirtioFS *vfs, uint64_t nodeid)
+{
+    struct fuse_in_header in_hdr =3D {
+        .opcode =3D guest32(FUSE_FORGET),
+        .unique =3D guest64(virtio_fs_get_unique(vfs)),
+        .nodeid =3D guest64(nodeid),
+    };
+    struct fuse_forget_in in =3D {
+        .nlookup =3D guest64(1),
+    };
+    struct iovec sg_in[] =3D {
+        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
+        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
+    };
+    struct fuse_out_header out_hdr;
+    struct iovec sg_out[] =3D {
+        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
+    };
+
+    in_hdr.len =3D guest32(iov_size(sg_in, G_N_ELEMENTS(sg_in)));
+
+    do_request(vfs, global_qtest, sg_in, G_N_ELEMENTS(sg_in),
+               sg_out, G_N_ELEMENTS(sg_out));
+
+    g_assert_cmpint(guest32(out_hdr.error), =3D=3D, 0);
+}
+
+/* Check contents of VIRTIO Configuration Space */
+static void test_config(void *parent, void *arg, QGuestAllocator *alloc)
+{
+    QVirtioFS *vfs =3D parent;
+    size_t i;
+    uint32_t num_request_queues;
+    char tag[37];
+
+    SKIP_TEST_IF_CROSS_ENDIAN();
+
+    for (i =3D 0; i < sizeof(tag) - 1; i++) {
+        tag[i] =3D qvirtio_config_readw(vfs->vdev, i);
+    }
+    tag[36] =3D '\0';
+
+    g_assert_cmpstr(tag, =3D=3D, VIRTIO_FS_TAG);
+
+    num_request_queues =3D qvirtio_config_readl(vfs->vdev,
+            offsetof(struct virtio_fs_config, num_request_queues));
+
+    g_assert_cmpint(num_request_queues, =3D=3D, 1);
+}
+
+/* Create file on host and check its contents and metadata in guest */
+static void test_file_from_host(void *parent, void *arg, QGuestAllocator *=
alloc)
+{
+    g_autofree gchar *filename =3D g_strdup_printf("%s/%s", shared_dir, "f=
oo");
+    const char *str =3D "This is a test\n";
+    char buf[strlen(str)];
+    QVirtioFS *vfs =3D parent;
+    struct fuse_entry_out entry;
+    int32_t error;
+    uint64_t nodeid;
+    uint64_t fh;
+    ssize_t nread;
+    gboolean ok;
+
+    SKIP_TEST_IF_CROSS_ENDIAN();
+
+    /* Create the test file in the shared directory */
+    ok =3D g_file_set_contents(filename, str, strlen(str), NULL);
+    g_assert(ok);
+
+    fuse_init(vfs);
+
+    error =3D fuse_lookup(vfs, FUSE_ROOT_ID, "foo", &entry);
+    g_assert_cmpint(error, =3D=3D, 0);
+    g_assert_cmpint(guest64(entry.attr.size), =3D=3D, strlen(str));
+    nodeid =3D guest64(entry.nodeid);
+
+    error =3D fuse_open(vfs, nodeid, O_RDONLY, &fh);
+    g_assert_cmpint(error, =3D=3D, 0);
+
+    nread =3D fuse_read(vfs, fh, 0, buf, sizeof(buf));
+    g_assert_cmpint(nread, =3D=3D, sizeof(buf));
+    g_assert_cmpint(memcmp(buf, str, sizeof(buf)), =3D=3D, 0);
+
+    fuse_release(vfs, fh);
+    fuse_forget(vfs, nodeid);
+}
+
+/* Create file from host and check its contents and metadata on host */
+static void test_file_from_guest(void *parent, void *arg,
+                                 QGuestAllocator *alloc)
+{
+    g_autofree gchar *filename =3D g_strdup_printf("%s/%s", shared_dir, "f=
oo");
+    const char *str =3D "This is a test\n";
+    gchar *contents =3D NULL;
+    gsize length =3D 0;
+    QVirtioFS *vfs =3D parent;
+    int32_t error;
+    uint64_t nodeid;
+    uint64_t fh;
+    ssize_t nwritten;
+    gboolean ok;
+
+    SKIP_TEST_IF_CROSS_ENDIAN();
+
+    fuse_init(vfs);
+
+    error =3D fuse_create(vfs, FUSE_ROOT_ID, "foo", 0644, O_CREAT | O_WRON=
LY,
+                        &nodeid, &fh);
+    g_assert_cmpint(error, =3D=3D, 0);
+
+    nwritten =3D fuse_write(vfs, fh, 0, str, strlen(str));
+    g_assert_cmpint(nwritten, =3D=3D, strlen(str));
+
+    fuse_release(vfs, fh);
+    fuse_forget(vfs, nodeid);
+
+    /* Check the file on the host */
+    ok =3D g_file_get_contents(filename, &contents, &length, NULL);
+    g_assert(ok);
+    g_assert_cmpint(length, =3D=3D, strlen(str));
+    g_assert_cmpint(memcmp(contents, str, strlen(str)), =3D=3D, 0);
+    g_free(contents);
+}
+
+static void register_vhost_user_fs_test(void)
+{
+    g_autofree gchar *cmd_line =3D
+        g_strdup_printf("-chardev socket,id=3Dchar-virtio-fs,path=3D%s",
+                        socket_path);
+    QOSGraphTestOptions opts =3D {
+        .edge.before_cmd_line =3D cmd_line,
+        .before =3D before_test,
+        .after =3D after_test,
+    };
+
+    if (geteuid() !=3D 0) {
+        g_test_message("Skipping vhost-user-fs tests because root is "
+                       "required for virtiofsd");
+        return;
+    }
+
+    qtest_add_abrt_handler(abrt_handler, NULL);
+
+    qos_add_test("config", "virtio-fs", test_config, &opts);
+    qos_add_test("file-from-host", "virtio-fs", test_file_from_host, &opts=
);
+    qos_add_test("file-from-guest", "virtio-fs", test_file_from_guest, &op=
ts);
+}
+
+libqos_init(register_vhost_user_fs_test);
+
+static void __attribute__((constructor)) init_paths(void)
+{
+    socket_path =3D g_strdup_printf("/tmp/qtest-%d-vhost-fs.sock", getpid(=
));
+    shared_dir =3D g_strdup_printf("/tmp/qtest-%d-virtio-fs-dir", getpid()=
);
+}
+
+static void __attribute__((destructor)) destroy_paths(void)
+{
+    g_free(shared_dir);
+    shared_dir =3D NULL;
+
+    g_free(socket_path);
+    socket_path =3D NULL;
+}
--=20
2.21.0


