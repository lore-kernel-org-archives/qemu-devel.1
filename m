Received: from eggs.gnu.org ([2001:4830:134:3::10]:57762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshc-0005M0-Hn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshb-0002iL-HZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:28 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshb-0002ha-BZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:27 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o8so2597588wra.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:14 +0100
Message-Id: <20180313224719.4954-5-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/69] scsi-disk.c: consider bl->max_transfer in
 INQUIRY emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

The calculation of the max_transfer atribute of BlockDriverState
makes considerations such as max_segments and transfer_length via
the BLKSECTGET ioctl (if available).

However, bl->max_transfer isn't considered when emulating the INQUIRY
'Block Limit' response to the scsi-hd devices. This leads to situations
where the declared max_sectors from the INQUIRY response is inconsistent
with the block limits, which isn't ideal. It can also be misleading to the
user that sets /sys/block/<dev>/queue/max_sectors_kb to a certain
value, then finds a different value in the guest OS for the same disk.

Following the same logic scsi_read_complete from scsi-generic.c does
when patching the response of the Block Limits VPD back to the guest,
change the max_io_sectors value of the emulated Block Limits VPD
response by considering the blk_get_max_transfer of the related
BlockDriverState. Use MIN_NOT_ZERO to be sure that the minimal
value is chosen.

Given that we're changing max_io_sectors, consider that min_io_sectors
and opt_io_sectors can't be greater than the new calculated value.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180306154411.18462-1-danielhb@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 49d2559d93..c65c1ce56d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -704,6 +704,21 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
                         page_code);
                 return -1;
             }
+            if (s->qdev.type == TYPE_DISK) {
+                int max_transfer_blk = blk_get_max_transfer(s->qdev.conf.blk);
+                int max_io_sectors_blk =
+                    max_transfer_blk / s->qdev.blocksize;
+
+                max_io_sectors =
+                    MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
+
+                /* min_io_size and opt_io_size can't be greater than
+                 * max_io_sectors */
+                min_io_size =
+                    MIN_NON_ZERO(min_io_size, max_io_sectors);
+                opt_io_size =
+                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
+            }
             /* required VPD size with unmap support */
             buflen = 0x40;
             memset(outbuf + 4, 0, buflen - 4);
-- 
2.14.3
