Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCP-00050d-VE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCM-0001hx-S3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCM-0001hZ-Ms
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hafC007039
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:02 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm612j4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:47:01 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:47:01 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:57 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-64-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 63/67] vhost-user-test: Use libqos instead of
 pxe-virtio.rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

vhost-user-test relies on iPXE just to initialize the virtio-net
device, and doesn't do any actual packet tx/rx testing.

In addition to that, the test relies on TCG, which is
imcompatible with vhost. The test only worked by accident: a bug
the memory backend initialization made memory regions not have
the DIRTY_MEMORY_CODE bit set in dirty_log_mask.

This changes vhost-user-test to initialize the virtio-net device
using libqos, and not use TCG nor pxe-virtio.rom.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit cdafe929615ec5eca71bcd5a3d12bab5678e5886)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/Makefile.include  |  2 +-
 tests/vhost-user-test.c | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 14be491..03382b5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -622,7 +622,7 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
-tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o qemu-char.o qemu-timer.o $(qtest-obj-y) $(test-io-obj-y)
+tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o qemu-char.o qemu-timer.o $(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 27b10c1..b89a551 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -16,8 +16,13 @@
 #include "qemu/sockets.h"
 #include "sysemu/char.h"
 #include "sysemu/sysemu.h"
+#include "libqos/libqos.h"
+#include "libqos/pci-pc.h"
+#include "libqos/virtio-pci.h"
 
 #include <linux/vhost.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_net.h>
 #include <sys/vfs.h>
 
 /* GLIB version compatibility flags */
@@ -29,14 +34,13 @@
 #define HAVE_MONOTONIC_TIME
 #endif
 
-#define QEMU_CMD_ACCEL  " -machine accel=tcg"
 #define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM,"\
                         "mem-path=%s,share=on -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=net0,chardev=%s,vhostforce"
-#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=net0,romfile=./pc-bios/pxe-virtio.rom"
+#define QEMU_CMD_NET    " -device virtio-net-pci,netdev=net0"
 
-#define QEMU_CMD        QEMU_CMD_ACCEL QEMU_CMD_MEM QEMU_CMD_CHR \
+#define QEMU_CMD        QEMU_CMD_MEM QEMU_CMD_CHR \
                         QEMU_CMD_NETDEV QEMU_CMD_NET
 
 #define HUGETLBFS_MAGIC       0x958458f6
@@ -136,6 +140,30 @@ typedef struct TestServer {
 static const char *tmpfs;
 static const char *root;
 
+static void init_virtio_dev(TestServer *s)
+{
+    QPCIBus *bus;
+    QVirtioPCIDevice *dev;
+    uint32_t features;
+
+    bus = qpci_init_pc();
+    g_assert_nonnull(bus);
+
+    dev = qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
+    g_assert_nonnull(dev);
+
+    qvirtio_pci_device_enable(dev);
+    qvirtio_reset(&qvirtio_pci, &dev->vdev);
+    qvirtio_set_acknowledge(&qvirtio_pci, &dev->vdev);
+    qvirtio_set_driver(&qvirtio_pci, &dev->vdev);
+
+    features = qvirtio_get_features(&qvirtio_pci, &dev->vdev);
+    features = features & VIRTIO_NET_F_MAC;
+    qvirtio_set_features(&qvirtio_pci, &dev->vdev, features);
+
+    qvirtio_set_driver_ok(&qvirtio_pci, &dev->vdev);
+}
+
 static void wait_for_fds(TestServer *s)
 {
     gint64 end_time;
@@ -548,6 +576,7 @@ static void test_migrate(void)
     from = qtest_start(cmd);
     g_free(cmd);
 
+    init_virtio_dev(s);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -662,6 +691,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
+    init_virtio_dev(s);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
@@ -728,6 +758,7 @@ int main(int argc, char **argv)
 
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
+    init_virtio_dev(server);
 
     qtest_add_data_func("/vhost-user/read-guest-mem", server, read_guest_mem);
     qtest_add_func("/vhost-user/migrate", test_migrate);
-- 
1.9.1
