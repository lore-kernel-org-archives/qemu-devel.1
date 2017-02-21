Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBF9-0001qN-7z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBF8-0004W1-7m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBF8-0004VY-28
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:16:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:43 +0400
Message-Id: <20170221141451.28305-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/30] tests: fix virtio-9p-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Spotted by ASAN.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 9556291567..43a1ad813f 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -80,7 +80,7 @@ static void qvirtio_9p_pci_stop(QVirtIO9P *v9p)
 {
     qvirtqueue_cleanup(v9p->dev->bus, v9p->vq, v9p->qs->alloc);
     qvirtio_pci_device_disable(container_of(v9p->dev, QVirtioPCIDevice, =
vdev));
-    g_free(v9p->dev);
+    qvirtio_pci_device_free((QVirtioPCIDevice *)v9p->dev);
     qvirtio_9p_stop(v9p);
 }
=20
--=20
2.11.0.295.gd7dffce1c.dirty
