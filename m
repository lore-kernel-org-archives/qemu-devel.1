Received: from eggs.gnu.org ([209.51.188.92]:55717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwlgX-0007xF-CZ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwlgV-0004Vf-Df
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 05:34:33 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 21 Feb 2019 11:33:12 +0100
Message-Id: <20190221103314.58500-9-sgarzare@redhat.com>
In-Reply-To: <20190221103314.58500-1-sgarzare@redhat.com>
References: <20190221103314.58500-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 08/10] tests/virtio-blk: add
 virtio_blk_fix_dwz_hdr() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>

This function is useful to fix the endianness of struct
virtio_blk_discard_write_zeroes headers.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/virtio-blk-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0739498da7..85b6b99adc 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -46,6 +46,12 @@ typedef struct QVirtioBlkReq {
     uint8_t status;
 } QVirtioBlkReq;
=20
+#ifdef HOST_WORDS_BIGENDIAN
+const bool host_is_big_endian =3D true;
+#else
+const bool host_is_big_endian; /* false */
+#endif
+
 static char *drive_create(void)
 {
     int fd, ret;
@@ -125,12 +131,6 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus=
 *bus, int slot)
=20
 static inline void virtio_blk_fix_request(QVirtioDevice *d, QVirtioBlkRe=
q *req)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    const bool host_is_big_endian =3D true;
-#else
-    const bool host_is_big_endian =3D false;
-#endif
-
     if (qvirtio_is_big_endian(d) !=3D host_is_big_endian) {
         req->type =3D bswap32(req->type);
         req->ioprio =3D bswap32(req->ioprio);
@@ -138,6 +138,17 @@ static inline void virtio_blk_fix_request(QVirtioDev=
ice *d, QVirtioBlkReq *req)
     }
 }
=20
+
+static inline void virtio_blk_fix_dwz_hdr(QVirtioDevice *d,
+    struct virtio_blk_discard_write_zeroes *dwz_hdr)
+{
+    if (qvirtio_is_big_endian(d) !=3D host_is_big_endian) {
+        dwz_hdr->sector =3D bswap64(dwz_hdr->sector);
+        dwz_hdr->num_sectors =3D bswap32(dwz_hdr->num_sectors);
+        dwz_hdr->flags =3D bswap32(dwz_hdr->flags);
+    }
+}
+
 static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice=
 *d,
                                    QVirtioBlkReq *req, uint64_t data_siz=
e)
 {
--=20
2.20.1
