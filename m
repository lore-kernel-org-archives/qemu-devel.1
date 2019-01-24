Received: from eggs.gnu.org ([209.51.188.92]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmio4-0007aN-FB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmio3-0003dM-GC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:28:48 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 24 Jan 2019 18:23:23 +0100
Message-Id: <20190124172323.230296-3-sgarzare@redhat.com>
In-Reply-To: <20190124172323.230296-1-sgarzare@redhat.com>
References: <20190124172323.230296-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 2/2] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

If the WRITE_ZEROES feature is enabled, we check this
command in the test_basic().

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/virtio-blk-test.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 04c608764b..8cabbcb85a 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -231,6 +231,69 @@ static void test_basic(QVirtioDevice *dev, QGuestAll=
ocator *alloc,
=20
     guest_free(alloc, req_addr);
=20
+    if (features & (1u << VIRTIO_BLK_F_WRITE_ZEROES)) {
+        struct virtio_blk_discard_write_zeroes *dwz_hdr;
+        void *expected;
+
+        /*
+         * WRITE_ZEROES request on the same sector of previous test wher=
e
+         * we wrote "TEST".
+         */
+        req.type =3D VIRTIO_BLK_T_WRITE_ZEROES;
+        req.data =3D g_malloc0(512);
+        dwz_hdr =3D (struct virtio_blk_discard_write_zeroes *)req.data;
+        dwz_hdr->sector =3D 0;
+        dwz_hdr->num_sectors =3D 1;
+        dwz_hdr->flags =3D 0;
+
+        req_addr =3D virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head =3D qvirtqueue_add(vq, req_addr, 16, false, true);
+        qvirtqueue_add(vq, req_addr + 16, 512, false, true);
+        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+
+        qvirtqueue_kick(dev, vq, free_head);
+
+        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status =3D readb(req_addr + 528);
+        g_assert_cmpint(status, =3D=3D, 0);
+
+        guest_free(alloc, req_addr);
+
+        /* Read request to check if the sector contains all zeroes */
+        req.type =3D VIRTIO_BLK_T_IN;
+        req.ioprio =3D 1;
+        req.sector =3D 0;
+        req.data =3D g_malloc0(512);
+
+        req_addr =3D virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head =3D qvirtqueue_add(vq, req_addr, 16, false, true);
+        qvirtqueue_add(vq, req_addr + 16, 512, true, true);
+        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+
+        qvirtqueue_kick(dev, vq, free_head);
+
+        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status =3D readb(req_addr + 528);
+        g_assert_cmpint(status, =3D=3D, 0);
+
+        data =3D g_malloc(512);
+        expected =3D g_malloc0(512);
+        memread(req_addr + 16, data, 512);
+        g_assert_cmpmem(data, 512, expected, 512);
+        g_free(expected);
+        g_free(data);
+
+        guest_free(alloc, req_addr);
+    }
+
     if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
         /* Write and read with 2 descriptor layout */
         /* Write request */
--=20
2.20.1
