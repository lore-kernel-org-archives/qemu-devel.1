Received: from eggs.gnu.org ([2001:4830:134:3::10]:49395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY68-0005HK-5e
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY63-00067C-KR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50540 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddY63-00065N-DG
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:39 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri,  4 Aug 2017 10:36:33 +0200
Message-Id: <1501835795-92331-3-git-send-email-hare@suse.de>
In-Reply-To: <1501835795-92331-1-git-send-email-hare@suse.de>
References: <1501835795-92331-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCHv2 2/4] scsi: use qemu_uuid to generate logical
 identifier for SES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

The SES enclosure descriptor requires a logical identifier,
so generate one using the qemu_uuid and the Qumranet OUI.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c89e82d..8419c75 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -10,6 +10,7 @@
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
+#include "qemu/crc32c.h"
 
 static char *scsibus_get_dev_path(DeviceState *dev);
 static char *scsibus_get_fw_dev_path(DeviceState *dev);
@@ -533,6 +534,22 @@ static bool scsi_target_emulate_receive_diagnostic(SCSITargetReq *r)
         enc_desc[0] = 0x09;
         enc_desc[2] = 1;
         enc_desc[3] = 0x24;
+        if (qemu_uuid_set) {
+            uint32_t crc;
+
+            /*
+             * Make this a NAA IEEE Registered identifier
+             * using Qumranet OUI (0x001A4A) and the
+             * crc32 from the system UUID.
+             */
+            enc_desc[4] = 0x50;
+            enc_desc[5] = 0x01;
+            enc_desc[6] = 0xa4;
+            enc_desc[7] = 0xa0;
+            crc = crc32c(0xffffffff, qemu_uuid.data, 16);
+            cpu_to_le32s(&crc);
+            memcpy(&enc_desc[8], &crc, 4);
+        }
         memcpy(&enc_desc[12], "QEMU    ", 8);
         memcpy(&enc_desc[20], "QEMU TARGET     ", 16);
         pstrcpy((char *)&enc_desc[36], 4, qemu_hw_version());
-- 
1.8.5.6
