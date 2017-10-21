Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <francisco.iglesias@feimtech.se>) id 1e5wxu-0003jo-Oo
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <francisco.iglesias@feimtech.se>) id 1e5wxr-0005C7-L5
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:38 -0400
Received: from ec2-52-28-205-119.eu-central-1.compute.amazonaws.com
	([52.28.205.119]:57302
	helo=ip-172-31-28-221.eu-central-1.compute.internal)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <francisco.iglesias@feimtech.se>)
	id 1e5wxr-00057W-EM
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:35 -0400
From: Francisco Iglesias <francisco.iglesias@feimtech.se>
Date: Sat, 21 Oct 2017 16:35:10 +0200
Message-Id: <20171021143521.31685-2-francisco.iglesias@feimtech.se>
In-Reply-To: <20171021143521.31685-1-francisco.iglesias@feimtech.se>
References: <20171021143521.31685-1-francisco.iglesias@feimtech.se>
Subject: [Qemu-devel] [PATCH 01/12] m25p80: Add support for continuous read
 out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, francisco.iglesias@feimtech.se
Cc: edgari@xilinx.com, alistai@xilinx.com

Add support for continuous read out of the RDSR and READ_FSR status
registers until the chip select is deasserted.

Signed-off-by: Francisco Iglesias <francisco.iglesias@feimtech.se>
---
 hw/block/m25p80.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a2438b9..2971519 100644
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
 
-- 
2.9.3
