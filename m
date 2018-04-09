Received: from eggs.gnu.org ([2001:4830:134:3::10]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzt-00063b-17
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f5Xzr-000860-Tc
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f5Xzr-00085l-Oh
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:42:15 -0400
Date: Mon, 9 Apr 2018 17:42:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1523284856-251254-6-git-send-email-mst@redhat.com>
References: <1523284856-251254-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284856-251254-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] virtio-serial: fix heap-over-flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, linzhecheng <linzhecheng@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

Check device having the feature of VIRTIO_CONSOLE_F_EMERG_WRITE before
get config->emerg_wr. It is neccessary because sizeof(virtio_console_config)
is 8 byte if VirtIOSerial doesn't have the feature of
VIRTIO_CONSOLE_F_EMERG_WRITE(see virtio_serial_device_realize),
read/write emerg_wr will lead to heap-over-flow.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/char/virtio-serial-bus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..d2dd8ab 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -580,13 +580,16 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
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
+
+    emerg_wr_lo = le32_to_cpu(config->emerg_wr);
     /* Make sure we don't misdetect an emergency write when the guest
      * does a short config write after an emergency write. */
     config->emerg_wr = 0;
-- 
MST
