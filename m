Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f0jtw-0005OT-8K
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1f0jtr-0007ng-GF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:24:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2094 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1f0jtr-0007ls-4k
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:24:11 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 27 Mar 2018 16:23:34 +0800
Message-ID: <20180327082334.22948-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] virtio-serial: fix heap-over-flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, mst@redhat.com, pbonzini@redhat.com, wangxinxin.wang@huawei.com, xuding42@huawei.com, linzhecheng <linzhecheng@huawei.com>

Check device having the feature of VIRTIO_CONSOLE_F_EMERG_WRITE before
get config->emerg_wr. It is neccessary because sizeof(virtio_console_config)
is 8 byte if VirtIOSerial doesn't have the feature of
VIRTIO_CONSOLE_F_EMERG_WRITE(see virtio_serial_device_realize),
read/write emerg_wr will lead to heap-over-flow.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7be7..3695172f37 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -580,11 +580,12 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
     VirtIOSerial *vser = VIRTIO_SERIAL(vdev);
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
-    uint8_t emerg_wr_lo = le32_to_cpu(config->emerg_wr);
     VirtIOSerialPort *port = find_first_connected_console(vser);
     VirtIOSerialPortClass *vsc;
+    uint8_t emerg_wr_lo;
 
-    if (!config->emerg_wr) {
+    if (!virtio_has_feature(vser->host_features,
+        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
         return;
     }
     /* Make sure we don't misdetect an emergency write when the guest
@@ -594,6 +595,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
         return;
     }
     vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+    emerg_wr_lo = le32_to_cpu(config->emerg_wr);
     (void)vsc->have_data(port, &emerg_wr_lo, 1);
 }
 
-- 
2.12.2.windows.2
