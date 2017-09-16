Received: from eggs.gnu.org ([2001:4830:134:3::10]:58301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1dt9ER-0007gJ-Ij
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 05:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1dt9EO-0003cY-Dk
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 05:17:47 -0400
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mol@pengutronix.de>) id 1dt9EO-0003bh-6x
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 05:17:44 -0400
From: Michael Olbrich <m.olbrich@pengutronix.de>
Date: Sat, 16 Sep 2017 11:16:11 +0200
Message-Id: <20170916091611.10241-1-m.olbrich@pengutronix.de>
Subject: [Qemu-devel] [PATCH] hw/sd: fix out-of-bounds check for multi block
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Olbrich <m.olbrich@pengutronix.de>

The current code checks if the next block exceeds the size of the card.
This generates an error while reading the last block of the card.
Do the out-of-bounds check when starting to read a new block to fix this.

This issue became visible with increased error checking in Linux 4.13.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 hw/sd/sd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff4db80..94ff52512c43 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
         break;
 
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0)
+        if (sd->data_offset == 0) {
+            if (sd->data_start + io_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                break;
+            }
             BLK_READ_BLOCK(sd->data_start, io_len);
+        }
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len) {
@@ -1812,11 +1817,6 @@ uint8_t sd_read_data(SDState *sd)
                     break;
                 }
             }
-
-            if (sd->data_start + io_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-                break;
-            }
         }
         break;
 
-- 
2.14.1
