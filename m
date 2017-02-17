Received: from eggs.gnu.org ([2001:4830:134:3::10]:44216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc4-0004H1-Cr
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc1-0005gl-JA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:40 -0500
Received: from mail.kernel.org ([198.145.29.136]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceoc1-0005gH-Br
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:37 -0500
Date: Fri, 17 Feb 2017 21:54:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-12-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/23] virtio: check for vring setup in
 virtio_queue_update_used_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

If the vring has not been set up, it is not necessary for vring_used_idx
to do anything (as is already the case when the caller is virtio_load).
This is harmless for now, but it will be a problem when the
MemoryRegionCache has not been set up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d62509d..cdafcec 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2156,7 +2156,9 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *=
vdev, int n, uint16_t idx)
=20
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
-    vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
+    if (vdev->vq[n].vring.desc) {
+        vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
+    }
 }
=20
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
--=20
MST
