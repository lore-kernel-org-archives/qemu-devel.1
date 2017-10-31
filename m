Received: from eggs.gnu.org ([2001:4830:134:3::10]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9RWR-0001d6-Ti
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 04:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9RWN-0006B9-7K
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 04:03:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1e9RWM-00066A-L4
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 04:03:39 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 31 Oct 2017 16:03:03 +0800
Message-ID: <20171031080303.15624-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] fix: unrealize virtio device if we fail to
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
Cc: mst@redhat.com, stefanha@redhat.com, linzhecheng <linzhecheng@huawei.com>

If we fail to hotplug virtio-blk device and then suspend
or shutdown VM, qemu is likely to crash.

Re-production steps:
1. Run VM named vm001
2. Create a virtio-blk.xml which contains wrong configurations:
<disk device="lun" rawio="yes" type="block">
  <driver cache="none" io="native" name="qemu" type="raw" />
  <source dev="/dev/mapper/11-dm" />
  <target bus="virtio" dev="vdx" />
</disk>
3. Run command : virsh attach-device vm001 virtio-blk.xml
error: Failed to attach device from blk-scsi.xml
error: internal error: unable to execute QEMU command 'device_add': Please set scsi=off for virtio-blk devices in order to use virtio 1.0
it means hotplug virtio-blk device failed.
4. Suspend or shutdown VM will leads to qemu crash

Problem happens in virtio_vmstate_change which is called by
vm_state_notify:
vdev’s parent_bus is NULL, so qdev_get_parent_bus(DEVICE(vdev)) will crash.
virtio_vmstate_change is added to the list vm_change_state_head at virtio_blk_device_realize(virtio_init),
but after hotplug virtio-blk failed, virtio_vmstate_change will not be removed from vm_change_state_head.
Adding unrealize function of virtio-blk device can solve this problem.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5884ce3480..ea532dc35f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2491,6 +2491,7 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
     virtio_bus_device_plugged(vdev, &err);
     if (err != NULL) {
         error_propagate(errp, err);
+        vdc->unrealize(dev, NULL);
         return;
     }
 
-- 
2.12.2.windows.2
