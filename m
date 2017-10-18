Received: from eggs.gnu.org ([2001:4830:134:3::10]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyM-0003o2-KE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qyL-0002P1-OX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:34 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:56826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qyL-0002OY-IF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:33 -0400
Received: by mail-wm0-x234.google.com with SMTP id l68so11141825wmd.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:21 +0200
Message-Id: <1508343141-31835-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/29] scsi: reject configurations with logical
 block size > physical block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Kanda <mark.kanda@oracle.com>

From: Mark Kanda <mark.kanda@oracle.com>

Logical block size of a SCSI disk should never be larger than
physical block size. From an ATA/SCSI perspective, it makes no sense
to have the logical block size greater than the physical block size,
and it cannot even be effectively expressed in the command set. The
whole point of adding the physical block size to the ATA/SCSI command
set was to communicate a desire for a larger block size (than logical),
while maintaining backwards compatibility with legacy 512 byte block
size.

When setting logical_block_size > physical_block_size, QEMU cannot express
it in READ CAPACITY(16) output, and all it can do is set the physical
block exponent to 0 (i.e. logical_block_size == physical_block_size).
Reporting the error properly, however, is better.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Message-Id: <1508185024-5840-1-git-send-email-mark.kanda@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a518080..1243117 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2347,6 +2347,14 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 
     blkconf_serial(&s->qdev.conf, &s->serial);
     blkconf_blocksizes(&s->qdev.conf);
+
+    if (s->qdev.conf.logical_block_size >
+        s->qdev.conf.physical_block_size) {
+        error_setg(errp,
+                   "logical_block_size > physical_block_size not supported");
+        return;
+    }
+
     if (dev->type == TYPE_DISK) {
         blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, &err);
         if (err) {
-- 
1.8.3.1
