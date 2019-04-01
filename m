Received: from eggs.gnu.org ([209.51.188.92]:43035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47A-0003kn-7K
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB477-00051D-Tj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42812
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004oY-IG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4h3J183645
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rksyp8nqr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:45 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:38 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:32 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-59-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 58/97] vhost-scsi: prevent using uninitialized
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
Cc: qemu-stable@nongnu.org, yuchenlin <yuchenlin@synology.com>, Forrest Liu <forrestl@synology.com>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit e6cc11d64fc998c11a4dfcde8fda3fc33a74d844)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/vhost-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 9c1bea8ff3..a5eb2800a2 100644
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
2.17.1
