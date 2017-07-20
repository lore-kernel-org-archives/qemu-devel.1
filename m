Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mr-0006Aj-2J
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY6mq-0004qM-Bj
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:21 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY6mq-0004q2-5A
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:26:20 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 10:25:21 +0200
Message-Id: <1500539123-23884-7-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
References: <1500539123-23884-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH 6/8] usb-ccid: Fix chaining fields in CCID USB
 messages
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

Incoming packets should never need chaining (bChainParamter => 0).
If they ever do we will have to fix this later. Zero is still better
than an uninitialized value.

Warn if outgoing packets try to use chaining (wLevelParameter != 0).
As we are doing APDU level exchanges, the driver should not need to
set these bits.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bc4dc35d3f..974ecad18d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -826,6 +826,7 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
     p->b.hdr.bSeq = seq;
     p->b.bStatus = ccid_calc_status(s);
     p->b.bError = s->bError;
+    p->bChainParameter = 0;
     if (p->b.bError) {
         DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
     }
@@ -1027,6 +1028,10 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
     len = le32_to_cpu(recv->hdr.dwLength);
     DPRINTF(s, 1, "%s: seq %d, len %d\n", __func__,
                 recv->hdr.bSeq, len);
+    if (le16_to_cpu(recv->wLevelParameter)) {
+        DPRINTF(s, D_WARN, "Unsupported non-zero level Parameter %x\n",
+            __func__, le16_to_cpu(recv->wLevelParameter));
+    }
     ccid_add_pending_answer(s, (CCID_Header *)recv);
     if (s->card && len <= BULK_OUT_DATA_SIZE) {
         ccid_card_apdu_from_guest(s->card, recv->abData, len);
-- 
2.11.0
