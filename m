Received: from eggs.gnu.org ([2001:4830:134:3::10]:46842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1dtARp-0004IF-6O
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 06:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mol@pengutronix.de>) id 1dtARn-0005sR-V2
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 06:35:41 -0400
Received: from metis.ext.pengutronix.de
	([2001:67c:670:201:290:27ff:fe1d:cc33]:39857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mol@pengutronix.de>) id 1dtARn-0005rh-MC
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 06:35:39 -0400
From: Michael Olbrich <m.olbrich@pengutronix.de>
Date: Sat, 16 Sep 2017 12:35:23 +0200
Message-Id: <20170916103523.1482-1-m.olbrich@pengutronix.de>
In-Reply-To: <150555367996.36.15771330325496067998@69b6ddf88678>
References: <150555367996.36.15771330325496067998@69b6ddf88678>
Subject: [Qemu-devel] [PATCH v2] hw/sd: fix out-of-bounds check for multi
 block reads
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

Changes in v2:
 - fixed warning

I'm not quite sure if 0x00 is the correct return value, but it's used
elsewhere in the same function when an error occurs, so it seems
reasonable.

 hw/sd/sd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff4db80..35347a5bbcde 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
         break;
 
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0)
+        if (sd->data_offset == 0) {
+            if (sd->data_start + io_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return 0x00;
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
