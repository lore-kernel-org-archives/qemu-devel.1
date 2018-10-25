Received: from eggs.gnu.org ([2001:4830:134:3::10]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTw0-0004nB-S4
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFTvu-0007WD-HZ
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:55:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFTvl-00076s-2V
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:55:25 -0400
Date: Wed, 24 Oct 2018 20:55:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181025005110.249256-29-mst@redhat.com>
References: <20181025005110.249256-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181025005110.249256-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 28/28] vhost-scsi: prevent using
 uninitialized vqs
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
