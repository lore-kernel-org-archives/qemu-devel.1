Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gAZ7O-00087r-HM
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gAZ7J-0000MW-Ft
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gAZ7F-00007y-Lj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:26:55 -0400
From: P J P <ppandit@redhat.com>
Date: Thu, 11 Oct 2018 16:54:36 +0530
Message-Id: <20181011112436.9305-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] ccid-card-passthru: check buffer size parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Arash TC <tohidi.arash@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading virtual smart card data, if buffer 'size' is negative
it would lead to memory corruption errors. Add check to avoid it.

Reported-by: Arash TC <tohidi.arash@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/usb/ccid-card-passthru.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0a6c657228..63ed78f4c6 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -275,6 +275,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
     PassthruState *card = opaque;
     VSCMsgHeader *hdr;
 
+    assert(0 <= size && size < VSCARD_IN_SIZE);
     if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
         error_report("no room for data: pos %u +  size %d > %" PRId64 "."
                      " dropping connection.",
-- 
2.17.1
