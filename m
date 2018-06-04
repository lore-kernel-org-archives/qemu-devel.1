Received: from eggs.gnu.org ([2001:4830:134:3::10]:36485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBr-0005gI-6D
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBp-0001eg-4d
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:35 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBo-0001eS-Vo
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:33 -0400
Received: by mail-qk0-x242.google.com with SMTP id d130-v6so19787158qkc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:14:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:14:19 -0300
Message-Id: <20180604151421.23385-2-f4bug@amsat.org>
In-Reply-To: <20180604151421.23385-1-f4bug@amsat.org>
References: <20180604151421.23385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] usb: correctly handle Zero Length
 Packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

USB Specification Revision 2.0, §5.5.3:
  The Data stage of a control transfer from an endpoint to the host is complete when the endpoint does one of the following:
  • Has transferred exactly the amount of data specified during the Setup stage
  • Transfers a packet with a payload size less than wMaxPacketSize or transfers a zero-length packet"

hw/usb/redirect.c:802:9: warning: Declared variable-length array (VLA) has zero size
        uint8_t buf[size];
        ^~~~~~~~~~~ ~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/redirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 65a9196c1a..58e8f7f5bd 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -795,7 +795,7 @@ static void usbredir_handle_bulk_data(USBRedirDevice *dev, USBPacket *p,
            usbredirparser_peer_has_cap(dev->parser,
                                        usb_redir_cap_32bits_bulk_length));
 
-    if (ep & USB_DIR_IN) {
+    if (ep & USB_DIR_IN || size == 0) {
         usbredirparser_send_bulk_packet(dev->parser, p->id,
                                         &bulk_packet, NULL, 0);
     } else {
-- 
2.17.1
