Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq3-00073l-Aa
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq0-0000CG-67
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpz-0000Bq-Sb
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:24 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048JC5h053509
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:22 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ru1j5ar5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:22 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:20 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:41 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-8-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 07/13] tests: virtio-9p: code refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

This moves the test_share static and the QOSState into the QVirtIO9P
structure, and put PCI related code in functions with a _pci_ name.

This will avoid code duplication in future tests, and allow to add
support for non-PCI platforms.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 101 ++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index f458297f9ae1..727316086337 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -18,59 +18,49 @@
 #include "standard-headers/linux/virtio_pci.h"
 
 static const char mount_tag[] = "qtest";
-static char *test_share;
 
+typedef struct {
+    QVirtioDevice *dev;
+    QOSState *qs;
+    QVirtQueue *vq;
+    char *test_share;
+} QVirtIO9P;
 
-static QOSState *qvirtio_9p_start(void)
+static QVirtIO9P *qvirtio_9p_start(const char *driver)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-fsdev local,id=fsdev0,security_model=none,path=%s "
-                      "-device virtio-9p-pci,fsdev=fsdev0,mount_tag=%s";
+                      "-device %s,fsdev=fsdev0,mount_tag=%s";
+    QVirtIO9P *v9p = g_new0(QVirtIO9P, 1);
 
-    test_share = g_strdup("/tmp/qtest.XXXXXX");
-    g_assert_nonnull(mkdtemp(test_share));
+    v9p->test_share = g_strdup("/tmp/qtest.XXXXXX");
+    g_assert_nonnull(mkdtemp(v9p->test_share));
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        return qtest_pc_boot(cmd, test_share, mount_tag);
-    }
-    if (strcmp(arch, "ppc64") == 0) {
-        return qtest_spapr_boot(cmd, test_share, mount_tag);
+        v9p->qs = qtest_pc_boot(cmd, v9p->test_share, driver, mount_tag);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        v9p->qs = qtest_spapr_boot(cmd, v9p->test_share, driver, mount_tag);
+    } else {
+        g_printerr("virtio-9p tests are only available on x86 or ppc64\n");
+        exit(EXIT_FAILURE);
     }
 
-    g_printerr("virtio-9p tests are only available on x86 or ppc64\n");
-    exit(EXIT_FAILURE);
-}
-
-static void qvirtio_9p_stop(QOSState *qs)
-{
-    qtest_shutdown(qs);
-    rmdir(test_share);
-    g_free(test_share);
+    return v9p;
 }
 
-static void pci_nop(void)
+static void qvirtio_9p_stop(QVirtIO9P *v9p)
 {
-    QOSState *qs;
-
-    qs = qvirtio_9p_start();
-    qvirtio_9p_stop(qs);
+    qtest_shutdown(v9p->qs);
+    rmdir(v9p->test_share);
+    g_free(v9p->test_share);
+    g_free(v9p);
 }
 
-typedef struct {
-    QVirtioDevice *dev;
-    QOSState *qs;
-    QVirtQueue *vq;
-} QVirtIO9P;
-
-static QVirtIO9P *qvirtio_9p_pci_init(QOSState *qs)
+static QVirtIO9P *qvirtio_9p_pci_start(void)
 {
-    QVirtIO9P *v9p;
-    QVirtioPCIDevice *dev;
-
-    v9p = g_new0(QVirtIO9P, 1);
-
-    v9p->qs = qs;
-    dev = qvirtio_pci_device_find(v9p->qs->pcibus, VIRTIO_ID_9P);
+    QVirtIO9P *v9p = qvirtio_9p_start("virtio-9p-pci");
+    QVirtioPCIDevice *dev = qvirtio_pci_device_find(v9p->qs->pcibus,
+                                                    VIRTIO_ID_9P);
     g_assert_nonnull(dev);
     g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_9P);
     v9p->dev = (QVirtioDevice *) dev;
@@ -84,26 +74,20 @@ static QVirtIO9P *qvirtio_9p_pci_init(QOSState *qs)
     return v9p;
 }
 
-static void qvirtio_9p_pci_free(QVirtIO9P *v9p)
+static void qvirtio_9p_pci_stop(QVirtIO9P *v9p)
 {
     qvirtqueue_cleanup(v9p->dev->bus, v9p->vq, v9p->qs->alloc);
     qvirtio_pci_device_disable(container_of(v9p->dev, QVirtioPCIDevice, vdev));
     g_free(v9p->dev);
-    g_free(v9p);
+    qvirtio_9p_stop(v9p);
 }
 
-static void pci_config(void)
+static void pci_config(QVirtIO9P *v9p)
 {
-    QVirtIO9P *v9p;
-    size_t tag_len;
+    size_t tag_len = qvirtio_config_readw(v9p->dev, 0);
     char *tag;
     int i;
-    QOSState *qs;
-
-    qs = qvirtio_9p_start();
-    v9p = qvirtio_9p_pci_init(qs);
 
-    tag_len = qvirtio_config_readw(v9p->dev, 0);
     g_assert_cmpint(tag_len, ==, strlen(mount_tag));
 
     tag = g_malloc(tag_len);
@@ -112,16 +96,31 @@ static void pci_config(void)
     }
     g_assert_cmpmem(tag, tag_len, mount_tag, tag_len);
     g_free(tag);
+}
+
+typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
+
+static void v9fs_run_pci_test(gconstpointer data)
+{
+    v9fs_test_fn fn = data;
+    QVirtIO9P *v9p = qvirtio_9p_pci_start();
 
-    qvirtio_9p_pci_free(v9p);
-    qvirtio_9p_stop(qs);
+    if (fn) {
+        fn(v9p);
+    }
+    qvirtio_9p_pci_stop(v9p);
+}
+
+static void v9fs_qtest_pci_add(const char *path, v9fs_test_fn fn)
+{
+    qtest_add_data_func(path, fn, v9fs_run_pci_test);
 }
 
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/virtio/9p/pci/nop", pci_nop);
-    qtest_add_func("/virtio/9p/pci/config", pci_config);
+    v9fs_qtest_pci_add("/virtio/9p/pci/nop", NULL);
+    v9fs_qtest_pci_add("/virtio/9p/pci/config", pci_config);
 
     return g_test_run();
 }
-- 
2.7.4
