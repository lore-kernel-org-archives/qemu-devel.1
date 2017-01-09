Received: from eggs.gnu.org ([2001:4830:134:3::10]:37232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWS-0002Qp-Rg
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWR-00045z-GY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWR-00043I-8W
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:55 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWQ-0001Sk-Dd
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:54 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:43 +0000
Message-Id: <1483962824-29185-21-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/21] m25p80: don't let rogue SPI controllers
 cause buffer overruns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

In normal operation we should never attempt to put more
data into the data[] array than it can hold. However if the
SPI controller connected to us misbehaves then it can send
us a sequence of commands that attempt this. Since the
controller might be in the guest (if the hardware does SPI
via bit-banging), catch the possible overrun conditions and
reset the flash internal state, logging them as guest errors.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 20170107111631.24444-1-jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: rewrote commit message to be more exact about when
 this can happen]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e3c1166..4c5f8c3 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -28,6 +28,7 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 
 #ifndef M25P80_ERR_DEBUG
@@ -377,6 +378,8 @@ typedef enum {
     MAN_GENERIC,
 } Manufacturer;
 
+#define M25P80_INTERNAL_DATA_BUFFER_SZ 16
+
 typedef struct Flash {
     SSISlave parent_obj;
 
@@ -387,7 +390,7 @@ typedef struct Flash {
     int page_size;
 
     uint8_t state;
-    uint8_t data[16];
+    uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
     uint32_t len;
     uint32_t pos;
     uint8_t needed_bytes;
@@ -1115,6 +1118,17 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
 
     case STATE_COLLECTING_DATA:
     case STATE_COLLECTING_VAR_LEN_DATA:
+
+        if (s->len >= M25P80_INTERNAL_DATA_BUFFER_SZ) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Write overrun internal data buffer. "
+                          "SPI controller (QEMU emulator or guest driver) "
+                          "is misbehaving\n");
+            s->len = s->pos = 0;
+            s->state = STATE_IDLE;
+            break;
+        }
+
         s->data[s->len] = (uint8_t)tx;
         s->len++;
 
@@ -1124,6 +1138,17 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
         break;
 
     case STATE_READING_DATA:
+
+        if (s->pos >= M25P80_INTERNAL_DATA_BUFFER_SZ) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Read overrun internal data buffer. "
+                          "SPI controller (QEMU emulator or guest driver) "
+                          "is misbehaving\n");
+            s->len = s->pos = 0;
+            s->state = STATE_IDLE;
+            break;
+        }
+
         r = s->data[s->pos];
         s->pos++;
         if (s->pos == s->len) {
@@ -1196,7 +1221,7 @@ static const VMStateDescription vmstate_m25p80 = {
     .pre_save = m25p80_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(state, Flash),
-        VMSTATE_UINT8_ARRAY(data, Flash, 16),
+        VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ),
         VMSTATE_UINT32(len, Flash),
         VMSTATE_UINT32(pos, Flash),
         VMSTATE_UINT8(needed_bytes, Flash),
-- 
2.7.4
