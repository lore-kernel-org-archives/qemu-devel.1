Received: from eggs.gnu.org ([2001:4830:134:3::10]:48454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cZMxx-0008Qm-0K
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:22:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cZMxs-00070N-Qi
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:22:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cZMxs-000708-Kk
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:22:40 -0500
From: P J P <ppandit@redhat.com>
Date: Fri,  3 Feb 2017 00:52:28 +0530
Message-Id: <20170202192228.10847-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: ccid: check ccid apdu length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

CCID device emulator uses Application Protocol Data Units(APDU)
to exchange command and responses to and from the host.
The length in these units couldn't be greater than 65536. Add
check to ensure the same. It'd also avoid potential integer
overflow in emulated_apdu_from_guest.

Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/usb/dev-smartcard-reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 89e11b6..1325ea1 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -967,7 +967,7 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
     DPRINTF(s, 1, "%s: seq %d, len %d\n", __func__,
                 recv->hdr.bSeq, len);
     ccid_add_pending_answer(s, (CCID_Header *)recv);
-    if (s->card) {
+    if (s->card && len <= BULK_OUT_DATA_SIZE) {
         ccid_card_apdu_from_guest(s->card, recv->abData, len);
     } else {
         DPRINTF(s, D_WARN, "warning: discarded apdu\n");
-- 
2.9.3
