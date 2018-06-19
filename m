Received: from eggs.gnu.org ([2001:4830:134:3::10]:55907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvH-0004YC-14
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvE-0005YX-IU
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:50 -0400
Received: from mx1.mpynet.fi ([82.197.21.84]:34709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1fVGvE-0005WM-AN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:48 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:35 +0300
Message-ID: <1529415820-7750-4-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 3/8] hw/scsi/scsi-disk: Always apply block
 configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

This allows the block driver to use the block configuration of the new
SCSI device. One use for this information is to set request limits
using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index aeaf611..c6efc4e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2412,6 +2412,7 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
         blk_set_dev_ops(s->qdev.conf.blk, &scsi_disk_block_ops, s);
     }
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
+    blkconf_apply_to_blkdrv(&s->qdev.conf);
 
     blk_iostatus_enable(s->qdev.conf.blk);
 }
-- 
2.7.4
