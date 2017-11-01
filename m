Received: from eggs.gnu.org ([2001:4830:134:3::10]:54379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGn-00065h-7W
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9nGl-0001MF-9U
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:17:01 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:43208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e9nGl-0001Ki-1t
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:16:59 -0400
Received: by mail-lf0-x241.google.com with SMTP id a16so1499697lfk.0
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 00:16:58 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Wed,  1 Nov 2017 08:16:40 +0100
Message-Id: <20171101071652.19375-2-frasse.iglesias@gmail.com>
In-Reply-To: <20171101071652.19375-1-frasse.iglesias@gmail.com>
References: <20171101071652.19375-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v6 01/13] m25p80: Add support for continuous
 read out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Add support for continuous read out of the RDSR and READ_FSR status
registers until the chip select is deasserted. This feature is supported
by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
Windbond, SST, Gigadevice, Eon and Macronix.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/block/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a2438b9..721ae1a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -423,6 +423,7 @@ typedef struct Flash {
     uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
     uint32_t len;
     uint32_t pos;
+    bool data_read_loop;
     uint8_t needed_bytes;
     uint8_t cmd_in_progress;
     uint32_t cur_addr;
@@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         s->pos = 0;
         s->len = 1;
+        s->data_read_loop = true;
         s->state = STATE_READING_DATA;
         break;
 
@@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         s->pos = 0;
         s->len = 1;
+        s->data_read_loop = true;
         s->state = STATE_READING_DATA;
         break;
 
@@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
         s->pos = 0;
         s->state = STATE_IDLE;
         flash_sync_dirty(s, -1);
+        s->data_read_loop = false;
     }
 
     DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
@@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
         s->pos++;
         if (s->pos == s->len) {
             s->pos = 0;
-            s->state = STATE_IDLE;
+            if (!s->data_read_loop) {
+                s->state = STATE_IDLE;
+            }
         }
         break;
 
@@ -1279,6 +1285,7 @@ static const VMStateDescription vmstate_m25p80 = {
         VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ),
         VMSTATE_UINT32(len, Flash),
         VMSTATE_UINT32(pos, Flash),
+        VMSTATE_BOOL(data_read_loop, Flash),
         VMSTATE_UINT8(needed_bytes, Flash),
         VMSTATE_UINT8(cmd_in_progress, Flash),
         VMSTATE_UINT32(cur_addr, Flash),
-- 
2.9.3
