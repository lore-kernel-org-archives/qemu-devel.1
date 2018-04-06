Received: from eggs.gnu.org ([2001:4830:134:3::10]:36418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utu-0007zI-1e
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uts-0007qI-Pt
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:46 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Uts-0007oQ-IJ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id u189so4843790wmd.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:15 +0200
Message-Id: <1523034681-33787-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/20] virtio-serial: fix heapover-flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

Check device having the feature of VIRTIO_CONSOLE_F_EMERG_WRITE before
get config->emerg_wr. It is neccessary because sizeof(virtio_console_config)
is 8 byte if VirtIOSerial doesn't have the feature of
VIRTIO_CONSOLE_F_EMERG_WRITE(see virtio_serial_device_realize),
read/write emerg_wr will lead to heap-over-flow.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Message-Id: <20180328133435.20112-1-linzhecheng@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
