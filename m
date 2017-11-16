Received: from eggs.gnu.org ([2001:4830:134:3::10]:33559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFNDK-0005mv-KN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFNDJ-0000NJ-Mc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFNDJ-0000MY-Gi
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:40:29 -0500
Date: Thu, 16 Nov 2017 18:40:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510850407-17266-2-git-send-email-mst@redhat.com>
References: <1510850407-17266-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1510850407-17266-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] fix: unrealize virtio device if we fail to
 hotplug it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, linzhecheng <linzhecheng@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

If we fail to hotplug virtio-blk device and then suspend
or shutdown VM, qemu is likely to crash.

Re-production steps:
1. Run VM named vm001
2. Create a virtio-blk.xml which contains wrong configurations:
<disk device=3D"lun" rawio=3D"yes" type=3D"block">
  <driver cache=3D"none" io=3D"native" name=3D"qemu" type=3D"raw" />
  <source dev=3D"/dev/mapper/11-dm" />
  <target bus=3D"virtio" dev=3D"vdx" />
</disk>
3. Run command : virsh attach-device vm001 virtio-blk.xml
error: Failed to attach device from blk-scsi.xml
error: internal error: unable to execute QEMU command 'device_add': Pleas=
e set scsi=3Doff for virtio-blk devices in order to use virtio 1.0
it means hotplug virtio-blk device failed.
4. Suspend or shutdown VM will leads to qemu crash

Problem happens in virtio_vmstate_change which is called by
vm_state_notify:
vdev=E2=80=99s parent_bus is NULL, so qdev_get_parent_bus(DEVICE(vdev)) w=
ill crash.
virtio_vmstate_change is added to the list vm_change_state_head at virtio=
_blk_device_realize(virtio_init),
but after hotplug virtio-blk failed, virtio_vmstate_change will not be re=
moved from vm_change_state_head.
Adding unrealize function of virtio-blk device can solve this problem.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5884ce3..ea532dc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2491,6 +2491,7 @@ static void virtio_device_realize(DeviceState *dev,=
 Error **errp)
     virtio_bus_device_plugged(vdev, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
+        vdc->unrealize(dev, NULL);
         return;
     }
=20
--=20
MST
