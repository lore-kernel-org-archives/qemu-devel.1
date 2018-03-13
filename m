Received: from eggs.gnu.org ([2001:4830:134:3::10]:57991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshx-0005e4-3r
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsht-00037J-Fo
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsht-000368-8O
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id k3so2529725wrg.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:45 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:28 +0100
Message-Id: <20180313224719.4954-19-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/69] scsi: support NDOB (no data-out buffer)
 for WRITE SAME commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A NDOB bit set to one specifies that the disk shall not transfer data
from the data-out buffer and shall process the command as if the data-out
buffer contained user data set to all zeroes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c       | 2 +-
 hw/scsi/scsi-disk.c      | 2 +-
 tests/virtio-scsi-test.c | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1eaeffc830..9646743a7d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -944,7 +944,7 @@ static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
         break;
     case WRITE_SAME_10:
     case WRITE_SAME_16:
-        cmd->xfer = dev->blocksize;
+        cmd->xfer = buf[1] & 1 ? 0 : dev->blocksize;
         break;
     case READ_CAPACITY_10:
         cmd->xfer = 8;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index c65c1ce56d..5b7a48f5a5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1807,7 +1807,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
-    if (buffer_is_zero(inbuf, s->qdev.blocksize)) {
+    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, s->qdev.blocksize)) {
         int flags = (req->cmd.buf[1] & 0x8) ? BDRV_REQ_MAY_UNMAP : 0;
 
         /* The request is used as the AIO opaque value, so add a ref.  */
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 7393d69bb2..037872bb98 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -216,6 +216,9 @@ static void test_unaligned_write_same(void)
     const uint8_t write_same_cdb_2[VIRTIO_SCSI_CDB_SIZE] = {
         0x41, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x33, 0x00, 0x00
     };
+    const uint8_t write_same_cdb_ndob[VIRTIO_SCSI_CDB_SIZE] = {
+        0x41, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x33, 0x00, 0x00
+    };
 
     vs = qvirtio_scsi_pci_init(PCI_SLOT);
 
@@ -225,6 +228,9 @@ static void test_unaligned_write_same(void)
     g_assert_cmphex(0, ==,
         virtio_scsi_do_command(vs, write_same_cdb_2, NULL, 0, buf2, 512, NULL));
 
+    g_assert_cmphex(0, ==,
+        virtio_scsi_do_command(vs, write_same_cdb_ndob, NULL, 0, NULL, 0, NULL));
+
     qvirtio_scsi_pci_free(vs);
 }
 
-- 
2.14.3
