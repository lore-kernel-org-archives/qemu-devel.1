Received: from eggs.gnu.org ([2001:4830:134:3::10]:51405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWV-0004cT-85
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWT-0007dA-Of
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWT-0007XQ-HB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:49 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWN-0007Yo-2W
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:11:59 +0000
Message-Id: <1513188761-20784-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/43] m25p80: Add support for continuous read
 out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Add support for continuous read out of the RDSR and READ_FSR status
registers until the chip select is deasserted. This feature is supported
by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
Windbond, SST, Gigadevice, Eon and Macronix.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński<mar.krzeminski@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-2-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a2438b9..d50acc1 100644
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
 
@@ -1269,11 +1275,38 @@ static Property m25p80_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static int m25p80_pre_load(void *opaque)
+{
+    Flash *s = (Flash *)opaque;
+
+    s->data_read_loop = false;
+    return 0;
+}
+
+static bool m25p80_data_read_loop_needed(void *opaque)
+{
+    Flash *s = (Flash *)opaque;
+
+    return s->data_read_loop;
+}
+
+static const VMStateDescription vmstate_m25p80_data_read_loop = {
+    .name = "m25p80/data_read_loop",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = m25p80_data_read_loop_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(data_read_loop, Flash),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m25p80 = {
     .name = "m25p80",
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_save = m25p80_pre_save,
+    .pre_load = m25p80_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(state, Flash),
         VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ),
@@ -1295,6 +1328,10 @@ static const VMStateDescription vmstate_m25p80 = {
         VMSTATE_UINT8(spansion_cr3nv, Flash),
         VMSTATE_UINT8(spansion_cr4nv, Flash),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_m25p80_data_read_loop,
+        NULL
     }
 };
 
-- 
2.7.4
