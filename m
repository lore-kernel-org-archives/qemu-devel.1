Received: from eggs.gnu.org ([2001:4830:134:3::10]:35316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mo-0006AL-MR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mn-0004pg-RU
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:18 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6mn-0004pW-Kl
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:17 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:25:19 +0200
Message-Id: <1500539123-23884-5-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
References: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH 4/8] usb-ccid: Fix ATR parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Fritsch <stefan_fritsch@genua.de>

From: Stefan Fritsch <stefan_fritsch@genua.de>

- The number of parameter set TA_i...TD_i is unlimited. The list ends
  if TD_i is not present or the high nibble is zero.
- If at least one protocol in any of the TD bytes is non-zero, the
  ATR must have a checksum.
- Add a missing length check before accessing TD.
- Fixup a wrong checksum but accept the ATR.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/ccid-card-passthru.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 45d96b03c6..e2e94ac1ba 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -146,8 +146,7 @@ static void ccid_card_vscard_handle_init(
 
 static int check_atr(PassthruState *card, uint8_t *data, int len)
 {
-    int historical_length, opt_bytes;
-    int td_count = 0;
+    int historical_length, opt_bytes, tck = 0;
     int td;
 
     if (len < 2) {
@@ -160,10 +159,8 @@ static int check_atr(PassthruState *card, uint8_t *data, int len)
                 data[0]);
         return 0;
     }
-    td_count = 0;
     td = data[1] >> 4;
-    while (td && td_count < 2 && opt_bytes + historical_length + 2 < len) {
-        td_count++;
+    while (td && opt_bytes + historical_length + 2 < len) {
         if (td & 0x1) {
             opt_bytes++;
         }
@@ -175,16 +172,37 @@ static int check_atr(PassthruState *card, uint8_t *data, int len)
         }
         if (td & 0x8) {
             opt_bytes++;
-            td = data[opt_bytes + 2] >> 4;
+            if (opt_bytes + 1 >= len) {
+                break;
+            }
+            /* Checksum byte must be present if T!=0 */
+            if (data[opt_bytes + 1] & 0xf) {
+                tck = 1;
+            }
+            td = data[opt_bytes + 1] >> 4;
+        } else {
+            td = 0;
         }
     }
-    if (len < 2 + historical_length + opt_bytes) {
+    if (len < 2 + historical_length + opt_bytes + tck) {
         DPRINTF(card, D_WARN,
             "atr too short: len %d, but historical_len %d, T1 0x%X\n",
             len, historical_length, data[1]);
         return 0;
     }
-    if (len > 2 + historical_length + opt_bytes) {
+    if (tck) {
+        int i;
+        uint8_t cksum = 0;
+        for (i = 1; i < 2 + historical_length + opt_bytes; ++i) {
+            cksum ^= data[i];
+        }
+        if (cksum != data[i]) {
+            DPRINTF(card, D_WARN, "atr has bad checksum: "
+                "real=0x%x should be 0x%x (FIXED)\n", cksum, data[i]);
+            data[i] = cksum;
+        }
+    }
+    if (len > 2 + historical_length + opt_bytes + tck) {
         DPRINTF(card, D_WARN,
             "atr too long: len %d, but hist/opt %d/%d, T1 0x%X\n",
             len, historical_length, opt_bytes, data[1]);
-- 
2.11.0
