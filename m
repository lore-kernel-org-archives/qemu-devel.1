Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRd-0000g4-1G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjRW-00040P-Kk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjRS-0003mC-Qn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:39 -0500
Date: Mon, 5 Nov 2018 13:17:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-34-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/33] vhost-scsi: prevent using uninitialized
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
