Received: from eggs.gnu.org ([209.51.188.92]:41326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQg-0005xU-QS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGMT-0003T7-4D
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:07:51 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:16 +0100
Message-Id: <20190220010232.18731-10-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/25] vhost-user: Express sizeof with size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

VHOST_USER_HDR_SIZE uses offsetof(), thus is an expression of type
size_t. Update the format string accordingly.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/virtio/vhost-user.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 564a31d12c..2eb7143d3d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -215,11 +215,12 @@ static int vhost_user_read(struct vhost_dev *dev, V=
hostUserMsg *msg)
     struct vhost_user *u =3D dev->opaque;
     CharBackend *chr =3D u->user->chr;
     uint8_t *p =3D (uint8_t *) msg;
-    int r, size =3D VHOST_USER_HDR_SIZE;
+    int r;
+    size_t size =3D VHOST_USER_HDR_SIZE;
=20
     r =3D qemu_chr_fe_read_all(chr, p, size);
     if (r !=3D size) {
-        error_report("Failed to read msg header. Read %d instead of %d."
+        error_report("Failed to read msg header. Read %d instead of %zu.=
"
                      " Original request %d.", r, size, msg->hdr.request)=
;
         goto fail;
     }
@@ -235,7 +236,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
     /* validate message size is sane */
     if (msg->hdr.size > VHOST_USER_PAYLOAD_SIZE) {
         error_report("Failed to read msg header."
-                " Size %d exceeds the maximum %zu.", msg->hdr.size,
+                " Size %u exceeds the maximum %zu.", msg->hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
         goto fail;
     }
@@ -246,7 +247,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
         r =3D qemu_chr_fe_read_all(chr, p, size);
         if (r !=3D size) {
             error_report("Failed to read msg payload."
-                         " Read %d instead of %d.", r, msg->hdr.size);
+                         " Read %d instead of %u.", r, msg->hdr.size);
             goto fail;
         }
     }
@@ -300,7 +301,8 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
 {
     struct vhost_user *u =3D dev->opaque;
     CharBackend *chr =3D u->user->chr;
-    int ret, size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
+    int ret;
+    size_t size =3D VHOST_USER_HDR_SIZE + msg->hdr.size;
=20
     /*
      * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
@@ -320,7 +322,7 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
     ret =3D qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
     if (ret !=3D size) {
         error_report("Failed to write msg."
-                     " Wrote %d instead of %d.", ret, size);
+                     " Wrote %d instead of %zu.", ret, size);
         return -1;
     }
=20
--=20
2.20.1
