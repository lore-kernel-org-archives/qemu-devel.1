Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOWSM-0007sl-QD
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOWSI-00045K-Rf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:17:18 -0500
Received: from relay6-d.mail.gandi.net ([2001:4b98:c:538::198]:56506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cOWSI-000458-LW
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 16:17:14 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Tue,  3 Jan 2017 22:17:05 +0100
Message-Id: <20170103211705.27876-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the internal
 data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mar.krzeminski@gmail.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/block/m25p80.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d29ff4c..6c374cf 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -28,6 +28,7 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 
 #ifndef M25P80_ERR_DEBUG
@@ -376,6 +377,8 @@ typedef enum {
     MAN_GENERIC,
 } Manufacturer;
 
+#define _INTERNAL_DATA_SIZE 16
+
 typedef struct Flash {
     SSISlave parent_obj;
 
@@ -386,7 +389,7 @@ typedef struct Flash {
     int page_size;
 
     uint8_t state;
-    uint8_t data[16];
+    uint8_t data[_INTERNAL_DATA_SIZE];
     uint32_t len;
     uint32_t pos;
     uint8_t needed_bytes;
@@ -1114,6 +1117,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
 
     case STATE_COLLECTING_DATA:
     case STATE_COLLECTING_VAR_LEN_DATA:
+
+        if (s->len >= _INTERNAL_DATA_SIZE) {
+            error_report("Bug - Write overrun internal data buffer");
+            abort();
+        }
+
         s->data[s->len] = (uint8_t)tx;
         s->len++;
 
@@ -1123,6 +1132,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
         break;
 
     case STATE_READING_DATA:
+
+        if (s->pos >= _INTERNAL_DATA_SIZE) {
+            error_report("Bug - Read overrun internal data buffer");
+            abort();
+        }
+
         r = s->data[s->pos];
         s->pos++;
         if (s->pos == s->len) {
@@ -1195,7 +1210,7 @@ static const VMStateDescription vmstate_m25p80 = {
     .pre_save = m25p80_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(state, Flash),
-        VMSTATE_UINT8_ARRAY(data, Flash, 16),
+        VMSTATE_UINT8_ARRAY(data, Flash, _INTERNAL_DATA_SIZE),
         VMSTATE_UINT32(len, Flash),
         VMSTATE_UINT32(pos, Flash),
         VMSTATE_UINT8(needed_bytes, Flash),
-- 
2.9.3
