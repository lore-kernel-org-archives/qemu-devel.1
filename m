Received: from eggs.gnu.org ([209.51.188.92]:60140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjZ2-00026T-AG
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjZ0-0005am-AF
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:06:32 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Feb 2019 15:03:01 +0100
Message-Id: <20190218140301.197408-11-sgarzare@redhat.com>
In-Reply-To: <20190218140301.197408-1-sgarzare@redhat.com>
References: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 10/10] tests/virtio-blk: add test for
 DISCARD command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>

If the DISCARD feature is enabled, we try this command in the
test_basic(), checking only the status returned by the request.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/virtio-blk-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index cfc560be46..0bdbee32ba 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -317,6 +317,33 @@ static void test_basic(QVirtioDevice *dev, QGuestAll=
ocator *alloc,
         guest_free(alloc, req_addr);
     }
=20
+    if (features & (1u << VIRTIO_BLK_F_DISCARD)) {
+        struct virtio_blk_discard_write_zeroes dwz_hdr;
+
+        req.type =3D VIRTIO_BLK_T_DISCARD;
+        req.data =3D (char *) &dwz_hdr;
+        dwz_hdr.sector =3D 0;
+        dwz_hdr.num_sectors =3D 1;
+        dwz_hdr.flags =3D 0;
+
+        virtio_blk_fix_dwz_hdr(dev, &dwz_hdr);
+
+        req_addr =3D virtio_blk_request(alloc, dev, &req, sizeof(dwz_hdr=
));
+
+        free_head =3D qvirtqueue_add(vq, req_addr, 16, false, true);
+        qvirtqueue_add(vq, req_addr + 16, sizeof(dwz_hdr), false, true);
+        qvirtqueue_add(vq, req_addr + 16 + sizeof(dwz_hdr), 1, true, fal=
se);
+
+        qvirtqueue_kick(dev, vq, free_head);
+
+        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+                               QVIRTIO_BLK_TIMEOUT_US);
+        status =3D readb(req_addr + 16 + sizeof(dwz_hdr));
+        g_assert_cmpint(status, =3D=3D, 0);
+
+        guest_free(alloc, req_addr);
+    }
+
     if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
         /* Write and read with 2 descriptor layout */
         /* Write request */
--=20
2.20.1
