Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N9-0006Mo-OL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N8-0004Pv-Nb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:51 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY7N8-0004PM-IV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:50 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 11:02:46 +0200
Message-Id: <1500541371-24788-4-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH v2 3/8] usb-ccid: Set protocol parameters based
 on card ATR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

From: Stefan Fritsch <stefan_fritsch@genua.de>

For the ATR interface bytes encoding see ISO/IEC 7816-3. For the
interpretation of the protocol parameter block see the CCID
specification.

- Values that are not present in the ATR default to zero.
- TA_1 is used to fill bmFindexDindex.
- The high nibble of bmTCCKST0 must be the protocol (T=0 or T=1).
- For T=0 the bWaitingInteger can be found in the global byte TC_2,
  for T=1 the waiting integer is in TB_3 and bIFSC is in TA_3.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 66 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 49791492ea..769949144b 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -801,7 +801,7 @@ static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
         return;
     }
     h->b.hdr.bMessageType = CCID_MESSAGE_TYPE_RDR_to_PC_Parameters;
-    h->b.hdr.dwLength = 0;
+    h->b.hdr.dwLength = (s->bProtocolNum == 1) ? 7 : 5;
     h->b.hdr.bSlot = recv->bSlot;
     h->b.hdr.bSeq = recv->bSeq;
     h->b.bStatus = ccid_calc_status(s);
@@ -871,6 +871,49 @@ static uint8_t atr_get_protocol_num(const uint8_t *atr, uint32_t len)
     return atr[i] & 0x0f;
 }
 
+/*
+ * Get a specific interface byte TX_y (X='A'..'D' y=1..3)
+ * See ISO/IEC 7816-3:2006 Chapter 8 for details.
+ */
+static uint8_t atr_get_TXY(const uint8_t *atr, uint32_t len, char x, int y)
+{
+    int pos;
+    uint8_t t0, ti, i;
+
+    if (x < 'A' || x > 'D') {
+        return 0;
+    }
+    x -= 'A';
+
+    if (len < 2) {
+        return 0;
+    }
+    t0 = atr[1] >> 4;
+    pos = 2;
+    ti = 1;
+    /* Skip TA_i..TD_i if present while not at requested index y */
+    while (ti < y) {
+        pos += !!(t0 & 0x01) + !!(t0 & 0x02) + !!(t0 & 0x04);
+        if (pos >= len || !(t0 & 0x08)) {
+            return 0;
+        }
+        t0 = atr[pos++] >> 4;
+        ti++;
+    }
+    if (!(t0 & 0x01 << x)) {
+        return 0;
+    }
+    for (i = 0; i < x; ++i) {
+        if (t0 & (1 << i)) {
+            pos++;
+        }
+    }
+    if (pos >= len) {
+        return 0;
+    }
+    return atr[pos];
+}
+
 static void ccid_write_data_block_atr(USBCCIDState *s, CCID_Header *recv)
 {
     const uint8_t *atr = NULL;
@@ -890,21 +933,20 @@ static void ccid_write_data_block_atr(USBCCIDState *s, CCID_Header *recv)
                                              : s->bProtocolNum);
     switch (atr_protocol_num) {
     case 0:
-        /* TODO: unimplemented ATR T0 parameters */
-        t0->bmFindexDindex = 0;
-        t0->bmTCCKST0 = 0;
+        t0->bmFindexDindex = atr_get_TXY(atr, len, 'A', 1);
+        t0->bmTCCKST0 = 0;      /* T0 */
         t0->bGuardTimeT0 = 0;
-        t0->bWaitingIntegerT0 = 0;
+        t0->bWaitingIntegerT0 = atr_get_TXY(atr, len, 'C', 2);
         t0->bClockStop = 0;
         break;
     case 1:
-        /* TODO: unimplemented ATR T1 parameters */
-        t1->bmFindexDindex = 0;
-        t1->bmTCCKST1 = 0;
-        t1->bGuardTimeT1 = 0;
-        t1->bWaitingIntegerT1 = 0;
-        t1->bClockStop = 0;
-        t1->bIFSC = 0;
+        /* NOTE: If present TD2 should specify protocl T=1 */
+        t1->bmFindexDindex = atr_get_TXY(atr, len, 'A', 1);
+        t1->bmTCCKST1 = 0x10;   /* T1 */
+        t1->bGuardTimeT1 = atr_get_TXY(atr, len, 'C', 1);
+        t1->bWaitingIntegerT1 = atr_get_TXY(atr, len, 'B', 3);
+        t1->bClockStop = 0x00;
+        t1->bIFSC = atr_get_TXY(atr, len, 'A', 3);
         t1->bNadValue = 0;
         break;
     default:
-- 
2.11.0
