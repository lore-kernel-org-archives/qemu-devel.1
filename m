Received: from eggs.gnu.org ([2001:4830:134:3::10]:48900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWH-0002Nn-4i
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWG-0006Zv-3k
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWF-0006Ze-Tz
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:16 -0400
Date: Sun, 15 Oct 2017 06:23:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-11-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/26] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Felipe Franciosi <felipe@nutanix.com>, Jason Wang <jasowang@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Felipe Franciosi <felipe@nutanix.com>

vhost_log_put() is called to decomission the dirty log between qemu and
a vhost device when stopping the device. Such a call can happen from
migration_completion().

Present code sets dev->log_size to zero too early in vhost_log_put(),
causing the sync check to always return false. As a consequence, the
last pass on the dirty bitmap never happens at the end of migration.

If a vhost device was busy (writing to guest memory) until the last
moments before vhost_virtqueue_stop(), this error will result in guest
memory corruption (at least) following migrations.

Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5fd69f0..ddc42f0 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -375,8 +375,6 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
     if (!log) {
         return;
     }
-    dev->log =3D NULL;
-    dev->log_size =3D 0;
=20
     --log->refcnt;
     if (log->refcnt =3D=3D 0) {
@@ -396,6 +394,9 @@ static void vhost_log_put(struct vhost_dev *dev, bool=
 sync)
=20
         g_free(log);
     }
+
+    dev->log =3D NULL;
+    dev->log_size =3D 0;
 }
=20
 static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
--=20
MST
