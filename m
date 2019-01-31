Received: from eggs.gnu.org ([209.51.188.92]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE80-0004LM-8u
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpE7z-0007iL-KX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:19:44 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 31 Jan 2019 16:19:13 +0100
Message-Id: <20190131151914.164903-5-sgarzare@redhat.com>
In-Reply-To: <20190131151914.164903-1-sgarzare@redhat.com>
References: <20190131151914.164903-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] tests/virtio-blk: change assert on
 data_size in virtio_blk_request()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

The size of data in the virtio_blk_request must be a multiple
of 512 bytes for IN and OUT requests, or a multiple of the size
of struct virtio_blk_discard_write_zeroes for DISCARD and
WRITE_ZEROES requests.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/virtio-blk-test.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 04c608764b..0739498da7 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -144,7 +144,20 @@ static uint64_t virtio_blk_request(QGuestAllocator *=
alloc, QVirtioDevice *d,
     uint64_t addr;
     uint8_t status =3D 0xFF;
=20
-    g_assert_cmpuint(data_size % 512, =3D=3D, 0);
+    switch (req->type) {
+    case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT:
+        g_assert_cmpuint(data_size % 512, =3D=3D, 0);
+        break;
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES:
+        g_assert_cmpuint(data_size %
+                         sizeof(struct virtio_blk_discard_write_zeroes),=
 =3D=3D, 0);
+        break;
+    default:
+        g_assert_cmpuint(data_size, =3D=3D, 0);
+    }
+
     addr =3D guest_alloc(alloc, sizeof(*req) + data_size);
=20
     virtio_blk_fix_request(d, req);
--=20
2.20.1
