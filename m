Received: from eggs.gnu.org ([2001:4830:134:3::10]:48311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5u-0003L8-Fx
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5t-0005Je-RO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:54 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 7 Jun 2018 17:40:27 +0300
Message-ID: <1528382429-13478-10-git-send-email-ari@tuxera.com>
In-Reply-To: <1528382429-13478-1-git-send-email-ari@tuxera.com>
References: <1528382429-13478-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 08/10] hw/block/fdc: Always apply block
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
Cc: Ari Sundholm <ari@tuxera.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

This allows the block driver to use the block configuration of the new
floppy device. One use for this information is to set request limits
using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/block/fdc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index cd29e27..b11eeda 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -482,6 +482,8 @@ static void fd_change_cb(void *opaque, bool load, Error **errp)
                                            errp)) {
             return;
         }
+
+        blkconf_apply_to_blkdrv(drive->conf);
     }
 
     drive->media_changed = 1;
@@ -594,6 +596,8 @@ static void floppy_drive_realize(DeviceState *qdev, Error **errp)
     pick_drive_type(drive);
     dev->type = drive->drive;
 
+    blkconf_apply_to_blkdrv(&dev->conf);
+
     fd_revalidate(drive);
 }
 
-- 
2.7.4
