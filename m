Received: from eggs.gnu.org ([2001:4830:134:3::10]:51757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JQ-0003MK-Vj
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008FA-K7
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:12 -0400
Received: from [185.30.24.106] (port=13502
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008C1-MQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:01 -0400
Date: Tue, 23 Oct 2018 19:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-29-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/28] vhost-scsi: prevent using uninitialized
 vqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, yuchenlin <yuchenlin@synology.com>, Forrest Liu <forrestl@synology.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

From: yuchenlin <yuchenlin@synology.com>

There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device,
but seabios will only set the physical address for the 3rd one (cmd).
Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr()
will be 0 for ctrl and event vq.

In this case, ctrl and event vq are not initialized.
vhost_verify_ring_mappings may use uninitialized vhost_virtqueue
such that vhost_verify_ring_part_mapping returns ENOMEM.

When encountered this problem, we got the following logs:

    qemu-system-x86_64: Unable to map available ring for ring 0
    qemu-system-x86_64: Verify ring failure on region 0

Signed-off-by: Forrest Liu <forrestl@synology.com>
Signed-off-by: yuchenlin <yuchenlin@synology.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index becf550085..7f21b4f9d6 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -183,7 +183,7 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
     }
=20
     vsc->dev.nvqs =3D VHOST_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
-    vsc->dev.vqs =3D g_new(struct vhost_virtqueue, vsc->dev.nvqs);
+    vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index =3D 0;
     vsc->dev.backend_features =3D 0;
=20
--=20
MST
