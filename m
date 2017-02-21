Received: from eggs.gnu.org ([2001:4830:134:3::10]:55935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBEE-00015w-SL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBED-00043b-R8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBED-00043A-GF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:41 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABBE78048A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:30 +0400
Message-Id: <20170221141451.28305-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/30] tests: fix vhost-user-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqos/virtio-pci.h |  2 ++
 tests/libqos/virtio-pci.c |  6 ++++++
 tests/vhost-user-test.c   | 11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 38c54c63ea..0fab916cf8 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -34,6 +34,8 @@ extern const QVirtioBus qvirtio_pci;
 void qvirtio_pci_foreach(QPCIBus *bus, uint16_t device_type,
                 void (*func)(QVirtioDevice *d, void *data), void *data);
 QVirtioPCIDevice *qvirtio_pci_device_find(QPCIBus *bus, uint16_t device_=
type);
+void qvirtio_pci_device_free(QVirtioPCIDevice *dev);
+
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d);
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d);
=20
diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index d4bf841f23..456cccdc7b 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -27,6 +27,12 @@ typedef struct QVirtioPCIForeachData {
     void *user_data;
 } QVirtioPCIForeachData;
=20
+void qvirtio_pci_device_free(QVirtioPCIDevice *dev)
+{
+    g_free(dev->pdev);
+    g_free(dev);
+}
+
 static QVirtioPCIDevice *qpcidevice_to_qvirtiodevice(QPCIDevice *pdev)
 {
     QVirtioPCIDevice *vpcidev;
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 2c45c7b29f..a61896c32d 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -139,6 +139,7 @@ enum {
 };
=20
 typedef struct TestServer {
+    QPCIBus *bus;
     gchar *socket_path;
     gchar *mig_path;
     gchar *chr_name;
@@ -160,14 +161,13 @@ static const char *root;
=20
 static void init_virtio_dev(TestServer *s)
 {
-    QPCIBus *bus;
     QVirtioPCIDevice *dev;
     uint32_t features;
=20
-    bus =3D qpci_init_pc(NULL);
-    g_assert_nonnull(bus);
+    s->bus =3D qpci_init_pc(NULL);
+    g_assert_nonnull(s->bus);
=20
-    dev =3D qvirtio_pci_device_find(bus, VIRTIO_ID_NET);
+    dev =3D qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
     g_assert_nonnull(dev);
=20
     qvirtio_pci_device_enable(dev);
@@ -180,6 +180,7 @@ static void init_virtio_dev(TestServer *s)
     qvirtio_set_features(&dev->vdev, features);
=20
     qvirtio_set_driver_ok(&dev->vdev);
+    qvirtio_pci_device_free(dev);
 }
=20
 static void wait_for_fds(TestServer *s)
@@ -507,6 +508,8 @@ static gboolean _test_server_free(TestServer *server)
     g_free(server->mig_path);
=20
     g_free(server->chr_name);
+    qpci_free_pc(server->bus);
+
     g_free(server);
=20
     return FALSE;
--=20
2.11.0.295.gd7dffce1c.dirty
