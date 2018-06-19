Received: from eggs.gnu.org ([2001:4830:134:3::10]:55973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvJ-0004aM-2u
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvI-0005e9-Ai
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:53 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:36 +0300
Message-ID: <1529415820-7750-5-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/8] hw/ide/qdev: Always apply block
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
Cc: Ari Sundholm <ari@tuxera.com>, John Snow <jsnow@redhat.com>, "open
	list:IDE" <qemu-block@nongnu.org>

This allows the block driver to use the block configuration of the new
IDE device. One use for this information is to set request limits
using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/ide/qdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 573b022..65d862a 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -213,6 +213,8 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
         dev->serial = g_strdup(s->drive_serial_str);
     }
 
+    blkconf_apply_to_blkdrv(&dev->conf);
+
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
 }
-- 
2.7.4
